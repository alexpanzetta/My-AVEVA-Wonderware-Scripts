<#
.DESCRIPTION
    This script will stop and disable Sentinel services for the computers
    listed in the $ComputersFile 

.AUTHOR
        Alex Panzetta
        alex.panzetta@aveva.com

.NOTES   
    Name       : StopDisable-Sentinel.ps1
    Version    : 1.0.0
    DateCreated: February 2021
#>

$ComputersFile = "C:\Temp\Sentinel_computers.txt"

foreach($Computer in Get-Content $ComputersFile) {
    Invoke-Command -ComputerName $Computer -ScriptBlock {
        Write-Host -ForegroundColor Green "Disabling Sentinel services on" $Computer 
        Set-Service -Name adpHostSrv -StartupType Disabled
        Set-Service -Name simHostSrv -StartupType Disabled
        Set-Service -Name psmsConsoleSrv -StartupType Disabled
        
        Write-Host -ForegroundColor Green "Stopping Sentinel services on" $Computer 
        Stop-Service -Name adpHostSrv
        Stop-Service -Name simHostSrv
        Stop-Service -Name psmsConsoleSrv
    }
}
