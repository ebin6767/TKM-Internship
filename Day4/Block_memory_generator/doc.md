<img width="1222" height="622" alt="image" src="https://github.com/user-attachments/assets/7e0618b4-623e-4ffe-a0a1-ef49f8c2cb5a" />
<img width="1245" height="490" alt="image" src="https://github.com/user-attachments/assets/b32046c5-ae2b-48b6-8b84-3f7e7065586c" />
This repository features a 256 x 8-bit Simple Dual-Port Block RAM optimized for FPGA implementation. The module is architected with independent read and write interfaces, utilizing dedicated data paths and synchronous clock control for both operations. Additionally, an asynchronous reset is included to initialize the memory state. The repository provides the complete RTL module, a testbench for verification, timing analysis reports, and waveform documentation, all developed within the Xilinx Vivado environment.

Behavioral Waveform Verification
Simulation results in the Xilinx Vivado Simulator confirm that the design functions correctly, exhibiting the expected read/write behavior:

-Initialization (0 ns – 17 ns): The system undergoes a reset sequence, ensuring all internal signals are properly initialized to the expected default states.

-Write Operations (35 ns – 65 ns): The memory demonstrates successful data capture. Specifically, writing 0xAA to address 0x0A and 0xBB to address 0x14 completes without error.

-Read Operations (After 65 ns): Post-write, the system transitions to read mode. The sequential read process accurately retrieves the previously stored values (0xAA followed by 0xBB) in the correct order, validating the integrity of the dual-port memory architecture.
