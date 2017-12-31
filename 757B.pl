use v5.22;
use strict;
use warnings;
use List::Util 'max';

my $n = <STDIN>;
my $line = <STDIN>;
my @strengths = split / /, $line;
my @vs = (0) x (1 << 31);
my @ns = (0) x (1 << 31);

for (my $i = 0; $i < scalar @strengths; $i++){
	@ns[$strengths[$i]]++;
}

for (my $i = 2; $i < (1<<31); $i++){
	next if ($vs[$i] != 0);
	@vs[$i] = 1;
	for (my $j = $i + 1; $j < (1 << 31); $j++){
		$vs[$j] = 1;
		$ns[$i] = $ns[$i] + $ns[$j];
	}
}

if ($ns[1] > 1){
	@ns[1] = 1;
}
my $maxx = max @ns;
print "$maxx"
