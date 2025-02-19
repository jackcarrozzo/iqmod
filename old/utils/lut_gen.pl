#!/usr/bin/perl -w
use strict;

my $bits=8;

my $max=(2**$bits-1);
my $i;
my $pi=3.1415926;

print "initial begin\n";
#from 0 to 2*pi
# output on [0,$max]
#for ($i=0;$i<=$max;$i++) {
#	printf("\tsin_lut[%03d] = %d\x27h%02X;\n",$i,$bits,$max*(0.5+sin((2*$pi*$i)/$max)/2));
#	printf("\tcos_lut[%03d] = %d\x27h%02X;\n",$i,$bits,$max*(0.5+cos((2*$pi*$i)/$max)/2));
#}

# from 0 to 2*pi
# output on [-$max/2,$max/2]
my ($sval,$cval,$sneg,$cneg);
for ($i=0;$i<=$max;$i++) {
	$sval=$max*sin(2*$pi*$i/$max)/2;
	$cval=$max*cos(2*$pi*$i/$max)/2;
	if ($sval<0) { $sneg="-";} else { $sneg=" ";}
	if ($cval<0) { $cneg="-";} else { $cneg=" ";}

 printf("\tsin_lut[%03d] = %s%d\x27d%d;\n",$i,$sneg,$bits,abs($sval));
 printf("\tcos_lut[%03d] = %s%d\x27d%d;\n",$i,$cneg,$bits,abs($cval));
}

print "end\n";



