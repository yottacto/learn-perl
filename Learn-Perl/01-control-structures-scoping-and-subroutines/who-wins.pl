#!/usr/bin/perl

use 5.26.1;
use warnings;
use strict;

my $team_number = 42;
my $filename = 'input';

open my $fh, '<', $filename or die "cannot open '$filename' $!";

my %bugs = get_team_stats($fh, $team_number);

say "Bugs created:";
say " $_: $bugs{$_}[1]" for sort {$bugs{$b}[1] <=> $bugs{$a}[1]} keys %bugs;

say "Bugs fixed";
say " $_: $bugs{$_}[0]" for sort keys %bugs;

my @winners = get_winners(map {$_ => $bugs{$_}[0] - $bugs{$_}[1]} keys %bugs);

say "$_ wins!" for @winners;

exit;

sub get_team_stats
{
    my ($fh, $number) = @_;

    my @data;
    my $found;
    while (my $line = <$fh>) {
        chomp $line;
        next if $line eq "";
        if ($line =~ m/^Team (\d+)$/) {
            last if $found;
            $found = 1 if $number == $1;
            next;
        }
        next unless $found;
        my ($name, @stats) = split(/[:,] +/, $line);
        die "malformed $line" unless @stats == 2;
        push @data, $name, \@stats;
    }
    die "nothing for team $number" unless @data;
    return @data;
}

sub get_winners
{
    my %data = @_;

    my @win;
    my $max = 0;
    for my $key (keys %data) {
        if ($data{$key} > $max) {
            @win = ($key);
            $max = $data{$key};
        } elsif ($data{$key} == $max) {
            push @win, $key;
        }
    }
    return @win;
}

