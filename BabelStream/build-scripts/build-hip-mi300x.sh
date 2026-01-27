#!/bin/bash
#SBATCH --job-name=build-mi300x
#SBATCH --partition=mi300x
#SBATCH --account=do018
#SBATCH --nodes=1
#SBATCH --time=00:10:00
#SBATCH --output=build-mi300x-%j.out
#SBATCH --error=build-mi300x-%j.err

export PATH=/opt/rocm-6.3.0/bin:$PATH

cd /cosma5/data/do009/dc-nobl3/babelstream-benchmark/BabelStream

rm -rf build-hip-mi300x
mkdir build-hip-mi300x && cd build-hip-mi300x
cmake .. -DMODEL=hip -DCMAKE_CXX_COMPILER=/opt/rocm-6.3.0/bin/hipcc -DCMAKE_HIP_ARCHITECTURES=gfx942
make -j
