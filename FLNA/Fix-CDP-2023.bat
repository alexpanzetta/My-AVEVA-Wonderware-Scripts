REM    .DESCRIPTION 
REM        Mounts the new AVEVA CDP 2023.1 ISO file 
REM        Then copies to C:\Install Files
REM        Lastly runs the Silent_Install_Setup.bat
REM    .NOTES   
REM        Name       : Fix-CDP-2023.bat
REM        Version    : 1.0
REM        DateCreated: April 2023
REM        Author: Alex.Panzetta@aveva.com

@off
reg query HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\{8E6D569F-7339-482E-954F-C2A5BD9A26CA} /v DisplayVersion >nul 2>&1
if %ERRORLEVEL% == 0 goto END
if %ERRORLEVEL% == 1 goto UPDATE

:END
@exit

:UPDATE
C:\Windows\System32\MsiExec.exe /X{46F7B664-9497-493D-8269-C39DE0F9C7BB} /passive
C:\Windows\System32\MsiExec.exe /X{62EE6C16-07EE-3A8D-A533-F3057F965F5E} /passive
C:\Windows\System32\MsiExec.exe /X{56205076-5F5F-408B-A2CC-EF72BFFBC6DD} /passive
C:\Windows\System32\MsiExec.exe /X{4368217D-0EEE-4612-973D-CB228B37F17A} /passive
"C:\ProgramData\Package Cache\{1182f806-658a-4241-9202-d43e13bf2719}\aspnetcore-runtime-6.0.8-win-x64.exe" /uninstall /quiet
"C:\ProgramData\Package Cache\{469641e6-0ab0-4da8-88d5-7bd24b093271}\dotnet-runtime-6.0.8-win-x86.exe" /uninstall /quiet
"C:\ProgramData\Package Cache\{5974fca0-8809-4100-89bb-9880c50c084e}\dotnet-hosting-6.0.8-win.exe" /uninstall /quiet
"C:\ProgramData\Package Cache\{df65a075-27e0-4afc-baea-ecaadef7b85c}\dotnet-runtime-6.0.8-win-x64.exe" /uninstall /quiet
"C:\ProgramData\Package Cache\{f88a1cc3-0725-4c99-b63a-06f28c1ed652}\aspnetcore-runtime-6.0.8-win-x86.exe" /uninstall /quiet
powershell -Command "Start-Process -Verb RunAs powershell '-ExecutionPolicy Bypass -Command "^"" cd \\"^""C:\Tools\\OIT Scripts\\"^""; & \\"^"".\Fix-CDP-2023.ps1\\"^"" "^""'"
GOTO END