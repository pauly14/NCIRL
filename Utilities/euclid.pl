#!/usr/bin/perl

my $version = "0.1";
print "Euclidean. Version: $version. (C) FS 2014\n";

while(1) {

my $a = gen_random(2000,5000);
my $b = gen_random(10,100);
my $workings;
my $quest = "Find the GCD of $a and $b";

my ($times, $remainder);

while (1) {
        if ($a < $b) {
                my $c = $a;
                $a = $b; $b = $c;
        }
        ($times,$remainder) = div($a,$b);
        $workings .= "Divide $a by $b, goes $times times with a remainder $remainder\n";
        if ($remainder == 0) {
                $workings .= "GCD is $b\n";
                last;
        }
        $workings .= "swapping $a by $b, $b by $remainder\n";
        $a = $b; $b = $remainder;
}

print $quest,": ";
my $resp=<STDIN>; chomp($resp);
if ($b eq $resp) {
        print "Correct!\n";
} else {
        print "Wrong, should be $b\n";
}
print $workings,"\n";
}

exit;

sub div {
my ($num,$denom) = @_;
my $times = int $num / $denom;
my $remainder = $num % $denom;
return $times,$remainder;
}

sub gen_random {
my ($min, $max) = @_;
my $num = int(rand(($max - $min) + 1)) + $min;
return $num;
}
