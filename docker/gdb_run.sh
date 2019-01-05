#!/bin/bash
# reference:
#   https://stackoverflow.com/questions/35860527/warning-error-disabling-address-space-randomization-operation-not-permitted/46676907#46676907

docker run --rm -it -v ${PWD}:${PWD} -w ${PWD} \
  --cap-add=SYS_PTRACE \
  --security-opt seccomp=unconfined \
  gdb

