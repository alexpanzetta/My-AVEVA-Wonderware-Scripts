<#
.DESCRIPTION
    This script will uninstall any version of the Sentinel Agent from the computers
    listed in the $ComputersFile 

.AUTHOR
        Alex Panzetta
        alex.panzetta@aveva.com

.NOTES   
    Name       : Uninstall-Sentinel.ps1
    Version    : 1.0.0
    DateCreated: February 2021
#>

$ComputersFile = "C:\Temp\Sentinel_Agent_Computers.txt"
$MyCredentials = Get-Credential DOMAIN\USERNAME  #Replace this with your domain\username

foreach($Computer in Get-Content $Computers) {
    Write-Host -ForegroundColor Cyan "Removing Sentinel Agent from" $Computer 
    Invoke-Command -ComputerName $Computer -ScriptBlock { Get-Package -Name 'Sentinel Agent*' | Uninstall-Package -Force -ErrorAction SilentlyContinue} -Credential $MyCredentials 
}