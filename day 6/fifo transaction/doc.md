<img width="1242" height="187" alt="image" src="https://github.com/user-attachments/assets/92ebf90e-59fb-45ab-9f7b-138940db31a0" />

# Introduction:
The basic operation principles of the FIFO memory structure are shown in this project. These include: The ability to perform synchronous writes and reads via a common clock. Full and Empty flags which prevent any possible buffer overflow/underflow conditions. A constrained random testbench using SystemVerilog classes.

# Design Components
1.fifo Module (DUT) The Design Under Test (DUT) uses circular buffer implementation using an 8-bit wide, 8-entry memory array (mem[7:0]). Pointers: 3-bit wide wr_ptr and rd_ptr used for tracking head/tail pointers. Flags: * full: Set when next position of the write pointer equals the read pointer. empty: Set when the write pointer equals the read pointer.

2.fifo_transaction Class The stimulus creation is encapsulated within this class. Randomization: rand variables used in SystemVerilog for wr_en, rd_en and data_in. Constraints: rw_dist_c constraint using dist to set distribution of write and read enable signals: wr_en: 50% probability to be high. rd_en: 40% probability to be high.

3.tb_fifo Module The testbench takes care of the lifecycle of simulation process: Reset Handling: Initializing the DUT in a known state. Stimulus Generation: Execution of a repeat(10) loop that performs randomization of transactions and applying the stimulus to the DUT interface. Data Capturing: Capture data_out, full and empty signals from the DUT after every transaction to make sure that the stimulus object has been updated with real design response.

# Simulation Waveforms:
The waveforms below, from EPWave, show the following behavior: Empty condition: True initially until writing any data. Operations: Follows proper sequence for storing and fetching data. Pointer Conditions: Shows regular FIFO circular queue operations.
