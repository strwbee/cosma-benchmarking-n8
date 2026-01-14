# BabelStream Benchmark
Measures memory bandwidth across GPUs.

## Set Up
BabelStream v5.0: https://github.com/UoB-HPC/BabelStream

Parameters:
- **Array size:** 134,217,728 (2²⁷) elements (~1GB per array, ~3GB total). (Array size must be a multiple of 1024)
- **Iterations:** 100
- **Precision:** double
- **Metric:** Triad kernel bandwidth (GB/s)

## Results Summary

| GPU | Node | Theoretical BW | Measured BW | Efficiency | Status |
|-----|------|----------------|-------------|------------|--------|
| A100 | mad04/05 | 1555 GB/s | 1352 GB/s | 86.9% | ✓ |
| MI100 | ga004 | 1200 GB/s | 947 GB/s | 78.9% | ✓ |
| MI210 | ga005/06 | 1600 GB/s | 1250 GB/s | 78.1% | ✓ |
| GH200 | gn003 | 4000 GB/s | 3500 GB/s | 87.5% | ✓ |
| A30 | gc001-008 | 933 GB/s | - | - | TODO |
| V100 | gn001 | 900 GB/s | - | - | TODO |
| H100 PCIe | gn004 | 2000 GB/s | - | - | TODO |
| MI300X | ga007 | 5300 GB/s | - | - | TODO |
| MI300A | ga008 | 5300 GB/s | - | - | TODO |

**Notes:**
- MI300X was originally pending for a long time over winter. Need to be check if finished.
- A30 on dine2 originally failed with exit code 53. Need to check if resolved.
- MI300X and H100 originally marked Down. Need to check if resolved.
- No cmake on Grace-Hopper: `pip3 install --user cmake` then add `$HOME/.local/bin` to PATH
- ROCm not on login: cannot build HIP code from login, must allocate compute node.

## Build Instructions

### CUDA (x86 host, sm_80 - A100, A30)

Build on login node:
```bash
cd /cosma5/data/do009/dc-nobl3/babelstream-benchmark
git clone https://github.com/UoB-HPC/BabelStream.git
cd BabelStream

export PATH=/usr/local/cuda-12.6/bin:$PATH

mkdir build-cuda-sm80 && cd build-cuda-sm80
cmake .. -DMODEL=cuda \
         -DCMAKE_CUDA_COMPILER=/usr/local/cuda-12.6/bin/nvcc \
         -DCUDA_ARCH=sm_80
make -j
```

### CUDA (Grace-Hopper, sm_90)

Must build on compute node (ARM host):
```bash
srun -p gracehopper -A do016 -t 30 --pty /bin/bash

# install cmake
pip3 install --user cmake
export PATH=$HOME/.local/bin:$PATH

export PATH=/usr/local/cuda-13.0/bin:$PATH

mkdir build-cuda-sm90 && cd build-cuda-sm90
cmake .. -DMODEL=cuda \
         -DCMAKE_CUDA_COMPILER=/usr/local/cuda-13.0/bin/nvcc \
         -DCUDA_ARCH=sm_90
make -j
```

### HIP (MI100, gfx908)

Must build on compute node:
```bash
srun -p cosma8-shm2 -A do018 --nodelist=ga004 -t 30 --pty /bin/bash

mkdir build-hip-gfx908 && cd build-hip-gfx908
cmake .. -DMODEL=hip \
         -DCMAKE_CXX_COMPILER=/opt/rocm-6.3.0/bin/hipcc \
         -DCMAKE_HIP_ARCHITECTURES=gfx908
make -j
```

### HIP (MI210, gfx90a)

Must build on compute node:
```bash
srun -p cosma8-shm2 -A do018 --exclude=ga004 -t 30 --pty /bin/bash

mkdir build-hip-gfx90a && cd build-hip-gfx90a
cmake .. -DMODEL=hip \
         -DCMAKE_CXX_COMPILER=/opt/rocm-6.3.0/bin/hipcc \
         -DCMAKE_HIP_ARCHITECTURES=gfx90a
make -j
```

### HIP (MI300X/MI300A, gfx942)

Must build on compute node:
```bash
# for MI300X with Slurm 
srun -p mi300x -A do018 -t 30 --pty /bin/bash

# for MI300A with direct SSH
ssh ga008

mkdir build-hip-gfx942 && cd build-hip-gfx942
cmake .. -DMODEL=hip \
         -DCMAKE_CXX_COMPILER=/opt/rocm-6.3.0/bin/hipcc \
         -DCMAKE_HIP_ARCHITECTURES=gfx942
make -j
```

## Run Commands

```bash
# CUDA
./cuda-stream --arraysize 134217728 --numtimes 100

# HIP
./hip-stream --arraysize 134217728 --numtimes 100
```

## Example Slurm Script

### A100 (cosma8-shm)
```bash
#!/bin/bash
#SBATCH --job-name=babelstream-a100
#SBATCH --partition=cosma8-shm
#SBATCH --account=do016
#SBATCH --time=00:10:00
#SBATCH --constraint=gpu
#SBATCH --output=babel-a100-%j.out
#SBATCH --error=babel-a100-%j.err

nvidia-smi  # verify GPU present

# replace with your working directory here
cd /cosma5/data/do009/dc-nobl3/babelstream-benchmark/BabelStream/build-cuda-sm80
./cuda-stream --arraysize 134217728 --numtimes 100
```
