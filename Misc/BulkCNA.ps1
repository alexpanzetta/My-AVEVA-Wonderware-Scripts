<#
.DESCRIPTION
    This script will set the ArchestrA User for the computers
    listed in the $ComputersFile 

.AUTHOR
        Alex Panzetta
        alex.panzetta@aveva.com

.NOTES   
    Name       : BulkCNA.ps1
    Version    : 1.0.0
    DateCreated: August 2021
#>

$ComputersFile = "C:\Temp\computers.txt"
$cmdCNA = "C:\Program Files (x86)\common files\archestra\aaadminuser -u YourUsername -p YourPassword"

foreach($Computer in Get-Content $ComputersFile) {
    Invoke-Command -ComputerName $Computer -ScriptBlock {$cmdCNA}
    Restart-Computer -ComputerName $Computer -Timeout 120 -Force
}
