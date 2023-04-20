# (c) 2019 AVEVA
#
# This Powershell script repairs Virtual Service Accounts that are
# missing their "Temp" directory under <VSA>\AppData\Local
#

#
# Check if this is Windows 10 1809 or greater, or Windows Server 2019 1809 or greater
#
if (([System.Environment]::OSVersion.Version.Major -lt 10) -or ([System.Environment]::OSVersion.Version.Build -lt 17763))
{
    Throw "This fix does not apply to the version of Windows running on this machine. Exiting without taking any action."
}

$osInfo = Get-CimInstance -ClassName Win32_OperatingSystem
Write-Host -NoNewline "Detected "
if ($osInfo.ProductType -eq 1) {
    Write-Host -NoNewline "Windows 10 "
}
else
{
    Write-Host -NoNewline "Windows Server 2019 "
}
Write-Host "Version 1809 or greater" ([System.Environment]::NewLine)

$TargetPathBase = $env:SystemDrive + "\Windows\ServiceProfiles"

#
# Virtual Service Accounts that require a Temp directory under their AppData\Local subdirectory.
#
$VirtualServiceProfiles = @(
    "aahClientAccessPoint", 
    "aahSupervisor", 
    "aaPim",
    "AIMTokenHost",
    "ArchestrADataStore",
    "AsbServiceManager",
    "InTouchDataService",
    "InTouchWeb",
    "Watchdog_Service"
    )

foreach ($VirtualServiceProfile in $VirtualServiceProfiles) {
    Write-Host -NoNewline ("Checking Virtual Service Profile '" + $VirtualServiceProfile + "'...")
	# Verify the profile exists
    $TargetPath = $TargetPathBase + "\" + $VirtualServiceProfile + "\AppData\Local"
    if (Test-Path -Path $TargetPath) {
        Write-Host "Found."
        # Does the Temp directory already exist?
        Write-Host -NoNewline "Checking for Temp directory..."
        $TempTarget = $TargetPath + "\Temp"
        if (-NOT (Test-Path -Path $TempTarget)) {
            Write-Host ("Missing.")
            # Temp directory is missing, so create it.
            New-Item -Path $targetPath -Name "Temp" -ItemType "directory"
            Write-Host ("Created Temp directory in " + $TargetPath)
        }
        else
        {
            Write-Host ("Found. No change required. Skipping.")
        }
    }
    else 
    {
        Write-Host ("Not Found (which is OK). Skipping.")
    }
    Write-Host -NoNewline ([System.Environment]::NewLine)
}
Write-Host "Done. Exiting."
