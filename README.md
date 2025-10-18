# Gamma Code Encoder (FPGA – VHDL)

**Author:** [Hilal Gure](https://github.com/hilalgure)  
**Email:** hilal_shide@live.com  
**Year:** 2025  

This project implements a **Gamma-code encoder** using **Finite State Machine (FSM)** logic on an FPGA.  
It converts input symbols from switches into LED blink patterns representing short (dot), medium (dash), and long (bar) pulses.  
The system also displays the chosen symbol on a seven-segment display and includes modular testbenches for simulation.

---

## 🔧 Features
- Modular design: **LUT → Shift Register → FSM → Display**
- Accurate **0.25 s base timing** from a 50 MHz input clock
- Verified through **ModelSim simulation**
- Tested on physical FPGA hardware (Quartus Prime)
- Complete documentation in **English and Norwegian**
- **IEEE-style LaTeX report** included under `/docs/latex`

---

## ⚙️ Hardware Mapping

| Input/Output | Function |
|---------------|-----------|
| `SW[3:0]` | Select symbol to encode |
| `KEY1` | Start encoding sequence |
| `KEY0` | Reset (active-high) |
| `LEDR[0]` | Encoded blink output |
| `LEDR[9]` | Reset indicator |
| `HEX0` | Displays selected symbol |

**Pulse encoding:**
- `00` → Dot (0.25 s)  
- `01` → Dash (0.75 s)  
- `10` → Bar  (1.50 s)

---

## 🧠 System Overview
The top-level entity (`gamma_code_encoder.vhd`) connects all modules:
1. **Gamma LUT** – Maps selected symbol to an 8-bit Gamma code.  
2. **Shift Register** – Outputs 2-bit tokens sequentially to FSM.  
3. **FSM** – Controls LED output timing and sequencing.  
4. **Counter** – Generates a 0.25 s timing tick from 50 MHz.  
5. **Seven-Segment Display** – Shows selected character on `HEX0`.

---

## 🧪 Verification
All modules were simulated and tested in **ModelSim**:
- Each VHDL entity has a dedicated testbench.  
- The FSM and timing were validated through waveform analysis.  
- Debugging LEDs visualized internal control signals (`tick_qsec`, `load_reg`, `shift_en`, etc.).  

Simulation ensured correctness before hardware synthesis in **Quartus Prime**.

---

## 📁 Repository Structure
```
Gamma-Code-Encoder/
│
├── src/ # VHDL source files
│ ├── gamma_code_encoder.vhd
│ ├── gamma_lut.vhd
│ ├── gamma_shift_reg.vhd
│ ├── fsm.vhd
│ ├── seven_seg.vhd
│ └── counter_slow.vhd
│
├── testbench/ # ModelSim testbenches
│ ├── tb_gamma_lut.vhd
│ ├── tb_gamma_shift_reg.vhd
│ ├── tb_fsm.vhd
│ ├── tb_counter_slow.vhd
│ └── tb_seven_seg.vhd
│
├── docs/ # Reports and documentation
│ ├── Gamma_Code_Encoder_Report.pdf # English report
│ ├── original_norwegian.pdf # Original report
│ └── latex/
│ ├── main.tex
│ ├── references.bib
│ └── figures/ # Images for the paper
│
├── LICENSE
├── .gitignore
└── README.md
```
---

## 📄 Report
📘 **English version:** [`docs/Gamma_Code_Encoder_Report.pdf`](./docs/Gamma_Code_Encoder_Report.pdf)  
📗 **Norwegian version:** [`docs/original_norwegian.pdf`](./docs/original_norwegian.pdf)  
📄 **LaTeX source:** [`docs/latex/`](./docs/latex)

---

## 🚀 How to Run

### ▶️ Simulation (ModelSim)
1. Open **ModelSim** and create a project.  
2. Add files from `src/` and a testbench from `testbench/`.  
3. Set the testbench as top-level and **Run Simulation**.  
4. Inspect waveforms for correct blink durations and FSM transitions.

### 💡 FPGA Implementation (Quartus)
1. Open **Quartus Prime** and create a new project.  
2. Add all design files from `/src/`.  
3. Assign FPGA pins for:
   - `CLOCK_50`
   - `SW[3:0]`, `KEY[1:0]`, `LEDR[9:0]`, `HEX0[6:0]`
4. Compile and program the FPGA.
5. Observe the LED and display outputs.

---

## 📚 References
- D. M. Harris and S. L. Harris, *Digital Design and Computer Architecture: RISC-V Edition*, Morgan Kaufmann, 2022.  
- B. Cohen, *Free Range VHDL: No Strings Attached!*, VhdlCohen Publishing, 2013.

---

## 📝 License

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](./LICENSE)  
This project is licensed under the **MIT License** — see the [LICENSE](./LICENSE) file for details.  
© 2025 **Hilal Gure**
