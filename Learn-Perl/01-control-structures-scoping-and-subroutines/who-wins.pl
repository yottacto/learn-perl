use 5.26.1;
use warnings;
use strict;

my $team_number = 42;
my $filename = 'input';

open my $fh, '<', $filename or die "cannot open '$filename'";

my %bugs = get_team_stats($fh, $team_number);

say "Bug created:";
say "\t$_: $bugs{$_}[1]" for sort {$bugs{$b}[1] <=> $bugs{$a}[1]} keys %bugs;

say "Bug fixed";
say "\t$_: $bugs{$_}[0]" for sort {$bugs{$b}[0] <=> $bugs{$a}[0]} keys %bugs;

my @winners = get_winners(map {$_ => $bugs{$_}[0] - $bugs{$_}[1]} keys %bugs);
say "cong, $_ win!" for @winners;

sub get_team_stats
{
    my ($fh, $team_number) = @_;
    my $found;
    my @stats;
    while (<$fh>) {
        chomp;
        next if $_ eq "";
        if (m/^Team (\d+)$/) {
            last if $found;
            $found = 1 if $1 == $team_number;
            next;
        }
        next unless $found;
        my ($name, @data) = split(/[:,] +/);
        die "malformed '$_', data: @data" unless @data == 2;
        push @stats, $name, \@data;
    }
    die "nothing for team $team_number" unless @stats;
    return @stats;
}

sub get_winners
{
    my %data = @_;
    my @win;
    my $max = 0;
    for my $key (keys %data) {
        if ($data{$key} > $max) {
            $max = $data{$key};
            @win = $key;
        } elsif ($data{$key} == $max) {
            push @win, $key;
        }
    }
    return @win;
}

