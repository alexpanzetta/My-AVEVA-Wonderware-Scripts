<#
.DESCRIPTION
    Example of data upload from PowerShell to Insight

.AUTHOR
        Alex Panzetta
        alex.panzetta@aveva.com

.NOTES   
    Name       : Insight-PowerShell-example.ps1
    Version    : 1.0.0
    DateCreated: June 2021
#>
$CSVbody = Get-Content -Path "D:\MobileAlerts.csv"

$BeaearToken = "Bearer eyJhbG------------" # Provide your own bearer
Invoke-RestMethod -Uri https://online.wonderware.com/apis/upload/datasource/ -Body $CSVbody -ContentType "text/CSV" -headers @{"x-filename"="PowerShell_REST_API.csv"; "Authorization"="$BeaearToken"} -Method Post
