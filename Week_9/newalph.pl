#!/usr/bin/perl

use warnings;
use strict;

use Bio::DB::GenBank;
use Bio::Tools::OddCodes;

# Wraps a sequence. Defaults to FASTA format.
sub seqwrap;

my $gbh = Bio::DB::GenBank->new();
my $seq = $gbh->get_Seq_by_acc('NP_000537.3');
my $och = Bio::Tools::OddCodes->new(-seq => $seq);

print(("=" x 8) . " " . $seq->display_id() . " " . ("=" x 8) . "\n");
print "Original Sequence:\n";
print seqwrap($seq);
print "\n\nStructural Sequence:\n";
print seqwrap($och->structural(), {-prot => 1});
print "\n";


# Takes a Seq object OR a sequence string.  Optional second argument
# allows specification of options.  The option keys are:
#   -prot       Only used if given a sequence string.  If true, use
#               protein wrapping syntax (i.e., split each section up
#               into multiples of 10 aa).
#   -wrap       The number of monomers by which to wrap. Default = 60.
sub seqwrap {
    my ($seq, $opt) = @_;
    
    $seq = $$seq while ref($seq) =~ m/^(?:REF|SCALAR)/;
    
    die "Invalid sequence" unless ref($seq) =~ m/^Bio::Seq/ || ref($seq) eq '';
    die "Invalid options" unless ref($opt) eq 'HASH' || ! defined $opt;
    
    $opt = {-wrap => 60, -prot => 0, (defined $opt ? %$opt : ())};
    
    my $mode = (ref($seq) =~ m/^Bio::Seq/ ? 'obj' : 'scl');
    
    my $str = ($mode eq 'obj' ? $seq->seq() : $seq);
    
    my $patt = "(.{" . $opt->{-wrap} . "})";
    
    $str =~ s/$patt/$1\n/g;
    
    $str =~ s/(.{10})(?!\$)/$1 /g if ($mode eq 'obj' ? $seq->alphabet() eq 'protein' :
	$opt->{-prot});
    
    return $str;
}
