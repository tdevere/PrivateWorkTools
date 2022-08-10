<#
 .Synopsis
  TimeTracker is a simple tool designed to help you track daily time entries. Each time the script is run, it creates a comma seperated file with the current data. Each command you use relies on the current data to execute. IF you miss daily entry for time, we currently do not expose a method to get the caluations done automaticlly. But you will have the time tracked in the file.

 .Description
  TimeTracker.ps1 is a simple tool designed to help you track daily time entries. Each time the script is run, it creates a comma seperated file with the current data. Each command you use relies on the current data to execute. IF you miss daily entry for time, we currently do not expose a method to get the caluations done automaticlly. But you will have the time tracked in the file.

  .Example
   # Add-TimeRecord - Takes case ID and Time paramaters (in minutes)
   Add-Time 53577900000517 5

 .Example
   # Get-TimeRecord - Returns today's time record
   Get-TimeRecord

#>

#Date is used to create a daily log file
$todaysDate = Get-Date -Format "MM-dd-yyyy"
#This is the path to your timeshee storage
$timeSheetPath = "$env:userprofile\Documents\timesheet"
#this is the dynamic date generated file
$timeSheet = $timeSheetPath + "\timesheet_" +  $todaysDate + ".csv"
#bool used to determine if the shee was already created; this may not be necessary but I left it here
$timeSheetCreated = "false"


#Method to read today's timesheet and create list of cases and times you worked on
Function Get-TimeRecord
{

    #Get the current timesheet
    $CurrentTimeSheet = Get-Content $timeSheet
    #Var for storing the entire time collected across all tracked items today
    $CompleteMinutes = New-Object System.Int32
    #Loop but split by line return and skip the first instanace (the first instance is table header)
    foreach ($line in ($CurrentTimeSheet -split "`r`n" | Select-Object -Skip 1))
    {
        #break up of reach comma seperated entry
        $splitLine = $line -split ','
        #counter for adding time in this single row
        $ConvIdtotalMinutes = New-Object System.Int32
        #Use to tell if I am on the first time in the loop; that first value is the case number; the rest are time entries
        $count = 0
        foreach ($split in $splitLine)
        {
            #see note above
            if ($count -eq 0)
            {
                $count = 1
                $ConvId = $split #Conversation ID
            }
            else
            {
                [int]$ConvIdtotalMinutes += [int]$split #used to added time to previous selection
            }
        }
        
        $msg = [String]::Format("ConversationID: {0} Total Minutes {1}", $ConvId, [int]$ConvIdtotalMinutes)
        $msg #Print out results on each loop
        [int]$CompleteMinutes += [int]$ConvIdtotalMinutes #Add to total time
    }
    
    $finalmsg = [String]::Format("Labor Date {0} Total Minutes Worked {1}", $todaysDate, [int]$CompleteMinutes)
    return $finalmsg #display final report message for total time
}

#Method used to add entries for your cases
Function Add-TimeRecord
{
    Param ($ConversationId, $TimeInMinutesToAdd)

    #Important to note, there is no quality check here.
    #if user gets ID wrong, we'll still track time

    if ($timeSheetCreated -ne "true")
    {
        New-TimeRecord 
    }

    #Does ConversationId Exist?

    $CurrentTimeSheet = Get-Content $timeSheet

    $conIdExists = $CurrentTimeSheet | Select-String -SimpleMatch $ConversationId.ToString()
    
    if ($conIdExists)
    {
        $conIdExists.LineNumber        
        $newTime = "," + $TimeInMinutesToAdd.ToString()
        $CurrentTimeSheet[$conIdExists.LineNumber-1] += $newTime
        $CurrentTimeSheet | Set-Content $timeSheet
    }
    else
    {
        #New entry
        $newEntry = $ConversationId.ToString() + "," + $TimeInMinutesToAdd.ToString()
        $newEntry
        Add-Content -Path $timeSheet $newEntry
    }

    #Display Updated Timesheet
    return (Get-TimeRecord)

}

Function New-TimeRecord
{
    #If the directory doesn't exist, created it
    if (Test-Path -Path $timeSheetPath)
    {    
    }
    else 
    {
        New-Item -Path $timeSheetPath -ItemType Directory
    }

     #If today's sheet doesn't exist, created it
    if (Test-Path -Path $timeSheet)
    {
    }
    else
    {
        Add-Content -Path $timeSheet -Value '"ConversationID","TimeWorked"'        
    }    
}

Export-ModuleMember -Function Get-TimeRecord
Export-ModuleMember -Function Add-TimeRecord

