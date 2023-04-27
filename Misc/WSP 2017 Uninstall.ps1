<#
.DESCRIPTION
    
    

.AUTHOR
        Alex Panzetta
        alex.panzetta@aveva.com

.NOTES   
    Name       : WSP 2017 Uninstall.ps1
    Version    : 1.0.0
    DateCreated: 
#>


<#
    $SelectApp = Get-ItemProperty HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\* | Where-Object {$_.Publisher -like 'Aveva*' -or $_.Publisher -like 'Schneider*' -or $_.Publisher -like 'Invensys*' -or $_.Publisher -like 'Wonderware*'} | Select-Object DisplayName, DisplayVersion, Publisher, InstallDate | Out-GridView -Title '[Aveva Wonderware System Cleanup] ' -PassThru | Select-Object -ExpandProperty 'DisplayName'
    $MyApp = Get-WmiObject -Class Win32_Product | Where-Object{$_.Name -eq $SelectApp}
    $MyApp.Uninstall()
#>

<#
    ******* Historian *******
    Make copies of History Block folders
    Open SQL Server Management Studio and run following query in Historian Database to find the locations of folders that needs to be backed up:
        SELECT * FROM StorageLocation


    ******* Historian Client *******
    Backup any *.aaTrend files

    ******* OI Gateway and OI Servers *******
    OI Gateway and OI Servers
    Backup any *.aaCFG files in - C:\Program Data\Wonderware\OI-Server\$Operations Integration Supervisory Servers$\<OI Server name>\<instance name>\*.aaCFG

    ******* Backup Add-on Script Functions *******
    Uninstalling InTouch leaves the Add-on Script Functions.
    For 32-bit operating systems: \Program Files\Wonderware\InTouch 
    For 64-bit operating systems: \Program Files (x86)\ Wonderware\InTouch

    ******* Wonderware System Platform Products *******
    Disable/Stop
        License Manager Web Service
        License Server Agent Service
        License Server Core Service
        License server Sam Service


    ******* Confirm following folders are removed *******
    C:\Program Files (x86)\ArchestrA
    C:\Program Files (x86)\AVEVA
    C:\Program Files (x86)\Common Files\ArchestrA
    C:\Program Files (x86)\Schneider Electric
    C:\Program Files (x86)\Wonderware
    C:\ProgramData\ArchestrA
    C:\ProgramData\AVEVA
    C:\ProgramData\Schneider Electric
    C:\ProgramData\Sentinel System Monitor
    C:\ProgramData\Wonderware
    C:\Program Files\AVEVA
    C:\Program Files\Common Files\ArchestrA
    C:\Users\Public\Wonderware
    C:\Historian

    ******* Confirm following Registry keys are removed *******
    1. For 32-Bit operating system: 
        HKEY_LOCAL_MACHINE\SOFTWARE\ArchestrA
        HKEY_LOCAL_MACHINE\SOFTWARE\Wonderware
        HKEY_LOCAL_MACHINE\SOFTWARE\Schneider Electric
    
    2. For 64-Bit operating system:

        HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\ArchestrA
        HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Wonderware
        HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Schneider Electric
    3. Delete HKEY_CURRENT_USER\Software\ArchestrA. 

    4. Delete HKEY_CURRENT_USER\Software\Wonderware. 


    ******* Remove users ******* 
    Remove-LocalUser -Name
        aaConfigTools
        aaGalaxyOwner 
        aaInTouchUsers
        ArchestrAWebHosting
        NT SERVICE\aaPIM
        NT SERVICE\aahSearchIndexer
        NT SERVICE\InTouchDataService
        NT SERVICE\InTouchWeb
        NT SERVICE\aahClientAccessPoint
        NT SERVICE\InSQLConfiguration
        NT SERVICE\InSQLEventSystem
        NT SERVICE\InSQLManualStorage
        NT SERVICE\InSQLStorage
        NT SERVICE\InSQLIndexing
        NT SERVICE\InSQLIOServer
        NT SERVICE\InSQLSystemDriver
        NT SERVICE\aahInSight
        NT SERVICE\aahSupervisor
        NT SERVICE\AsbServiceManager
        NT SERVICE\AIMTokenHost
        NT SERVICE\Watchdog_Service
        NT SERVICE\psmsconsoleSrv
        NT SERVICE\simHostSrv
        NT SERVICE\adphostSrv
        aaInTouchRWUsers
        aaAdministrators
        aaPowerUsers
        aaReplicationUsers
        aaUsers
        ArchestrAWebHosting
        ASBCoreServices
        ASBSolution
        ArchestrAWebHosting
        PSMS Administrators
        PSMS Advanced Support Engineers	
        PSMS Configurators
        PSMS Readonly Operators
        PSMS Report Users
        PSMS Support Engineers
        SELicMgr
        AELicMgr
#>

Get-ItemProperty HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\* | Where-Object {$_.Publisher -like 'Aveva*' -or $_.Publisher -like 'Schneider*' -or $_.Publisher -like 'Invensys*' -or $_.Publisher -like 'Wonderware*'} | 
foreach {$_.DisplayName + ' ' + $_.UninstallString}


Get-ItemProperty HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\* | Where-Object {$_.DisplayName -like 'Archestra*'} | 
foreach {$_.DisplayName + ' ' + $_.UninstallString}
