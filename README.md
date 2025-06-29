
## Synchronous FIFO Design (Verilog)

### 🔧 Overview

This project implements a **parameterized synchronous FIFO (First-In First-Out) memory buffer** using Verilog, including a comprehensive testbench for functional verification.

It demonstrates key digital design concepts such as:

* Circular buffer management
* Pointer-based `full` and `empty` flag generation
* Synchronous read/write operations
* Self-checking testbench logic


---



### 📐 FIFO Features

| Feature         | Description                               |
| --------------- | ----------------------------------------- |
| **Depth**       | Configurable via `DEPTH` parameter        |
| **Data Width**  | Configurable via `DATA_WIDTH` parameter   |
| **Full/Empty**  | Robust flag logic using pointer MSBs      |
| **Synchronous** | Single clock domain (ideal for FPGA/ASIC) |

---

### ✅ Simulation Results

The FIFO was simulated using **EPWave ** with successful verification of all write/read sequences.
[EP_Wave]()

> ✅ Matching `data_in` and `data_out`
> ✅ Proper flag toggling (`empty`, `full`)


---

### 🧪 Testbench Highlights

* Generates random `data_in` using `$random`
* Writes and reads alternately under valid conditions
* Verifies each output against expected values stored in a local reference array
* Dumps signals to `dump.vcd` for waveform inspection

---

### ▶️ How to Simulate




   Use [EDAPlayground](https://www.edaplayground.com/) to quickly simulate and view waveforms online.

---

### 📌 Learning Outcomes

By building this project, you will:

* Understand FIFO internals and circular buffer logic
* Learn to implement reset-safe, synthesizable logic
* Develop testbenches with randomized stimuli and self-checking
* Gain experience debugging waveforms and verifying timing

---

### 👨‍💻 Author
Manvitha Bheemavarapu
