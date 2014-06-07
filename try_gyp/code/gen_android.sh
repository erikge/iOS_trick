#!/bin/bash

# android
ANDROID_BUILD_TOP=`pwd` gyp android_app/android_app.gyp --depth=. -Dlibrary=static_library -DOS=android -f android-make


