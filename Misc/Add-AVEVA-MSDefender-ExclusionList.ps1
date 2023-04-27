<#
.DESCRIPTION
    Adds folder exclusions to Microsoft Defender as in Tech Notes #2865/32662
    Folder exclusion list available at:
    https://softwaresupportsp.aveva.com/#/knowledgebase/details/tn2865
    https://softwaresupportsp.aveva.com/#/knowledgebase/details/tn000032662
.AUTHOR
    Alex Panzetta
    alex.panzetta@aveva.com

.NOTES   
    Name       : Add-AVEVA-MSDefender-ExclusionList.ps1
    Version    : 1.0.0
    DateCreated: April 2023
#>

ConfigDefender\Add-MpPreference -ExclusionPath "C:\ProgramData\ArchestrA\"
ConfigDefender\Add-MpPreference -ExclusionPath "C:\Program Files\ArchestrA\"
ConfigDefender\Add-MpPreference -ExclusionPath "C:\Program Files\Common Files\ArchestrA\"
ConfigDefender\Add-MpPreference -ExclusionPath "C:\Program Files\FactorySuite\"
ConfigDefender\Add-MpPreference -ExclusionPath "C:\ProgramData\Wonderware\"
ConfigDefender\Add-MpPreference -ExclusionPath "C:\Program Files\Wonderware\"
ConfigDefender\Add-MpPreference -ExclusionPath "C:\Program Files\Common Files\ArchestrA\"
ConfigDefender\Add-MpPreference -ExclusionPath "C:\Program Files (x86)\ArchestrA\"
ConfigDefender\Add-MpPreference -ExclusionPath "C:\Program Files (x86)\Common Files\ArchestrA\"
ConfigDefender\Add-MpPreference -ExclusionPath "C:\Program Files (x86)\FactorySuite\"
ConfigDefender\Add-MpPreference -ExclusionPath "C:\Program Files (x86)\Wonderware\"
ConfigDefender\Add-MpPreference -ExclusionPath "C:\Program Files (x86)\AVEVA\"
ConfigDefender\Add-MpPreference -ExclusionPath "C:\ProgramData\Wonderware\"
ConfigDefender\Add-MpPreference -ExclusionPath "C:\Users\Public\Wonderware\"
ConfigDefender\Add-MpPreference -ExclusionPath "C:\InSQL\Data\"
ConfigDefender\Add-MpPreference -ExclusionPath "C:\Historian\Data\"
ConfigDefender\Add-MpPreference -ExclusionPath "C:\Users\All Users\ArchestrA\"
ConfigDefender\Add-MpPreference -ExclusionPath "C:\Program Files (x86)\ArchestrA\Framework\bin\"
ConfigDefender\Add-MpPreference -ExclusionPath "C:\Users\Public\Wonderware\InTouchApplications"
ConfigDefender\Add-MpPreference -ExclusionPath "C:\ProgramData\AVEVA\Licensing"
ConfigDefender\Add-MpPreference -ExclusionPath "C:\ProgramData\FNEServer"
ConfigDefender\Add-MpPreference -ExclusionPath "C:\ProgramData\ArchestrA\LogFiles\"
ConfigDefender\Add-MpPreference -ExclusionPath "C:\Documents and Settings\All Users\Application data\Archestra\LogFiles\"
ConfigDefender\Add-MpPreference -ExclusionPath "C:\Program Files (x86)\Microsoft SQL Server\MSSQL.MSSQLSERVER\MSSQL\DATA\"
ConfigDefender\Add-MpPreference -ExclusionExtension *.aaPDF
ConfigDefender\Add-MpPreference -ExclusionExtension *.mdf
ConfigDefender\Add-MpPreference -ExclusionExtension *.ldf
ConfigDefender\Add-MpPreference -ExclusionExtension *.idx
ConfigDefender\Add-MpPreference -ExclusionExtension *.pdx