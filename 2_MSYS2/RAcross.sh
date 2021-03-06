#!/usr/bin/bash

SETUP_PS3=0
SETUP_ANDROID=1

RACROSS_SETUP_GIT=0

if [[ ${RACROSS_SETUP_GIT} = 1 ]] ; then
git config --global user.email "you@example.com"
git config --global user.name "Your Name"
fi

export RACROSS_BASE=${HOME}/RAcross

export RACROSS_CACHE=${RACROSS_BASE}/cache
if [[ ${RACROSS_SETUP_CACHE} = 1 ]] ; then
	echo "*** restructure cache ***"
	rm -rf ${RACROSS_CACHE}
	mkdir -p ${RACROSS_CACHE}
fi

export RACROSS_TOOLS=${HOME}/RAcross-tools
rm -rf ${RACROSS_TOOLS}
mkdir -p ${RACROSS_TOOLS}

export RACROSS_INITSCRIPT=~/.bashrc

cd ~/RAcross

if [[ ${RACROSS_SETUP_INSTALL} = 1 ]] ; then
	pacman -S --noconfirm git cmake ninja make unzip patch mingw-w64-x86_64-toolchain mingw-w64-i686-toolchain mingw-w64-i686-toolchain mingw-w64-x86_64-pkg-config mingw-w64-x86_64-SDL2 mingw-w64-x86_64-SDL2_ttf mingw-w64-x86_64-SDL2_mixer mingw-w64-x86_64-libxml2 mingw-w64-x86_64-freetype mingw-w64-x86_64-python3 mingw-w64-x86_64-ffmpeg mingw-w64-x86_64-libusb mingw-w64-x86_64-wxWidgets
elif [[ ${RACROSS_SETUP_CACHE} = 1 ]] ; then
	pacman -Syu --noconfirm
	pacman -S --noconfirm git patch
	pacman -Sw --noconfirm cmake ninja make unzip mingw-w64-x86_64-toolchain mingw-w64-i686-toolchain mingw-w64-x86_64-pkg-config mingw-w64-x86_64-SDL2 mingw-w64-x86_64-SDL2_ttf mingw-w64-x86_64-SDL2_mixer mingw-w64-x86_64-libxml2 mingw-w64-x86_64-freetype mingw-w64-x86_64-python3 mingw-w64-x86_64-ffmpeg mingw-w64-x86_64-libusb mingw-w64-x86_64-wxWidgets
fi

if [[ ${RACROSS_SETUP_GIT} = 1 ]] ; then
git config --global user.email "you@example.com"
git config --global user.name "Your Name"
fi

# PS3
if [[ ${SETUP_PS3} = 1 ]] ; then
	if [[ ${RACROSS_SETUP_INSTALL} = 1 ]] ; then
		echo "*** setup PS3 ***"
		cd ${RACROSS_BASE}
		unzip PS3_SDK-475_001.zip
		unzip PS3_Toolchain_411-Win_420_001.zip -d cell1
		unzip SNCPPUToolchainforPlayStation3v470.1.zip -d cell2
		cp -rf cell1/cell/* cell/
		rm -rf cell1
		cp -rf cell2/cell/* cell/
		rm -rf cell2
		mv cell ${RACROSS_TOOLS}/
		export CELL_SDK=${RACROSS_TOOLS}/cell
		export PATH=$PATH:$CELL_SDK/host-win32/ppu/bin:$CELL_SDK/host-win32/spu/bin:$CELL_SDK/host-win32/sn/bin
		echo "export CELL_SDK=${RACROSS_TOOLS}/cell" >> ${RACROSS_INITSCRIPT}
		echo "export PATH=\$PATH:\$CELL_SDK/host-win32/ppu/bin:\$CELL_SDK/host-win32/spu/bin:\$CELL_SDK/host-win32/sn/bin" >> ${RACROSS_INITSCRIPT}
	fi
fi

# Android NDK *.cmd file cannot run*
if [[ ${SETUP_ANDROID} = 1 ]] ; then
	echo "*** setup Android NDK ***"
	cd ${RACROSS_BASE}
	if [ ${RACROSS_SETUP_CACHE} = 1 ] ; then
		wget https://dl.google.com/android/repository/android-ndk-r21b-windows-x86_64.zip -P ${RACROSS_CACHE}
	fi
	if [[ ${RACROSS_SETUP_INSTALL} = 1 ]] ; then
		unzip ${RACROSS_CACHE}/android-ndk-r21b-windows-x86_64.zip -d ${RACROSS_TOOLS}/
		export NDK_ROOT_DIR=${RACROSS_TOOLS}/android-ndk-r21b
		export PATH=$PATH:${RACROSS_TOOLS}/android-ndk-r21b
		echo "export NDK_ROOT_DIR=${RACROSS_TOOLS}/android-ndk-r21b" >> ${RACROSS_INITSCRIPT}
		echo "export PATH=\$PATH:${RACROSS_TOOLS}/android-ndk-r21b" >> ${RACROSS_INITSCRIPT}
	fi
fi

# libretro-super
echo "*** setup libretro-super ***"
cd ~
if [[ ${RACROSS_SETUP_CACHE} = 1 ]] ; then
	git clone https://github.com/libretro/libretro-super.git
	cd libretro-super
	git remote add AZO234 https://github.com/AZO234/libretro-super.git
	git pull --no-edit AZO234 AZO_fix
	cd ..
	tar zcvf ${RACROSS_CACHE}/libretro-super.tar.gz libretro-super
	if [[ ${RACROSS_SETUP_INSTALL} = 0 ]] ; then
		rm -rf libretro-super
	fi
fi
if [[ ${RACROSS_SETUP_CACHE} = 0 ]] ; then
	tar zxfv ${RACROSS_CACHE}/libretro-super.tar.gz
fi

# build scripts
if [[ ${RACROSS_SETUP_INSTALL} = 1 ]] ; then
	cp ${RACROSS_BASE}/build-core.sh ~/libretro-super
fi

# delete RAcross installer
if [[ ${RACROSS_SETUP_DELETE} = 1 ]] ; then
	rm -rf ${RACROSS_BASE}
fi

echo "*****************************************"
echo "RAcross setup is finished. please reboot."
echo "*****************************************"

read -p "press any key."

