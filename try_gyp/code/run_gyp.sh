#!/bin/bash

# platform depent
#gyp top_ws.gyp --generator-output=../build --depth=. -f xcode

# android
ANDROID_BUILD_TOP=`pwd` gyp top_ws.gyp --depth=. -DOS=android -f android-make


# generate iOS proj



#gyp top.gyp --depth=. -f xcode -DOS=iOS --generator-output=./build