#!/usr/bin/perl

use strict;
use warnings;
use Date::Parse;
use Getopt::Long;
use Data::Dumper;

my %args;
GetOptions(\%args,
           "day=s",
           "start=s",
           "end=s",
           "project=s",
           "notes=s",
           "task=s",
           "verbose",
           "debug");

my $addPath = "~/github/bin/addTime.php";
my $fbUser = "Ashton"; #freshbooks user

my $start = `date +"%R"`;
chomp $start;
if($args{start}) { $start = $args{start}; }

my $debug = 0;
if($args{debug}) { $debug = $args{debug}; }

my $verbose = 0;
if($args{verbose}) { $verbose = $args{verbose}; }

my $date = `date +"%Y-%m-%d"`;
if($args{day}) {
    my $day = sprintf("%02d", $args{day});

    $date = `date +"%Y-%m-$day"`;
}
chomp $date;
my $notes = '';
my $project = '';
my $task = '';
my $end = '';

if($args{notes}) {
    $notes = $args{notes};
} else {
    print 'Notes: ';
    $notes = <STDIN>;
    chomp($notes);
}

if($args{project}) {
    $project = $args{project};
} else {
    print 'Project [portal]: ';
    $project = <STDIN>;
    chomp($project);
}
if ($project eq "") { $project = 'portal'; }

if($args{task}) {
    $task = $args{task};
} else {
    print 'Task [meetings]: ';
    $task = <STDIN>;
    chomp($task);
}
if ($task eq "") { $task = 'meetings'; }    

if($args{end}) {
    $end = $args{end};
} else {
    print "No end time furninshed; Hit any key to complete...";
    my $input = <STDIN>;
    $end = `date +"%R"`;
}

if($debug != 0) { print "start: $start\n"; }
if($debug != 0) { print "end: $end\n"; }

# if($debug != 0) { print "start: ".str2time($start)."\n"; }
# if($debug != 0) { print "end: ".str2time($end)."\n"; }

my $difference = (str2time( $end ) - str2time( $start ));

if($debug != 0) { print "difference: $difference\n"; }

my $hours = sprintf("%.2f", ($difference/60/60) * 1.10);

if($debug != 0) { print "hours: $hours\n"; }

my $addCommand = "php $addPath '$project' '$task' '$fbUser' $hours $date '$notes'";
if($debug != 0) {
    print "$addCommand\n";

    print 'Confirm write to freshbooks?';
    $task = <STDIN>;
    chomp($task);
}
print `$addCommand`;

exit;
