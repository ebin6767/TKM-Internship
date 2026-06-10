#  D Flip-Flop (D FF) – Verilog HDL

## 📌 Overview
This project implements a **D Flip-Flop (D FF)** using Verilog HDL.
A D Flip-Flop is a sequential circuit that stores a single bit of data on the rising edge of the clock.
It is widely used in registers, memory elements, and digital systems.

##  Features
- Edge-triggered operation (positive edge)
- Synchronous data storage
- Asynchronous reset support
- Outputs Q and Q̅ (complement)
- Verified using testbench simulation

## 🧠 Working Principle
At every positive clock edge:
1. If reset = 1 → Output resets to 0
2. If reset = 0 → Output follows input D
3. Q stores the value of D, while Q̅ remains the complement of Q.



## 🔌 Inputs and Outputs

### Inputs
- `d` → Data input
- `clk` → Clock signal
- `rst` → Reset signal

### Outputs
- `q` → Stored output
- `qbar` → Complement output

## 🧪 Test Cases
| Reset | D | Clock Edge | Q | Q̅ | Description |
| :---: | :---: | :---: | :---: | :---: | :--- |
| 1 | X | ↑ | 0 | 1 | Reset active |
| 0 | 0 | ↑ | 0 | 1 | Store 0 |
| 0 | 1 | ↑ | 1 | 0 | Store 1 |
| 0 | 0 | No edge | Q | Q̅ | Hold previous |

## 📊 Waveform Explanation
- On reset = 1, Q becomes 0 immediately.
- On each rising clock edge, Q updates to D.
- Q̅ always remains opposite of Q.
- Between clock edges, the output remains stable.

##  Key Observation
This is a sequential circuit; therefore, the output changes **only** on clock edges, not continuously.

##  Project Structure
- `rtl/`: Contains the D Flip-Flop design module.
- `sim/`: Contains the testbench file.
- `output/`: Simulation waveform results.

- ## output waveform
- <img width="1032" height="531" alt="image" src="https://github.com/user-attachments/assets/0745bd38-f367-4ec4-82d6-647044de67ac" />
