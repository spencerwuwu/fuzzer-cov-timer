#!/bin/bash
. $(dirname $0)/../common.sh

build_lib() {
  get_git_tag https://github.com/openssl/openssl.git OpenSSL_1_0_2d SRC
  rm -rf BUILD
  cp -rf SRC BUILD
  (cd BUILD && CC="$CC $CFLAGS" ./config && make clean && make -j $JOBS)
}


build_lib
build_afl
$CC $CFLAGS target.cc -c
$CXX $LIBFUZZER_SRC/afl/afl_driver.cpp target.o afl-llvm-rt.o.o BUILD/libcrypto.a BUILD/libssl.a -lgcrypt -I BUILD/include -o afl-fuzz.out --coverage
rm *.o

rm -rf IN OUT; mkdir IN OUT; echo z > IN/z;
#afl-fuzz -i IN -o OUT ./afl-fuzz.out
