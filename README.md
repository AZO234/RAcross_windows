RAcross_windows
===============

RAcross is libretro(RA?)'s core cross build emvironment.

	- Use Windows 10 Professional October 2020 update 64bit (Vanilla)

RAcross_windows can test follow cross builds

	- host
	- MSVC2019 x86&x64 desktop
	- MSVC2019 x86&x64 UWP
	- MSVC2019 ARM&ARM64 UWP

install
-------

	1. Locate RAcross_windows directory on C:\

	2. C:\Racross_windows\1_WPS\setup.bat right click -> open as administrator

		- (sleep/standby/hibernate is disabled)
		- PowerShell
		- Chocolatey
		- Visual Studio 2019 Community
		- WDK for Windows 10
		- vcpkg
		- Ninja
		- MSYS2

	3. MSYS2 shell opened and setuped

		- package update
		- packages

	4. "RAcross setup is finished." displaied then keydown and close PowerShell

usage
-----

	1. "Start" -> "MSYS2 64bit" -> "Msys2 MinGW 64bit"
	2. locate your core source at /home/USER/ (C:\msys64\home\USER\)
	3. edit libretro-super/build-core.sh, LR_CORE and LR_CORE_SRC value
	4. cd libretro-super
	5. ./build-core.sh
	6. build logs are output in 'log' dir  
	binalys are output in 'dist' dir

