# miniBUDE Benchmark

Measures compute performance across GPUs in GFLOP/s.

## Set Up

miniBUDE: https://github.com/UoB-HPC/miniBUDE

Parameters:
- **Input deck:** bm2 (2672 atoms ligand)
- **Poses:** 65,536
- **Iterations:** 8
- **PPWI:** 1 (default, poses per work item)
- **Metric:** GFLOP/s

## Results Summary

| GPU | Node | Measured GFLOP/s | Status |
|-----|------|------------------|--------|
| V100 | gn001 | 35.2 | ✓ |
| A30 | gc001-008 | - | ✗ (dine2 has V100s attached?) |
| A100 | mad04/05 | 160.2 | ✓ |
| H100 NVL | gn004 | 187.4 | ✓ |
| GH200 | gn003 | 281.6 | ✓ |
| MI100 | ga004 | - | job pending |
| MI210 | ga005/06 | - | job pending |
| MI300A | ga008 | 267.4 | ✓ |
| MI300X | ga007 | 388.7 | ✓ |

**Notes:**
- GH200 (gn003) doesn't have git installed: copy `~/git` from login node.
- A30: dine2 nodes currently have V100s attached via CerIO fabric, not A30s.
- MI100/MI210: cosma8-shm2 partition busy. Jobs pending.
- Re-running with `-p all` may give better performance. (NEED TO TEST)
