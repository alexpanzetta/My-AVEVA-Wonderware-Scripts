if (-Not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] 'Administrator')) {
 if ([int](Get-CimInstance -Class Win32_OperatingSystem | Select-Object -ExpandProperty BuildNumber) -ge 6000) {
  $CommandLine = "-File `"" + $MyInvocation.MyCommand.Path + "`" " + $MyInvocation.UnboundArguments
  Start-Process -FilePath PowerShell.exe -Verb Runas -ArgumentList $CommandLine
  Exit
 }
}
$hostname = [System.Net.Dns]::GetHostName()
$fixVarName = "Dlog4j2.formatMsgNoLookups"
$fixVarValue = "true"

function addEnvironmentVariable()
{
param(
[parameter(Mandatory=$true)][string]$envKey,
[parameter(Mandatory=$true)][string]$envVal
)
    [Environment]::SetEnvironmentVariable($envKey, $envVal,[System.EnvironmentVariableTarget]::Machine)
Restart-Computer -Force

}

Write-Host "Running initial configuration on" $hostname -ForegroundColor Yellow
Write-Host "Verifying System Environment on" $hostname -ForegroundColor Yellow
$getEnvVar = dir env: | Where-Object {$_.Name -eq $fixVarName}

if (($getEnvVar.Name -and $getEnvVar.Value -ne $fixVarValue) -or (!$getEnvVar.Name))
{
    Write-Host "Adding variable" $fixVarName "=" $fixVarValue -ForegroundColor Green
    addEnvironmentVariable -envKey $fixVarName -envVal $fixVarValue
    Write-Host "Done. Please reboot $hostname to complete the process" -ForegroundColor Green
}
else
{
    Write-Host $hostname "is already patched"  -ForegroundColor Green
}
Start-Sleep -Seconds 5