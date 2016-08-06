#!/usr/bin/perl

use strict;
use warnings;

use Bio::DB::GenBank;

my $gbh = Bio::DB::GenBank->new();
my $seq = $gbh->get_Seq_by_acc('NG_017013.2');

print ref($seq) . "\n";
