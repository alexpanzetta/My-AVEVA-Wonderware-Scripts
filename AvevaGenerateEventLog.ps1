<#
.DESCRIPTION
    Register an Event Source in the Applciaiton log and use it for generating warning/Error events.
    This can be used to troubleshoot Aveva System Monitor (a.k.a Sentinel) rules processing and alert delivery

.USAGE    
    This needs to be ran as Administrator

.AUTHOR
        Alex Panzetta
        alex.panzetta@aveva.com

.NOTES   
    Name       : AvevaGenerateEventLog.ps1
    Version    : 1.0.0
    DateCreated: 11/12/2020
#>

New-EventLog -ComputerName $env:computername -Source AvevaGenerateEventLog -LogName Application -ErrorAction SilentlyContinue
Write-EventLog -LogName "Application" -Source "AvevaGenerateEventLog" -EventID 1 -EntryType Error -Message "Error Event generated from script, used to test Sentinel rules" -Category 1
Write-EventLog -LogName "Application" -Source "AvevaGenerateEventLog" -EventID 2 -EntryType Warning -Message "Warning Event generated from script, used to test Sentinel rules" -Category 1