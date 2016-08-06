#!/usr/bin/perl
use strict;
use warnings;

# Created on: Jul 24, 2016
# Written by: Robert Grady

my $Version = 1.0.0;

use lib "..";
use week04::q3;

my $s = "";

for (1..500) {
	$s .= randseq(15, 1);
}

print "$s\n";