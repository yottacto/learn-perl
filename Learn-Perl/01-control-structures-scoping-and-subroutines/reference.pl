#!/usr/bin/perl

use 5.26.1;
use warnings;
use strict;

# my @array = (1, 2, 3);
# my $array_ref = \@array;
# say $array_ref->[0];
# my %hash = (a => 1, b => 2, c => 3);
# my $hash_ref = \%hash;
# say $hash_ref->{a};

# my $array_ref = [1, 2, 3];
# say $array_ref->[0];
# my $hash_ref = {a => 1, b => 2, c => 3};
# say $hash_ref->{a};

my @arrays = ([1, 2, 3], [4, 5, 6]);
my $array_ref = $arrays[1];
say $array_ref->[1];
say $arrays[1][1];
say $arrays[1]->[1];
say join(',', @$_) for @arrays;
say $_ for @{$arrays[0]};

my $scalar = 4;
say ref \$scalar;

