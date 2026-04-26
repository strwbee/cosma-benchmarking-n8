# miniBUDE Benchmark

Measures compute performance across GPUs in GFLOP/s.

## Set Up

miniBUDE: https://github.com/UoB-HPC/miniBUDE

Parameters:
- **Input deck:** bm2 (2672 atoms ligand)
- **Poses:** 65,536
- **Iterations:** 8
- **PPWI:** all (run with `-p all` to find the best PPWI)
- **Metric:** GFLOP/s

## Results Summary

| GPU | Node | Best PPWI | Measured GFLOP/s | Status |
|-----|------|-----------|------------------|--------|
| V100 | gn001 | 8 | 130.9 | ✓ |
| A30 | gc001-008 | 8 | 209.4 | ✓ |
| A100 | mad04/05 | 8 | 390.6 | ✓ |
| H100 NVL | gn004 | 32 | 481.3 | ✓ |
| GH200 | gn003 | 8 | 674.6 | ✓ |
| MI100 | ga004 | - | - | (pending) |
| MI210 | ga005/06 | 16 | 118.5 | ✓ |
| MI300A | ga008 | 8 | 359.3 | ✓ |
| MI300X | ga007 | 8 | 476.6 | ✓ |
