<#
.DESCRIPTION
            Gets the list of platforms stored in the registry for computers
            contained in a text file
           
.AUTHOR
        Alex Panzetta
        alex.panzetta@aveva.com

.NOTES   
    Name       : Get-PlaformsFromRegistry.ps1
    Version    : 1.0.0
    DateCreated: 2/12/2021
#>

$PlatformId = 5
$ComputersFile = "C:\temp\computers.txt"

foreach($computer in Get-Content $ComputersFile) {
        Invoke-Command -Computer $computer -ScriptBlock {Get-ChildItem -Path Registry::HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\ArchestrA\Framework\Platform\PlatformNodes | Select-Object Name | Select-String -Pattern 'PlatformId'$PlatformId -CaseSensitive -SimpleMatch} 
        } 