#!/bin/bash

F="run"

RUN_DIR=`pwd`

. ./configure-ios-env.sh
cd $RUN_DIR
. ./build_x264.sh
cd $RUN_DIR
. ./build_ffmpeg.sh
