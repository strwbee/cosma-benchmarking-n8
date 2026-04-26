# miniBUDE Benchmark

Measures compute performance across GPUs in GFLOP/s.

## Set Up

miniBUDE: https://github.com/UoB-HPC/miniBUDE

Parameters:
- **Input deck:** bm2 (2672 atoms ligand)
- **Poses:** 65,536
- **Iterations:** 8
- **PPWI:** all (run with `-p all`)
- **Metric:** GFLOP/s

## Results Summary

| Rank | GPU | Node | Best PPWI | Measured GFLOP/s |
|------|-----|------|-----------|------------------|
| 1 | GH200 | gn003 | 8 | 674.6 |
| 2 | H100 NVL | gn004 | 32 | 481.3 |
| 3 | MI300X | ga007 | 8 | 476.6 |
| 4 | A100 | mad04/05 | 8 | 390.6 |
| 5 | MI300A | ga008 | 8 | 359.3 |
| 6 | A30 | gc001-008 | 8 | 209.4 |
| 7 | V100 | gn001 | 8 | 130.9 |
| 8 | MI210 | ga005/06 | 16 | 118.5 |
| - | MI100 | ga004 | - | ⏳ (pending) |

**Notes:**
- PPWI (poses per work item) significantly impacts performance. Run with `-p all` for the auto best PPWI.
- MI210 shows high timing variance (stddev ~3000ms at optimal PPWI): may indicate thermal throttling or contention.
- AMD GPUs show lower efficiency than NVIDIA (~0.5% vs ~2-4%) when compared to theoretical peak FP64, possibily due to CUDA optimisation in the benchmark.
