<#
    .DESCRIPTION 
        Mounts AVEVA ISO files as E:\ Drive
        Then copies to C:\InstallFiles

    .NOTES   
        Name       : FLNA_Extract-AVEVA-ISOs.ps1
        Version    : 1.0
        DateCreated: April 2023
        Author: Alex.Panzetta@aveva.com
#>

# Set drive letter
$driveLetter = "E:"

# Set ISOs location
$CDP_ISO = "C:\Install Files\Aveva InTouch 2020 R2 SP1\CDP_2023.iso"


# Set folders to extract to
$AVEVA_Folder = "C:\Install Files\AVEVA"
$CDP_Folder = $AVEVA_Folder + "\AVEVA_Enterprise_Licensing_3_7_002\"

# Create folders it they do not exist

if (!(Test-Path $AVEVA_Folder -PathType Container)) {
    New-Item -ItemType Directory -Path $AVEVA_Folder
    New-Item -ItemType Directory -Path $CDP_Folder
    }


# Mount ISO image
$diskImg = Mount-DiskImage -ImagePath $CDP_ISO -NoDriveLetter
$volInfo = $diskImg | Get-Volume
mountvol $CDP_ISO $volInfo.UniqueId 

# Extract files
Write-Host -ForegroundColor Cyan "Extracting files from" $CDP_ISO
xcopy $driveLetter $CDP_Folder /E /C
Dismount-DiskImage $isoImg # Dismount ISO image

Write-Host -ForegroundColor Cyan "Done extracting files from ISOs."

Write-Host -ForegroundColor Green "All done!!"