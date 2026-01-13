# COSMA GPU Nodes
Last updated: 2025-01-13 (verification needed on COSMA)

## Summary

| GPU | Node(s) | Access Method | Partition | Account |
|-----|---------|---------------|-----------|---------|
| V100 (10x) | gn001 | Direct SSH | - | do016? |
| A30 (composable) | gc001-008 | Slurm | dine2 | do015 |
| A100 (composable) | mad04, mad05 | Slurm | cosma8-shm | do016 |
| A100 (composable) | mad06 | Direct SSH | - | do016 |
| GH200 | gn002 | Direct SSH | - | do016 |
| GH200 | gn003 | Slurm | gracehopper | do016 |
| H100 PCIe | gn004 | Direct SSH | - | do016 |
| MI100 | ga004 | Slurm | cosma8-shm2 | do018? |
| MI210 (2x) | ga005, ga006 | Slurm | cosma8-shm2 | do018? |
| MI300X (8x) | ga007 | Slurm | mi300x | do018 |
| MI300A (4x) | ga008 | Direct SSH | - | do018 |
| PVC (2x) | gi001 | - | - | do017 |

## GPU Specifications

| GPU | Architecture | FP64 TFLOPS | VRAM (GB) | Memory BW (GB/s) | Backend |
|-----|--------------|-------------|-----------|------------------|---------|
| V100 | Volta | 7.0 | 32 | 900 | CUDA |
| A30 | Ampere | 5.2 | 24 | 933 | CUDA |
| A100 | Ampere | 9.7 | 40 | 1555 | CUDA |
| GH200 | Hopper | - | 96 | 4000 | CUDA |
| H100 PCIe | Hopper | 26 | 80 | 2000 | CUDA |
| H100 SXM | Hopper | 34 | 80 | 3350 | CUDA |
| MI100 | CDNA | 11.5 | 32 | 1200 | HIP |
| MI210 | CDNA2 | 22.6 | 64 | 1600 | HIP |
| MI300X | CDNA3 | 81.7 | 192 | 5300 | HIP |
| MI300A | CDNA3 (APU) | 61.3 | 128 | 5300 | HIP |
| PVC | Xe HPC | 52.4 | 128 | 3280 | SYCL |

### NVIDIA GPUs

#### gn001 : V100 Cluster
- **GPUs:** 10x NVIDIA V100 (32GB)
- **Host:** 768GB RAM, dual Intel Xeon Gold 5218 @ 2.3GHz
- **Access:** SSH
- **Account:** do016 (needs verification)
- **CUDA arch:** sm_70

#### gc001-008 : DINE2 A30 Cluster (composable)
- **GPUs:** Up to 8x NVIDIA A30 per node (composable)
- **Host:** 2TB RAM, dual 32-core Sapphire Rapids (64 cores/node)
- **Access:** Slurm partition `dine2`
- **Account:** do015
- **CUDA arch:** sm_80
- **Notes:** 
  - Composable fabric (CerIO), GPUs can be allocated dynamically
  - Total 8 GPUs across 8 nodes, configurable on request

#### mad04, mad05 : A100 Nodes (composable)
- **GPUs:** 0-3x NVIDIA A100 (40GB) each (composable with Liqid fabric)
- **Host:** 4TB RAM, 128 cores
- **Access:** Slurm partition `cosma8-shm`
- **Account:** do016 (needs verification)
- **CUDA arch:** sm_80

#### mad06 : A100/Milan-X Node
- **GPUs:** 0-3x NVIDIA A100 (composable)
- **Host:** 1TB RAM, 128 cores, Milan-X architecture (768MB L3 cache)
- **Access:** SSH
- **Account:** do016 (needs verification)
- **CUDA arch:** sm_80

#### gn002 : Grace-Hopper
- **GPUs:** NVIDIA GH200
- **Host:** ARM (aarch64)
- **Access:** SSH
- **Account:** do016
- **CUDA arch:** sm_90
- **Notes:** ARM host requires native compilation or cross-compilation

#### gn003 : Grace-Hopper
- **GPUs:** NVIDIA GH200
- **Host:** ARM (aarch64)
- **Access:** Slurm partition `gracehopper`
- **Account:** do016
- **CUDA arch:** sm_90
- **Build notes:**
  - No system cmake. Use `pip3 install --user cmake` and add to PATH
  - CUDA 13.0 available at `/usr/local/cuda-13.0/bin/nvcc`

#### gn004 : H100 PCIe
- **GPUs:** 1x NVIDIA H100 PCIe
- **Host:** x86 (Intel)
- **Access:** SSH
- **Account:** do016 (need to verify this)
- **CUDA arch:** sm_90

### AMD HIP/ROCm Systems

#### ga004 : MI100
- **GPUs:** 1x AMD MI100
- **Host:** 1TB RAM, dual 64-core AMD EPYC Milan 7713 @ 2GHz (128 cores)
- **Access:** Slurm partition `cosma8-shm2`
- **Account:** do018 (need to verify this)
- **ROCm arch:** gfx908
- **ROCm version:** 6.3.0 (system-level, at `/opt/rocm-6.3.0/`)

#### ga005, ga006 : MI210
- **GPUs:** 2x AMD MI210 each
- **Host:** 1TB RAM, dual 32-core EPYC 7513 (64 cores/node)
- **Access:** Slurm partition `cosma8-shm2`
- **Account:** do018 (need to verify this)
- **ROCm arch:** gfx90a
- **ROCm version:** 6.3.0

#### ga007 : MI300X
- **GPUs:** 8x AMD MI300X
- **Access:** Slurm partition `mi300x`
- **Account:** do018
- **ROCm arch:** gfx942
- **Notes:** 
  - Highest memory bandwidth in cluster (5300 GB/s)

#### ga008 : MI300A (APU)
- **GPUs:** 4x AMD MI300A
- **Host:** 500GB shared RAM
- **Access:** SSH
- **Account:** do018
- **ROCm arch:** gfx942
- **Notes:**
  - APU architecture: GPU and CPU share physical RAM

### Intel Systems

#### gi001 : Ponte Vecchio (DEAD)
- **GPUs:** 2x Intel Ponte Vecchio
- **Status:** Dead
- **Notes:** Was using OneAPI/SYCL backend

## Access Commands

### Check partition access
```bash
scontrol show partition=<partition_name> | grep AllowAccounts
```

### Check groups you belong to
```bash
id
```

### Slurm submission
```bash
# A100 on cosma8-shm
sbatch -p cosma8-shm -A do016 script.sh

# Interactive MI300X session
srun -p mi300x -A do018 -t 10 --pty /bin/bash
```

### SSH access
```bash
# From a COSMA login node:
ssh gn001    # V100s
ssh gn002    # Grace-Hopper (ARM)
ssh gn004    # H100
ssh ga008    # MI300A
ssh mad06    # A100 + Milan-X
