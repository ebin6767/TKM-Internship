<img width="1250" height="217" alt="image" src="https://github.com/user-attachments/assets/d4a02fcb-b22e-4b2a-a4c9-c8183d96abd6" />
Synchronous FIFO Design and Verification
This project focuses on the design and verification of an 8-bit Synchronous FIFO memory buffer. The core hardware logic is implemented using Verilog, while the verification environment is built as a SystemVerilog testbench to rigorously validate read and write operations. To maintain a clean, modular, and scalable testbench architecture, a SystemVerilog interface (fifo_if) is utilized to encapsulate all interconnecting signals—including clock, reset, data busses, and status flags—between the testbench and the FIFO module.

📌 Project Features
Data Width: Supports an 8-bit wide data bus for both input and output operations.

Storage Capacity: Configured to store a maximum depth of up to 8 data values.

Modular Architecture: Utilizes a dedicated fifo_if interface to streamline signal routing and enhance code maintainability.

Status Flags: Integrates essential status indicators (such as full and empty flags) to ensure robust flow control, preventing data overflow, underflow, or unexpected glitches.
