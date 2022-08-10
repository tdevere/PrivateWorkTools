[[_TOC_]]

# TimeTracker Documentation

## Overview

TimeTracker.ps1 is a simple tool designed to help you track daily time entries. Each time the script is run, it creates a comma seperated file with the current data. Each command you use relies on the current data to execute. IF you miss daily entry for time, we currently do not expose a method to get the caluations done automaticlly. But you will have the time tracked in the file. 

* PowerShell runs on Windows, Linux and MacBook

## Setup
Run the [Setup Script](/Setup.ps1) as an administrator to avoid some permission issues. This script copies the PowerShell modules within this repository to the Powershell modules directory on your system under your user profile. This makes running the commands natively to your PowerShell session simple and easy to use. 

## Add-TimeRecord
To track a time entry, you need to invoke the script and pass two paramaters: ConversationID and TimeInMinutes.

    ``` Add-Time 53577900000517 5 ```

## Get-TimeRecord
To Get today's Time Log run

    ``` Get-TimeRecord ```

# Notes

As the day goes on, you will add more time and so here is an example of the raw file at the end of the day:

``` 
"ConversationID","TimeWorked"
53577900000517,5,5,5
53577900000458,5,10
13577900000517,15,15,15,15,15,15,15,20,20
```

To your daily report, call the Get-TimeRecord method of the script like this:

``` 
ConversationID: 53577900000517 Total Minutes 15
ConversationID: 53577900000458 Total Minutes 15
ConversationID: 13577900000517 Total Minutes 145
Labor Date 07-02-2020 Total Minutes Worked 175
```

This should help you imprpove your time tracking ability.

