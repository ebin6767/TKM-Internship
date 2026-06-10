<img width="1282" height="739" alt="image" src="https://github.com/user-attachments/assets/3ac40005-039e-4d06-bdd4-7a10cd9edb0c" />
This project implements a simple FIFO-based data transfer system using Verilog. It consists of four modules:
face_mod Receives 8-bit input data (S_in). Passes the data directly to the FIFO (S_out). Continuously enables writing by setting wr_en = 1.
fifo Acts as an 8×8 FIFO memory (8 locations, each 8 bits). Stores incoming data when wr_en is high. Provides stored data when rd_en is asserted. Generates full and empty status signals. Uses separate read and write pointers for FIFO operation.
mod_out Controls FIFO read operations using a simple FSM. Checks whether the FIFO contains data. Generates rd_en to read data from the FIFO. Transfers the received FIFO data to the output (d_out).
top_module Integrates face_mod, fifo, and mod_out.
Creates a complete data path:

Input Data → face_mod → FIFO → mod_out → final_out

Testbench (top_module_tb) Generates clock and reset signals. Applies test data (D1, D2, D3, D4, D5) to the system. Verifies that data is written into the FIFO and later appears at final_out.
