#!/bin/bash
#SBATCH --job-name=build-grace
#SBATCH --partition=gracehopper
#SBATCH --account=do016
#SBATCH --nodes=1
#SBATCH --time=00:15:00
#SBATCH --output=build-grace-%j.out
#SBATCH --error=build-grace-%j.err

export PATH=$HOME/.local/bin:$PATH
export PATH=/usr/local/cuda-13.0/bin:$PATH

cmake --version
nvcc --version

cd /cosma5/data/do009/dc-nobl3/babelstream-benchmark/BabelStream

rm -rf build-cuda-grace
mkdir build-cuda-grace && cd build-cuda-grace
cmake .. -DMODEL=cuda -DCMAKE_CUDA_COMPILER=/usr/local/cuda-13.0/bin/nvcc -DCUDA_ARCH=sm_90
make -j
