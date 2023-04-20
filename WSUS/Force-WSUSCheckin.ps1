Function Force-WSUSCheckin($Computer)
{
invoke-command -computername $Computer -scriptblock {
Start-Service wuauserv -Verbose
$updateSession = new-object -com “Microsoft.Update.Session”;
# More info about the Search method: https://docs.microsoft.com/en-us/windows/desktop/api/wuapi/nf-wuapi-iupdatesearcher-search
$criteria = $null
$updateSession.CreateupdateSearcher().Search($criteria) | out-null
Write-host “Waiting 10 seconds for SyncUpdates webservice to complete to add to the wuauserv queue so that it can be reported on”
Start-sleep -seconds 10
Write-host “running wuauclt /reportnow …”
wuauclt /reportnow
}
}

Force-WSUSCheckin -Computer GR1
