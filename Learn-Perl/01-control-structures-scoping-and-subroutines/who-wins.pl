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
my %created;
my $max_bugs = 0;
my @max_name;
while (my $line = <$fh>) {
    chomp($line);
    next if ($line eq "");
    last if ($line =~ m/^Team \d+$/);
    my ($name, $fixed, $created) = split(/[:,] +/, $line, 3);
    die "malformed '$line'" unless(defined $created);
    $bugs{$name}    = $fixed;
    $created{$name} = $created;
    my $net = $fixed - $created;
    if ($net > $max_bugs) {
        $max_bugs = $net;
        @max_name = $name;
    } elsif ($net == $max_bugs) {
        push(@max_name, $name)
    }
}

say "Bugs created:";
say " $_: $created{$_}" for sort {-($created{$a} <=> $created{$b})} keys %created;

say "Bugs fixed:";
say " $_: $bugs{$_}" for sort keys %bugs;

say "@max_name wins!";

