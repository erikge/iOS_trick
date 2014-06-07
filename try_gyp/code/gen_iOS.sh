#!/bin/bash

gyp iOS_app/iOS_app.gyp --generator-output=../build --depth=. -Dlibrary=static_library -DOS=iOS -f xcode

