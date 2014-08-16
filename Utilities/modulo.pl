#!/usr/bin/perl


my $version = "0.1";
print "Modulo. Version: $version. (C) FS 2014\n";

my @base=qw(2 8 16);

while (1) {
my $num = gen_random(100,1567);
my $base = @base[int rand @base];

my $workings;
my $quest = "Convert $num (base 10) to base $base";
my $n;

my ($times, $remainder);

do {
        ($times,$remainder) = div($num,$base);
        $workings .= "$num / $base goes $times times and $remainder remainder\n";
        $num=$times;
        if ($base == 16) {
                $n=sprintf("%x",$remainder).$n;
        } else {
                $n =$remainder.$n;
        }
} while ($num > 0);

print $quest,": ";
my $resp=<STDIN>; chomp($resp);
if ($n eq $resp) {
        print "Correct!\n";
} else {
        print "Wrong, should be $n\n";
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
