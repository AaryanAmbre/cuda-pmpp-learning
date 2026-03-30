# 🚀 CUDA Learning Journey (PMPP-Based)

This repository documents my journey of learning **GPU Programming using CUDA** based on the book *Programming Massively Parallel Processors (PMPP)*.

---

## 🎯 Goals

* Understand GPU architecture and parallel programming
* Learn CUDA programming from fundamentals
* Analyze performance using NVIDIA Nsight tools
* Build HPC-ready skills for real-world applications

---

## 📂 Project Structure

| Folder          | Description                                     |
| --------------- | ----------------------------------------------- |
| `01_vector_add` | First CUDA program (basic parallel computation) |
| `notes/`        | Concept explanations and theory                 |
| `assets/`       | Diagrams and screenshots                        |

---

## ⚡ Tech Stack

* CUDA C++
* NVIDIA Nsight Systems
* WSL (Ubuntu)
* VS Code

---

## 📊 Key Learnings So Far

* GPU requires explicit memory management (Host ↔ Device)
* Kernel functions run in parallel across threads
* Thread indexing is crucial:

  ```cpp
  int i = threadIdx.x + blockIdx.x * blockDim.x;
  ```
* GPU is not efficient for small workloads due to overhead
* Profiling is essential to understand performance

---

## 🔍 Profiling Insight

Using Nsight Systems:

* `cudaMalloc` and initialization dominate for small inputs
* Kernel execution is extremely fast but often hidden
* Larger input sizes reveal true GPU parallelism

---

## 🚀 Future Work

* Memory optimization (shared memory, coalescing)
* Matrix multiplication
* Parallel reduction
* Performance tuning

---

## 📌 Author

Aaryan Ambre
Aspiring HPC / GPU Engineer 🚀
