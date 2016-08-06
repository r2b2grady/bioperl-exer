#!/usr/bin/perl

use warnings;
use strict;

use Bio::Perl;

=pod

=head1 refasta

Takes one or more FASTA files, reads them in using Bioperl, converts each
sequence into a valid Bioperl sequence, and writes the sequences out to new
files.  Files are specified as command-line arguments.

=cut

# Declare function.
sub refasta($);

my @files = ();

for (@ARGV) {
    if (-f $_) {
	push @files, $_;
    }
}

# Print out POD and exit if no files were specified.
unless (@files) {
    print "No valid files specified!\n" if @ARGV;
    `perldoc $0`;
    exit;
}

# Parse files.
for (@files) {
    refasta($_);
}

# Performs the read-in, conversion, and writing operations.
sub refasta($) {
    my ($f) = (@_);
    
    my $new = $f;
    $new =~ s/(?=\.[^\.]+$)/_new/;
    
    # Sequences
    my @s;
    
    open my $fh, '<', $f;
        
    while (<$fh>) {
	if (m/^>(.*)/) {
	    my ($name) = split /\|/, $1;
	    push @s, {-name => $name};
	} else {
	    chomp();
	    $s[-1]->{-seq} .= $_;
	}
    }
    
    close $fh;
    
    for (@s) {
	$_->{-bioseq} = new_sequence($_->{-seq}, $_->{-name});
    }
    
    write_sequence(">$new", 'fasta', map { $_->{-bioseq} } @s);
}
