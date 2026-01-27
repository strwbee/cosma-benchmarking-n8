#!/bin/bash
#SBATCH --job-name=babelstream-grace
#SBATCH --partition=gracehopper
#SBATCH --account=do016
#SBATCH --nodes=1
#SBATCH --time=00:05:00
#SBATCH --output=gpu-results/babelstream-grace-%j.out
#SBATCH --error=gpu-results/babelstream-grace-%j.err

export PATH=/usr/local/cuda-13.0/bin:$PATH

echo "Running on: $(hostname)"
nvidia-smi

/cosma5/data/do009/dc-nobl3/babelstream-benchmark/BabelStream/build-cuda-grace/cuda-stream --arraysize 134217728 --numtimes 100
