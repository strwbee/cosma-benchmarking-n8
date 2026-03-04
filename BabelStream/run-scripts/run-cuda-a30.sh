#!/bin/bash
#SBATCH --job-name=babelstream-a30
#SBATCH --partition=dine2
#SBATCH --account=do015
#SBATCH --nodes=1
#SBATCH --time=00:05:00
#SBATCH --output=/dine/data/do009/dc-nobl3/babelstream/a30-%j.out
#SBATCH --error=/dine/data/do009/dc-nobl3/babelstream/a30-%j.err

echo "Running on: $(hostname)"
nvidia-smi

/dine/data/do009/dc-nobl3/babelstream/cuda-stream --arraysize 134217728 --numtimes 100 
