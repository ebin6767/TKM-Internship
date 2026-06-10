#  2-to-4 Decoder (Verilog HDL)

## 📌 Overview

This project implements a **2-to-4 Decoder** using **Verilog HDL**.

It converts a **2-bit binary input** into a **one-hot 4-bit output**.

Only one output line is activated for each valid input combination.

---

## ⚙️ Features

- 2-to-4 decoding
- Combinational logic design
- One-hot output generation
- Simple case-based implementation
- Verified using testbench simulation
- Fast output response

---


##  Inputs and Outputs

### Inputs

- `b[1:0]` → 2-bit binary input

### Outputs

- `d[3:0]` → One-hot decoded output

---



##  Test Cases

| Input (b) | Output (d) | Description |
|-----------|------------|-------------|
| 00 | 0001 | First output active |
| 01 | 0010 | Second output active |
| 10 | 0100 | Third output active |
| 11 | 1000 | Fourth output active |

---

## 📊 Waveform Explanation

- Input `00` → Output `0001`
- Input `01` → Output `0010`
- Input `10` → Output `0100`
- Input `11` → Output `1000`

## output waveform
<img width="1595" height="542" alt="image" src="https://github.com/user-attachments/assets/270cdad3-dac7-471e-8463-5198c4dbd47e" />



