#!/bin/bash
# build on login node for A100 and A30

cd /cosma5/data/do009/dc-nobl3/babelstream-benchmark/BabelStream
module load nvhpc/25.11
mkdir -p build-cuda-sm80 && cd build-cuda-sm80
cmake .. -DMODEL=cuda \
         -DCMAKE_CUDA_COMPILER=$(which nvcc) \
         -DCUDA_ARCH=sm_80
make -j