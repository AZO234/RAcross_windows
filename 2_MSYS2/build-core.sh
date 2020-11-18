#!/usr/bin/bash

BUILD_PS3=0
BUILD_XBOX=0
BUILD_XBOX360=0
BUILD_ANDROID=1

LR_CORE=np2kai
LR_CORE_SRC=~/NP2kai

LR_DISTLOG_CLEAN=1
LR_SRC_FETCH=0

cd ~/libretro-super

if [[ ${LR_DISTLOG_CLEAN} = 1 ]] ; then
rm -rf dist/*
rm -rf log/*
fi

unset CC
unset CXX
unset AR
unset LD

# MinGW x86_64
rm -rf libretro-${LR_CORE}
echo "=== MinGW x86_64 - build start ==="
if [[ ${LR_SRC_FETCH} = 1 ]] ; then
./libretro-fetch.sh ${LR_CORE}
else
cp -rf ${LR_CORE_SRC} libretro-${LR_CORE}
fi
./libretro-build.sh ${LR_CORE}
echo "=== MinGW x86_64 - build end ==="
mv log/${LR_CORE}.log log/${LR_CORE}_mingw64.log
mv dist/win_x64 dist/mingw64

CC=i686-w64-mingw32-gcc
CXX=i686-w64-mingw32-g++
AR=i686-w64-mingw32-gcc-ar
LD=${CXX}

# MinGW i686
rm -rf libretro-${LR_CORE}
echo "=== MinGW i686 - build start ==="
if [[ ${LR_SRC_FETCH} = 1 ]] ; then
./libretro-fetch.sh ${LR_CORE}
else
cp -rf ${LR_CORE_SRC} libretro-${LR_CORE}
fi
./libretro-build.sh ${LR_CORE}
echo "=== MinGW i686 - build end ==="
mv log/${LR_CORE}.log log/${LR_CORE}_mingw32.log
mv dist/win_x64 dist/mingw32

unset CC
unset CXX
unset AR
unset LD

# PS3
if [[ ${BUILD_PS3} = 1 ]] ; then
rm -rf libretro-${LR_CORE}
echo "=== PS3 - build start ==="
if [[ ${LR_SRC_FETCH} = 1 ]] ; then
./libretro-fetch.sh ${LR_CORE}
else
cp -rf ${LR_CORE_SRC} libretro-${LR_CORE}
fi
./libretro-build-ps3.sh ${LR_CORE}
echo "=== PS3 - build end ==="
mv log/${LR_CORE}.log log/${LR_CORE}_ps3.log
fi

# sncps3
if [[ ${BUILD_PS3} = 1 ]] ; then
rm -rf libretro-${LR_CORE}
echo "=== sncps3 - build start ==="
if [[ ${LR_SRC_FETCH} = 1 ]] ; then
./libretro-fetch.sh ${LR_CORE}
else
cp -rf ${LR_CORE_SRC} libretro-${LR_CORE}
fi
./libretro-build-sncps3.sh ${LR_CORE}
echo "=== sncps3 - build end ==="
mv log/${LR_CORE}.log log/${LR_CORE}_sncps3.log
fi

# android-mk
if [[ ${BUILD_ANDROID} = 1 ]] ; then
	rm -rf libretro-${LR_CORE}
	echo "=== android-mk - build start ==="
	if [[ ${LR_SRC_FETCH} = 1 ]] ; then
	./libretro-fetch.sh ${LR_CORE}
	else
	cp -rf ${LR_CORE_SRC} libretro-${LR_CORE}
	fi
	./libretro-build-android-mk.sh ${LR_CORE} 2>&1 | tee log/${LR_CORE}_android.log
	echo "=== android-mk - build end ==="
fi

# Xbox
if [[ ${BUILD_XBOX} = 1 ]] ; then
rm -rf libretro-${LR_CORE}
echo "=== Xbox - build start ==="
if [[ ${LR_SRC_FETCH} = 1 ]] ; then
./libretro-fetch.sh ${LR_CORE}
else
cp -rf ${LR_CORE_SRC} libretro-${LR_CORE}
fi
./libretro-build-xdk1.sh ${LR_CORE}
echo "=== Xbox - build end ==="
mv log/${LR_CORE}.log log/${LR_CORE}_xdk1.log
fi

# Xbox 360
if [[ ${BUILD_XBOX360} = 1 ]] ; then
rm -rf libretro-${LR_CORE}
echo "=== Xbox 360 - build start ==="
if [[ ${LR_SRC_FETCH} = 1 ]] ; then
./libretro-fetch.sh ${LR_CORE}
else
cp -rf ${LR_CORE_SRC} libretro-${LR_CORE}
fi
./libretro-build-xdk360.sh ${LR_CORE}
echo "=== Xbox 360 - build end ==="
mv log/${LR_CORE}.log log/${LR_CORE}_xdk360.log
fi

# MSVC2017 x86 desktop
rm -rf libretro-${LR_CORE}
echo "=== MSVC2017 x86 desktop - build start ==="
if [[ ${LR_SRC_FETCH} = 1 ]] ; then
./libretro-fetch.sh ${LR_CORE}
else
cp -rf ${LR_CORE_SRC} libretro-${LR_CORE}
fi
./libretro-build-msvc2017_x86_desktop.sh ${LR_CORE}
echo "=== MSVC2017 x86 desktop - build end ==="
mv log/${LR_CORE}.log log/${LR_CORE}_msvc2017_x86_desktop.log

# MSVC2017 x64 desktop
rm -rf libretro-${LR_CORE}
echo "=== MSVC2017 x64 desktop - build start ==="
if [[ ${LR_SRC_FETCH} = 1 ]] ; then
./libretro-fetch.sh ${LR_CORE}
else
cp -rf ${LR_CORE_SRC} libretro-${LR_CORE}
fi
./libretro-build-msvc2017_x64_desktop.sh ${LR_CORE}
echo "=== MSVC2017 x64 desktop - build end ==="
mv log/${LR_CORE}.log log/${LR_CORE}_msvc2017_x64_desktop.log

# MSVC2017 x86 UWP
rm -rf libretro-${LR_CORE}
echo "=== MSVC2017 x86 UWP - build start ==="
if [[ ${LR_SRC_FETCH} = 1 ]] ; then
./libretro-fetch.sh ${LR_CORE}
else
cp -rf ${LR_CORE_SRC} libretro-${LR_CORE}
fi
./libretro-build-msvc2017_x86_uwp.sh ${LR_CORE}
echo "=== MSVC2017 x86 UWP - build end ==="
mv log/${LR_CORE}.log log/${LR_CORE}_msvc2017_x86_uwp.log

# MSVC2017 x64 UWP
rm -rf libretro-${LR_CORE}
echo "=== MSVC2017 x64 UWP - build start ==="
if [[ ${LR_SRC_FETCH} = 1 ]] ; then
./libretro-fetch.sh ${LR_CORE}
else
cp -rf ${LR_CORE_SRC} libretro-${LR_CORE}
fi
./libretro-build-msvc2017_x64_uwp.sh ${LR_CORE}
echo "=== MSVC2017 x64 UWP - build end ==="
mv log/${LR_CORE}.log log/${LR_CORE}_msvc2017_x64_uwp.log

# MSVC2017 ARM UWP
rm -rf libretro-${LR_CORE}
echo "=== MSVC2017 ARM UWP - build start ==="
if [[ ${LR_SRC_FETCH} = 1 ]] ; then
./libretro-fetch.sh ${LR_CORE}
else
cp -rf ${LR_CORE_SRC} libretro-${LR_CORE}
fi
./libretro-build-msvc2017_arm_uwp.sh ${LR_CORE}
echo "=== MSVC2017 ARM UWP - build end ==="
mv log/${LR_CORE}.log log/${LR_CORE}_msvc2017_arm_uwp.log

unset CC
unset CXX
unset AR
unset LD

