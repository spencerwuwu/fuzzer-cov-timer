#!/bin/bash

get_git_revision() {
  GIT_REPO="$1"
  GIT_REVISION="$2"
  TO_DIR="$3"
  [ ! -e $TO_DIR ] && git clone $GIT_REPO $TO_DIR && (cd $TO_DIR && git reset --hard $GIT_REVISION)
}

get_git_tag() {
  GIT_REPO="$1"
  GIT_TAG="$2"
  TO_DIR="$3"
  [ ! -e $TO_DIR ] && git clone $GIT_REPO $TO_DIR && (cd $TO_DIR && git checkout $GIT_TAG)
}

get_svn_revision() {
  SVN_REPO="$1"
  SVN_REVISION="$2"
  TO_DIR="$3"
  [ ! -e $TO_DIR ] && svn co -r$SVN_REVISION $SVN_REPO $TO_DIR
}

build_afl() {
  $CC -c -w $AFL_SRC/llvm_mode/afl-llvm-rt.o.c
}

export CC="clang"
export CXX="clang++"
export CFLAGS=${CFLAGS:-"-g -fprofile-instr-generate -fcoverage-mapping"}
export CXXFLAGS=${CXXFLAGS:-"-g -fprofile-instr-generate -fcoverage-mapping"}
export AFL_SRC="/root/afl"
export LIBFUZZER_SRC="/root/Fuzzer"

