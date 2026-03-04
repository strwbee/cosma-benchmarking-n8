#!/bin/bash
# build on login node for V100

cd /cosma5/data/do009/dc-nobl3/babelstream-benchmark/BabelStream
module load nvhpc/24.5
mkdir -p build-cuda-sm70 && cd build-cuda-sm70
cmake .. -DMODEL=cuda \
         -DCMAKE_CUDA_COMPILER=$(which nvcc) \
         -DCUDA_ARCH=sm_70
make -j