#!/usr/bin/perl

use strict;
use Getopt::Std;


getopts("h");
our($opt_h);

usage() if $opt_h;
usage() unless @ARGV;

my @files = @ARGV;

my $t = " " x 4;

foreach my $file (@files){


    my %obj_data = (); #ultimately all the data goes here

            ### parse the file. ### 

    open GRID, $file or die "cannot open $file: $!";

    my $level = 0;
    my @scope = (\%obj_data);

    my $fudge = 0; # because the intervals are on the same indent level
                   # as its parent, the levels have to be fudged a little

    while( my $line = <GRID> ){

	# create a new items array
	if( $line =~ /^(\s*)item\s*\[\]:/i ){
	    my $tabs = $1;
	    my $new_level = $tabs =~ tr/ //;
	    $new_level /= 4;

	    $fudge = 0;

	    $level = $new_level + 1;
	    
	    # move the new item to the top of the scope stack
	    $scope[$#scope]->{'item'} = [];
	    push @scope, $scope[$#scope]->{'item'}; 

	}elsif( $line =~ /^(\s*)item\s*\[\d+\]:/i ){
	    my $tabs = $1;

	    my $new_level = $tabs =~ tr/ //;
	    $new_level /= 4;

	    $fudge = 0;

	    # return to the correct scope if we're out of it
	    if( $new_level < $level ){
		for( my $i = 0; $i < ($level - $new_level) ; $i++){
		    pop @scope;
		}
	    }elsif( $new_level > $level ){
		die "$.: error in item nesting. indenting level $new_level
found but were in $level\n";
	    }

	    # create a new hashref for the children of the item
	    my $content = {};
	    push @{$scope[$#scope]}, $content;
	    push @scope, $content; # save the scope

	    $level = $new_level + 1;
	}elsif( $line =~ /^(\s*)intervals:/i ){
	    my $tabs = $1;
	    my $new_level = $tabs =~ tr/ //;
	    $new_level /= 4;

	    $level = $new_level + 1;
	    $scope[$#scope]->{'intervals'} = [];
	    push @scope, $scope[$#scope]->{'intervals'}; 

	    $fudge = 1;
	}elsif( $line =~ /^(\s*)intervals\s*\[\d+\]:/i ){
	    my $tabs = $1;
	    my $new_level = $tabs =~ tr/ //;
	    $new_level /= 4;

	    # return to the correct scope if we're out of it
	    if( ( $new_level + $fudge ) < $level ){
		for( my $i = 0; $i < ($level - ($new_level + $fudge)); $i++ ){
		    pop @scope;
		}

	    }elsif( ($new_level + $fudge) > $level ){
		die "$.: error in item nesting. indenting level $new_level
found but were in $level\n";
	    }
	    
	    # create a new hashref for the children of the item
	    my $content = {};
	    push @{$scope[$#scope]}, $content;
	    push @scope, $content; # save the scope

	    $level = ($new_level + $fudge) + 1;

	}elsif( $line =~ /^(\s*)([\w\s]+?)\s*=\s*(.+?)\s*$/ ){
	    my $tabs = $1;
	    my $key = $2;
	    my $val = $3;
	    $val =~ s/^\"(.*)\"$/$1/; # remove any quotes

	    my $new_level = $tabs =~ tr/ //;
	    $new_level /= 4;


	    # return to the correct scope if we're out of it
	    if( ($new_level + $fudge ) < $level ){
		for( my $i = 0; $i < ($level - ($new_level + $fudge)); $i++ ){
		    pop @scope;
		}
	    }elsif( ($new_level + $fudge) > $level ){
		die "$.: error in item nesting. indenting level $new_level
found but were in $level\n";
	    }

	    # store a key into the current hash
	    $scope[$#scope]->{$key} = $val; 
	}

    }

    close GRID;

### done reading in the data. everything should be in %obj_data now

    if( $obj_data{'Object class'} eq "TextGrid"){
	my ($name) = $file =~ /(?:^.+\/)?(.+?).TextGrid/i; 
	print_timings( $name, \%obj_data );
    }elsif($obj_data{'Object class'} eq "Collection"){
	foreach my $item (@{$obj_data{'item'}}){

	    print_timings( $item->{'name'},  $item);
	}
    }
}


sub print_timings($$){
    my ($name, $textgrid) = @_;

    my @diphones;

    # each item should be a tier
    foreach my $item (@{$textgrid->{item}}){
	if( $item->{'name'} =~ /diphone/i ){

	    # look for the region that comes first
	    foreach my $int (@{$item->{'intervals'}}){
		if( $int->{'text'} =~ /.-./ ){
		    push @diphones, [$int->{'text'}, $int->{'xmin'}, 
				     undef, $int->{'xmax'}];
		}
	    }

	
	}elsif( $item->{'name'} =~ /midpoint/i ){
	    # look for the region that comes first
	    foreach my $int (@{$item->{'intervals'}}){

		# time to fill in the midpoints
		if( $int->{'text'} =~ /./ ){

		    for( my $i = 0; $i <= $#diphones; $i++){

			# we still need to fill it in
			if( ! $diphones[$i][2] 
			    && $diphones[$i][3] > $int->{'xmax'}
			    && $diphones[$i][1] < $int->{'xmax'} ){
			    $diphones[$i][2] = $int->{'xmax'};

			}elsif( ! $diphones[$i][2] 
			    && $diphones[$i][3] > $int->{'xmin'}
			    && $diphones[$i][1] < $int->{'xmin'} ){
			    $diphones[$i][2] = $int->{'xmin'};
			} 

		    }
		}
	    }
	    
	}else{
	    warn "ignoring unknown tier $item->{'name'}\n";
	}
    }

    foreach my $diphone (@diphones){
	printf ("%s\t%s\t%0.3f\t%0.3f\t%0.3f\t\n", @$diphone[0] ,$name, 
		@$diphone[1], @$diphone[2], @$diphone[3]);
    }
}


sub usage(){
    die<<USAGE;
usage: $0 filenames.TextGrid

reads in praat TextGrid files and outputs festival diphone index files. This 
requires having two tiers labeled "diphone" and "midpoint" with text labels
for each of the boundaries.

The input file can be gotten by selecting one or more TextGrids in Praat
and going to Write->Write to text file...

(if you're selecting only one TextGrid, leave its filename with the 
diphone name still intact)

USAGE
}
