#!/bin/bash
#SBATCH --job-name=build-hip-mi210
#SBATCH --partition=cosma8-shm2
#SBATCH --account=do009
#SBATCH --nodelist=ga005
#SBATCH --nodes=1
#SBATCH --time=00:10:00
#SBATCH --output=build-hip-mi210-%j.out
#SBATCH --error=build-hip-mi210-%j.err

export PATH=/opt/rocm-6.3.0/bin:$PATH

cd /cosma5/data/do009/dc-nobl3/babelstream-benchmark/BabelStream

rm -rf build-hip-mi210
mkdir build-hip-mi210 && cd build-hip-mi210
cmake .. -DMODEL=hip -DCMAKE_CXX_COMPILER=/opt/rocm-6.3.0/bin/hipcc -DCMAKE_HIP_ARCHITECTURES=gfx90a
make -j
