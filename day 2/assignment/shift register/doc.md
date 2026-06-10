#  Universal Shift Register (4-bit) – Verilog HDL

## 📌 Overview

This project implements a **4-bit Universal Shift Register** using **Verilog HDL**.

It is a multi-mode sequential circuit capable of performing:

- SISO (Serial In Serial Out)
- SIPO (Serial In Parallel Out)
- PISO (Parallel In Serial Out)
- PIPO (Parallel In Parallel Out)

The operation is controlled using a **2-bit mode selector**.

---

## ⚙️ Features

- 4-bit register design
- Supports all shift register types
- Mode-based operation control
- Serial and parallel data handling
- Clock-driven sequential circuit
- Reset support
- Testbench verified through simulation

---

##  Working Principle

The register operates according to the value of `mod[1:0]`.

| Mode | Operation |
|------|-----------|
| 00 | SISO |
| 01 | SIPO |
| 10 | PISO |
| 11 | PIPO |

Each mode determines how data is shifted or loaded:

- Shift operation moves bits through the register.
- Load operation stores parallel data.
- Serial input enters through `sin`.
- Parallel input enters through `pin[3:0]`.

---

##  Inputs and Outputs

### Inputs

- `clk` → Clock signal
- `rst` → Reset signal
- `sin` → Serial input
- `shift` → Shift enable
- `load` → Load enable
- `pin[3:0]` → Parallel input
- `mod[1:0]` → Mode select

### Outputs

- `sout` → Serial output
- `pout[3:0]` → Parallel output

##  Test Cases

| Mode | Operation | Input Type | Output Type | Description |
|--------|------------|-------------|--------------|-------------|
| 00 | SISO | Serial | Serial | Bit shifted out serially |
| 01 | SIPO | Serial | Parallel | Serial data stored in register |
| 10 | PISO | Parallel | Serial | Parallel load then shift out |
| 11 | PIPO | Parallel | Parallel | Direct parallel transfer |

---

##  Applications

- Data serialization and deserialization
- Temporary data storage
- Communication interfaces
- Digital signal processing systems
- FPGA and ASIC designs
- Embedded hardware systems

## output waveform
<img width="1192" height="395" alt="image" src="https://github.com/user-attachments/assets/88e9eeb2-f6ce-463b-bd72-e5779e3f2128" />



