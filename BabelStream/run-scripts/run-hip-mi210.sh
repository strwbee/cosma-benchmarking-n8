#!/bin/bash
#SBATCH --job-name=babelstream-mi210
#SBATCH --partition=cosma8-shm2
#SBATCH --account=do009
#SBATCH --nodelist=ga005
#SBATCH --nodes=1
#SBATCH --time=00:05:00
#SBATCH --mem=32G
#SBATCH --output=gpu-results/babelstream-mi210-%j.out
#SBATCH --error=gpu-results/babelstream-mi210-%j.err

export PATH=/opt/rocm-6.3.0/bin:$PATH

echo "Running on: $(hostname)"
rocminfo

/cosma5/data/do009/dc-nobl3/babelstream-benchmark/BabelStream/build-hip-mi210/hip-stream --arraysize 134217728 --numtimes 100
