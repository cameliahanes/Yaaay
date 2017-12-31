use v5.22;
use strict;
use warnings;

my $line = <STDIN>;
chomp ($line);
my ($a, $b, $c) = split(' ', $line);

my @us = ();
my @ps = ();

my $counter = <STDIN>;
while ($counter--){
	my $ln = <STDIN>;
	my ($p, $t) = split(' ', $ln);
	if ($t eq 'USB'){
		push @us, $p;
	} else {
		push @ps, $p;
	}
}

my $total = 0;
my $cc = 0;

for (my $i = 0; $i < $a; $i++){
	if (@us == 0){
		last;
	}
	$total = $total + $us[-1];
	pop @us;
	$cc++;
}

for (my $i = 0; $i < $b; $i ++){
	if (@ps == 0){
		last;
	}
	$total = $total + $ps[-1];
	pop @ps;
	$cc++;
}

for (my $i = 0; $i < $c; ++$i){
	if (@ps == 0 && @us == 0){
		last;
	}
	my $pp = 1 << 31;
	my $uu = 1 << 31;
	if (!@ps == 0){
		$pp = $ps[-1];	
	}
	if (!@us == 0){
		$uu = $ps[-1];
	}
	
	if ($pp < $uu){
		$total = $total + $pp;
		pop @ps;
	} else {
		$total = $total + $uu;
		pop @us;
	}
	$cc++;
}

print "$cc  $total\n"

