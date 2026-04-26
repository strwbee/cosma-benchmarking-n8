# Cosma Testbeds Benchmarking

N8 Internship Project: Benchmarking GPU performance on COSMA.
This repo provides documentation of access, build procedures, and results. The goal is to:
- Verify: which GPU clusters are accessible and operational.
- Verify: what is available and operational on each GPU cluster (which compilers, modules, toolchains.. etc.).
- Document: a measured performance of the GPU systems alongside a theoretical baseline.

## Benchmarks
| Benchmark   | Type             | Metric  | Status       |
|------------|------------------|---------|--------------|
| BabelStream| Memory Bandwidth | GB/s    | Complete     |
| miniBUDE   | Compute          | GFLOPS  | In progress  |

## Results

| GPU | Node | BabelStream (GB/s) | Rank | miniBUDE (GFLOP/s) | Rank |
|-----|------|--------------------|------|--------------------|------|
| GH200 | gn003 | 3,500 | 3 | 674.6 | 1 |
| H100 NVL | gn004 | 3,387 | 4 | 481.3 | 2 |
| MI300X | ga007 | 4,036 | 1 | 476.6 | 3 |
| MI300A | ga008 | 3,648 | 2 | 359.3 | 5 |
| A100 | mad04/05 | 1,352 | 5 | 390.6 | 4 |
| MI210 | ga005/06 | 1,250 | 6 | 118.5 | 8 |
| MI100 | ga004 | 947 | 7 | — | — |
| V100 | gn001 | 823 | 8 | 130.9 | 7 |
| A30 | gc001-008 | 822 | 9 | 209.4 | 6 |
