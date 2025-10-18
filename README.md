# Gamma Code Encoder (FPGA – VHDL)

**Author:** [Hilal Gure](https://github.com/hilalgure)  
**Email:** hilal_shide@live.com  
**Year:** 2025  

This repository contains a modular **Gamma-code encoder** implemented in **VHDL** and verified with **ModelSim**.  
A finite-state machine (FSM) converts 2-bit pulse tokens (dot/dash/bar) into LED blink patterns with a 0.25 s base tick, while the chosen symbol is shown on a seven-segment display.

> **Demo target:** Intel/Altera FPGA (50 MHz system clock)  
> **Tools:** Quartus Prime, ModelSim

---

## 🔧 Features
- Clean **modular architecture**: LUT → Shift Register → FSM → LED/7-seg
- **Quarter-second clock** generator from 50 MHz
- **Testbenches** for each submodule (self-contained simulations)
- Ready **IEEE-style report** (see `/docs`) and LaTeX template

---

## 🗂 Repository Structure
Gamma-Code-Encoder/
│
├── src/                     # VHDL source (design)
│   ├── gamma_code_encoder.vhd
│   ├── gamma_lut.vhd
│   ├── gamma_shift_reg.vhd
│   ├── fsm.vhd
│   ├── seven_seg.vhd
│   └── counter_slow.vhd
│
├── testbench/               # ModelSim testbenches
│   ├── tb_gamma_lut.vhd
│   ├── tb_gamma_shift_reg.vhd
│   ├── tb_fsm.vhd
│   ├── tb_counter_slow.vhd
│   └── tb_seven_seg.vhd
│
├── docs/                    # Reports, figures, LaTeX
│   ├── Gamma_Code_Encoder_Report.pdf      # English PDF
│   ├── original_norwegian.pdf             
│   └── latex/
│       ├── main.tex
│       ├── references.bib
│       └── figures/                       # images for the paper
│
├── LICENSE
├── .gitignore
└── README.md


---

## ⚙️ Hardware Mapping

- **SW[3:0]**: Select symbol
- **KEY1**: Start encoding/blink sequence (active low in code → wire as needed)
- **KEY0**: Reset (active low in code → `LEDR[9]` indicates reset)
- **LEDR[0]**: Output blink according to Gamma code
- **HEX0**: Selected symbol (7-segment)

Pulse tokens (2-bit):
- `00` → **dot** (0.25 s)  
- `01` → **dash** (0.75 s)  
- `10` → **bar**  (1.50 s)

---

## 🚀 Quick Start

### Simulation (ModelSim)
1. Open ModelSim and create a project.
2. Add files in `src/` and the desired `testbench/tb_*.vhd`.
3. Set the testbench as top and **Run**.  
   Waveforms verify LUT mapping, shift behavior, tick timing, and FSM sequencing.

### FPGA (Quartus)
1. Create a new Quartus project and add all files in `src/`.
2. Assign pins for `CLOCK_50`, `SW[3:0]`, `KEY[1:0]`, `LEDR[9:0]`, `HEX0[6:0]`.
3. Compile, program the board, and use switches & keys as above.

---

## 🧩 Design Modules
- `gamma_lut.vhd` – maps `SW[3:0]` to an 8-bit Gamma code (four 2-bit pulses)
- `gamma_shift_reg.vhd` – shifts out 2-bit tokens (MSB first), asserts `finished` when empty
- `counter_slow.vhd` – quarter-second tick from 50 MHz (generic `n`, `k`)
- `fsm.vhd` – Moore FSM: `S1_LOAD → S2_CHECK → S3_BLINK → S4_PAUSE → S5_DONE`
- `seven_seg.vhd` – displays chosen symbol on HEX0

---

## 📄 Report
- 📘 **English PDF:** [`./docs/Gamma_Code_Encoder_Report.pdf`](./docs/Gamma_Code_Encoder_Report.pdf)  
- ✍️ **LaTeX (IEEEtran) source:** `./docs/latex/` (build in Overleaf or locally)

---

## 📚 References
- D. M. Harris and S. L. Harris, *Digital Design and Computer Architecture: RISC-V Edition*, Morgan Kaufmann, 2022.  
- B. Cohen, *Free Range VHDL: No Strings Attached!*, VhdlCohen Publishing, 2013.

---

## 📝 License

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](./LICENSE)

This project is licensed under the **MIT License** — see the [LICENSE](./LICENSE) file for details.

© 2025 **Hilal Gure**


