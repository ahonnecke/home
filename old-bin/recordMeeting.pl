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
           "path=s",
           "author=s",
           "since=s",
           "cols=s",
           "log",
           "verbose",
           "debug",
           "email",
    );

my $reportDate = `date | sed -e 's/MDT//g'`;
my $dayEnd = `date +"%R"`.":00";
my $start = "08:15:00";
my $end = "17:00:00";
my $addPath = "~/github/bin/addTime.php";
my $fbUser = "Ashton"; #freshbooks user
my $log = 0;
my $verbose = 0;
my $debug = 0;
my $email = 1;
my $author = 'Ashton';
my $since = '4am';
my $path = "~/pixelstub/csuglobal/portal-csuglobal-edu/";
my $weekdayNum = `date +%u`;
my @addCommands = ();
my $output = '';
my @outputs = ();
my $totalTime = 0;
my $cols=150;
my $timePrintfString = "| %4s | %8s | %8s | %-25s | %-40s \n";
my $timePrintfDebugString = "| %4s | %8s | %8s | %-16s | %-50s | %-40s \n";

my @timeEntries = ();
my $hash;   

if($args{day}) {
    my $day = sprintf("%02d", $args{day});
    
    $reportDate = `date +"%Y-%m-$day"`;
    $dayEnd = "17:00:00";
}
if($args{log}) { $log = $args{log}; }
if($args{verbose}) { $verbose = $args{verbose}; }
if($args{debug}) { $debug = $args{debug}; }
if($args{email}) { $email = $args{email}; }
if($args{author}) { $author = $args{author}; }
if($args{since}) { $since = $args{since}; }
if($args{path}) { $path = $args{path}; }
if($args{end}) { $end = $args{end}; }
if($args{start}) { $start = $args{start}; }
if($args{cols}) { $cols = $args{cols}; }

chomp $reportDate;
chomp $dayEnd;

`cd $path && git fetch`;
my $dataCommand = " git log --pretty=format:\"%ad::%an::%d::%B\" ";
  $dataCommand .= " --reverse --all --since=$since --author=$author --date=local";

my $data = `cd $path && $dataCommand`;

my @commits = split(/\n/, $data);

my $lastTime = $start;
my $timeTotal = 0;

my $date = $reportDate;

my $today = `date +"%Y-%m-%d"`;
chomp($today);

foreach my $commit (@commits) {
    
    my @infos = split("::", $commit);
    
    if ( ! exists $infos[0]) { next; }
    
    my $stamp = $infos[0];
    my $author = $infos[1];
    my $branch = $infos[2];
    my $comment = $infos[3];

    my @stamps = split(" ", $stamp);
    my $time = $stamps[3];

    if($time eq $lastTime) {
        $time = $end;
    }
    #should be, if this is the last time entry, then
    #check to see if a end time was passed in
    
    my $s1 = str2time( $lastTime );
    my $s2 = str2time( $time );
    
    my $spent = ($s2 - $s1)/60/60;
    my $int = int($spent);

    chomp($branch);
    my $rawBranch = $branch;
    $branch =~ s/[\(, ,\)]//g;
    $branch =~ s/origin\///g;
    $branch =~ s/HEAD//g;
    $branch =~ s/master//g;
    $branch =~ s/ahonnecke//g;
    chomp($branch);

    if ($branch eq "") { $branch = 'portal'; }
    
    my $remainder = $spent - $int;

    $hash->{hours} = sprintf("%.2f", $spent * 1.30);
    $hash->{started} = $lastTime;
    $hash->{ended} = $time;
    $hash->{project} = $branch;
    $hash->{notes} = $comment;
    $hash->{task} = 'development';
    
    push(@timeEntries, $hash);
    
    if($debug != 0) {
        $hash->{branch} = $rawBranch;
    }

    $lastTime = $time;

    $output ='';
}

if($weekdayNum < 6) {
    my $scrum = {};
    $scrum->{hours} = .5;
    $scrum->{started} = '9:00:00';
    $scrum->{ended} = '9:30:00';
    $scrum->{project} = 'Scrum';
    $scrum->{notes} = 'Daily Stand Up Scrum';
    $scrum->{task} = 'Meetings';
    push(@timeEntries, $scrum);
}

if($weekdayNum == 4) {
    my $status = {};    
    $status->{hours} = 1;
    $status->{started} = '14:00:00';
    $status->{ended} = '15:00:00';
    $status->{project} = 'Status Meeting';
    $status->{notes} = 'Weekly IT Status Meeting';
    $status->{task} = 'Meetings';
    push(@timeEntries, $status);
}

my $lineBreak = print "=" x $cols;
print $lineBreak;

print "\n=";
print " " x ($cols/6);
printf("%30s -- %-44s", $author, $reportDate);
print " " x ($cols/6);
print "=\n";
print "=" x $cols;
print "\n";

if($debug != 0) {
    printf($timePrintfDebugString,
           'Time', 'Started', 'Ended', 'Project', 'Branch', 'Notes');
} else {
    printf($timePrintfString,
           'Time', 'Started', 'Ended', 'Project', 'Notes');
}
print "=" x $cols;
print "\n";

for my $href ( @timeEntries ) {
    if($debug != 0) {
        printf($timePrintfDebugString,
               $href->{hours}, $href->{started}, $href->{ended}, $href->{project}, $href->{branch}, $href->{notes});
    } else {
        printf($timePrintfString,
               $href->{hours}, $href->{started}, $href->{ended}, $href->{project}, $href->{notes});
    }

    my $comment = $href->{notes};

    if (exists $href->{branch}) {
        $comment = $href->{branch}." -- ".$href->{notes};
    }
    
    my $addCommand = sprintf("php %s '%s' '%s' %s %s %s '%s'",
                             $addPath, $href->{task}, $href->{project}, $fbUser, $href->{hours}, $today, $comment);

    push(@addCommands, $addCommand);
    $totalTime = $totalTime + $href->{hours};    
}

printf("| %2.2f |\n", $totalTime);
print "=" x $cols;
print "\n";

foreach my $addCommand (@addCommands) {
    if($debug != 0) { print "$addCommand\n"; }
}

print "Log time to freshbooks now? [y] ";
my $input = <STDIN>;	
chomp($input);

if($input eq 'n') {
    print "\nFine then, I didn't want your stupid timesheet anyway...\n";
} else {
    print "\nLogging hours to freshbooks...\n";
    
    foreach my $addCommand (@addCommands) {
        print ".\n";
        print `$addCommand`;
    }
}

exit 0;
