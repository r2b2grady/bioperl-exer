#!/usr/bin/perl
use strict;
use warnings;

# Created on: Jul 23, 2016
# Written by: Robert Grady

my $Version = 1.0.0;

use Data::Dumper;
use lib 'D:/workspace/Bioperl_Exer/Week_8';
use Gene;

sub getseq($);

my $g = Gene->new(
                  name  => 'SIR2',
                   org   => 'S. cerevisiae',
                   seq   => getseq('../S288C_YDL042C_SIR2_genomic.fsa'),
                 );

print "";

# Retrieves a DNA sequence from a given FASTA file.
sub getseq($) {
	my ($fpath) = @_;
	
	open my $fh, '<', $fpath || die "Unable to open $fpath: $!";
	
	my $s = "";
	
	while (<$fh>) {
		my $dbg = \$_;
		if (m/^>/) {
			if ($s) {
				last;
			} else {
				next;
			}
		} else {
			chomp();
			$s .= $_;
		}
	}
	
	close $fh;
	
	return $s;
}