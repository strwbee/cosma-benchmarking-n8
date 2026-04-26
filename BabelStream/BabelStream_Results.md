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
| Rank | GPU | Node | Theoretical GB/s | Measured GB/s | Efficiency |
|------|-----|------|------------------|---------------|------------|
| 1 | MI300X | ga007 | 5,300 | 4,036 | 76.2% |
| 2 | MI300A | ga008 | 5,300 | 3,648 | 68.8% |
| 3 | GH200 | gn003 | 4,000 | 3,500 | 87.5% |
| 4 | H100 NVL | gn004 | 3,938 | 3,387 | 86.0% |
| 5 | A100 | mad04/05 | 1,555 | 1,352 | 86.9% |
| 6 | MI210 | ga005/06 | 1,600 | 1,250 | 78.1% |
| 7 | MI100 | ga004 | 1,200 | 947 | 78.9% |
| 8 | V100 | gn001 | 900 | 823 | 91.4% |
| 9 | A30 | gc001-008 | 933 | 822 | 88.1% |

**Notes:**
- Use `module load nvhpc/25.11` for CUDA on login (or `nvhpc/24.5` for V100 sm_70).
- ROCm not on login: cannot build HIP code from login, must allocate compute node.
- ROCm 7.2.0 on MI300X/MI300A (ga007/ga008), not 6.3.0.
- dine2 nodes mount `/dine` not `/cosma5`.
- MI300A (ga008) doesn't mount `/cosma5`: copy binary to home directory (cp build-hip-mi300x/hip-stream ~).
