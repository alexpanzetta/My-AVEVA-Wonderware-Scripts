<#
    .DESCRIPTION 
        Mounts the new AVEVA CDP 2023.1 ISO file 
        Then copies to C:\Install Files
        Lastly runs the Silent_Install_Setup.bat

    .NOTES   
        Name       : Fix-CDP-2023.ps1
        Version    : 1.0
        DateCreated: April 2023
        Author: Alex.Panzetta@aveva.com
#>

# Check if already installed; do ntohing if already upgraded
If (Get-Package | Where-Object {$_.Name -like 'AVEVA Communication Drivers Pack*' -and $_.Version -eq '7.4.0'}) 
    {
        # Set ISO source location
        $ISOFilePath = "C:\Install Files\AVEVA\CDP_2023.1.iso"

        # Set extracted ISO target location
        $CDP_Folder = "C:\Install Files\AVEVA\CDP2023-1"
        # Create folders it they do not exist
        if (!(Test-Path $CDP_Folder -PathType Container)) {
            New-Item -ItemType Directory -Path $CDP_Folder
            }

            # Mount ISO image
        $mountResult = Mount-DiskImage $ISOFilePath -PassThru
        $SourceDir = ($mountResult | Get-Volume).DriveLetter + ":\*"

        # Extract files
        Copy-Item -Path $SourceDir -Destination $CDP_Folder -Recurse
        $UpdateCmd= $CDP_Folder + "\Silent_Install_Setup.bat"
        Start-Process $UpdateCmd -ArgumentList /INSTALL
    }