#!/usr/bin/perl

use 5.26.1;
use warnings;
use strict;

my $team_number = 42;
my $filename = 'input';

open(my $fh, '<',$filename) or die "cannot open '$filename' $!";

my $found;
while (<$fh>) {
    if (m/^Team (\d+)$/) {
        next if ($1 != $team_number);
        $found = 1;
        last;
    }
}
die "cannnot find 'Team $team_number'" unless($found);

