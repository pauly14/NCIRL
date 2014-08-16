#!/usr/bin/perl

my $version = "0.2";
my $answer;
my $c; my $v; my $t;
my $timeout = 7;

print "Spinner. Version: $version. (C) FS 2014\n";

my @func = qw(calc base10tobase2 base10tohex hextobase10 binarytobase10 hextobinary binarytohex calcbase2 calcbase16);
my @func = qw(base10tobase2 base10tohex hextobase10 binarytobase10 hextobinary binarytohex calcbase2 calcbase16 complement2s);

while (1) {
eval {
        local $SIG{ALRM} = sub { die "timeout\n" }; # NB: \n required
        my $func = @func[int rand @func];
        ($c, $v, $t) = &$func;
        $timeout = gettar($t); $timeout = 1000;
        alarm $timeout;
        print $c,": ";
        $answer = <STDIN>;
        chomp($answer);
        alarm 0;
    };

print "\n" if !$answer;
if ($v eq $answer) {
        print "Correct!\n";
} else {
        print "Wrong, should be $v\n";
}
}

exit;

sub gettar {
my $tar = shift;
my $timeout = 60;
if ($tar eq 'A') {
        $timeout = 5;
} elsif ($tar eq 'B') {
        $timeout = 10;
} elsif ($tar eq 'C') {
        $timeout = 20;
} elsif ($tar eq 'D') {
        $timeout = 40;
} elsif ($tar eq 'E') {
        $timeout = 60;
} elsif ($tar eq 'F') {
        $timeout = 120;
} elsif ($tar eq 'G') {
        $timeout = 300;
}
return ($timeout);
}

sub calc {
my $n1 = gen_random(1,12);
my $n2 = gen_random(1,12);
my @oplist = qw(+ - * /);
my @optariff = qw(A A C D);
my $r = int rand @oplist;
my $op = @oplist[$r];
my $tar = @optariff[$r];
my $c = "$n1 $op $n2";
my $v = eval($c);
return $c,$v,$tar;
}

sub base10tobase2{
my $tar = 'C';
my $n1 = gen_random(1,255);
my $v = sprintf("%b",$n1);
my $c = "$n1 (base 10) -> binary";
return $c,$v,$tar;
}

sub base10tohex{
my $tar = 'C';
my $n1 = gen_random(1,255);
my $v = sprintf("%x",$n1);
my $c = "$n1 (base 10) -> hex";
return $c,$v,$tar;
}

sub hextobase10{
my $tar = 'C';
my $v = gen_random(1,255);
my $n1 = sprintf("%x",$v);
my $c = "$n1 (hex) -> decimal";
return $c,$v,$tar;
}

sub binarytobase10 {
my $tar = 'C';
my $v = gen_random(1,255);
my $n1 = sprintf("%b",$v);
my $c = "$n1 (binary) -> decimal";
return $c,$v,$tar;
}

sub hextobinary{
my $tar = 'B';
my $v = gen_random(1,255);
my $n1 = sprintf("%x",$v);
my $n2 = sprintf("%b",$v);
my $c = "$n1 (hex) -> binary";
return $c,$n2,$tar;
}

sub binarytohex{
my $tar = 'B';
my $v = gen_random(1,255);
my $n1 = sprintf("%b",$v);
my $n2 = sprintf("%x",$v);
my $c = "$n1 (binary) -> hex";
return $c,$n2,$tar;
}

sub calcbase2 {
my $n1 = sprintf("%b",gen_random(1,255));
my $n2 = sprintf("%b",gen_random(1,255));
my @oplist = qw(* + - & | ^ ~);
my @optariff = qw(B C B B B B);
my $r = int rand @oplist;
my $op = @oplist[$r];
my $tar = @optariff[$r];
my ($c1, $c);
if ($op eq '~') {
        $c1 = "~0b$n1 & 0xFF";
        $c = "not $n1 (binary)";
} else {
        $c1 = "(0b$n1 $op 0b$n2) & 0xFF";
        $c = "$n1 $op $n2 (binary)";
}
my $v = sprintf("%b",eval($c1));
return $c,$v,$tar;
}

sub calcbase16 {
my $n1 = sprintf("%x",gen_random(1,255));
my $n2 = sprintf("%x",gen_random(1,255));
my @oplist = qw(+ - & | ^ ~);
my @optariff = qw(B C B B B B);
my $r = int rand @oplist;
my $op = @oplist[$r];
my $tar = @optariff[$r];
my ($c1, $c);
if ($op eq '~') {
        $c1 = "~0x$n1 & 0xFF";
        $c = "not $n1 (hex)";
} else {
        $c1 = "(0x$n1 $op 0x$n2) & 0xFF";
        $c = "$n1 $op $n2 (hex)";
}
my $v = sprintf("%x",eval($c1));
return $c,$v,$tar;
}

sub complement2s {
my $tar = 'B';
my $v = gen_random(1,127);
my $n1 = sprintf("%b",(~$v + 1) & 0xFF);
my $c = "$v (base10) -> 2s complement";
return $c,$n1,$tar;
}



sub dec_bin2s {
return unpack "B8", pack "c", shift;
}

sub gen_random {
my ($min, $max) = @_;
my $num = int(rand(($max - $min) + 1)) + $min;
return $num;
}
