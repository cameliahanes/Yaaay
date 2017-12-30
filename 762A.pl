use v5.22;
use warnings;
use strict;

my $line = <STDIN>;
chomp ($line);
my ($n, $k) = split(' ', $line);
my $div = 1;

while ($div <= $n / 2 && $k > 0){
	if ($n % $div == 0)
	{	$k--;
	}
	$div++;
}

$div--;
if ($n % $div != 0){
	print "-1";
}
else{
print "$div"
}
