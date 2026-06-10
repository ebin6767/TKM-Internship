# ⚡ 4-bit Ripple Carry Adder (Verilog HDL)

## 📌 Overview
This project implements a **4-bit Ripple Carry Adder** using Verilog HDL.
It performs binary addition of two 4-bit inputs along with a carry-in.
The design is built using full adders connected in series, where carry propagates from LSB to MSB.

## ⚙️ Features
- 4-bit binary addition
- Carry-in support
- Modular full adder design
- Ripple carry propagation
- Simulation verified using testbench

## 🧠 Working Principle
Each full adder performs:
1. **Sum** = A ⊕ B ⊕ Cin
2. **Carry** = majority logic of inputs
3. Carry output of one stage feeds the next stage.

## 🔌 Inputs and Outputs

### Inputs
- `a[3:0]` → First operand
- `b[3:0]` → Second operand
- `cin` → Input carry

### Outputs
- `s[3:0]` → Sum output
- `cout` → Final carry-out

## 🧪 Test Cases

| A | B | Cin | Sum | Cout | Description |
|---|---|---|---|---|---|
| 0000 | 0000 | 0 | 0000 | 0 | Reset |
| 0001 | 0010 | 0 | 0011 | 0 | Simple addition |
| 0010 | 0100 | 1 | 0111 | 0 | With carry-in |
| 1110 | 0110 | 0 | 0100 | 1 | Overflow case |
| 0011 | 1100 | 1 | 0000 | 1 | Full carry propagation |

## 📊 Waveform Explanation
- Carry starts at LSB.
- Propagates through each full adder.
- Final carry appears at MSB stage.
- Delay increases with bit position.

## 🚀 Applications
- ALU design
- FPGA arithmetic circuits
- Digital systems
- Computer architecture

- ##output waveform
- <img width="1267" height="557" alt="image" src="https://github.com/user-attachments/assets/ccdaef09-6f2c-4f5b-82b6-b8d435b2ea6f" />
