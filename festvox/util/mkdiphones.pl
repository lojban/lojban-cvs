#!/usr/bin/perl

# ( jrc_0001 "# t a p y p a #" ("p-y" "y-p") )


use strict;

die<<USAGE unless @ARGV;
usage: $0 filename

USAGE

my $file = $ARGV[0]; 
my $file2 = $ARGV[1]; 

open IN, $file or die "cannot open $file: $!";
open IN2, $file2 or die "cannot open $file: $!";

print <IN2>;
close IN2;

while(my $line = <IN>){

    if( $line =~ /^\s*\(\s*(\w+)\s+".+?"\s+\("(.+?)"\s+"(.+?)"\)/ ){

#	print "$2\t$1\t0.400 0.450 0.500\n";
#	print "$3\t$1\t0.500 0.550 0.600\n";
	print "$2\t$1\t\t\t\n";
	print "$3\t$1\t\t\t\n";
    }elsif( $line =~ /^\s*\(\s*(\w+)\s+"(.+?)"\s+\("(.+?)"\s*\)/ ){

	my $fi = $1;
	my $samp = $2;
	my $ph = $3;

	print "$ph\t$fi\t\t\t\n";

	if( $ph =~ /\#-/ ){

#	    print "$ph\t$fi\t0.050 0.100 0.150\n";

	    
	}else{
	    if( $samp =~ /\-/ ){

#		print "$ph\t$fi\t0.525 0.675 0.740\n";

	    }else{
#		print "$ph\t$fi\t0.500 0.600 0.700\n";

	    }
	}
    }
}
