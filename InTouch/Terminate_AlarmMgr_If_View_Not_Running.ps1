<#
.DESCRIPTION
    This script will check if the Window Viewer process is running; if not, it will terminate alarmmgr.
    If View.exe is terminated and the corresponding alarmmgr.exe process is not, Alarm Clients won't show alarms

.AUTHOR
        Alex Panzetta
        alex.panzetta@aveva.com

.NOTES   
    Name       : Terminate_AlarmMgr_If_View_Not_Running.ps1
    Version    : 1.0.0
    DateCreated: August 2020
#>

# Infinite loop; this will run until the script is stopped 
while (1 -eq 1){
    # Get the status of WindowViewer (view.exe) and AlarmMgr.exe
    $view = Get-Process -ErrorAction SilentlyContinue | Where-Object {$_.SI -eq (Get-Process -PID $pid).SessionID } 
    # If View.exe is not running, stop alarmmgr
    if (!$view) {
        # Checkf if alarmmgr is present
        Get-Process | Where-Object {$_.SI -eq (Get-Process -PID $pid).SessionID -and $_.Name -eq 'alarmmgr'} | Stop-Process -Force
    }
    # Free up variables
    Remove-Variable view
    # Wait for one minute
    Start-Sleep 60
}
