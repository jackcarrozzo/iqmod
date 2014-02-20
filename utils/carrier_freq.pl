#!/usr/bin/perl -w
use strict;

# this of course is only valid if clock ports and file names dont change

my $inclk=50000000; # onboard osc
my $sincos_range=5;  # range of sin/cos lookup table in bits
$sincos_range=2**$sincos_range;

print "Input osc:\t ".($inclk/1000000)." mhz\n";
print "LUT range:\t $sincos_range values\n";

my $pll_div=0;
my $pll_mult=0;

open(F,"../thepll.v") or die("Error opening ../thepll.v!");
while (<F>) {
	chomp;
	my $line=$_;

	if ($line=~/altpll_component.clk0_divide_by = ([0-9]+),/) {
		print "PLL divide by:\t $1\n";
		$pll_div=$1;
	} elsif ($line=~/altpll_component.clk0_multiply_by = ([0-9]+),/) {
		print "PLL multiply by:\t $1\n";
		$pll_mult=$1;
	}

	last if (($pll_div!=0)&&($pll_mult!=0));  # done, no need to continue
}
close(F);

my $posperclk;

open(F,"../iqcalc.v") or die("Error opening ../iqcalc.v!");
while (<F>) {
  chomp;
  my $line=$_;

	if ($line=~/define POSPERCLK ([0-9]+)'d2/) {
		print "Pos per clock:\t $1\n";
		$posperclk=$1;
		last;
	}
}
close(F);

my $clk0=($inclk*$pll_mult)/$pll_div;
print "clk0 freq:\t $clk0 hz\n";
my $sigfreq=$clk0*$posperclk/$sincos_range;
print "---\nCarrier freq:\t $sigfreq hz\n";
