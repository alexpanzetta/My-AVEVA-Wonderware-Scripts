<#
    .DESCRIPTION
            Searches in the registry for InstallSource=E:\InstallFiles or F:\InstallFiles
            and replaces 

    .AUTHOR
            Alex Panzetta
            alex.panzetta@aveva.com

    .NOTES   
        Name       : Fix-AVEVA-Software-Source-Location.ps1
        Version    : 1.0.0
        DateCreated: April 2023
#>

$RegistryPath = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall"
$SP_CurrLocation = "E:\InstallFiles"
$SP_NewLocation = "C:\Install Files\AVEVA\Aveva InTouch 2020 R2 SP1"

$CDP_CurrLocation = "F:\InstallFiles"
$CDP_NewLocation = "C:\Install Files\AVEVA\CDP_2023" 


$Registry = Get-ChildItem $RegistryPath -Recurse
foreach ($a in $Registry) {
  $a.Property | Where-Object {
    $a.GetValue($_) -Like "*$SP_CurrLocation*"
  } | ForEach-Object {
    $CurrentValue = $a.GetValue($_)
    $ReplacedValue = $CurrentValue.Replace($SP_CurrLocation, $SP_NewLocation)
    Write-Output "Changing value of $a\$_ from '$CurrentValue' to '$ReplacedValue'"
    Set-ItemProperty -Path Registry::$a -Name $_ -Value $ReplacedValue
  }
}

foreach ($a in $Registry) {
  $a.Property | Where-Object {
    $a.GetValue($_) -Like "*$CDP_CurrLocation*"
  } | ForEach-Object {
    $CurrentValue = $a.GetValue($_)
    $ReplacedValue = $CurrentValue.Replace($CDP_CurrLocation, $CDP_NewLocation)
    Write-Output "Changing value of $a\$_ from '$CurrentValue' to '$ReplacedValue'"
    Set-ItemProperty -Path Registry::$a -Name $_ -Value $ReplacedValue
  }
}