#!/usr/bin/python
import os

input_path = "OUT/queue"

files = os.listdir(input_path)

for the_file in files:
    if "stat" in the_file:
        continue
    os.system("cat " + input_path + "/" + the_file + " | LLVM_PROFILE_FILE=\"cov.profraw\" ./my_coverage")

