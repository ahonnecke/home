<?php
//Client name, must be in the freshbooks system already
$clientName = 'CSU Global';
$rate = 65; //defautl rate if none found

//you API url and token obtained from freshbooks.com
$url = "https://pixelstub.freshbooks.com/api/2.1/xml-in";
$token = "f1e097193974bb8a5218cca3971dd79a";

$usage = "Usage: $argv[0] <taskName> <hours>\n";

if(count($argv) < 1) die($usage);
    
$options = array_slice($argv, 1);
    
if(isset($options[0])) $date = $options[0];

if(! isset($date)) $date = date("Y-m-d");


//include particular file for entity you need (Client, Invoice, Category...)
include_once "/Users/ahonnecke/Library/FreshBooks/TimeEntry.php";
include_once "/Users/ahonnecke/Library/FreshBooks/Project.php";
include_once "/Users/ahonnecke/Library/FreshBooks/Task.php";
include_once "/Users/ahonnecke/Library/FreshBooks/Staff.php";
include_once "/Users/ahonnecke/Library/FreshBooks/Client.php";

/* function getTask($taskName) { */
/*     //new Task object */
/*     $taskGetter = new FreshBooks_Task(); */
    
/*     if(! $task = $taskGetter->getByName($taskName)) { */
/*         die("Unable to locate task '$taskName' \n"); */
/*     } else { */
/*         $task->rate = 65; */
/*     } */
    
/*     return $task; */
/* } */

//init singleton FreshBooks_HttpClient
FreshBooks_HttpClient::init($url,$token);

//new Project object
$timeGetter = new Freshbooks_TimeEntry();

$times = $timeGetter->getByDate($date);

echo count($times). " time entries found on $date\n";

$burns = array();

foreach($times as $time) {
    $comments = explode(',', $time->notes); 
    $count = preg_match_all('/TA.[0-9]/' ,
                            $time->notes,
                            $out);

    if($count == 0) continue;
    
    $time = $time->hours / $count;

    foreach($out[0] as $task) {
        $cmd = "ralio time $task $time\n";
        echo $cmd;
        $burns[] = $cmd;
    }
}

if(count($burns) == 0) die("Nothing to burn down: no task numbers located...\n");

echo "Burn that shit? (Y/N) - ";

$stdin = fopen('php://stdin', 'r');
$response = fgetc($stdin);
if ($response != 'Y') {
   echo "Aborted.\n";
   exit;
}

foreach($burns as $burn) {
    echo $burn;
    echo exec($burn);
}