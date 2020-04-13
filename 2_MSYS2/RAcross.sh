#!/usr/bin/bash

SETUP_PS3=0
SETUP_DEVKITPRO=0
SETUP_ANDROID=0
SETUP_THEOS=0

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
	pacman -S --noconfirm git make unzip patch mingw-w64-x86_64-toolchain mingw-w64-x86_64-pkg-config mingw-w64-x86_64-SDL2 mingw-w64-x86_64-SDL2_ttf mingw-w64-x86_64-SDL2_mixer mingw-w64-x86_64-libxml2 mingw-w64-x86_64-freetype mingw-w64-x86_64-python3 mingw-w64-x86_64-ffmpeg
elif [[ ${RACROSS_SETUP_CACHE} = 1 ]] ; then
	pacman -Syu --noconfirm
	pacman -S --noconfirm git patch
	pacman -Sw --noconfirm make unzip mingw-w64-x86_64-toolchain mingw-w64-x86_64-pkg-config mingw-w64-x86_64-SDL2 mingw-w64-x86_64-SDL2_ttf mingw-w64-x86_64-SDL2_mixer mingw-w64-x86_64-libxml2 mingw-w64-x86_64-freetype mingw-w64-x86_64-python3 mingw-w64-x86_64-ffmpeg
fi

# devkitPro
if [[ ${SETUP_DEVKITPRO} = 1 ]] ; then
	echo "*** setup devkitPro ***"
	cd ${RACROSS_BASE}
	export DEVKITPRO=/opt/devkitpro
	export DEVKITARM=$DEVKITPRO/devkitARM
	export DEVKITA64=$DEVKITPRO/devkitA64
	export DEVKITPPC=$DEVKITPRO/devkitPPC
	export PATH=$PATH:$DEVKITPRO/devkitARM/bin
	export PATH=$PATH:$DEVKITPRO/devkitA64/bin
	export PATH=$PATH:$DEVKITPRO/devkitPPC/bin
	if [[ ${RACROSS_SETUP_CACHE} = 1 ]] ; then
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
	if [[ ${RACROSS_SETUP_INSTALL} = 1 ]] ; then
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
		wget https://dl.google.com/android/repository/android-ndk-r21-windows-x86_64.zip -P ${RACROSS_CACHE}
	fi
	if [[ ${RACROSS_SETUP_INSTALL} = 1 ]] ; then
		unzip ${RACROSS_CACHE}/android-ndk-r21-windows-x86_64.zip -d ${RACROSS_TOOLS}/
		export NDK_ROOT_DIR=${RACROSS_TOOLS}/android-ndk-r21
		export PATH=$PATH:${RACROSS_TOOLS}/android-ndk-r21
		echo "export NDK_ROOT_DIR=${RACROSS_TOOLS}/android-ndk-r21" >> ${RACROSS_INITSCRIPT}
		echo "export PATH=\$PATH:${RACROSS_TOOLS}/android-ndk-r21" >> ${RACROSS_INITSCRIPT}
	fi
fi

# Theos
if [[ ${SETUP_THEOS} = 1 ]] ; then
	echo "*** setup Theos ***"
	cd ${RACROSS_BASE}
	export THEOS=${RACROSS_TOOLS}/theos
	echo "export THEOS=${RACROSS_TOOLS}/theos" >> ${RACROSS_INITSCRIPT}
#	git clone --recursive https://github.com/AZO234/theos.git ${THEOS}
	git clone https://github.com/AZO234/theos.git ${THEOS}
	cd ${THEOS}
	git checkout fix
	git submodule update --init --recursive
	cd ${RACROSS_BASE}
	rm -rf ${THEOS}/sdks
	git clone https://github.com/theos/sdks.git ${THEOS}/sdks
#	curl https://ghostbin.com/ghost.sh -o ${THEOS}/bin/ghost
	curl https://gist.githubusercontent.com/supermamon/e5d7d19286f7fb471c85d0b1127d5e47/raw/a57b0f8cf7864e53169bb5290ce56be2c7631403/ghost.sh -o ${THEOS}/bin/ghost
	chmod +x ${THEOS}/bin/ghost
#	if [[ ! ${RACROSS_SETUP_DELETE} = 1 ]] ; then
#		tar Jcvf ${RACROSS_CACHE}/theos.tar.xz ${THEOS}
#	fi
fi

# libretro-super
echo "*** setup libretro-super ***"
cd ~
if [[ ${RACROSS_SETUP_CACHE} = 1 ]] ; then
	git clone https://github.com/AZO234/libretro-super.git
	cd libretro-super
	git checkout AZO_fix
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

