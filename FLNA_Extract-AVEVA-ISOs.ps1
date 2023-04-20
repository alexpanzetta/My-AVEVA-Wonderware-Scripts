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
$ASP_ISO = "C:\Install Files\Aveva InTouch 2020 R2 SP1\SP_2020_R2_SP1.iso"
$CDP_ISO = "C:\Install Files\Aveva InTouch 2020 R2 SP1\CDP_2023.iso"
$AELM_ISO = "C:\Install Files\Aveva InTouch 2020 R2 SP1\AVEVA_Enterprise_Licensing_3_7_002.iso"


# Set folders to extract to
$AVEVA_Folder = "C:\Install Files\AVEVA"
$ASP_Folder = $AVEVA_Folder + "\Aveva InTouch 2020 R2 SP1\"
$CDP_Folder = $AVEVA_Folder + "\AVEVA_Enterprise_Licensing_3_7_002\"
$AELM_Folder = $AVEVA_Folder + "\CDP_2023\"

# Create folders it they do not exist

if (!(Test-Path $AVEVA_Folder -PathType Container)) {
    New-Item -ItemType Directory -Path $AVEVA_Folder
    New-Item -ItemType Directory -Path $ASP_Folder
    New-Item -ItemType Directory -Path $CDP_Folder
    New-Item -ItemType Directory -Path $AELM_Folder
    }

# Mount ISO image
$diskImg = Mount-DiskImage -ImagePath $ASP_ISO -NoDriveLetter
$volInfo = $diskImg | Get-Volumemountvol $driveLetter $volInfo.UniqueId

# Extract files
Write-Host -ForegroundColor Cyan "Extracting files from" $ASP_ISO
xcopy $driveLetter $ASP_Folder /E /C
Dismount-DiskImage $isoImg # Dismount ISO image

# Mount ISO image
$diskImg = Mount-DiskImage -ImagePath $CDP_ISO -NoDriveLetter
$volInfo = $diskImg | Get-Volume
mountvol $CDP_ISO $volInfo.UniqueId 

# Extract files
Write-Host -ForegroundColor Cyan "Extracting files from" $CDP_ISO
xcopy $driveLetter $CDP_Folder /E /C
Dismount-DiskImage $isoImg # Dismount ISO image

# Mount ISO image
$diskImg = Mount-DiskImage -ImagePath $AELM_ISO -NoDriveLetter
$volInfo = $diskImg | Get-Volume
mountvol $AELM_ISO $volInfo.UniqueId 

# Extract files
Write-Host -ForegroundColor Cyan "Extracting files from" $AELM_ISO
xcopy $driveLetter $AELM_Folder /E /C
Dismount-DiskImage $isoImg # Dismount ISO image

Write-Host -ForegroundColor Cyan "Done extracting files from ISOs."

Write-Host -ForegroundColor Cyan "Fixing registry entries."
Start-Process -FilePath "C:\Windows\System32\reg.exe" -ArgumentList "/IMPORT `"$AVEVA_Folder\FixedReg.reg`""

Write-Host -ForegroundColor Green "All done!!"