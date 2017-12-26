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

my %bugs;
my $max_bugs = 0;
my @max_name;
while (my $line = <$fh>) {
    chomp($line);
    next if ($line eq "");
    last if ($line =~ m/^Team \d+$/);
    my ($name, $bugs) = split(/: +/, $line, 2);
    die "malformed '$line'" unless(defined $bugs);
    $bugs{$name} = $bugs;
    if ($bugs > $max_bugs) {
        $max_bugs = $bugs;
        @max_name = $name;
    } elsif ($bugs == $max_bugs) {
        push(@max_name, $name)
    }
}

say "$_: $bugs{$_}" for (sort keys %bugs);
say "@max_name wins!";

