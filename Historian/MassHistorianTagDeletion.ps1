<#
.DESCRIPTION
            Delete tags contained in a text file
.AUTHOR
        Alex Panzetta
        alex.panzetta@aveva.com

.NOTES   
    Name       : MassHistorianTagDeletion.ps1
    Version    : 1.0.0
    DateCreated: 12/14/2020
#>
$TagsFile = "C:\Resources\tags.txt"
$HistorianServer = "HIST1"
$HistorianUser = "wwAdmin"
$HistorianPassword = "wwAdmin"

foreach($line in Get-Content $TagsFile) {
        $execSP = "exec aaDeleteTag @TagName = "+ $line
        Invoke-Sqlcmd  -ServerInstance $HistorianServer -Database Runtime -Query $execSP -Username $HistorianUser -Password $HistorianPassword
}