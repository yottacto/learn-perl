#!/usr/bin/perl

use 5.26.1;
use warnings;
use strict;

my $team_number = 42;
my $filename = 'input';

open(my $fh, '<', $filename) or die "cannot open '$filename' $!";

while (<$fh>) {
    chomp;
    last if ($_ eq "Team $team_number");
}
die "cannnot find 'Team $team_number'" if (eof $fh);

my $max_bugs = -1;
my $max_name;
while (my $line = <$fh>) {
    chomp($line);
    next if $line eq "";
    last if ($line =~ m/^Team \d+$/);
    $line =~ m/^(\w+): (\d+)$/;
    my ($name, $bugs) = ($1, $2);
    die "malformed '$line'" unless(defined $bugs);
    if ($bugs > $max_bugs) {
        $max_bugs = $bugs;
        $max_name = $name;
    }
}

if ($max_bugs > 0) {
    say "cong $max_name! Winner Winner Chicken Dinner!";
} else {
    say "Nobody fixed any bugs!";
}

