#!/bin/bash
#SBATCH --job-name=babelstream-a100
#SBATCH --partition=cosma8-shm
#SBATCH --account=do009
#SBATCH --nodes=1
#SBATCH --time=00:05:00
#SBATCH --output=gpu-results/babelstream-a100-%j.out
#SBATCH --error=gpu-results/babelstream-a100-%j.err

module load nvhpc/25.11

echo "Running on: $(hostname)"
nvidia-smi

/cosma5/data/do009/dc-nobl3/babelstream-benchmark/BabelStream/build-cuda-sm80/cuda-stream --arraysize 134217728 --numtimes 100
