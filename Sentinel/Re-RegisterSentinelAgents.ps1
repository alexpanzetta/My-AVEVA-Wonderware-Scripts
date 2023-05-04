<#
.DESCRIPTION
    Re-registers Sentinel Agents to Sentinel Manager

.AUTHOR
        Alex Panzetta
        alex.panzetta@aveva.com

.NOTES   
    Name       : Re-RegisterSentinelAgents.ps1
    Version    : 1.0.0
    DateCreated: 12/16/2020
#>

$ComputersFile = "C:\temp\sentinel\computers.txt"
$SentinelServer = "SentinelServerName"
$SentinelUser = "wwAdmin"
$SentinelPassword = "wwAdmin"
$RegKeyPath = 'SOFTWARE\WOW6432Node\Wonderware\Archestra\Plugins\Sentinel System Monitor\Sentinel Manager'
$AgentVersion = '1.1.200'

foreach($computer in Get-Content $ComputersFile) {
    $IPAddr = [System.Net.Dns]::GetHostAddresses($computer) | Select-Object -ExpandProperty IPAddressToString
    $Reg = [Microsoft.Win32.RegistryKey]::OpenRemoteBaseKey('LocalMachine', $computer)
    $RegKey= $Reg.OpenSubKey($RegKeyPath)
    $MachineIdentifier = $RegKey.GetValue("MachineIdentifier")
    $StoredProcedure = "EXEC uspAutoRegisterRemoteMachine '$computer','$IPAddr','$MachineIdentifier','$AgentVersion','1'"
    Invoke-Sqlcmd  -ServerInstance $SentinelServer -Database Runtime -Query $StoredProcedure -Username $SentinelUser -Password $SentinelPassword
}
