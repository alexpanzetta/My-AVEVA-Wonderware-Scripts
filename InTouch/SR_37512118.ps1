<#
.DESCRIPTION
    This script will check if the Window Viewer process is running; if not, it will terminate alarmmgr.
    If View.exe is terminated and the corresponding alarmmgr.exe process is not, Alarm Clients won't show alarms

.AUTHOR
        Alex Panzetta
        alex.panzetta@aveva.com

.NOTES   
    Name       : SR_37512118.ps1
    Version    : 1.0.0
    DateCreated: August 2020
#>

# Infinite loop; this will run until the script is stopped 
while (1 -eq 1){
    # Get the status of WindowViewer (view.exe) and AlarmMgr.exe
    $view = Get-Process view -ErrorAction SilentlyContinue
    # If View.exe is not running, Logoff current user
    if (!$view) {
        # Logoff current user
        Get-Process | Where-Object {$_.SI -eq (Get-Process -PID $pid).SessionID -and $_.Name -eq 'alarmmgr'} | Stop-Process -Force
    }
    # Free up variables
    Remove-Variable view
    # Wait for one minute
    Start-Sleep 60
}