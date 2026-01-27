#!/bin/bash
#SBATCH --job-name=babelstream-a30
#SBATCH --partition=dine2
#SBATCH --account=do015
#SBATCH --nodes=1
#SBATCH --time=00:05:00
#SBATCH --output=gpu-results/babelstream-a30-%j.out
#SBATCH --error=gpu-results/babelstream-a30-%j.err

module load nvhpc/25.11

echo "Running on: $(hostname)"
nvidia-smi

/cosma5/data/do009/dc-nobl3/babelstream-benchmark/BabelStream/build-cuda-sm80/cuda-stream --arraysize 134217728 --numtimes 100
