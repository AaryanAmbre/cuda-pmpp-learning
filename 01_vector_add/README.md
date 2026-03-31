# 01 – Vector Addition

## 🎯 Objective

Implement a basic parallel vector addition kernel to understand the fundamental CUDA programming model: kernel launch, thread indexing, and host/device memory management.

---

## 🛠️ What Will Be Implemented

* A CUDA kernel that adds two vectors element-wise in parallel
* Host-side memory allocation (`cudaMalloc`, `cudaMemcpy`, `cudaFree`)
* Thread/block configuration and grid sizing
* Verification of GPU result against CPU reference

---

## 📁 Module Structure

```
01_vector_add/
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
./scripts/build.sh   01_vector_add
./scripts/run.sh     01_vector_add
./scripts/profile.sh 01_vector_add
```

---

## 📊 Profiling Notes

> _Add Nsight Systems observations here after profiling._

| Metric              | Value |
| ------------------- | ----- |
| Kernel duration     | 4.0063 ms|
| Memory transfer H→D | –     |
| Memory transfer D→H | –     |
| Occupancy           | –     |
