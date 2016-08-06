#!/usr/bin/perl
use strict;
use warnings;

# Created on: Jul 23, 2016
# Written by: Robert Grady

my $Version = 1.0.0;

my $rs = 'GNNAAAATTTTNNC';

my $n = length($rs);

# Hash of ambiguity abbreviations.  Abbreviations taken from
# http://www.bioinformatics.nl/molbi/SCLResources/sequence_notation.htm,
# section 'Restriction Enzymes'.
my %abbr = (R => '[GA]',
            Y => '[CT]',
            M => '[AC]',
            K => '[GT]',
            S => '[GC]',
            W => '[AT]',
            B => '[CGT]',
            D => '[AGT]',
            H => '[ACT]',
            V => '[ACG]',
            N => '[ACGT]');

# Convert all ambiguity abbreviations to Regexp syntax.
for (keys %abbr) {
    $rs =~ s/$_/\Q$abbr{$_}\E/gi;
}

my @rs;
my $out;
# Check if the sequence has the specific cleavage site specified.
if ($rs =~ m/\^/) {
    # Specific site specified, split by the marker.
    @rs = ($rs =~ m/^(.*)\^(.*)$/);
} else {
    # No specific site specified, assume it cuts one base away from the 3'
    # end of the recognition sequence.
    @rs = ($rs =~ m/^(.*)(.)$/);
}

my $dup = join '', keys(%abbr);
$dup = "(([ACGT$dup]|\\[.*?\\])\\2+)";

while ($rs[0] =~ m/$dup/) {
	my $b = $2;
	my $x = length($1) / length($b);
	
	$rs[0] =~ s/$dup/$b\{$x\}/;
}

# Assemble and return the pattern.

print "";