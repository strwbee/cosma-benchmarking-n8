#!/bin/bash
#SBATCH --job-name=build_hip
#SBATCH --partition=cosma8-shm2
#SBATCH --account=do009
#SBATCH --nodes=1
#SBATCH --time=00:15:00
#SBATCH --output=build-hip-%j.out
#SBATCH --error=build-hip-%j.err

export PATH=/opt/rocm-6.3.0/bin:$PATH

cd /cosma5/data/do009/dc-nobl3/babelstream-benchmark/BabelStream

mkdir -p build-hip-mi100 && cd build-hip-mi100
cmake .. -DMODEL=hip -DCMAKE_CXX_COMPILER=/opt/rocm-6.3.0/bin/hipcc -DCMAKE_HIP_ARCHITECTURES="gfx908;gfx90a" 2>&1
make -j 2>&1
