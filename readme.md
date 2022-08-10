# TimeTracker Documentation

## Overview

TimeTracker.psm1 is a simple tool designed to help you track daily time entries. Each time the script is run, it creates a comma seperated file with the current data. Each command you use relies on the current data to execute. If you miss daily entry for time, we currently do not expose a method to get the caluations done automaticlly. But you will have the time tracked in the file stored on your drive. 

* ``` Note: PowerShell runs on Windows, Linux and MacBook ```

## Setup
Run the [Setup Script](/Setup.ps1) as an administrator to avoid some permission issues. This script copies the PowerShell modules within this repository to the Powershell modules directory on your system under your user profile. It will create a directory for each and makes running the commands natively to your PowerShell session simple and easy to use. 

## Add-TimeRecord
To track a time entry, you need to invoke the script and pass two paramaters: ConversationID and TimeInMinutes.

``` Add-Time 53577900000517 5 ```

## Get-TimeRecord
To Get today's Time Log run

``` Get-TimeRecord ```

## Remove Time from Record
If you need to remove time from a record, use the same record ID (first paramater) and then put in a negative number which would indicate how much time to remove from your entry.

``` 
    Add-TimeRecord 53577900993738 -1 
    ConversationID: 53577900993738 Total Minutes 80
    Labor Date 08-10-2022 Total Minutes Worked 80
```

## End of Day Report

As the day goes on, you will add more time. To your daily report, call the Get-TimeRecord method of the script like this:
``` 
    ConversationID: 53577900000517 Total Minutes 15
    ConversationID: 53577900000458 Total Minutes 15
    ConversationID: 13577900000517 Total Minutes 145
    Labor Date 07-02-2020 Total Minutes Worked 175
```

This should help you imprpove your time tracking ability.

# To-Do
It might be nice to be able to remove an entry or substract time. I haven't tested but it may be possible to just pass a negative number to the script and during final calcuation, p