<#
    .DESCRIPTION 
        Enumerates Microsoft's installed Hotfixes, and checks their status against the file [SecurityCentralSupportedProducts.xlsx]
        FYI SecurityCentralSupportedProducts.xlsx can be downloaded at https://softwaresupportsp.aveva.com/#/securitycentral
    
    .PARAMETER ApprovedListFile
        Name of Excel spreadsheet downloaded from Security Central
    

    .AUTHOR
        Alex Panzetta
        alex.panzetta@aveva.com
    
    .NOTES   
        Name       : Check-AvevaSupportedPatcheList.ps1
        Version    : 1.0
        DateCreated: April 2023
        WARNING    : This script is intended for educational purposes and provided AS IS.
#>

$InstalledUpdate = Get-WMIobject -class win32_quickfixengineering | Select-Object -ExpandProperty HotFixID
$PSScriptRoot = Split-Path -Parent -Path $MyInvocation.MyCommand.Definition
$ApprovedListFile = $PSScriptRoot + '\SecurityCentralSupportedProducts.xlsx'

Function Check-AvevaSupportedPatcheList {
    [cmdletbinding()]
    Param (
        [parameter(Mandatory)]
        [ValidateScript({
            Try {
                If (Test-Path -Path $_) {$True}
                Else {Throw "$($_) is not a valid path!"}
            }
            Catch {
                Throw $_
            }
        })]
        [string]$Source,
        [parameter(Mandatory)]
        [string]$SearchText
        #You can specify wildcard characters (*, ?)
    )
    $Excel = New-Object -ComObject Excel.Application
    Try {
        $Source = Convert-Path $Source
    }
    Catch {
        Write-Warning "Unable locate full path of $($Source)"
        BREAK
    }
    $Workbook = $Excel.Workbooks.Open($Source)
    ForEach ($Worksheet in @($Workbook.Sheets)) {
        # Find Method https://msdn.microsoft.com/en-us/vba/excel-vba/articles/range-find-method-excel
        $Found = $WorkSheet.Cells.Find($SearchText) #What
        If ($Found) {
            # Address Method https://msdn.microsoft.com/en-us/vba/excel-vba/articles/range-address-property-excel
            $rowStatus,$colStatus = $Found.Row,$Found.Column
            $Status = $Worksheet.Cells.Item($Found.Row,2).text
            if ($Status -ccontains "Supported") {
                Write-Host -ForegroundColor Green $SearchText 'is' $Status 
                }
            elseif ($Status -ccontains "Not Tested")  {
                Write-Host -ForegroundColor Yellow $SearchText 'is' $Status
                }
            elseif ($Status -ccontains "Exception")  {
                $ExceptionLink = $Worksheet.Cells.Item($Found.Row,7).text
                Write-Host -ForegroundColor Red $SearchText 'is Not Supported. More Info at' $ExceptionLink
                }
        }
        Else {
            Write-Host -ForegroundColor Green "$SearchText Not Applicable"
        }
    }
    $workbook.close($false)
    [void][System.Runtime.InteropServices.Marshal]::ReleaseComObject([System.__ComObject]$excel)
    [gc]::Collect()
    [gc]::WaitForPendingFinalizers()
    Remove-Variable excel -ErrorAction SilentlyContinue
}

Write-Host -ForegroundColor Cyan "Checking Microsft Installed Hotfixes in" $ApprovedListFile
foreach($Msupdate in $InstalledUpdate) {
    Check-AvevaSupportedPatcheList -Source 'C:\Users\alepa\OneDrive\Documents\GitHub\AVEVA-PS-Scripts\SecurityCentralSupportedProducts.xlsx' -SearchText $Msupdate
    }