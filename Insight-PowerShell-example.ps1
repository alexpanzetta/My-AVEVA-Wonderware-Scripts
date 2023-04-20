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

$BeaearToken = "Bearer eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCIsImtpZCI6Ijc0MDAyZjA2LTE0MGYtNDcyMy04NjVkLWIxOGVkOWYwNDI2OCJ9.eyJEYXRhU291cmNlSWQiOiJjZjRkMzM0MS1mYTNhLTQxOTMtODFhMy0wY2E4YmM3NDk3MzUiLCJ0eXBlIjoic2VydmljZSIsInZlcnNpb24iOiIyLjAiLCJ0ZW5hbnRpZCI6IjNkYmQ5ZGNkLWFmNTktNGMzNS05N2EyLWRmYzYwNGFiZTEwNCIsInNpaWQiOiIwMzMxOTAyZi0wMjIwLTQxMWQtYjMxYy1jOGEyNDg3ZGU2ZTQiLCJqdGkiOiI2NjFlZjJlNS1iMjk2LTRlYTEtYWVmNC03YTU0YjE2YTM5MTUiLCJpc3MiOiJwcm9vZm9maWRlbnRpdHlzZXJ2aWNlIn0.quNFXQ2wuy8ZQFWvW-8TypQN1FcmjBEQ8cC_7OaoGFMuZNEwWYK5fZHbb46HfIjO2DrnS9JMaYLa8cCX7Paj2towfUdxKzDGeF1fgr1BA57LdCFwIHbtLlKYYkFM31DBxK53J8Pb8-8z4XUVZXsas9TePrhWnUw8OPwAUaWbuzAVRIq0lc2oJWb43Ni9nGRQL6LwFT_kFn-QSQbB72NkdfE5FzgZptBQI8rRQc2b1k6pYzGCBB1m73c7bAW9qrjjrNLWQRL954s_-Y4SnAJFnVd8DBhCzDwKpGlknfsBTuWRWWyYM3kSc1kzKtcjTOKwXHjX2U6o0fBM8aW7GyyeEw"
Invoke-RestMethod -Uri https://online.wonderware.com/apis/upload/datasource/ -Body $CSVbody -ContentType "text/CSV" -headers @{"x-filename"="PowerShell_REST_API.csv"; "Authorization"="$BeaearToken"} -Method Post
