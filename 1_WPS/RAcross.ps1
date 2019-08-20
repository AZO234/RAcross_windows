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

function global:sl_wps_base {
"--- set locate neutral."
Set-Location "$RACROSS_WPS_BASE"
}

$cli = New-Object System.Net.WebClient

if($env:RACROSS_SETUP_CACHE -eq 1) {
	"restructure cache ..."
	Remove-Item "$RACROSS_WPS_CACHEBASE" -Recurse -Force
	New-Item "$RACROSS_WPS_CACHEBASE" -ItemType Directory
}

# VisualStudio 2017 community
sl_wps_base
if($env:RACROSS_SETUP_CACHE -eq 1) {
	if([String]::IsNullOrEmpty($env:RACROSS_LANG)) {
		$env:RACROSS_LANG = "En-us"
	}
	"downloading vs_community.exe ..."
	$cli.DownloadFile("https://download.visualstudio.microsoft.com/download/pr/41217ce6-f73c-48b9-b679-e5193984336b/500a2965365fa0283c3c31e4837487d9/vs_community.exe", "$RACROSS_WPS_CACHEBASE\vs_community.exe")
	"downloading vs_community cache ..."
	Start-Process -FilePath "$RACROSS_WPS_CACHEBASE\vs_community.exe" -ArgumentList "--quiet --layout $RACROSS_WPS_CACHEBASE\vs2017layout --add Microsoft.VisualStudio.Workload.ManagedDesktop --add Microsoft.VisualStudio.Workload.NativeDesktop -add Microsoft.VisualStudio.Workload.Universal
 --add Microsoft.VisualStudio.Component.VC.ATL --add Microsoft.VisualStudio.Component.VC.MFC.ARM --add Microsoft.VisualStudio.Component.VC.MFC.ARM64 --add Microsoft.VisualStudio.Component.VC.ATL.ARM --add Microsoft.VisualStudio.Component.VC.ATL.ARM64 --add Microsoft.VisualStudio.Component.VC.Tools.x86.x64 --add Microsoft.VisualStudio.Component.VC.ATLMFC --add Microsoft.VisualStudio.Component.VC.CLI.Support --add Microsoft.VisualStudio.Component.VC.Modules.x86.x64 --add Microsoft.VisualStudio.ComponentGroup.UWP.VC --add Microsoft.VisualStudio.Component.WinXP --add Microsoft.VisualStudio.Component.VC.Tools.ARM --add Microsoft.VisualStudio.Component.VC.Tools.ARM64 --add Microsoft.VisualStudio.Component.UWP.VC.ARM64 --includeRecommended --lang En-us" -Wait
}
if($env:RACROSS_SETUP_INSTALL -eq 1) {
	"setup vs_community ..."
	Start-Process -FilePath "$RACROSS_WPS_CACHEBASE\vs2017layout\vs_community.exe" -ArgumentList "--quiet --add Microsoft.Component.MSBuild --add Microsoft.VisualStudio.Workload.ManagedDesktop --add Microsoft.VisualStudio.Workload.NativeDesktop -add Microsoft.VisualStudio.Workload.Universal
 --add Microsoft.VisualStudio.Component.VC.ATL --add Microsoft.VisualStudio.Component.VC.MFC.ARM --add Microsoft.VisualStudio.Component.VC.MFC.ARM64 --add Microsoft.VisualStudio.Component.VC.ATL.ARM --add Microsoft.VisualStudio.Component.VC.ATL.ARM64 --add Microsoft.VisualStudio.Component.VC.Tools.x86.x64 --add Microsoft.VisualStudio.Component.VC.ATLMFC --add Microsoft.VisualStudio.Component.VC.CLI.Support --add Microsoft.VisualStudio.Component.VC.Modules.x86.x64 --add Microsoft.VisualStudio.ComponentGroup.UWP.VC --add Microsoft.VisualStudio.Component.WinXP --add Microsoft.VisualStudio.Component.VC.Tools.ARM --add Microsoft.VisualStudio.Component.VC.Tools.ARM64 --add Microsoft.VisualStudio.Component.UWP.VC.ARM64 --includeRecommended" -Wait
}

# MSYS2 64bit
sl_wps_base
$MSYS_INSTALLED = 0
if(Test-Path "C:\msys64") {
	$MSYS_INSTALLED = 1
}
if($env:RACROSS_SETUP_CACHE -eq 1) {
	"downloading MSYS2 ..."
	$cli.DownloadFile("http://repo.msys2.org/distrib/x86_64/msys2-x86_64-20190524.exe", "$RACROSS_WPS_CACHEBASE\msys2-x86_64.exe")
#	$cli.DownloadFile("https://raw.githubusercontent.com/msys2/msys2-installer/master/auto-install.js", "$RACROSS_WPS_CACHEBASE\auto-install.js")
}
if($MSYS_INSTALLED -eq 0) {
	"setup MSYS2 ..."
	#Start-Process -FilePath "$RACROSS_WPS_CACHEBASE\msys2-x86_64.exe" -ArgumentList "--platform minimal --script $RACROSS_WPS_CACHEBASE\auto-install.js -v" -Wait
	Start-Process -FilePath "$RACROSS_WPS_CACHEBASE\msys2-x86_64.exe" -Wait
}

# copy MSYS2 files
sl_wps_base
if($MSYS_INSTALLED -eq 0) {
	"copy MSYS2 files ..."
	Copy-Item -Path "$RACROSS_BASE\2_MSYS2" -Destination "C:\msys64\home\$env:USERNAME\RAcross" -Recurse
	# 1st start MSYS2
	"update MSYS2 ..."
	Start-Process -FilePath "C:\msys64\msys2_shell.cmd" -ArgumentList "-mingw64 -c `"pacman -Syu --noconfirm`"" -Wait
}

# delete RAcross installer
if($env:RACROSS_SETUP_DELETE -eq 1) {
#	Remove-Item "$RACROSS_BASE" -Recurse -Force
	Remove-Item "$RACROSS_BASE\*" -Recurse -Force
}

# 2nd start MSYS2
"setup MSYS2 env ..."
Start-Process -FilePath "C:\msys64\msys2_shell.cmd" -ArgumentList "-mingw64 -c `"RAcross/RAcross.sh`"" -Wait

