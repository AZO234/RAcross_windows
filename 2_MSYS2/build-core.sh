#!/usr/bin/bash

BUILD_PS3=0

LR_CORE=np2kai
LR_CORE_SRC=~/NP2kai

SRCFETCH=0

cd ~/libretro-super

unset CC
unset CXX
unset AR
unset LD

# host(windows x86_64)
rm -rf libretro-${LR_CORE}
echo "=== host - build start ==="
if [ ${SRCFETCH} = 1 ] ; then
./libretro-fetch.sh ${LR_CORE}
else
cp -rf ${LR_CORE_SRC} libretro-${LR_CORE}
fi
./libretro-build.sh ${LR_CORE}
echo "=== host - build end ==="
mv log/${LR_CORE}.log log/${LR_CORE}_host.log

# PS3
if [ ${BUILD_PS3} = 1 ] ; then
rm -rf libretro-${LR_CORE}
echo "=== PS3 - build start ==="
if [ ${SRCFETCH} = 1 ] ; then
./libretro-fetch.sh ${LR_CORE}
else
cp -rf ${LR_CORE_SRC} libretro-${LR_CORE}
fi
./libretro-build-ps3.sh ${LR_CORE}
echo "=== PS3 - build end ==="
mv log/${LR_CORE}.log log/${LR_CORE}_ps3.log
fi

# sncps3
if [ ${BUILD_PS3} = 1 ] ; then
rm -rf libretro-${LR_CORE}
echo "=== sncps3 - build start ==="
if [ ${SRCFETCH} = 1 ] ; then
./libretro-fetch.sh ${LR_CORE}
else
cp -rf ${LR_CORE_SRC} libretro-${LR_CORE}
fi
./libretro-build-sncps3.sh ${LR_CORE}
echo "=== sncps3 - build end ==="
mv log/${LR_CORE}.log log/${LR_CORE}_sncps3.log
fi

# MSVC2017 x86 desktop
rm -rf libretro-${LR_CORE}
echo "=== MSVC2017 x86 desktop - build start ==="
if [ ${SRCFETCH} = 1 ] ; then
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
if [ ${SRCFETCH} = 1 ] ; then
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
if [ ${SRCFETCH} = 1 ] ; then
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
if [ ${SRCFETCH} = 1 ] ; then
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
if [ ${SRCFETCH} = 1 ] ; then
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

