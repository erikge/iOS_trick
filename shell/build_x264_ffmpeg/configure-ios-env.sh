#!/bin/bash

F="configure-ios-env"

if test "$*" = "--help" -o "$*" = "-h"; then
  echo "$F [OPTIONS]"
  echo ""
  echo "where:"
  echo "  OPTIONS    Other options that will be passed directly to"
  echo "             ./aconfigure script. Run ./aconfigure --help"
  echo "             for more info."
  echo ""
  echo "Environment variables:"
  echo "  IPHONESDK  Optionally specify which SDK to use. Value is the full "
  echo "             path of the SDK. By default, the latest SDK installed"
  echo "             will be used."
  echo "  CC         Optionally specify the path of the ARM cross compiler"
  echo "             to use. By default, the compiler is deduced from the"
  echo "             SDK."
  echo "  ARCH       Optional flags to specify target architecture, e.g."
  echo "             ARCH='-arch armv6'. Default is armv7."
  echo ""
  exit 0
fi

# DEVPATH ===================================================
# Set the main iPhone developer directory, if not set
if test "x${DEVPATH}" = "x"; then
  DEVPATH=/Applications/XCode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer
  if test  ! -d $DEVPATH; then
    DEVPATH=/Developer/Platforms/iPhoneOS.platform/Developer
  fi
  echo "$F: DEVPATH is not specified, using ${DEVPATH}"
fi
# Make sure $DEVPATH directory exist
if test ! -d $DEVPATH; then
  echo "$F error: directory $DEVPATH does not exist. Please install iPhone development kit"
  exit 1
fi

# SDKPATH ===================================================
# Choose SDK version to use
if test "$IPHONESDK" = ""; then
  # If IPHONESDK is not set, use the latest one
  for f in `ls $DEVPATH/SDKs/`; do echo $f | sed 's/\(.sdk\)//'; done | sort | tail -1 > tmpsdkname
  IPHONESDK=`cat tmpsdkname`.sdk
  rm -f tmpsdkname
  SDKPATH=${DEVPATH}/SDKs/${IPHONESDK}
  echo "$F: IPHONESDK is not specified, choosing ${IPHONESDK}"
elif test -d ${IPHONESDK}; then
  # .. else if IPHONESDK is set and it points to a valid path, just use it
  SDKPATH=${IPHONESDK}
else
  # .. else assume the SDK name is used.
  SDKPATH=${DEVPATH}/SDKs/${IPHONESDK}
fi
# Test the SDK directory
if test ! -d ${SDKPATH}/usr/include; then
  echo "$F error: unable to find valid iPhone SDK in ${SDKPATH}"
  exit 1
fi

# CFLAGS ===================================================
# Default CFLAGS if it's not specified
# CFLAGS="-O2 -Wno-unused-label"
if test "$CFLAGS" = ""; then
  CFLAGS="-Wno-unused-label"
fi

# LDFLAGS ===================================================
# Default LDFLAGS if it's not specified
# LDFLAGS="-O2"
if test "$LDFLAGS" = ""; then
  LDFLAGS=""
fi

# TCPATH ===================================================
# Test the toolchain directory
TCPATH="${DEVPATH}/../../../Toolchains/XcodeDefault.xctoolchain"
if test ! -d ${TCPATH}/usr/bin; then
  TCPATH="${DEVPATH}"
fi

# CC ===================================================
# Determine which gcc for this SDK. Binaries should have the
# full path as it's not normally in user's PATH
if test "${CC}" = ""; then
  # Try to use clang if available
  ccpath="${TCPATH}/usr/bin/clang"
  # Next, try to use llvm-gcc
  gccpath="${DEVPATH}/usr/bin/llvm-gcc"
  if test -e ${ccpath}; then
    export CC="${ccpath}" 
  elif test -e ${gccpath}; then
    export CC="${gccpath}"
  else
    for archpath in `ls -d ${SDKPATH}/usr/lib/gcc/arm-apple-darwin*`; do
       archname=`basename ${archpath}`
       for gccver in `ls ${archpath}`; do
          gccpath="${DEVPATH}/usr/bin/${archname}-gcc-${gccver}"
          if test -e ${gccpath}; then
            export CC="${gccpath}"
          fi
       done
    done
  fi
  if test ! "${CC}" = ""; then
    echo "$F: CC is not specified, choosing ${CC}"
  fi
fi
if test "${CC}" = ""; then
    echo "$F error: unable to find gcc for ${IPHONESDK}. If you think you have the right gcc, set the full path in CC environment variable."
    exit 1
fi

# ARCH ===================================================
#if test "${ARCH}" = ""; then
#  export ARCH="-arch armv7"
#  echo "$F: ARCH is not specified, choosing ${ARCH}"
#fi

# CXX ===================================================
# Set CXX if not set
if test "${CXX}" = ""; then
  export CXX=`echo ${CC} | sed 's/gcc/g++/'`
  echo "$F: CXX is not specified, using ${CXX}"
fi

# Other settings to feed to configure script. 
#ARCH="-arch armv6"
export CFLAGS="${CFLAGS} -DPJ_CONFIG_IPHONE=1 -DPJ_SDK_NAME=\"\\\"`basename $SDKPATH`\\\"\" ${ARCH} -isysroot ${SDKPATH} -ggdb" 
export LDFLAGS="${LDFLAGS} ${ARCH} -isysroot ${SDKPATH} -framework AudioToolbox -framework Foundation"
export AR="${TCPATH}/usr/bin/libtool -static -o "
export AR_FLAGS=" "
export RANLIB="echo ranlib"
# Use gcc -E as preprocessor instead of cpp, since cpp will find the
# header files in standard /usr/include instead of in isysroot
export CPP="${CC} ${ARCH} -E -isysroot ${SDKPATH}"

# Print settings
if test "1" = "1"; then
  echo "$F: calling ./aconfigure with env vars:"
  echo " CC = ${CC}"
  echo " CXX = ${CXX}"
  echo " SDKPATH = ${SDKPATH}"
  echo " CFLAGS = ${CFLAGS} "
  echo " LDFLAGS = ${LDFLAGS}"
  echo " AR = ${AR}"
  echo " RANLIB = ${RANLIB}"
fi

# And finally invoke the configure script itself
#./aconfigure --host=arm-apple-darwin9 --disable-sdl $*

if test "$?" = "0"; then
  echo "Done configuring for `basename $SDKPATH`"
  echo ""
fi
