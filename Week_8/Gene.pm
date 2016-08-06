package Gene;

use Exporter 'import';

# Created on: Jul 23, 2016
# Written by: Robert Grady

my $Version = 1.0.0;

sub new {
	my ($class, %attribs) = @_;
	my $obj = {
		_name => $attribs{name}   || die("Need 'name'!"),
		_org  => $attribs{org}    || die("Need organism!"),
		_seq  => $attribs{seq}    || die("Need sequence!")
	};
	return bless $obj, $class;
}

1;