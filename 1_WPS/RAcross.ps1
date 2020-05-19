$RACROSS_BASE = "C:\RAcross_windows"
$RACROSS_WPS_BASE = "$RACROSS_BASE\1_WPS"

$env:RACROSS_SETUP_CACHE = 0
if(($env:RACROSS_SETUP_TYPE -eq 0) -or ($env:RACROSS_SETUP_TYPE -eq 1) -or ($env:RACROSS_SETUP_TYPE -eq 2)) {
	$env:RACROSS_SETUP_CACHE = 1
}
$env:RACROSS_SETUP_INSTALL = 0
if($env:RACROSS_SETUP_TYPE -ne 2) {
	$env:RACROSS_SETUP_INSTALL = 1
}
$env:RACROSS_SETUP_DELETE = 0
if(($env:RACROSS_SETUP_TYPE -eq 0) -or ($env:RACROSS_SETUP_TYPE -eq 3)) {
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

# VisualStudio 2019 community
sl_wps_base
if($env:RACROSS_SETUP_CACHE -eq 1) {
	$env:RACROSS_LANG = "en-US ja-JP"
	"downloading vs_community.exe ..."
	$cli.DownloadFile("https://download.visualstudio.microsoft.com/download/pr/5e397ebe-38b2-4e18-a187-ac313d07332a/169156e6e9a005d49b357c42240184dc1e3ccc28ebc777e70d49257c074f77e8/vs_Community.exe", "$RACROSS_WPS_CACHEBASE\vs_Community.exe")
	"downloading vs_community cache ..."
	Start-Process -FilePath "$RACROSS_WPS_CACHEBASE\vs_Community.exe" -ArgumentList "--quiet --layout $RACROSS_WPS_CACHEBASE\vs2019layout --add Microsoft.VisualStudio.Component.CoreEditor --add Microsoft.VisualStudio.Component.StartPageExperiment.Cpp --add Microsoft.VisualStudio.Workload.NativeDesktop --add Microsoft.Component.MSBuild --add Microsoft.Net.Component.4.7.2.TargetingPack --add Microsoft.Net.Component.4.8.SDK --add Microsoft.Net.ComponentGroup.DevelopmentPrerequisites --add Microsoft.NetCore.Component.Runtime.3.1 --add Microsoft.NetCore.Component.SDK --add Microsoft.VisualStudio.Component.IntelliCode --add Microsoft.VisualStudio.Component.ManagedDesktop.Core --add Microsoft.VisualStudio.Component.ManagedDesktop.Prerequisites --add Microsoft.VisualStudio.Component.Roslyn.Compiler --add Microsoft.VisualStudio.Component.Roslyn.LanguageServices --add Microsoft.VisualStudio.Component.SQL.CLR --add Microsoft.VisualStudio.Component.TextTemplating --add Microsoft.VisualStudio.Component.VC.CoreIde --add Microsoft.VisualStudio.Component.VC.Redist.14.Latest --add Microsoft.VisualStudio.ComponentGroup.NativeDesktop.Core --add Microsoft.VisualStudio.Component.Debugger.JustInTime --add Microsoft.VisualStudio.Component.Graphics.Tools --add Microsoft.VisualStudio.Component.VC.CMake.Project --add Microsoft.VisualStudio.Component.VC.DiagnosticTools --add Microsoft.VisualStudio.ComponentGroup.WebToolsExtensions.CMake --add Microsoft.Component.NetFX.Native --add Microsoft.ComponentGroup.Blend --add Microsoft.VisualStudio.Component.AppInsights.Tools --add Microsoft.VisualStudio.Component.DiagnosticTools --add Microsoft.VisualStudio.Component.Graphics --add Microsoft.VisualStudio.Component.NuGet --add Microsoft.VisualStudio.ComponentGroup.MSIX.Packaging --add Microsoft.VisualStudio.ComponentGroup.UWP.NetCoreAndStandard --add Microsoft.VisualStudio.ComponentGroup.UWP.Support --add Microsoft.VisualStudio.ComponentGroup.UWP.Xamarin --add Component.GitHub.VisualStudio --add Microsoft.VisualStudio.Component.VC.ATL.Spectre --add Microsoft.VisualStudio.Component.VC.ATLMFC.Spectre --add Microsoft.VisualStudio.Component.VC.MFC.ARM.Spectre --add Microsoft.VisualStudio.Component.VC.MFC.ARM64.Spectre --add Microsoft.VisualStudio.Component.VC.Redist.MSM --add Microsoft.VisualStudio.Component.VisualStudioData --add Microsoft.VisualStudio.Component.VC.Runtimes.ARM.Spectre --add Microsoft.VisualStudio.Component.VC.Runtimes.ARM64.Spectre --add Microsoft.VisualStudio.Component.VC.Runtimes.x86.x64.Spectre --add Microsoft.VisualStudio.Component.WinXP --add Microsoft.VisualStudio.Component.Git --add Microsoft.VisualStudio.Component.ClassDesigner --add Microsoft.VisualStudio.Component.DependencyValidation.Community --add Microsoft.Component.HelpViewer --add Microsoft.VisualStudio.Component.Windows10SDK --add Microsoft.VisualStudio.Component.UWP.VC.ARM64 --add Microsoft.VisualStudio.Component.Windows10SDK.IpOverUsb --includeRecommended --lang $env:RACROSS_LANG" -Wait
}
if($env:RACROSS_SETUP_INSTALL -eq 1) {
	"setup vs_community ..."
	Start-Process -FilePath "$RACROSS_WPS_CACHEBASE\vs2019layout\vs_Community.exe" -ArgumentList "--quiet --add Microsoft.VisualStudio.Component.CoreEditor --add Microsoft.VisualStudio.Component.StartPageExperiment.Cpp --add Microsoft.VisualStudio.Workload.NativeDesktop --add Microsoft.Component.MSBuild --add Microsoft.Net.Component.4.7.2.TargetingPack --add Microsoft.Net.Component.4.8.SDK --add Microsoft.Net.ComponentGroup.DevelopmentPrerequisites --add Microsoft.NetCore.Component.Runtime.3.1 --add Microsoft.NetCore.Component.SDK --add Microsoft.VisualStudio.Component.IntelliCode --add Microsoft.VisualStudio.Component.ManagedDesktop.Core --add Microsoft.VisualStudio.Component.ManagedDesktop.Prerequisites --add Microsoft.VisualStudio.Component.Roslyn.Compiler --add Microsoft.VisualStudio.Component.Roslyn.LanguageServices --add Microsoft.VisualStudio.Component.SQL.CLR --add Microsoft.VisualStudio.Component.TextTemplating --add Microsoft.VisualStudio.Component.VC.CoreIde --add Microsoft.VisualStudio.Component.VC.Redist.14.Latest --add Microsoft.VisualStudio.ComponentGroup.NativeDesktop.Core --add Microsoft.VisualStudio.Component.Debugger.JustInTime --add Microsoft.VisualStudio.Component.Graphics.Tools --add Microsoft.VisualStudio.Component.VC.CMake.Project --add Microsoft.VisualStudio.Component.VC.DiagnosticTools --add Microsoft.VisualStudio.ComponentGroup.WebToolsExtensions.CMake --add Microsoft.Component.NetFX.Native --add Microsoft.ComponentGroup.Blend --add Microsoft.VisualStudio.Component.AppInsights.Tools --add Microsoft.VisualStudio.Component.DiagnosticTools --add Microsoft.VisualStudio.Component.Graphics --add Microsoft.VisualStudio.Component.NuGet --add Microsoft.VisualStudio.ComponentGroup.MSIX.Packaging --add Microsoft.VisualStudio.ComponentGroup.UWP.NetCoreAndStandard --add Microsoft.VisualStudio.ComponentGroup.UWP.Support --add Microsoft.VisualStudio.ComponentGroup.UWP.Xamarin --add Component.GitHub.VisualStudio --add Microsoft.VisualStudio.Component.VC.ATL.Spectre --add Microsoft.VisualStudio.Component.VC.ATLMFC.Spectre --add Microsoft.VisualStudio.Component.VC.MFC.ARM.Spectre --add Microsoft.VisualStudio.Component.VC.MFC.ARM64.Spectre --add Microsoft.VisualStudio.Component.VC.Redist.MSM --add Microsoft.VisualStudio.Component.VisualStudioData --add Microsoft.VisualStudio.Component.VC.Runtimes.ARM.Spectre --add Microsoft.VisualStudio.Component.VC.Runtimes.ARM64.Spectre --add Microsoft.VisualStudio.Component.VC.Runtimes.x86.x64.Spectre --add Microsoft.VisualStudio.Component.WinXP --add Microsoft.VisualStudio.Component.Git --add Microsoft.VisualStudio.Component.ClassDesigner --add Microsoft.VisualStudio.Component.DependencyValidation.Community --add Microsoft.Component.HelpViewer --add Microsoft.VisualStudio.Component.Windows10SDK --add Microsoft.VisualStudio.Component.UWP.VC.ARM64 --add Microsoft.VisualStudio.Component.Windows10SDK.IpOverUsb --includeRecommended" -Wait
}

# WDK for Windows 10
sl_wps_base
if($env:RACROSS_SETUP_CACHE -eq 1) {
	"downloading WDK for Windows 10 ..."
	$cli.DownloadFile("https://go.microsoft.com/fwlink/?linkid=2085767", "$RACROSS_WPS_CACHEBASE\wdksetup.exe")
	"setup WDK for Windows 10 ..."
	Start-Process -FilePath "$RACROSS_WPS_CACHEBASE\wdksetup.exe" -ArgumentList "/features OptionId.WindowsDriverKitComplete /quiet" -Wait
}

# vcpkg
Start-Process -FilePath "C:\Program Files (x86)\Microsoft Visual Studio\2019\Community\Common7\IDE\CommonExtensions\Microsoft\TeamFoundation\Team Explorer\Git\mingw32\bin\git" -ArgumentList "clone https://github.com/Microsoft/vcpkg C:\vcpkg" -Wait
cd C:\vcpkg
.\bootstrap-vcpkg.bat
.\vcpkg integrate install
[Environment]::SetEnvironmentVariable('VCPKG_ROOT', "C:\vcpkg", 'Machine')

# [vcpkg] OpenSSL
.\vcpkg install openssl

# [vcpkg] SDL2
.\vcpkg install sdl2 sdl2-mixer sdl2-ttf

# [vcpkg] libusb
.\vcpkg install libusb

# [vcpkg] wxWidgets
.\vcpkg install wxwidgets

# Ninja
sl_wps_base
"setup Ninja ..."
Start-Process -FilePath "choco" -ArgumentList "install -y ninja" -Wait

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

