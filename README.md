# Gamma Code Encoder (FPGA - VHDL)

This project implements a **Gamma-code encoder** using **Finite State Machine (FSM)** design on an FPGA.  
It converts input symbols from switches into LED blink patterns representing dot, dash, and bar pulses.

---

## 📘 Overview
- Language: **VHDL**
- Platform: **Intel/Altera FPGA (Quartus + ModelSim)**
- Author: *Hilal Gure*
- Date: *Spring 2025*

---

## 🧩 Folder Structure
| Folder | Description |
|--------|--------------|
| `src/` | VHDL source files for encoder and submodules |
| `testbench/` | Testbenches for ModelSim simulations |
| `docs/` | Report, figures, and documentation |

---

## ⚙️ Features
- Modular VHDL design (LUT, shift register, FSM, seven-segment display)
- Time-controlled LED blink using a 0.25 s base clock
- Fully simulated in ModelSim
- Synthesized and tested on FPGA hardware

---

## 🧪 Report
📄 [Read full report (PDF)](./docs/Gamma_Code_Encoder_Report.pdf)

---

## 🚀 How to Run
1. Open the project in **Quartus Prime**.
2. Compile and program onto FPGA.
3. Use switches `SW[3:0]` to select symbol, and button `KEY[1:0]` to start/reset.
4. Observe LED and 7-segment display outputs.

---

## 📚 References
- Harris & Harris, *Digital Design and Computer Architecture: RISC-V Edition*
- Cohen, *Free Range VHDL*
