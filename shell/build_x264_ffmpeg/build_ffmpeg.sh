#!/bin/bash

#gcc 4.6
#ndk 14
pushd `dirname $0`
VERSION=$1

export  SRC_DIR=`pwd`/../ffmpeg-x264/ffmpeg_src
export  BUILD_OUT=`pwd`/build/ffmpeg/
export  x264_DIR=`pwd`/dist/x264/
export  DIST_DIR=`pwd`/dist/ffmpeg/

export  BUILD_OUT_6=${BUILD_OUT}/armv6/
export  BUILD_OUT_7=${BUILD_OUT}/armv7/
export  BUILD_OUT_7s=${BUILD_OUT}/armv7s/

cd $SRC_DIR
rm -Rf $BUILD_OUT
mkdir -p $BUILD_OUT

#platform
FLAGS="--sysroot=${SDKPATH} --target-os=darwin --enable-pic --enable-static --disable-asm --disable-symver "
EXTRA_CFLAGS=""
EXTRA_LDFLAGS="-L${SDKPATH}/usr/lib/system"

#for disable lib
FLAGS="$FLAGS --enable-cross-compile --disable-everything --disable-ffmpeg --disable-ffprobe "
#FLAGS="$FLAGS  --disable-avdevice --disable-avfilter --disable-postproc"

#for lib optimize 
FLAGS="$FLAGS --enable-small --enable-zlib "
FLAGS="$FLAGS --enable-gpl "

#for cpu type
FALGS="$FLAGS --enable-runtime-cpudetect --enable-asm "

#for ffmpeg decodec type
#FLAGS="$FLAGS --enable-decoder=h263  --enable-encoder=h263"
FLAGS="$FLAGS --enable-decoder=h264  --enable-parser=h264"

#For libx264
FLAGS="$FLAGS --enable-libx264 --enable-encoder=libx264 "

FLAGS="$FLAGS --cpu=cortex-a8  --arch=armv7s-a "
EXTRA_CFLAGS="$EXTRA_CFLAGS -I${x264_DIR}/include"
EXTRA_LDFLAGS="$EXTRA_LDFLAGS -L${x264_DIR}/lib"

######################################################
echo "Building armv7..."
EXTRA_CFLAGS_7="$EXTRA_CFLAGS -arch armv7"
EXTRA_LDFLAGS_7="$EXTRA_LDFLAGS -arch armv7"
mkdir -p ${BUILD_OUT_7}
./configure $FLAGS --prefix=$BUILD_OUT_7 --extra-cflags="$EXTRA_CFLAGS_7" --extra-ldflags="$EXTRA_LDFLAGS_7" | tee $BUILD_OUT_7/configuration.txt

make clean
make  -j4 || exit 1
make install || exit 1
echo "Installed: $BUILD_OUT_7"

######################################################
echo "Building armv7s..."
EXTRA_CFLAGS_7s="$EXTRA_CFLAGS -arch armv7s"
EXTRA_LDFLAGS_7s="$EXTRA_LDFLAGS -arch armv7s"
mkdir -p ${BUILD_OUT_7s}
./configure $FLAGS --prefix=$BUILD_OUT_7s --extra-cflags="$EXTRA_CFLAGS_7s" --extra-ldflags="$EXTRA_LDFLAGS_7s" | tee $BUILD_OUT_7s/configuration.txt

make clean
make  -j4 || exit 1
make install || exit 1
echo "Installed: $BUILD_OUT_7s"

######################################################
echo "Combining Libraries"
ARCHS="armv7 armv7s" #"armv6 armv7"
BUILD_LIBS="libavcodec.a libavdevice.a libavfilter.a libavformat.a libavutil.a libpostproc.a libswresample.a libswscale.a"

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

popd; popd
