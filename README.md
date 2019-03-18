RAcross_windows
===============

RAcross is libretro(RA?)'s core cross build emvironment.

	- Use Windows 10 Professional October 2018 update 64bit (Vanilla)

RAcross_windows can test follow cross builds

	- host
	- MSVC2017 x86 desktop
	- MSVC2017 x64 desktop
	- MSVC2017 x86 UWP
	- MSVC2017 x64 UWP
	- MSVC2017 ARM UWP

install
-------

	1. Locate RAcross_windows directory on C:\
	2. Windows PowerShell setting to use ps1 script

		1. "Start" -&gt; "Windows PowerShell" right click -&gt; open as administrator
		2. input commant "Set-ExecutionPolicy RemoteSigned"
		3. Y
		4. close shell

	3. C:\Racross_windows\1_WPS\setup.bat right click -> open as administrator

		- (sleep/standby/hibernate is disabled)
		- Visual Studio 2017 Community

	4. MSYS2 64bit setup window displaied

		- All default click "Next"
		- final dialog, check clear "run MSYS2 64bit" then "Finish"

	5. MinGW setup window displaied

		- select "mingw32-base-bin" and "mingw32-gcc-g++-bin", then "Apply Changes"

	6. MSYS2 shell opened and setuped

		- package update
		- packages

	7. "RAcross setup is finished." displaied then keydown and close PowerShell

usage
-----

	1. "Start" -> "MSYS2 64bit" -> "Msys2 MinGW 32bit"
	2. locate your core source at /home/USER/ (C:\msys64\home\USER\)
	3. edit libretro-super/build-core.sh, LR_CORE and LR_CORE_SRC value
	4. cd libretro-super
	5. ./build-core.sh
	6. build logs are output in log dir

