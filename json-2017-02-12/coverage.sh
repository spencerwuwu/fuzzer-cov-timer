#!/bin/bash
# Copyright 2017 Google Inc. All Rights Reserved.
# Licensed under the Apache License, Version 2.0 (the "License");

build_cov() {
  #rm -rf COV
  #cp -rf SRC COV
  (cd COV && make)
}

export CC="clang"
export CXX="clang++"
export CFLAGS=${CFLAGS:-"-g -fprofile-instr-generate -fcoverage-mapping"}
export CXXFLAGS=${CXXFLAGS:-"-g -fprofile-instr-generate -fcoverage-mapping"}

get_git_revision https://github.com/nlohmann/json.git b04543ecc58188a593f8729db38c2c87abd90dc3 SRC
build_cov

$CXX $CXXFLAGS -std=c++11 COV/test/src/fuzzer-driver_afl.cpp -I COV/src COV/test/src/fuzzer-parse_json.cpp -fprofile-instr-generate -fcoverage-mapping -o my_coverage 
