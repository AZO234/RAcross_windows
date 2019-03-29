$env:BUILD_PS3=0
$env:BUILD_DEVKIT=0
$env:BUILD_XBOX=0
$env:BUILD_XBOX360=0
$env:BUILD_ANDROID=0
$env:BUILD_EMSCRIPTEN=1

if($env:BUILD_EMSCRIPTEN -eq 1) {
	$user_emsdk = [Environment]::GetFolderPath('LocalApplicationData') + "\emsdk\emsdk_env.bat"
	Start-Process -FilePath $user_emsdk -Wait
}

Start-Process -FilePath "C:\msys64\msys2_shell.cmd" -ArgumentList "-mingw32 -c `"~/libretro-super/build-core.sh`""
