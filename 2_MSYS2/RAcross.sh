#!/usr/bin/bash

SETUP_PS3=0
SETUP_DEVKITPRO=0
SETUP_ANDROID=0

export RACROSS_BASE=${HOME}/RAcross

export RACROSS_CACHE=${RACROSS_BASE}/cache
if [ ${RACROSS_SETUP_CACHE} = 1 ] ; then
	echo "*** restructure cache ***"
	rm -rf ${RACROSS_CACHE}
	mkdir -p ${RACROSS_CACHE}
fi

export RACROSS_TOOLS=${HOME}/RAcross-tools
rm -rf ${RACROSS_TOOLS}
mkdir -p ${RACROSS_TOOLS}

export RACROSS_INITSCRIPT=~/.bashrc

cd ~/RAcross

if [ ${RACROSS_SETUP_INSTALL} = 1 ] ; then
	pacman -S --noconfirm git make unzip patch
elif [ ${RACROSS_SETUP_CACHE} = 1 ] ; then
	pacman -Syu --noconfirm
	pacman -S --noconfirm git patch
	pacman -Sw --noconfirm make unzip
fi

# MinGW
if [ ${RACROSS_SETUP_INSTALL} = 1 ] ; then
	export PATH=$PATH:/c/MinGW/bin
	echo "export PATH=\$PATH:/c/MinGW/bin" >> ${RACROSS_INITSCRIPT}
fi

# devkitPro
if [ ${SETUP_DEVKITPRO} = 1 ] ; then
	echo "*** setup devkitPro ***"
	cd ${RACROSS_BASE}
	export DEVKITPRO=/opt/devkitpro
	export DEVKITARM=$DEVKITPRO/devkitARM
	export DEVKITA64=$DEVKITPRO/devkitA64
	export DEVKITPPC=$DEVKITPRO/devkitPPC
	export PATH=$PATH:$DEVKITPRO/devkitARM/bin
	export PATH=$PATH:$DEVKITPRO/devkitA64/bin
	export PATH=$PATH:$DEVKITPRO/devkitPPC/bin
	if [ ${RACROSS_SETUP_CACHE} = 1 ] ; then
		echo "[dkp-libs]" >> /etc/pacman.conf
		echo "SigLevel = Optional TrustAll" >> /etc/pacman.conf
		echo "Server = https://downloads.devkitpro.org/packages" >> /etc/pacman.conf
		echo "[dkp-windows]" >> /etc/pacman.conf
		echo "SigLevel = Optional TrustAll" >> /etc/pacman.conf
		echo "Server = https://downloads.devkitpro.org/packages/windows" >> /etc/pacman.conf
		wget https://downloads.devkitpro.org/devkitpro-keyring-r1.787e015-2-any.pkg.tar.xz -P ${RACROSS_CACHE}
		pacman -U --noconfirm ${RACROSS_CACHE}/devkitpro-keyring-r1.787e015-2-any.pkg.tar.xz
		pacman -Syuw --noconfirm
		pacman -Sw --noconfirm 3ds-dev gamecube-dev wii-dev wiiu-dev switch-dev
	fi
	if [ ${RACROSS_SETUP_INSTALL} = 1 ] ; then
		echo "export DEVKITPRO=/opt/devkitpro" >> ${RACROSS_INITSCRIPT}
		echo "export DEVKITARM=\$DEVKITPRO/devkitARM" >> ${RACROSS_INITSCRIPT}
		echo "export DEVKITA64=\$DEVKITPRO/devkitA64" >> ${RACROSS_INITSCRIPT}
		echo "export DEVKITPPC=\$DEVKITPRO/devkitPPC" >> ${RACROSS_INITSCRIPT}
		echo "export PATH=\$PATH:\$DEVKITPRO/devkitARM/bin" >> ${RACROSS_INITSCRIPT}
		echo "export PATH=\$PATH:\$DEVKITPRO/devkitA64/bin" >> ${RACROSS_INITSCRIPT}
		echo "export PATH=\$PATH:\$DEVKITPRO/devkitPPC/bin" >> ${RACROSS_INITSCRIPT}
		pacman -Syu --noconfirm
		pacman -S --noconfirm 3ds-dev gamecube-dev wii-dev wiiu-dev switch-dev
	fi
fi

# PS3
if [ ${SETUP_PS3} = 1 ] ; then
	if [ ${RACROSS_SETUP_INSTALL} = 1 ] ; then
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
if [ ${SETUP_ANDROID} = 1 ] ; then
	echo "*** setup Android NDK ***"
	cd ${RACROSS_BASE}
	if [ ${RACROSS_SETUP_CACHE} = 1 ] ; then
		wget https://dl.google.com/android/repository/android-ndk-r18b-windows-x86_64.zip -P ${RACROSS_CACHE}
	fi
	if [ ${RACROSS_SETUP_INSTALL} = 1 ] ; then
		unzip ${RACROSS_CACHE}/android-ndk-r18b-windows-x86_64.zip -d ${RACROSS_TOOLS}/
		export NDK_ROOT_DIR=${RACROSS_TOOLS}/android-ndk-r18b
		export PATH=$PATH:${RACROSS_TOOLS}/android-ndk-r18b
		echo "export NDK_ROOT_DIR=${RACROSS_TOOLS}/android-ndk-r18b" >> ${RACROSS_INITSCRIPT}
		echo "export PATH=\$PATH:${RACROSS_TOOLS}/android-ndk-r18b" >> ${RACROSS_INITSCRIPT}
	fi
fi

# libretro-super
echo "*** setup libretro-super ***"
cd ~
if [ ${RACROSS_SETUP_CACHE} = 1 ] ; then
	git clone --depth=1 https://github.com/libretro/libretro-super.git
	patch -p1 -d libretro-super < ${RACROSS_BASE}/libretro-super.patch
	chmod +x libretro-super/libretro-build-libnx.sh
	tar zcvf ${RACROSS_CACHE}/libretro-super.tar.gz libretro-super
	if [ ${RACROSS_SETUP_INSTALL} = 0 ] ; then
		rm -rf libretro-super
	fi
fi
if [ ${RACROSS_SETUP_CACHE} = 0 ] ; then
	tar zxfv ${RACROSS_CACHE}/libretro-super.tar.gz
fi

# build scripts
if [ ${RACROSS_SETUP_INSTALL} = 1 ] ; then
	cp ${RACROSS_BASE}/build-core.sh ~/libretro-super
	cp ${RACROSS_BASE}/build-core.ps1 ~/libretro-super
fi

# delete RAcross installer
if [ ${RACROSS_SETUP_DELETE} = 1 ] ; then
	rm -rf ${RACROSS_BASE}
fi

echo "*****************************************"
echo "RAcross setup is finished. please reboot."
echo "*****************************************"

read -p "press any key."

