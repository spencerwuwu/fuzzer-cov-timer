#!/usr/bin/python
import os

input_path = "OUT/queue"

files = os.listdir(input_path)

for the_file in files:
    if "stat" in the_file:
        continue
    cmd = "LLVM_PROFILE_FILE=\"cov.profraw\" ./my_coverage < " + input_path + "/" + the_file
    print cmd
    os.system(cmd)

