#!/bin/bash
# must run on MI300X node: srun -p mi300x -A do018 -t 30 --pty /bin/bash

cd /cosma5/data/do009/dc-nobl3/babelstream-benchmark/BabelStream
mkdir -p build-hip-mi300x && cd build-hip-mi300x
cmake .. -DMODEL=hip \
         -DCMAKE_CXX_COMPILER=/opt/rocm-7.2.0/bin/hipcc \
         -DCMAKE_HIP_ARCHITECTURES=gfx942
make -j
