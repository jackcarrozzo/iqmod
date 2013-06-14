#!/usr/bin/perl -w
use strict;
use POSIX;

my ($i,$t);
my $pi=3.1415926;

my $numT=32;
my ($addr,$mult);

print "initial begin\n";
# from 0 to 2*pi
# output on [-256,255] (9 bits, so they add to the 10-bit DAC value)
my ($sval,$sneg,$cval,$cneg);
for ($i=0;$i<16;$i++) {
	for ($t=0;$t<$numT;$t++) {
		$mult=$i-7.5; # center on 0

		$sval=255*($mult/7.5)*sin(2*$pi*$t/$numT);
		$cval=255*($mult/7.5)*cos(2*$pi*$t/$numT);

		#print "i: $i, t: $t, sin $sval\n";

		if ($sval<0) { $sneg="-";} else { $sneg=" ";}
		if ($cval<0) { $cneg="-";} else { $cneg=" ";}

		$sval=round(abs($sval));
		$cval=round(abs($cval));

		$addr=($i*32)+$t;
		printf("\tqsin_lut[%03d] = %s9\x27sd%d;\n",$addr,$sneg,$sval);
		printf("\ticos_lut[%03d] = %s9\x27sd%d;\n",$addr,$cneg,$cval);
	}
}

print "end\n";
print "endmodule\n";

sub round {
	my $in=shift;
	
	if (($in-floor($in))>=0.5) { return floor($in)+1; }
	else { return floor($in); }
}

