<#
    .DESCRIPTION 
        Approve a list of KB updates in a CSV file for a specific group in WSUS By using PowerShell
        The CSV file can be generated with Get-AvevaApprovedPatcheList.ps1
    
    .AUTHOR
        Alex Panzetta
        alex.panzetta@aveva.com

    .NOTES   
        Name       : Approve-WSUSUpdatesFromFile.ps1
        Version    : 0.1
        DateCreated: February 2021
#>



$ApprovedUpdateFile = 'C:\WSUS\Scripting\Approved.csv'
$ComputerGroupName = 'ICS'

Function Approve-Update{ 
    param(
        [Parameter(Mandatory=$true)][string] $ComputerGroupName,
        [Parameter(Mandatory=$true)][string] $PatchID
    )
    $Groups = Get-PSWSUSGroup -Name $ComputerGroupName
    Write-Host -ForegroundColor Green 'Approving' $PatchID 'for group' $ComputerGroupName
    Get-PSWSUSUpdate -Update $PatchID | Approve-PSWSUSUpdate -Group $Groups -Action Install
    
    $Return
} # Approve-Update




if ($ApprovedUpdateFile) {
    Get-Content $ApprovedUpdateFile | Foreach {
        Approve-Update $ApproveForGroup $_
        }
    }