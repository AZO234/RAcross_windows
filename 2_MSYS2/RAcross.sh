#!/usr/bin/bash

SETUP_DEVKITPRO=0
SETUP_PS3=0

export RACROSS_BASE=${HOME}/RAcross

export RACROSS_CACHE=${RACROSS_BASE}/cache
rm -rf ${RACROSS_CACHE}
mkdir -p ${RACROSS_CACHE}

export RACROSS_TOOLS=${HOME}/RAcross-tools
rm -rf ${RACROSS_TOOLS}
mkdir -p ${RACROSS_TOOLS}

export RACROSS_INITSCRIPT=~/.bashrc

RACROSS_NPROC=`nproc`
if test ${RACROSS_NPROC} -gt 1 ; then
export MAKEFLAGS=-j${RACROSS_NPROC} ${MAKEFLAGS}
fi

cd ~/RAcross

pacman -Syu --noconfirm
pacman -S --noconfirm make git unzip patch

# MinGW
echo "*** setup MinGW ***"
cd ${RACROSS_BASE}
wget "https://jaist.dl.osdn.jp/mingw/70619/binutils-2.32-1-mingw32-bin.tar.xz" -O ${RACROSS_CACHE}/binutils-mingw32-bin.tar.xz
wget "https://jaist.dl.osdn.jp/mingw/69950/gcc-core-8.2.0-3-mingw32-bin.tar.xz" -O ${RACROSS_CACHE}/gcc-core-mingw32-bin.tar.xz
wget "https://jaist.dl.osdn.jp/mingw/69944/gcc-c++-8.2.0-3-mingw32-bin.tar.xz" -O ${RACROSS_CACHE}/gcc-c++-mingw32-bin.tar.xz
wget "https://jaist.dl.osdn.jp/mingw/69303/pthreads-GC-w32-2.10-mingw32-pre-20160821-1-dev.tar.xz" -O ${RACROSS_CACHE}/pthreads-GC-w32-mingw32-bin.tar.xz
mkdir MinGW
cd MinGW
#tar Jxfv ${RACROSS_CACHE}/binutils-mingw32-bin.tar.xz
#tar Jxfv ${RACROSS_CACHE}/gcc-core-mingw32-bin.tar.xz
#tar Jxfv ${RACROSS_CACHE}/gcc-c++-mingw32-bin.tar.xz
#tar Jxfv ${RACROSS_CACHE}/pthreads-GC-w32-mingw32-bin.tar.xz
xz -dc ${RACROSS_CACHE}/binutils-mingw32-bin.tar.xz | tar xfv -
xz -dc ${RACROSS_CACHE}/gcc-core-mingw32-bin.tar.xz | tar xfv -
xz -dc ${RACROSS_CACHE}/gcc-c++-mingw32-bin.tar.xz | tar xfv -
xz -dc ${RACROSS_CACHE}/pthreads-GC-w32-mingw32-bin.tar.xz | tar xfv -
cp -rf * /usr/
cd ..
rm -rf MingGW

# devkitPro
if [ ${SETUP_DEVKITPRO} = 1 ] ; then
echo "*** setup devkitPro ***"
cd ${RACROSS_BASE}
export DEVKITPRO=/opt/devkitpro
export DEVKITARM=$DEVKITPRO/devkitARM
export DEVKITA64=$DEVKITPRO/devkitA64
export DEVKITPPC=$DEVKITPRO/devkitPPC
export LIBCTRU=$DEVKITPRO/libctru
export LIBOGC=$DEVKITPRO/libogc
export LIBNX=$DEVKITPRO/libnx
echo "export DEVKITPRO=/opt/devkitpro" >> ~/.bashrc
echo "export DEVKITARM=\$DEVKITPRO/devkitARM" >> ${RACROSS_INITSCRIPT}
echo "export DEVKITA64=\$DEVKITPRO/devkitA64" >> ${RACROSS_INITSCRIPT}
echo "export DEVKITPPC=\$DEVKITPRO/devkitPPC" >> ${RACROSS_INITSCRIPT}
echo "export LIBCTRU=\$DEVKITPRO/libctru" >> ${RACROSS_INITSCRIPT}
echo "export LIBOGC=\$DEVKITPRO/libogc" >> ${RACROSS_INITSCRIPT}
echo "export LIBNX=\$DEVKITPRO/libnx" >> ${RACROSS_INITSCRIPT}
echo "[dkp-libs]" >> /etc/pacman.conf
echo "SigLevel = Optional TrustAll" >> /etc/pacman.conf
echo "Server = https://downloads.devkitpro.org/packages" >> /etc/pacman.conf
echo "[dkp-windows]" >> /etc/pacman.conf
echo "SigLevel = Optional TrustAll" >> /etc/pacman.conf
echo "Server = https://downloads.devkitpro.org/packages/windows" >> /etc/pacman.conf
wget https://downloads.devkitpro.org/devkitpro-keyring-r1.787e015-2-any.pkg.tar.xz
pacman -U --noconfirm ${RACROSS_CACHE}/devkitpro-keyring-r1.787e015-2-any.pkg.tar.xz
pacman -Syu --noconfirm
pacman -S --noconfirm 3ds-dev gamecube-dev wii-dev wiiu-dev switch-dev
fi

# PS3
if [ ${SETUP_PS3} = 1 ] ; then
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

# libretro-super
echo "*** setup libretro-super ***"
cd ~
git clone --depth=1 https://github.com/libretro/libretro-super.git
tar Jcvf ${RACROSS_CACHE}/libretro-super.tar.xz libretro-super

# build scripts
cp ${RACROSS_BASE}/build-core.sh ~/libretro-super

# delete RAcross installer
rm -rf ${RACROSS_BASE}

echo "*****************************************"
echo "RAcross setup is finished. please reboot."
echo "*****************************************"

read -p "press any key."

