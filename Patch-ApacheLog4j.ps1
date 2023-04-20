<#
.DESCRIPTION
    This script will apply the suggested remediatoin for the ApacheLog4j vulnerability on computers 
    listed in the $ComputersFile 

.AUTHOR
        Alex Panzetta
        alex.panzetta@aveva.com

.NOTES   
    Name       : Patch-ApacheLog4j.ps1
    Version    : 1.0.0
    DateCreated: January 2022
#>

$ComputersFile = "C:\Temp\Computers.txt"
$MyCredentials = Get-Credential alex-work\test  #Replace this with your domain\username
$vulName = 'ApacheLog4j'
$fixVarName = "Dlog4j2.formatMsgNoLookups"
$fixVarValue = "true"


foreach($Computer in Get-Content $ComputersFile) {
    $getEnvVar = Invoke-Command -ComputerName $Computer -ScriptBlock {[Environment]::GetEnvironmentVariable($fixVarName)}
    if (($getEnvVar.Name -and $getEnvVar.Value -ne $fixVarValue) -or (!$getEnvVar.Name))
        {
            Write-Host -ForegroundColor Red $Computer ' may be vulnerable to' $vulName 
            Write-Host -ForegroundColor Cyan "Applying system variable [$fixVarName] and setting it to [$fixVarValue] on" [$Computer]
            Invoke-Command -ComputerName $Computer -Credential $MyCredentials -ArgumentList $Environment {[System.Environment]::SetEnvironmentVariable($fixVarName, $fixVarValue, [System.EnvironmentVariableTarget]::Machine )}
            Write-Host -ForegroundColor Red $Computer ' needs to be reboot for the fi to be in effect'
        }
        else
        {
            Write-Host -ForegroundColor Green $Computer ' is not vulnerable to' $vulName
        }
   }

