#!/usr/bin/bash

BUILD_PS3=0
BUILD_DEVKIT=0
BUILD_XBOX=0
BUILD_XBOX360=0
BUILD_ANDROID=0
BUILD_THEOS=0

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

# host(windows x86_64)
rm -rf libretro-${LR_CORE}
echo "=== host - build start ==="
if [[ ${LR_SRC_FETCH} = 1 ]] ; then
./libretro-fetch.sh ${LR_CORE}
else
cp -rf ${LR_CORE_SRC} libretro-${LR_CORE}
fi
./libretro-build.sh ${LR_CORE}
echo "=== host - build end ==="
mv log/${LR_CORE}.log log/${LR_CORE}_host.log

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

# CTR
if [[ ${BUILD_DEVKIT} = 1 ]] ; then
rm -rf libretro-${LR_CORE}
echo "=== CTR - build start ==="
if [[ ${LR_SRC_FETCH} = 1 ]] ; then
./libretro-fetch.sh ${LR_CORE}
else
cp -rf ${LR_CORE_SRC} libretro-${LR_CORE}
fi
./libretro-build-ctr.sh ${LR_CORE}
echo "=== CTR - build end ==="
mv log/${LR_CORE}.log log/${LR_CORE}_ctr.log
fi

# NGC
if [[ ${BUILD_DEVKIT} = 1 ]] ; then
rm -rf libretro-${LR_CORE}
echo "=== NGC - build start ==="
if [[ ${LR_SRC_FETCH} = 1 ]] ; then
./libretro-fetch.sh ${LR_CORE}
else
cp -rf ${LR_CORE_SRC} libretro-${LR_CORE}
fi
./libretro-build-ngc.sh ${LR_CORE}
echo "=== NGC - build end ==="
mv log/${LR_CORE}.log log/${LR_CORE}_ngc.log
fi

# Wii
if [[ ${BUILD_DEVKIT} = 1 ]] ; then
rm -rf libretro-${LR_CORE}
echo "=== Wii - build start ==="
if [[ ${LR_SRC_FETCH} = 1 ]] ; then
./libretro-fetch.sh ${LR_CORE}
else
cp -rf ${LR_CORE_SRC} libretro-${LR_CORE}
fi
./libretro-build-wii.sh ${LR_CORE}
echo "=== Wii - build end ==="
mv log/${LR_CORE}.log log/${LR_CORE}_wii.log
fi

# WiiU
if [[ ${BUILD_DEVKIT} = 1 ]] ; then
rm -rf libretro-${LR_CORE}
echo "=== WiiU - build start ==="
if [[ ${LR_SRC_FETCH} = 1 ]] ; then
./libretro-fetch.sh ${LR_CORE}
else
cp -rf ${LR_CORE_SRC} libretro-${LR_CORE}
fi
./libretro-build-wiiu.sh ${LR_CORE}
echo "=== WiiU - build end ==="
mv log/${LR_CORE}.log log/${LR_CORE}_wiiu.log
fi

# libnx
if [[ ${BUILD_DEVKIT} = 1 ]] ; then
rm -rf libretro-${LR_CORE}
echo "=== libnx - build start ==="
if [[ ${LR_SRC_FETCH} = 1 ]] ; then
./libretro-fetch.sh ${LR_CORE}
else
cp -rf ${LR_CORE_SRC} libretro-${LR_CORE}
fi
./libretro-build-libnx.sh ${LR_CORE}
echo "=== libnx - build end ==="
mv log/${LR_CORE}.log log/${LR_CORE}_libnx.log
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

# iOS Theos
if [[ ${BUILD_THEOS} = 1 ]] ; then
	rm -rf libretro-${LR_CORE}
	echo "=== iOS Theos - build start ==="
	if [[ ${LR_SRC_FETCH} = 1 ]] ; then
	./libretro-fetch.sh ${LR_CORE}
	else
	cp -rf ${LR_CORE_SRC} libretro-${LR_CORE}
	fi
	./libretro-build-ios-theos.sh ${LR_CORE}
	echo "=== iOS Theos - build end ==="
	mv log/${LR_CORE}.log log/${LR_CORE}_ios-theos.log
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

