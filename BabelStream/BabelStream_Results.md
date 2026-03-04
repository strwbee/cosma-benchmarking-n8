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
| V100 | gn001 | 900 GB/s | 823 GB/s | 91.4% | ✓ |
| A30 | gc001-008 | 933 GB/s | 822 GB/s | 88.1% | ✓ |
| A100 | mad04/05 | 1555 GB/s | 1352 GB/s | 86.9% | ✓ |
| H100 NVL | gn004 | 3938 GB/s | 3387 GB/s | 86.0% | ✓ |
| GH200 | gn003 | 4000 GB/s | 3500 GB/s | 87.5% | ✓ |
| MI100 | ga004 | 1200 GB/s | 947 GB/s | 78.9% | ✓ |
| MI210 | ga005/06 | 1600 GB/s | 1250 GB/s | 78.1% | ✓ |
| MI300A | ga008 | 5300 GB/s | 3648 GB/s | 68.8% | ✓ |
| MI300X | ga007 | 5300 GB/s | 4036 GB/s | 76.2% | ✓ |

**Notes:**

- Use `module load nvhpc/25.11` for CUDA on login (or `nvhpc/24.5` for V100 sm_70).
- ROCm not on login: cannot build HIP code from login, must allocate compute node.
- ROCm 7.2.0 on MI300X (ga007), not 6.3.0.
- dine2 nodes mount `/dine` not `/cosma5`: 
- MI300A (ga008) doesn't mount `/cosma5`: copy binary to home directory (cp build-hip-mi300x/hip-stream ~)

## Build Instructions

### CUDA (A100, A30; x86 host, sm_80)
Build on login node:
```bash
cd /cosma5/data/do009/dc-nobl3/babelstream-benchmark
git clone https://github.com/UoB-HPC/BabelStream.git
cd BabelStream

module load nvhpc/25.11
...
cmake .. -DMODEL=cuda \
         -DCMAKE_CUDA_COMPILER=$(which nvcc) \
         -DCUDA_ARCH=sm_80
make -j
```

### CUDA (Grace-Hopper; sm_90)
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

### CUDA (H100 NVL; x86 host, sm_90)
Build on login node:
```bash
cd /cosma5/data/do009/dc-nobl3/babelstream-benchmark/BabelStream
module load nvhpc/25.11
mkdir build-cuda-sm90-x86 && cd build-cuda-sm90-x86
cmake .. -DMODEL=cuda \
         -DCMAKE_CUDA_COMPILER=$(which nvcc) \
         -DCUDA_ARCH=sm_90
make -j
```

### HIP (MI100; gfx908)
Must build on compute node:
```bash
srun -p cosma8-shm2 -A do018 --nodelist=ga004 -t 30 --pty /bin/bash

mkdir build-hip-gfx908 && cd build-hip-gfx908
cmake .. -DMODEL=hip \
         -DCMAKE_CXX_COMPILER=/opt/rocm-6.3.0/bin/hipcc \
         -DCMAKE_HIP_ARCHITECTURES=gfx908
make -j
```

### HIP (MI210; gfx90a)
Must build on compute node:
```bash
srun -p cosma8-shm2 -A do018 --exclude=ga004 -t 30 --pty /bin/bash

mkdir build-hip-gfx90a && cd build-hip-gfx90a
cmake .. -DMODEL=hip \
         -DCMAKE_CXX_COMPILER=/opt/rocm-6.3.0/bin/hipcc \
         -DCMAKE_HIP_ARCHITECTURES=gfx90a
make -j
```

### HIP (MI300X, MI300A; gfx942)
Must build on compute node:
```bash
# for MI300X with Slurm 
srun -p mi300x -A do018 -t 30 --pty /bin/bash
mkdir build-hip-mi300x-mi300a && cd build-hip-mi300x-mi300a
cmake .. -DMODEL=hip \
         -DCMAKE_CXX_COMPILER=/opt/rocm-7.2.0/bin/hipcc \
         -DCMAKE_HIP_ARCHITECTURES=gfx942
make -j

# for MI300A: copy binary to home, then ssh ga008 and run from ~
```

## Run Commands

```bash
# CUDA
./cuda-stream --arraysize 134217728 --numtimes 100

# HIP
./hip-stream --arraysize 134217728 --numtimes 100
```

## Example Slurm Scripts

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

### A30 (dine2)
Note: dine2 nodes mount `/dine` not `/cosma5`.
```bash
#!/bin/bash
#SBATCH --job-name=babelstream-a30
#SBATCH --partition=dine2
#SBATCH --account=do015
#SBATCH --time=00:10:00
#SBATCH --output=babel-a30-%j.out
#SBATCH --error=babel-a30-%j.err

nvidia-smi

# replace with your working directory here, ensure /dine not /cosma5
/dine/data/do009/dc-nobl3/babelstream/cuda-stream --arraysize 134217728 --numtimes 100
```
