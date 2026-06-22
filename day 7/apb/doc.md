<img width="1860" height="678" alt="17821576324463560730152751943733" src="https://github.com/user-attachments/assets/44b1af98-a5af-4495-aba7-fda5e4cbd8d6" />


# APB Protocol Layered Testbench
This project has a SystemVerilog testbench that checks an Advanced Peripheral Bus design. The project is set up in a way and works with EDA Playground.

# File Structure and Overview
The testbench is made up of smaller parts and follows the standard SystemVerilog verification architecture. Here is what you will find in the DAY7/APB/tb directory:

# Design and Top-Level Files
- design.sv: This file has the Register Transfer Level code for the APB design we are testing.

- testbench.sv: This is the testbench module. It creates the APB design, the physical interface and the clock and reset signals. It is also where EDA Playground starts.

# Verification Environment Components
- interface.sv: This file defines the APB protocol signals, clocking blocks and modports. These are used to connect the testbench parts to the APB design.

- transaction.sv: This file defines what an APB transaction looks like. It has fields for the address, data and read/write control.

- generator.sv: This part creates transactions and sends them to the driver.

- driver.sv: The driver gets transactions from the generator. Sends them to the APB interface.

- monitor.sv: The monitor watches the APB interface. Turns the activity into transactions. It then sends these transactions to the scoreboard.

- scoreboard.sv: The scoreboard gets the transactions from the monitor. Checks if they are correct. It does this by comparing the expected results with the output from the APB design.

- environment.sv: This is the container that creates and connects the generator, driver, monitor and scoreboard.

test.sv: This is the test case layer. It creates the environment sets up the test and starts the simulation.

# Running on EDA Playground
To run this simulation on EDA Playground follow these steps:

1. Testbench and Design:
Put the testbench code in the Testbench window.

Put the design code in the Design window.

2. Include Directives: Make sure your testbench file includes all the files, in the right order. For example:
`include "interface.sv"

`include "transaction.sv"

`include "generator.sv"

`include "driver.sv"

`include "monitor.sv"

`include "scoreboard.sv"

`include "environment.sv"

`include "test.sv"

3. Simulator Selection: Choose a simulator from the list on the left.

4. Run: Click the Run button to start the simulation. The testbench will. Run, checking the Advanced Peripheral Bus design.
