<?php
//Client name, must be in the freshbooks system already
$clientName = 'CSU Global';
$rate = 65; //defautl rate if none found

//you API url and token obtained from freshbooks.com
$url = "https://pixelstub.freshbooks.com/api/2.1/xml-in";
$token = "f1e097193974bb8a5218cca3971dd79a";

$usage = "Usage: $argv[0] <projectName> <taskName> <staffName> <hours> [date] [notes] \n";

if(count($argv) < 3) die($usage);
    
$options = array_slice($argv, 1);
    
$projectName = $options[0];
$taskName = $options[1];
$staffName = $options[2];
$hours = $options[3];
if(isset($options[4])) $date = $options[4];
if(isset($options[5])) $notes = $options[5];

if(!$projectName || empty($projectName)) $projectName = 'portal';
if(!$hours) {
    echo "Hours are required\n";
    die($usage);
}

if(!$taskName) {
    echo "Task Name is required\n";
    die($usage);
}

if(! isset($date)) $date = date("H-m-d");

if(!is_numeric($hours)) {
    echo "'$hours' must be a number... but it's not now is it? \n";
    die($usage);
}

//include particular file for entity you need (Client, Invoice, Category...)
include_once "/Users/ahonnecke/Library/FreshBooks/TimeEntry.php";
include_once "/Users/ahonnecke/Library/FreshBooks/Project.php";
include_once "/Users/ahonnecke/Library/FreshBooks/Task.php";
include_once "/Users/ahonnecke/Library/FreshBooks/Staff.php";
include_once "/Users/ahonnecke/Library/FreshBooks/Client.php";

function getTask($taskName) {
    //new Task object
    $taskGetter = new FreshBooks_Task();
    
    if(! $task = $taskGetter->getByName($taskName)) {
        die("Unable to locate task '$taskName' \n");
    } else {
        $task->rate = 65;
    }
    
    return $task;
}

//init singleton FreshBooks_HttpClient
FreshBooks_HttpClient::init($url,$token);

//new Project object
$projectGetter = new FreshBooks_Project();

if(! $project = $projectGetter->getByName($projectName)) {

    $clientGetter = new FreshBooks_Client();
    if($client = $clientGetter->getByName($clientName)) {
    
        $project = new FreshBooks_Project();
        $project->name = ucfirst($projectName);
        $project->clientId = $client->clientId;
        $project->rate = "55";
        $project->billMethod = "project-rate";

        $task = getTask($taskName);

        if(!$task) {
            die("Unable to get task\n");
        }
        
        $project->tasks = array($task->taskId);
        
        if(!$response = $project->create()) {
            print_r($project);
            
            die("Unable to create project '$projectName' \n");
        }
        
        echo "Created project '$projectName' \n";
    }  else {
        die("Unable to locate client '$clientName' \n");
    }
}

$task = getTask($taskName);

//new Staff object
$staffGetter = new FreshBooks_Staff();

if(! $staff = $staffGetter->getByFirstName($staffName)) {
    die("Unable to locate staff '$staffName' \n");
}


$timeEntry = new FreshBooks_TimeEntry();

$timeEntry->projectId = $project->projectId;
$timeEntry->taskId = $task->taskId;
$timeEntry->staffId = $staff->staffId;
$timeEntry->hours = $hours;
$timeEntry->date = $date;
if($notes) $timeEntry->notes = $notes;

if(!$response = $timeEntry->create()) {
    echo "Unable to create time entry \n";
    print_r($timeEntry);
    die();
}