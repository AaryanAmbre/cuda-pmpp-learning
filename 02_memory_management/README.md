# 02 – Memory Management

## 🎯 Objective

Explore CUDA's memory model in depth: global memory, pinned (page-locked) memory, unified memory, and the performance trade-offs of each transfer strategy.

---

## 🛠️ What Will Be Implemented

* Explicit host ↔ device transfers with `cudaMalloc` / `cudaMemcpy`
* Pinned memory allocation with `cudaMallocHost`
* Unified Memory (`cudaMallocManaged`) and prefetching
* Benchmark comparisons across memory strategies

---

## 📁 Module Structure

```
02_memory_management/
├── src/          # CUDA source files (.cu, .cpp)
├── include/      # Header files (.h, .cuh)
├── build/        # Compiled binaries (git-ignored)
├── profiling/
│   ├── nsys_reports/    # Nsight Systems report files (.nsys-rep)
│   └── screenshots/     # Profiler timeline screenshots
└── docs/
    └── explanation.md   # Concept explanation
```

---

## ⚙️ Build & Run

```bash
# From repo root
./scripts/build.sh   02_memory_management
./scripts/run.sh     02_memory_management
./scripts/profile.sh 02_memory_management
```

---

## 📊 Profiling Notes

> _Add Nsight Systems observations here after profiling._

| Metric                   | Pageable | Pinned | Unified |
| ------------------------ | -------- | ------ | ------- |
| H→D bandwidth (GB/s)     | –        | –      | –       |
| D→H bandwidth (GB/s)     | –        | –      | –       |
| Kernel duration (µs)     | –        | –      | –       |
