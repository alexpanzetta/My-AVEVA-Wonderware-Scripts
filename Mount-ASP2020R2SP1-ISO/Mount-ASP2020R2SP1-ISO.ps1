<#
    .DESCRIPTION 
        Mounts the ASP 2020 R2 SP1 ISO as E:\ Drive
        Mounts the CDP 2023 as F:\ Drive
    .NOTES   
        Name       : Mount-ASP2020R2SP1-ISO.ps1
        Version    : 1.0
        DateCreated: April 2023
        Author: Alex.Panzetta@aveva.com
#>
$driveLetter = "E:"
$isoImg = "C:\Install Files\Aveva InTouch 2020 R2 SP1\SP_2020_R2_SP1.iso"
$diskImg = Mount-DiskImage -ImagePath $isoImg  -NoDriveLetter
$volInfo = $diskImg | Get-Volume
mountvol $driveLetter $volInfo.UniqueId

$driveLetter = "F:"
$isoImg = "C:\Install Files\Aveva InTouch 2020 R2 SP1\CDP_2023.iso"
$diskImg = Mount-DiskImage -ImagePath $isoImg  -NoDriveLetter
$volInfo = $diskImg | Get-Volume
mountvol $driveLetter $volInfo.UniqueId