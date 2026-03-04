#!/bin/bash
#SBATCH --job-name=babelstream-mi300x
#SBATCH --partition=mi300x
#SBATCH --account=do018
#SBATCH --nodes=1
#SBATCH --time=00:05:00
#SBATCH --output=gpu-results/babelstream-mi300x-%j.out
#SBATCH --error=gpu-results/babelstream-mi300x-%j.err

export PATH=/opt/rocm-7.2.0/bin:$PATH

echo "Running on: $(hostname)"
rocminfo | grep "Marketing Name"

/cosma5/data/do009/dc-nobl3/babelstream-benchmark/BabelStream/build-hip-mi300x/hip-stream --arraysize 134217728 --numtimes 100
