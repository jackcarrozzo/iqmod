#!/usr/bin/perl -w
use strict;

my $bits=8;

my $max=(2**$bits-1);
my $i;
my $pi=3.1415926;

print "initial begin\n";
#from 0 to 2*pi
for ($i=0;$i<=$max;$i++) {
	printf("\tsin_lut[%03d] = %d\x27h%02X;\n",$i,$bits,$max*(0.5+sin((2*$pi*$i)/$max)/2));
	printf("\tcos_lut[%03d] = %d\x27h%02X;\n",$i,$bits,$max*(0.5+cos((2*$pi*$i)/$max)/2));
}
print "end\n";

