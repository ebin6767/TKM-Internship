# 🔢 BCD Adder (Binary Coded Decimal) – Verilog HDL

## 📌 Overview
This project implements a **BCD Adder** using Verilog HDL.
It adds two BCD digits and corrects the result if it exceeds 9 by adding 6 (0110).

It uses a **Ripple Carry Adder** + correction logic.

## ⚙️ Features
- 4-bit BCD addition
- Ripple carry adder based design
- Automatic decimal correction
- Carry generation support
- Simulation verified using testbench

## 🧠 Working Principle
1. Add two BCD digits using binary addition
2. Check if result > 9 or carry = 1
3. If invalid → add 0110 correction
4. Output corrected BCD sum

## 🔌 Inputs and Outputs

### Inputs
- `a[3:0]` → BCD input A
- `b[3:0]` → BCD input B
- `cin` → Input carry

### Outputs
- `sum[3:0]` → Corrected BCD sum
- `cout` → Carry to next digit

## 🧪 Test Cases
| A | B | Cin | Raw Sum | Correction | Final Sum | Cout | Description |
|---|---|---|---|---|---|---|---|
| 0000 | 0000 | 0 | 0000 | No | 0000 | 0 | Reset |
| 0001 | 0010 | 0 | 0011 | No | 0011 | 0 | Valid |
| 0101 | 0011 | 0 | 1000 | No | 1000 | 0 | Valid |
| 0101 | 0101 | 0 | 1010 | Yes | 0000 | 1 | Correction applied |
| 0110 | 0101 | 0 | 1011 | Yes | 0001 | 1 | Overflow case |
| 1001 | 1001 | 0 | 10010 | Yes | 1001 | 1 | Maximum case |

## 📊 Waveform Explanation
- First stage performs binary addition
- Second stage checks correction condition
- If sum > 9 → adds 0110
- Final output is valid BCD

## 🖥️ Output Waveform
<img width="1262" height="622" alt="image" src="https://github.com/user-attachments/assets/291111bd-3db5-4586-87d7-5148bcbc39ff" />
