powercfg.exe -x -monitor-timeout-ac 0
powercfg.exe -x -standby-timeout-ac 0
powercfg.exe -x -hibernate-timeout-ac 0

rem chocolatey
@"%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" -NoProfile -InputFormat None -ExecutionPolicy Bypass -Command "iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))" && SET "PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin"

rem PowerShell Core
choco install -y powershell-core

rem Run powershell script
cd C:\RAcross_windows\1_WPS
"C:\Program Files\PowerShell\7\pwsh.exe" -WorkingDirectory ~ -ExecutionPolicy RemoteSigned -File .\RAcross.ps1

