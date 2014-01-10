#!/bin/sh

# This script is originally based off of the one by Gabriel Handford
# Original scripts can be found here: https://github.com/gabriel/ffmpeg-iphone-build
# Modified by Roderick Buenviaje
# Builds versions of the VideoLAN x264 for armv6 and armv7
# Combines the two libraries into a single one

trap exit ERR

export  DIR=`pwd`/../ffmpeg-x264/x264_src
export  BUILD_OUT=`pwd`/build/x264/
export  BUILD_OUT6=${BUILD_OUT}/armv6/
export  BUILD_OUT7=${BUILD_OUT}/armv7/
export  BUILD_OUT7s=${BUILD_OUT}/armv7s/
export  DIST_DIR=`pwd`/dist/x264/

#specify the version of iOS you want to build against
export VERSION="5.1"

#platform configuration
FLAGS="--host=arm-apple-darwin --sysroot=${SDKPATH} --enable-pic --enable-static --disable-asm --disable-cli --enable-strip"
#neon: semms not supported
#EXTRA_CFLAGS="$EXTRA_CFLAGS -march=armv7-a -mfloat-abi=softfp -mfpu=neon"
#EXTRA_LDFLAGS="$EXTRA_LDFLAGS -Wl,--fix-cortex-a8"

cd $DIR
rm -Rf $BUILD_OUT

#echo "Building armv6..."
#mkdir -p ${BUILD_OUT6}
#./configure --host=arm-apple-darwin --sysroot=${SDKPATH} --prefix=$BUILD_OUT6 --extra-cflags='-arch armv6' --extra-ldflags='-L${SDKPATH}/usr/lib/system -arch armv6' --enable-pic --disable-asm --enable-static
#make && make install
#echo "Installed: $BUILD_OUT6"

######################################################
echo "Building armv7..."
EXTRA_CFLAGS="-arch armv7"
EXTRA_LDFLAGS="-L${SDKPATH}/usr/lib/system -arch armv7"
mkdir -p ${BUILD_OUT7}
./configure $FLAGS --prefix=$BUILD_OUT7 --extra-cflags="$EXTRA_CFLAGS" --extra-ldflags="$EXTRA_LDFLAGS" | tee $BUILD_OUT7/configuration.txt
make clean
make -j4 || exit 1
make install || exit 1
echo "Installed: $BUILD_OUT7"

######################################################
echo "Building armv7s..."
EXTRA_CFLAGS="-arch armv7s"
EXTRA_LDFLAGS="-L${SDKPATH}/usr/lib/system -arch armv7s"
mkdir -p ${BUILD_OUT7s}
./configure $FLAGS --prefix=$BUILD_OUT7s --extra-cflags="$EXTRA_CFLAGS" --extra-ldflags="$EXTRA_LDFLAGS" | tee $BUILD_OUT7s/configuration.txt
make clean
make -j4 || exit 1
make install || exit 1
echo "Installed: $BUILD_OUT7s"

######################################################
echo "Combining Libraries"
ARCHS="armv7 armv7s" #"armv6 armv7"
BUILD_LIBS="libx264.a"

cd $BUILD_OUT
rm -Rf $DIST_DIR
mkdir -p $DIST_DIR/lib
mkdir -p $DIST_DIR/include

for LIB in $BUILD_LIBS; do
  LIPO_CREATE=""
  for ARCH in $ARCHS; do
    LIPO_CREATE="$LIPO_CREATE-arch $ARCH $ARCH/lib/$LIB "
  done
  OUTPUT="$DIST_DIR/lib/$LIB"
  echo "Creating: $OUTPUT"
  lipo -create $LIPO_CREATE -output $OUTPUT
  lipo -info $OUTPUT
done

cp -Rf $ARCH/include/ $DIST_DIR/include/

