#!/usr/bin/perl

use warnings;
use strict;
$|++;

use Bio::DB::GenBank;
use Bio::Tools::SeqStats;

my $gbh = Bio::DB::GenBank->new();
my $seq = $gbh->get_Seq_by_acc("NG_017013.2");

my $stats = Bio::Tools::SeqStats->new($seq);
my $mw = $stats->get_mol_wt();

print(("=" x 8) . " " . $seq->display_id() . " " . ("=" x 8) . "\n");
print("Greatest Lower: $mw->[0]\n");
print("  Lowest Upper: $mw->[1]\n");
