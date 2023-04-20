<#
    .DESCRIPTION 
        Filter through the list of updates posted in Security Central and extract the Approved patches
        The output CSV file can later be used with Approve-WSUSUpdatesFromFile.ps1
    
    .AUTHOR
        Alex Panzetta
        alex.panzetta@aveva.com

    .NOTES   
        Name       : Get-AvevaApprovedPatcheList.ps1
        Version    : 1.0
        DateCreated: February 2021
#>


$Infile = 'D:\WSUS\SecurityCentralSupportedProducts.xlsx'
$Tmpfile = 'D:\WSUS\tmpApproved.csv'
$Outfile = 'D:\WSUS\Approved.csv'

# Remove previous export
if (Test-Path $Tmpfile) {
  Remove-Item $Tmpfile
}
if (Test-Path $Outfile) {
  Remove-Item $Outfile
}

$sheetName = "SecurityCentral"
$objExcel = New-Object -ComObject Excel.Application
$workbook = $objExcel.Workbooks.Open($Infile)
$sheet = $workbook.Worksheets.Item($sheetName)
$objExcel.Visible=$false
$rowMax = ($sheet.UsedRange.Rows).count

$rowStatus,$colStatus = 1,2
$rowMSKB,$colMSKB = 1,10

for ($i=1; $i -le $rowMax-1; $i++)
{
    $Status = $sheet.Cells.Item($rowStatus+$i,$colStatus).text
    $MSKB = $sheet.Cells.Item($rowMSKB+$i,$colMSKB).text
    $strMSKB = $_.Trim().Replace("MS ","").Replace("KB ","KB").Replace("KBs ","KB")
    $strMSKB | Out-File $Tmpfile
    
}

# Add commas
(Get-Content $Tmpfile) | add-content -path $Outfile
Remove-Item $Tmpfile
$objExcel.quit()