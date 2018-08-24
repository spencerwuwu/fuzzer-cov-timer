#!/bin/bash
# Copyright 2016 Google Inc. All Rights Reserved.
# Licensed under the Apache License, Version 2.0 (the "License");
. $(dirname $0)/../common_coverage.sh

set -x
build_afl
$CC $CFLAGS -ldl -pthread  -c sqlite3.c
$CC $CFLAGS -c ossfuzz.c

$CXX $LIBFUZZER_SRC/afl/afl_driver.cpp afl-llvm-rt.o.o -ldl -pthread sqlite3.o ossfuzz.o -fprofile-instr-generate -fcoverage-mapping -o my_coverage
