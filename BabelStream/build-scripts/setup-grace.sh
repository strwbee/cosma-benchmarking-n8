#!/bin/bash
#SBATCH --job-name=setup-grace
#SBATCH --partition=gracehopper
#SBATCH --account=do016
#SBATCH --nodes=1
#SBATCH --time=00:10:00
#SBATCH --output=setup-grace-%j.out
#SBATCH --error=setup-grace-%j.err

which python3
python3 --version
which pip3

pip3 install --user cmake

export PATH=$HOME/.local/bin:$PATH
which cmake
cmake --version
