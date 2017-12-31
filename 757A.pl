use v5.22;
use warnings;
use strict;
use List::Util qw(min);
my $ss = <STDIN>;
chomp($ss);
my @s = split("", $ss);
my $n1 = 0, my $n2 = 0, my $n3 = 0, my $n4 = 0, my $n5 = 0, my $n6 = 0, my $n7 = 0;
for (my $i = 0; $i < scalar @s; $i++){
	my $c = $s[$i];
	if ($c eq 'B'){
		$n1++;
	} elsif ($c eq 'u'){
		$n2++;
	} elsif ($c eq 'l'){
		$n3++;
	} elsif ($c eq 'b'){
		$n4++;
	} elsif ($c eq 'a'){
		$n5++;
	} elsif ($c eq 's'){
		$n6++;
	} elsif ($c eq 'r'){
		$n7++;
	}
}

$n2 = $n2/2;
$n5 = $n5/2;

my $arrp= join(':', $n1, $n2, $n3, $n4, $n5, $n6, $n7);
my @arr = split(":", $arrp); 
my $myMin = $arr[0];
foreach my $nr (@arr){
	if ($nr < $myMin){
		$myMin = $nr;
	}
}
print "$myMin"
