# Build Instructions for COSMA GPU Benchmarks
Build instructions for BabelStream and miniBUDE.

## Overview

| GPU | Node | Architecture | Compiler | Build Location |
|-----|------|--------------|----------|----------------|
| V100 | gn001 | sm_70 | CUDA (nvhpc/24.5) | Login node |
| A30 | gc001-008 | sm_80 | CUDA (nvhpc/25.11) | Login node |
| A100 | mad04/05 | sm_80 | CUDA (nvhpc/25.11) | Login node |
| H100 NVL | gn004 | sm_90 | CUDA (nvhpc/25.11) | Login node |
| GH200 | gn003 | sm_90 | CUDA 13.0 | Compute node (ARM) |
| MI100 | ga004 | gfx908 | ROCm 7.2.0 | Compute node |
| MI210 | ga005/06 | gfx90a | ROCm 7.2.0 | Compute node |
| MI300X | ga007 | gfx942 | ROCm 7.2.0 | Compute node |
| MI300A | ga008 | gfx942 | ROCm 7.2.0 | Compute node |

## CUDA Builds

### V100 (sm_70)

```bash
module load nvhpc/24.5
mkdir build-cuda-sm70 && cd build-cuda-sm70

# BabelStream
cmake .. -DMODEL=cuda -DCMAKE_CUDA_COMPILER=$(which nvcc) -DCUDA_ARCH=sm_70
make -j

# miniBUDE
cmake .. -DMODEL=cuda -DCMAKE_CUDA_COMPILER=$(which nvcc) -DCUDA_ARCH=sm_70 -DRELEASE_FLAGS="-O3"
make -j
```

### A100 (sm_80)

```bash
module load nvhpc/25.11
mkdir build-cuda-sm80 && cd build-cuda-sm80

# BabelStream
cmake .. -DMODEL=cuda -DCMAKE_CUDA_COMPILER=$(which nvcc) -DCUDA_ARCH=sm_80
make -j

# miniBUDE
cmake .. -DMODEL=cuda -DCMAKE_CUDA_COMPILER=$(which nvcc) -DCUDA_ARCH=sm_80 -DRELEASE_FLAGS="-O3"
make -j
```

### A30 (sm_80, dine2)

A30 uses the same architecture as A100. Build on login node, then copy to `/dine/`. Dine2 nodes don't mount `/cosma5`.

```bash
# build on login same as A100 above

# after, copy to /dine
mkdir -p /dine/data/do009/dc-nobl3/babelstream
cp cuda-stream /dine/data/do009/dc-nobl3/babelstream/

mkdir -p /dine/data/do009/dc-nobl3/minibude/build-cuda-sm80
cp cuda-bude /dine/data/do009/dc-nobl3/minibude/build-cuda-sm80/
cp -r ../data /dine/data/do009/dc-nobl3/minibude/
```
### H100 NVL (sm_90, x86)

```bash
module load nvhpc/25.11
mkdir build-cuda-sm90-x86 && cd build-cuda-sm90-x86

# BabelStream
cmake .. -DMODEL=cuda -DCMAKE_CUDA_COMPILER=$(which nvcc) -DCUDA_ARCH=sm_90
make -j

# miniBUDE
cmake .. -DMODEL=cuda -DCMAKE_CUDA_COMPILER=$(which nvcc) -DCUDA_ARCH=sm_90 -DRELEASE_FLAGS="-O3"
make -j
```

### GH200 (sm_90, ARM)

Must build on compute node (ARM host). Requires cmake installation first.

```bash
# setup once: install cmake
srun -p gracehopper -A do016 -t 10 --pty /bin/bash
pip3 install --user cmake
exit

# build
srun -p gracehopper -A do016 -t 30 --pty /bin/bash
export PATH=$HOME/.local/bin:$PATH
export PATH=$HOME:$PATH  # for git (copy from login if missing)
export PATH=/usr/local/cuda-13.0/bin:$PATH

mkdir build-cuda-grace && cd build-cuda-grace

# BabelStream
cmake .. -DMODEL=cuda -DCMAKE_CUDA_COMPILER=/usr/local/cuda-13.0/bin/nvcc -DCUDA_ARCH=sm_90
make -j

# miniBUDE
cmake .. -DMODEL=cuda -DCMAKE_CUDA_COMPILER=/usr/local/cuda-13.0/bin/nvcc -DCUDA_ARCH=sm_90 -DRELEASE_FLAGS="-O3"
make -j
```

**Note:** GH200 doesn't have git installed. Copy from login node first:
```bash
cp /usr/bin/git ~/git
```

## HIP Builds (AMD GPUs)

HIP builds must be done on compute nodes. ROCm is not available on login nodes.

### MI100 (gfx908)

```bash
srun -p cosma8-shm2 -A do018 --nodelist=ga004 --gres=gpu:1 -t 30 --pty /bin/bash
export PATH=/opt/rocm-7.2.0/bin:$PATH

mkdir build-hip-mi100 && cd build-hip-mi100

# BabelStream
cmake .. -DMODEL=hip -DCMAKE_CXX_COMPILER=/opt/rocm-7.2.0/bin/hipcc -DCMAKE_HIP_ARCHITECTURES=gfx908
make -j

# miniBUDE
cmake .. -DMODEL=hip -DCMAKE_CXX_COMPILER=/opt/rocm-7.2.0/bin/hipcc -DHIP_ARCH=gfx908 -DRELEASE_FLAGS="-O3"
make -j
```

### MI210 (gfx90a)

```bash
srun -p cosma8-shm2 -A do018 --exclude=ga004 --gres=gpu:1 -t 30 --pty /bin/bash
export PATH=/opt/rocm-7.2.0/bin:$PATH

mkdir build-hip-mi210 && cd build-hip-mi210

# BabelStream
cmake .. -DMODEL=hip -DCMAKE_CXX_COMPILER=/opt/rocm-7.2.0/bin/hipcc -DCMAKE_HIP_ARCHITECTURES=gfx90a
make -j

# miniBUDE
cmake .. -DMODEL=hip -DCMAKE_CXX_COMPILER=/opt/rocm-7.2.0/bin/hipcc -DHIP_ARCH=gfx90a -DRELEASE_FLAGS="-O3"
make -j
```

### MI300X (gfx942)

```bash
srun -p mi300x -A do018 --gres=gpu:1 -t 30 --pty /bin/bash
export PATH=/opt/rocm-7.2.0/bin:$PATH

mkdir build-hip-mi300x && cd build-hip-mi300x

# BabelStream
cmake .. -DMODEL=hip -DCMAKE_CXX_COMPILER=/opt/rocm-7.2.0/bin/hipcc -DCMAKE_HIP_ARCHITECTURES=gfx942
make -j

# miniBUDE
cmake .. -DMODEL=hip -DCMAKE_CXX_COMPILER=/opt/rocm-7.2.0/bin/hipcc -DHIP_ARCH=gfx942 -DRELEASE_FLAGS="-O3"
make -j
```

### MI300A (gfx942)

MI300A uses the same architecture as MI300X. Build on MI300X, then copy binary to home. MI300A doesn't mount `/cosma5`.

```bash
# after building on MI300X
cp build-hip-mi300x/hip-stream ~/
cp build-hip-mi300x/hip-bude ~/

# run on MI300A
ssh ga008
export PATH=/opt/rocm-7.2.0/bin:$PATH
~/hip-stream --arraysize 134217728 --numtimes 100
~/hip-bude --deck ~/minibude-data/bm2 -i 8 -p all
```

## Run Commands

### BabelStream
```bash
./cuda-stream --arraysize 134217728 --numtimes 100  # CUDA
./hip-stream --arraysize 134217728 --numtimes 100   # HIP
```

### miniBUDE
```bash
./cuda-bude --deck ../data/bm2 -i 8 -p all  # CUDA
./hip-bude --deck ../data/bm2 -i 8 -p all   # HIP
```
