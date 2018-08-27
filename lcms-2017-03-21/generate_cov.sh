#!/bin/bash

rm -rf cov.profdata cov.profraw
./run_cov.py
llvm-profdata merge cov.profraw -o cov.profdata
llvm-cov report ./my_coverage -instr-profile=cov.profdata
