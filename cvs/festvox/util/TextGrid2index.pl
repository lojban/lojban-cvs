#!/usr/bin/perl

use strict;
use Getopt::Std;


getopts("l:hs:");
our($opt_l, $opt_h, $opt_s);

usage() if $opt_h;
usage() unless @ARGV;

my @files = @ARGV;
my $sort_mtd = "sample";
$sort_mtd = $opt_s if $opt_s;

my $prev_list = $opt_l;

my $t = " " x 4;

my %out_diphones;

my $header = "";

if($prev_list){
    open LIST, $prev_list or die "cannot open list: $prev_list: $!";

    my $in_header = 0;

    while( my $line = <LIST> ){
	if( $line =~ /EST_Header_End/i ){
	    $header .= $line;
	    $in_header = 0;
	}elsif( $line =~ /EST_File/i || $in_header ){
	    $header .= $line;
	    $in_header = 1;

	}elsif( $line =~ /^\s*(.+?\-.+?)\s+(\w+)\s+([0-9\.]+)\s+([0-9\.]+)\s+([0-9\.]+)\s+/ ){
	    $out_diphones{$1} = [$3, $4, $5, $2];
	}
    }

    close LIST;
}

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
	gen_timings( $name, \%obj_data , \%out_diphones );

    }elsif($obj_data{'Object class'} eq "Collection"){
	foreach my $item (@{$obj_data{'item'}}){

	    gen_timings( $item->{'name'},  $item, \%out_diphones );
	}
    }
}

my @sorted_diphones;

if( $sort_mtd eq "diphone" ){
    @sorted_diphones = sort keys %out_diphones;

}elsif( $sort_mtd eq "sample" ){
    @sorted_diphones = sort {$out_diphones{$a}[3] cmp $out_diphones{$b}[3]} keys %out_diphones;


}else{
    die "unknown sort method $sort_mtd. try $0 -h for valid methods\n";
}

print $header;

foreach my $diphone (@sorted_diphones){
	printf ("%s\t%s\t%0.3f\t%0.3f\t%0.3f\n", $diphone ,
		$out_diphones{$diphone}[3], 
		$out_diphones{$diphone}[0], 
		$out_diphones{$diphone}[1], 
		$out_diphones{$diphone}[2] );
}

###########################################################

# takes in the name of the sample file, the info from praat, and the diphone
# hash
sub gen_timings($$$){
    my ($name, $textgrid, $diphones) = @_;

    # each item should be a tier
    foreach my $item (@{$textgrid->{item}}){
	if( $item->{'name'} =~ /diphone/i ){

	    # look for the region that comes first
	    foreach my $int (@{$item->{'intervals'}}){
		if( $int->{'text'} =~ /.-./ ){
		    $diphones->{ $int->{'text'} } = [$int->{'xmin'}, 
						     undef, 
						     $int->{'xmax'}, 
						     $name];
		}
	    }

	
	}elsif( $item->{'name'} =~ /midpoint/i ){
	    # look for the region that comes first
	    foreach my $int (@{$item->{'intervals'}}){

		# time to fill in the midpoints
		if( $int->{'text'} =~ /./ ){

		    foreach my $diphone (keys %$diphones ){

			# we still need to fill it in
			if( ! $diphones->{$diphone}[1] 
			    && $diphones->{$diphone}[2] > $int->{'xmax'}
			    && $diphones->{$diphone}[0] < $int->{'xmax'} ){
			    $diphones->{$diphone}[1] = $int->{'xmax'};

			}elsif( ! $diphones->{$diphone}[1] 
			    && $diphones->{$diphone}[2] > $int->{'xmin'}
			    && $diphones->{$diphone}[0] < $int->{'xmin'} ){
			    $diphones->{$diphone}[1] = $int->{'xmin'};
			} 

		    }
		}
	    }
	    
	}else{
	    warn "ignoring unknown tier $item->{'name'}\n";
	}
    }
}


sub usage(){
    die<<USAGE;
usage: $0 [-s SORT_METHOD] [-l EXISTING.LIST] filenames.TextGrid

reads in praat TextGrid files and outputs festival diphone index files. This 
requires having two tiers labeled "diphone" and "midpoint" with text labels
for each of the boundaries.

The input file can be gotten by selecting one or more TextGrids in Praat
and going to Write->Write to text file...

options:
-s SORT_METHOD       SORT_METHOD is either "dihpone" or "sample" to sort the
                     output
-l EXISTING.LIST     reads in EXISTING.LIST and merges it with the extracted 
                     diphones. Any diphones in EXISTING.LIST will be 
                     overwritten by extracted ones. The header from 
		     EXISTING.LIST is also output.
-h                   this help


(if you're selecting only one TextGrid, leave its filename with the 
diphone name still intact)

USAGE
}
