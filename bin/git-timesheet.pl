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
           "before=s",
           "after=s",
           "cols=s",
           "project=s",
           "log",
           "verbose",
           "debug",
           "yesterday",
           "edit",
    );

my $dateTitle = `date | sed -e 's/MDT//g'`;
my $reportDate = 0;

my $dayEnd = `date +"%R"`.":00";
my $day = 0;
my $start = "08:15:00";
my $end = "17:00:00";
my $addPath = "~/github/bin/addTime.php";
my $fbUser = "Ashton"; #freshbooks user
my $log = 0;
my $verbose = 0;
my $debug = 0;
my $yesterday = 0;
my $before = '';
my $after = '12am';
my $project = 'portal'; #default project
my $edit = 0;
my $author = 'Ashton';
my $path = "~/pixelstub/csuglobal/portal-csuglobal-edu/";
my $weekdayNum = `date +%u`;
my @addCommands = ();
my $output = '';
my @outputs = ();
my $totalTime = 0;
my $cols=150;
my $timePrintfString = "| %5s | %8s | %8s | %-25s | %8s | %-40s \n";
my $timePrintfDebugString = "| %5s | %8s | %8s | %-20s | %-60s | %8s | %-40s \n";

my @timeEntries = ();

if($args{yesterday}) {
    $reportDate = `last_workday.sh`;
    chomp($reportDate);
    $after = $reportDate; #should be  2 days ago
#    $before = `date +"%Y-%m-%d"`; should get yesterday's number
    
    #if its monday, and we pass in yesterday pretend its friday
    if($weekdayNum == 1) {
        $weekdayNum = 5;
    } else {
        $weekdayNum = $weekdayNum=1;
    }
} elsif($args{day}) {    
    $day = sprintf("%02d", $args{day});
    
    $reportDate = `date +"%Y-%m-$day"`;
    print $reportDate;
    
    $dayEnd = "17:00:00";
} else {    
    $reportDate = `date +"%Y-%m-%d"`;
}
if($args{after}) { $after = $args{after}; }
if($args{before}) { $before = $args{before}; }

if($args{log}) { $log = $args{log}; }
if($args{verbose}) { $verbose = $args{verbose}; }
if($args{debug}) { $debug = $args{debug}; }
if($args{edit}) { $edit = $args{edit}; }
if($args{author}) { $author = $args{author}; }
if($args{path}) { $path = $args{path}; }
if($args{end}) { $end = $args{end}; }
if($args{start}) { $start = $args{start}; }
if($args{cols}) { $cols = $args{cols}; }
if($args{project}) { $project = $args{project}; }

chomp $reportDate;
chomp $dayEnd;

`cd $path && git fetch --all --quiet`;
my $dataCommand = " git log --pretty=format:\"%ad::%an::%d::%B\" ";
$dataCommand .= " --reverse --all --author=$author --date=local";

if($before ne "") { $dataCommand .= " --before={$before}"; }
if($after ne "") { $dataCommand .= " --after={$after}"; }

if($debug != 0) { print "Git log: ".$dataCommand."\n"; }

my $data = `cd $path && $dataCommand`;

my @commits = split(/\n/, $data);

my $lastTime = $start;
my $timeTotal = 0;

chomp($reportDate);

foreach my $commit (@commits) {    
    my @infos = split("::", $commit);
    
    if ( ! exists $infos[0]) { next; }

    if($debug != 0) { print "DEBUG commit: ".$commit."\n"; }

    
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
    
    my $spent = abs(($s2 - $s1)/60/60);

    #if hours is more than 24 that bug is back,
    #mod it by 2 to get some time, but not a crazy amount
    if( $spent >= 24 ) {
        $spent = ($spent % 2);
    }
    
    my $int = int($spent);

    chomp($branch);
    my $rawBranch = $branch;

    my @branches = split(',', $rawBranch);
    my $finalBranch = '';

    foreach my $branch (@branches){
    
        $branch =~ s/[\(, ,\)]//g;
        $branch =~ s/origin\///g;
        $branch =~ s/HEAD//g;
        $branch =~ s/master//g;
        $branch =~ s/ahonnecke//g;
        if($debug != 0) { print "DEBUG BRANCH: ".$branch."\n"; }

        if ($branch ne "") { $finalBranch = $branch; }
        chomp($branch);
    }
    $branch = $finalBranch;
    chomp($branch);
    chomp($rawBranch);

    if ($branch eq "") { $branch = $project; }
    
    my $remainder = $spent - $int;
    my $hash = {};

    $hash->{hours} = sprintf("%2.2f", $spent * 1.25); #assuming 10% deploy and testing time after commit
    $hash->{started} = $lastTime;
    $hash->{ended} = $time;
    $hash->{project} = $branch;
    $hash->{task} = 'development';
    $hash->{branch} = $rawBranch;

    if($comment =~ /(TA[0-9]*)/) {
        $hash->{rallytask} = $1;
        my $rallyCommentCommand = "ralio show $1 | perl -pe 's/\x1b\[[0-9;]*m//g' | head -n1 | awk -F'❙' '{print \$1}' | awk -F'-' '{print \$2}'";
        if($debug != 0) { print "$rallyCommentCommand \n"; }
        my $rallyComment = `$rallyCommentCommand`;
        chomp($rallyComment);
        if($debug != 0) { print "$rallyComment \n"; }
        
        $hash->{notes} = "$comment$rallyComment";
    } else {
        $hash->{rallytask} = 'N/A';
        $hash->{notes} = $comment;
    }
    
    push(@timeEntries, $hash);

    $lastTime = $time;

    $output ='';
}

if($weekdayNum < 6) {
    my $scrum = {};
    $scrum->{hours} = .25;
    $scrum->{started} = '9:00:00';
    $scrum->{ended} = '9:30:00';
    $scrum->{project} = 'Scrum';
    $scrum->{notes} = 'Daily Stand Up Scrum';
    $scrum->{task} = 'Meetings';
    $scrum->{branch} = 'N/A';
    $scrum->{rallytask} = 'N/A';
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
    $status->{branch} = 'N/A';
    $status->{rallytask} = 'N/A';
    push(@timeEntries, $status);
}

chomp($dateTitle);

print "=" x $cols;

print "\n";
my $title = sprintf("%25s -- %25s", $author, $dateTitle);
printf("=%55s", $title);
print " " x ($cols-57);
print "=\n";
print "=" x $cols;
print "\n";

if($debug != 0) {
    printf($timePrintfDebugString,
           'Time', 'Started', 'Ended', 'Project', 'Branch', 'Task #', 'Notes');
} else {
    printf($timePrintfString,
           'Time', 'Started', 'Ended', 'Project', 'Task #', 'Notes');
}
print "=" x $cols;
print "\n";

for my $href ( @timeEntries ) {
    if($debug != 0) {
        printf($timePrintfDebugString,
               $href->{hours},
               $href->{started},
               $href->{ended},
               $href->{project},
               $href->{branch},
               $href->{rallytask},
               $href->{notes});
    } else {
        printf($timePrintfString,
               $href->{hours},
               $href->{started},
               $href->{ended},
               $href->{project},
               $href->{rallytask},
               $href->{notes});
    }

    my $comment = $href->{notes};

    if (exists $href->{branch} && $href->{branch} ne '') {
        $comment = $href->{branch}." -- ".$href->{notes};
    }

    chomp($comment);

    my $addCommand = sprintf("php %s '%s' '%s' %s %s %s '%s'",
                             $addPath,
                             $href->{project},
                             $href->{task},
                             $fbUser,
                             $href->{hours},
                             $reportDate,
                             $comment);
    my $burnCommand = '';
    
    # if ($href->{rallytask} ne 'N/A') {
    #     $burnCommand = sprintf("; railo time %s %s",
    #                              $href->{rallytask},
    #                              $href->{hours});
    # }

    push(@addCommands, $addCommand . $burnCommand);
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

if($input eq 'y') {
    print "\nLogging hours to freshbooks...\n";
    
    foreach my $addCommand (@addCommands) {
        print ".\n";
        print `$addCommand`;
    }
} else {
    print "\nFine then, I didn't want your stupid timesheet anyway...\n";
}

exit 0;
