#!/bin/bash
#SBATCH --job-name=babelstream-hip
#SBATCH --partition=cosma8-shm2
#SBATCH --account=do009
#SBATCH --nodes=1
#SBATCH --time=00:05:00
#SBATCH --output=gpu-results/babelstream-hip-%j.out
#SBATCH --error=gpu-results/babelstream-hip-%j.err

export PATH=/opt/rocm-6.3.0/bin:$PATH

echo "Running on: $(hostname)"
rocminfo

/cosma5/data/do009/dc-nobl3/babelstream-benchmark/BabelStream/build-hip-mi100/hip-stream --arraysize 134217728 --numtimes 100
