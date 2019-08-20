powercfg.exe -x -monitor-timeout-ac 0
powercfg.exe -x -standby-timeout-ac 0
powercfg.exe -x -hibernate-timeout-ac 0

cd C:\RAcross_windows\1_WPS
powershell -WorkingDirectory ~ -ExecutionPolicy RemoteSigned -File .\RAcross.ps1

