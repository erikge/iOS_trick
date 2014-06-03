#!/bin/bash

# generate iOS proj
gyp top_ws.gyp --depth=. -f xcode --generator-output=../build


#gyp top.gyp --depth=. -f xcode -DOS=iOS --generator-output=./build