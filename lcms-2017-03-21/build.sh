#!/bin/bash
# Copyright 2017 Google Inc. All Rights Reserved.
# Licensed under the Apache License, Version 2.0 (the "License");
. $(dirname $0)/../common_build.sh

build_lib() {
  rm -rf BUILD
  cp -rf SRC BUILD
  (cd BUILD && ./autogen.sh && ./configure && make -j $JOBS)
}

get_git_revision https://github.com/mm2/Little-CMS.git f9d75ccef0b54c9f4167d95088d4727985133c52 SRC
build_lib
build_afl

set -x
$CXX $CXXFLAGS $LIBFUZZER_SRC/afl/afl_driver.cpp afl-llvm-rt.o.o cms_transform_fuzzer.cc -I BUILD/include/ BUILD/src/.libs/liblcms2.a -o afl-fuzz.out

rm -rf IN OUT; mkdir IN OUT; echo z > IN/z;
afl-fuzz -i IN -o OUT ./afl-fuzz.out
