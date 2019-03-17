[string]$global:RACROSS_BASE = "C:\RAcross_windows"
[string]$global:RACROSS_WPS_BASE = "$RACROSS_BASE\1_WPS"

[string]$global:RACROSS_WPS_CACHEBASE = "$RACROSS_BASE\CACHE"

function global:sl_wps_base {
"--- set locate neutral."
Set-Location "$RACROSS_WPS_BASE"
}

$cli = New-Object System.Net.WebClient

Remove-Item "$RACROSS_WPS_CACHEBASE" -Recurse
New-Item "$RACROSS_WPS_CACHEBASE" -ItemType Directory

# VisualStudio 2017 community
sl_wps_base
"downloading vs_community.exe ..."
$cli.DownloadFile("https://download.visualstudio.microsoft.com/download/pr/41217ce6-f73c-48b9-b679-e5193984336b/500a2965365fa0283c3c31e4837487d9/vs_community.exe", "$RACROSS_WPS_CACHEBASE\vs_community.exe")
"downloading vs_community cache ..."
Start-Process -FilePath "$RACROSS_WPS_CACHEBASE\vs_community.exe" -ArgumentList "--quiet --layout $RACROSS_WPS_CACHEBASE\vs2017layout --add Microsoft.Component.MSBuild --add Microsoft.VisualStudio.Component.Roslyn.Compiler --add Microsoft.VisualStudio.Component.TextTemplating --add Microsoft.VisualStudio.Component.VC.CoreIde --add Microsoft.VisualStudio.Component.VC.Redist.14.Latest --add Microsoft.VisualStudio.ComponentGroup.NativeDesktop.Core --add Microsoft.VisualStudio.Component.Debugger.JustInTime --add Microsoft.Net.Component.4.7.2.SDK --add Microsoft.VisualStudio.Component.Static.Analysis.Tools --add Microsoft.VisualStudio.Component.Windows10SDK.17134 --add Microsoft.VisualStudio.Component.VC.ATL --add Microsoft.VisualStudio.Component.VC.Tools.x86.x64 --add Microsoft.VisualStudio.Component.VC.ATLMFC --add Microsoft.VisualStudio.Component.VC.CLI.Support --add Microsoft.VisualStudio.Component.VC.Modules.x86.x64 --add Microsoft.VisualStudio.Component.Windows10SDK.16299.UWP.Native --add Microsoft.VisualStudio.Component.Windows81SDK --add Microsoft.VisualStudio.Component.WinXP --includeRecommended --lang ja-JP" -Wait
"setup vs_community ..."
Start-Process -FilePath "$RACROSS_WPS_CACHEBASE\vs2017layout\vs_community.exe" -ArgumentList "--quiet --add Microsoft.Component.MSBuild --add Microsoft.VisualStudio.Component.Roslyn.Compiler --add Microsoft.VisualStudio.Component.TextTemplating --add Microsoft.VisualStudio.Component.VC.CoreIde --add Microsoft.VisualStudio.Component.VC.Redist.14.Latest --add Microsoft.VisualStudio.ComponentGroup.NativeDesktop.Core --add Microsoft.VisualStudio.Component.Debugger.JustInTime --add Microsoft.Net.Component.4.7.2.SDK --add Microsoft.VisualStudio.Component.Static.Analysis.Tools --add Microsoft.VisualStudio.Component.Windows10SDK.17134 --add Microsoft.VisualStudio.Component.VC.ATL --add Microsoft.VisualStudio.Component.VC.Tools.x86.x64 --add Microsoft.VisualStudio.Component.VC.ATLMFC --add Microsoft.VisualStudio.Component.VC.CLI.Support --add Microsoft.VisualStudio.Component.VC.Modules.x86.x64 --add Microsoft.VisualStudio.Component.Windows10SDK.16299.UWP.Native --add Microsoft.VisualStudio.Component.Windows81SDK --add Microsoft.VisualStudio.Component.WinXP --includeRecommended" -Wait

# MSYS2 64bit
sl_wps_base
"downloading MSYS2 ..."
$cli.DownloadFile("http://repo.msys2.org/distrib/x86_64/msys2-x86_64-20180531.exe", "$RACROSS_WPS_CACHEBASE\msys2-x86_64.exe")
"setup MSYS2 ..."
#$cli.DownloadFile("https://raw.githubusercontent.com/msys2/msys2-installer/master/auto-install.js", "$RACROSS_WPS_CACHEBASE\auto-install.js")
#Start-Process -FilePath "$RACROSS_WPS_CACHEBASE\msys2-x86_64.exe" -ArgumentList "--platform minimal --script $RACROSS_WPS_CACHEBASE\auto-install.js -v" -Wait
Start-Process -FilePath "$RACROSS_WPS_CACHEBASE\msys2-x86_64.exe" -Wait

# copy MSYS2 files
sl_wps_base
"copy MSYS2 files ..."
Copy-Item -Path "$RACROSS_BASE\2_MSYS2" -Destination "C:\msys64\home\$env:USERNAME\RAcross" -Recurse

# 1st start MSYS2
"update MSYS2 ..."
Start-Process -FilePath "C:\msys64\msys2_shell.cmd" -ArgumentList "-mingw32 -c `"pacman -Syu --noconfirm`"" -Wait
# 2nd start MSYS2
"setup MSYS2 env ..."
Start-Process -FilePath "C:\msys64\msys2_shell.cmd" -ArgumentList "-mingw32 -c `"RAcross/RAcross.sh`"" -Wait

