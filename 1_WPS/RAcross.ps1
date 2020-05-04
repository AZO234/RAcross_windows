$RACROSS_BASE = "C:\RAcross_windows"
$RACROSS_WPS_BASE = "$RACROSS_BASE\1_WPS"

# SETUP_TYPE
# 0:install(after delete cache)
# 1:install(after cache undelete)
# 2:cache
# 3:install from cache(after delete cache)
# 4:install from cache(after cache undelete)
# always MSYS2 is installed
$RACROSS_SETUP_TYPE = 0

$env:RACROSS_SETUP_CACHE = 0
if(($RACROSS_SETUP_TYPE -eq 0) -or ($RACROSS_SETUP_TYPE -eq 1) -or ($RACROSS_SETUP_TYPE -eq 2)) {
	$env:RACROSS_SETUP_CACHE = 1
}
$env:RACROSS_SETUP_INSTALL = 0
if($RACROSS_SETUP_TYPE -ne 2) {
	$env:RACROSS_SETUP_INSTALL = 1
}
$env:RACROSS_SETUP_DELETE = 0
if(($RACROSS_SETUP_TYPE -eq 0) -or ($RACROSS_SETUP_TYPE -eq 3)) {
	$env:RACROSS_SETUP_DELETE = 1
}

$RACROSS_WPS_CACHEBASE = "$RACROSS_BASE\CACHE"
$RACROSS_DESKTOP = [Environment]::GetFolderPath('CommonDesktopDirectory')

function global:sl_wps_base {
"--- set locate neutral."
Set-Location "$RACROSS_WPS_BASE"
}

$cli = New-Object System.Net.WebClient
$WsShell = New-Object -ComObject WScript.Shell

if($env:RACROSS_SETUP_CACHE -eq 1) {
	"restructure cache ..."
	Remove-Item "$RACROSS_WPS_CACHEBASE" -Recurse -Force
	New-Item "$RACROSS_WPS_CACHEBASE" -ItemType Directory
}

# VisualStudio 2017 community
sl_wps_base
if($env:RACROSS_SETUP_CACHE -eq 1) {
#	$env:RACROSS_LANG = "ja-JP"
	if([String]::IsNullOrEmpty($env:RACROSS_LANG)) {
		$env:RACROSS_LANG = "en-US"
	}
	"downloading vs_community.exe ..."
	$cli.DownloadFile("https://download.visualstudio.microsoft.com/download/pr/41217ce6-f73c-48b9-b679-e5193984336b/500a2965365fa0283c3c31e4837487d9/vs_community.exe", "$RACROSS_WPS_CACHEBASE\vs_community.exe")
	"downloading vs_community cache ..."
	Start-Process -FilePath "$RACROSS_WPS_CACHEBASE\vs_community.exe" -ArgumentList "--quiet --layout $RACROSS_WPS_CACHEBASE\vs2017layout --add Microsoft.VisualStudio.Workload.ManagedDesktop --add Microsoft.VisualStudio.Workload.NativeDesktop --add Microsoft.VisualStudio.Workload.Universal --add Microsoft.VisualStudio.Component.VC.ATL --add Microsoft.VisualStudio.Component.VC.MFC.ARM --add Microsoft.VisualStudio.Component.VC.MFC.ARM64 --add Microsoft.VisualStudio.Component.VC.ATL.ARM --add Microsoft.VisualStudio.Component.VC.ATL.ARM64 --add Microsoft.VisualStudio.Component.VC.Tools.x86.x64 --add Microsoft.VisualStudio.Component.VC.ATLMFC --add Microsoft.VisualStudio.Component.VC.CLI.Support --add Microsoft.VisualStudio.Component.VC.Modules.x86.x64 --add Microsoft.VisualStudio.ComponentGroup.UWP.VC --add Microsoft.VisualStudio.Component.WinXP --add Microsoft.VisualStudio.Component.VC.Tools.ARM --add Microsoft.VisualStudio.Component.VC.Tools.ARM64 --add Microsoft.VisualStudio.Component.UWP.VC.ARM64 --add Component.WebSocket --add Microsoft.Component.ClickOnce --add Microsoft.Component.NetFX.Native --add Microsoft.ComponentGroup.Blend --add Microsoft.Net.Component.4.5.TargetingPack --add Microsoft.Net.Core.Component.SDK.2.1 --add Microsoft.VisualStudio.Component.AppInsights.Tools --add Microsoft.VisualStudio.Component.DiagnosticTools --add Microsoft.VisualStudio.Component.Graphics --add Microsoft.VisualStudio.Component.JavaScript.Diagnostics --add Microsoft.VisualStudio.Component.JavaScript.TypeScript --add Microsoft.VisualStudio.Component.NuGet --add Microsoft.VisualStudio.Component.PortableLibrary --add Microsoft.VisualStudio.Component.Roslyn.Compiler --add Microsoft.VisualStudio.Component.Roslyn.LanguageServices --add Microsoft.VisualStudio.Component.SQL.CLR --add Microsoft.VisualStudio.Component.Static.Analysis.Tools --add Microsoft.VisualStudio.Component.TypeScript.3.1 --add Microsoft.VisualStudio.Component.UWP.Support --add Microsoft.VisualStudio.Component.VisualStudioData --add Microsoft.VisualStudio.Component.Windows10SDK.17763 --add Microsoft.VisualStudio.ComponentGroup.UWP.Cordova --add Microsoft.VisualStudio.ComponentGroup.UWP.NetCoreAndStandard --add Microsoft.VisualStudio.ComponentGroup.UWP.Xamarin --add Microsoft.VisualStudio.ComponentGroup.WebToolsExtensions --add Microsoft.Net.Component.4.7.2.SDK --add Microsoft.VisualStudio.Component.Graphics.Win81 --add Microsoft.VisualStudio.Component.VC.CoreIde --add Microsoft.VisualStudio.Component.Windows10SDK.IpOverUsb --add Microsoft.Component.MSBuild --add Microsoft.VisualStudio.Component.Git --add Microsoft.VisualStudio.Component.VC.CMake.Project --includeRecommended --lang $env:RACROSS_LANG" -Wait
}
if($env:RACROSS_SETUP_INSTALL -eq 1) {
	"setup vs_community ..."
	Start-Process -FilePath "$RACROSS_WPS_CACHEBASE\vs2017layout\vs_community.exe" -ArgumentList "--quiet --add Microsoft.VisualStudio.Workload.ManagedDesktop --add Microsoft.VisualStudio.Workload.NativeDesktop --add Microsoft.VisualStudio.Workload.Universal --add Microsoft.VisualStudio.Component.VC.ATL --add Microsoft.VisualStudio.Component.VC.MFC.ARM --add Microsoft.VisualStudio.Component.VC.MFC.ARM64 --add Microsoft.VisualStudio.Component.VC.ATL.ARM --add Microsoft.VisualStudio.Component.VC.ATL.ARM64 --add Microsoft.VisualStudio.Component.VC.Tools.x86.x64 --add Microsoft.VisualStudio.Component.VC.ATLMFC --add Microsoft.VisualStudio.Component.VC.CLI.Support --add Microsoft.VisualStudio.Component.VC.Modules.x86.x64 --add Microsoft.VisualStudio.ComponentGroup.UWP.VC --add Microsoft.VisualStudio.Component.WinXP --add Microsoft.VisualStudio.Component.VC.Tools.ARM --add Microsoft.VisualStudio.Component.VC.Tools.ARM64 --add Microsoft.VisualStudio.Component.UWP.VC.ARM64 --add Component.WebSocket --add Microsoft.Component.ClickOnce --add Microsoft.Component.NetFX.Native --add Microsoft.ComponentGroup.Blend --add Microsoft.Net.Component.4.5.TargetingPack --add Microsoft.Net.Core.Component.SDK.2.1 --add Microsoft.VisualStudio.Component.AppInsights.Tools --add Microsoft.VisualStudio.Component.DiagnosticTools --add Microsoft.VisualStudio.Component.Graphics --add Microsoft.VisualStudio.Component.JavaScript.Diagnostics --add Microsoft.VisualStudio.Component.JavaScript.TypeScript --add Microsoft.VisualStudio.Component.NuGet --add Microsoft.VisualStudio.Component.PortableLibrary --add Microsoft.VisualStudio.Component.Roslyn.Compiler --add Microsoft.VisualStudio.Component.Roslyn.LanguageServices --add Microsoft.VisualStudio.Component.SQL.CLR --add Microsoft.VisualStudio.Component.Static.Analysis.Tools --add Microsoft.VisualStudio.Component.TypeScript.3.1 --add Microsoft.VisualStudio.Component.UWP.Support --add Microsoft.VisualStudio.Component.VisualStudioData --add Microsoft.VisualStudio.Component.Windows10SDK.17763 --add Microsoft.VisualStudio.ComponentGroup.UWP.Cordova --add Microsoft.VisualStudio.ComponentGroup.UWP.NetCoreAndStandard --add Microsoft.VisualStudio.ComponentGroup.UWP.Xamarin --add Microsoft.VisualStudio.ComponentGroup.WebToolsExtensions --add Microsoft.Net.Component.4.7.2.SDK --add Microsoft.VisualStudio.Component.Graphics.Win81 --add Microsoft.VisualStudio.Component.VC.CoreIde --add Microsoft.VisualStudio.Component.Windows10SDK.IpOverUsb --add Microsoft.Component.MSBuild --add Microsoft.VisualStudio.Component.Git --add Microsoft.VisualStudio.Component.VC.CMake.Project --includeRecommended" -Wait
}

# MSYS2 64bit
sl_wps_base
$MSYS_INSTALLED = 0
if(Test-Path "C:\msys64") {
	$MSYS_INSTALLED = 1
}
if($MSYS_INSTALLED -eq 0) {
	"setup MSYS2 ..."
	Start-Process -FilePath "choco" -ArgumentList "install -y msys2" -Wait
	$Shortcut = $WsShell.CreateShortcut($RACROSS_DESKTOP + "\MinGW 64bit.lnk")
	$Shortcut.TargetPath = ("C:\tools\msys64\mingw64.exe")
	$Shortcut.IconLocation = ("C:\tools\msys64\mingw64.exe")
	$Shortcut.Save()
}

# copy MSYS2 files
sl_wps_base
if($MSYS_INSTALLED -eq 0) {
	"copy MSYS2 files ..."
	Copy-Item -Path "$RACROSS_BASE\2_MSYS2" -Destination "C:\tools\msys64\home\$env:USERNAME\RAcross" -Recurse
}

# Noteppad++
sl_wps_base
"setup Notepad++ ..."
Start-Process -FilePath "choco" -ArgumentList "install -y notepadplusplus" -Wait
$Shortcut = $WsShell.CreateShortcut($RACROSS_DESKTOP + "\Notepad++.lnk")
$Shortcut.TargetPath = ([Environment]::GetFolderPath('ProgramFiles') + "\Notepad++\notepad++.exe")
$Shortcut.IconLocation = ([Environment]::GetFolderPath('ProgramFiles') + "\Notepad++\notepad++.exe")
$Shortcut.Save()

# WinMerge
sl_wps_base
"setup WinMerge ..."
Start-Process -FilePath "choco" -ArgumentList "install -y winmerge" -Wait
$Shortcut = $WsShell.CreateShortcut($RACROSS_DESKTOP + "\WinMerge.lnk")
$Shortcut.TargetPath = ([Environment]::GetFolderPath('ProgramFiles') + "\WinMerge\WinMergeU.exe")
$Shortcut.IconLocation = ([Environment]::GetFolderPath('ProgramFiles') + "\WinMerge\WinMergeU.exe")
$Shortcut.Save()

# RetroArch
sl_wps_base
"setup RetroArch ..."
Start-Process -FilePath "choco" -ArgumentList "install -y retroarch" -Wait
$Shortcut = $WsShell.CreateShortcut($RACROSS_DESKTOP + "\RetroArch.lnk")
$Shortcut.TargetPath = ("C:\tools\retroarch\retroarch.exe")
$Shortcut.IconLocation = ("C:\tools\retroarch\retroarch.exe")
$Shortcut.Save()

# delete RAcross installer
if($env:RACROSS_SETUP_DELETE -eq 1) {
	Remove-Item "$RACROSS_BASE\*" -Recurse -Force
}

# 2nd start MSYS2
"setup MSYS2 env ..."
Start-Process -FilePath "C:\tools\msys64\msys2_shell.cmd" -ArgumentList "-mingw64 -c `"RAcross/RAcross.sh`"" -Wait

