<#
    .DESCRIPTION 
        Filter through the list of updates posted in Security Central and approve the supported patches
    
    .PARAMETER ApprovedListFile
        Name of Excel spreadsheet downloaded from Security Central
    
    .PARAMETER ApprovedListSheetName
        Name of the sheet within ApprovedListFile
    
    .PARAMETER TargetComputerGroup
        Name of computer group the patches will be updated for

    .AUTHOR
        Alex Panzetta
        alex.panzetta@aveva.com
    
    .EXAMPLE
        Approve-AvevaSupportedPatcheList -ApprovedListFile 'C:\AvevaWSUS\SecurityCentralSupportedProducts.xlsx' -ApprovedListSheetName 'SecurityCentral' -TargetComputerGroup 'ICS'

    .NOTES   
        Name       : Approve-AvevaSupportedPatcheList.ps1
        Version    : 1.0
        DateCreated: February 2021
#>

function Approve-AvevaSupportedPatcheList {
    [cmdletbinding()]  
    param(
        [Parameter(Mandatory=$true)][string] $ApprovedListFile,
        [Parameter(Mandatory=$true)][string] $ApprovedListSheetName,
        [Parameter(Mandatory=$true)][string] $TargetComputerGroup
    ) 
    
    Process {
        $objExcel = New-Object -ComObject Excel.Application
        $workbook = $objExcel.Workbooks.Open($ApprovedListFile)
        $sheet = $workbook.Worksheets.Item($ApprovedListSheetName)
        $objExcel.Visible=$false
        $rowMax = ($sheet.UsedRange.Rows).count

        # NOTE: If the table schema changes in the input Excel spreadsheet, please provide the column number containing the 'Status' column; in this case column B=2
        $rowStatus,$colStatus = 1,3

        # NOTE: If the table schema changes in the input Excel spreadsheet, please provide the column number containing the 'MS KB Number Description' column; in this case column J=10
        $rowMSKB,$colMSKB = 1,10
        #Connect-PSWSUSServer -WsusServer $WSUSServer -Port $WSUSPort
        for ($i=1; $i -le $rowMax-1; $i++)
        {
            $currstatus= [math]::Round(100*$i/$rowmax) 
            $Status = $sheet.Cells.Item($rowStatus+$i,$colStatus).text
            $MSKB = $sheet.Cells.Item($rowMSKB+$i,$colMSKB).text
            if ($Status -eq 'Supported') {
                $KbStr = $MSKB.Split(",") | ForEach {
                    if ($_.Length -gt 2){if($_ -like 'KB*') {
                        $strMSKB = $_.Trim().Replace("MS ","").Replace("KB ","KB").Replace("KBs ","KB")
                        $Groups = Get-PSWSUSGroup -Name $TargetComputerGroup
                        $ActivityMessage = 'Approving patches for computer group ' + $TargetComputerGroup
                        Write-Progress -Activity $ActivityMessage -Status "$currstatus% Complete:" -PercentComplete $currstatus;
                        Write-Host 'Approving' $strMSKB 'for' $TargetComputerGroup 
                        Get-WsusUpdate -Classification All -Approval Unapproved -Status FailedOrNeeded | where {$_.update.Title -like "*$strMSKB*"} | Approve-WsusUpdate -Action Install -TargetGroupName $TargetComputerGroup
                        }
                    }
                }
            }
        }
        Get-Process -ErrorAction SilentlyContinue | Where-Object {$_.SI -eq (Get-Process -PID $pid).SessionID -and $_.Name -eq 'Excel'} | Stop-Process -Force        
        Write-host -ForegroundColor Cyan $rowMax 'patches have been approved for group' $TargetComputerGroup
    }           
}

Approve-AvevaSupportedPatcheList -ApprovedListFile 'C:\WSUS\Scripting\SecurityCentralSupportedProducts.xlsx' -ApprovedListSheetName 'SecurityCentral' -TargetComputerGroup 'ICS'

