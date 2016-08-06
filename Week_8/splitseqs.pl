#!/usr/bin/perl
use strict;
use warnings;

# Created on: Jul 24, 2016
# Written by: Robert Grady

my $Version = 1.0.0;
my $dir = $0;
$dir =~ s{/[^/]*\.pl}{};

chdir $dir;

my $seq;

open my $fh, '<', './test.fsa';

while (<$fh>) {
	chomp();
	$seq .= $_;
}

my @bits = ();

while (scalar(@bits) < 40) {
	
}