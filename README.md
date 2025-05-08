# APB-with-SRAM
# Overview
The AMBA APB4 Protocol project implements the Advanced Peripheral Bus (APB) protocol, part of the AMBA (Advanced Microcontroller Bus Architecture) family. This protocol is designed to offer a low-complexity, low-power interface for communication with peripherals in modern System-on-Chip (SoC) designs. It is particularly suited for connecting low-speed peripherals such as timers, UARTs, GPIOs, and configuration registers, where high performance is not required.
# Repository Structure
RTL/: Contains the Verilog source files for the APB master and slave modules.
Simulation/: Includes the testbench files that simulate the external system, providing commands to the APB master and slave.
docs/: Contains the project documentation, including references and the AMBA APB Protocol Specification.
Scripts/: Provides script files, including a DO file for QuestaSim and a TCL file for Vivado, to enhance simulation and synthesis speed.
doc_4th_section/: Contains synthesis reports, such as timing summaries and resource utilization.
# Protocol Architecture
Main Idea: This project involves implementing the AMBA APB protocol, consisting of an APB master, an APB slave, and an external system (such as a CPU). The external system sends commands to the APB master, which then communicates these commands to the APB slave. Inside the APB slave, a cache memory is integrated to facilitate testing of write and read processes. The testbench simulates the external system, allowing for the verification of the protocol's functionality.
# Key Architectural Features:
Non-Pipelined Bus Interface: Ensures straightforward communication with peripherals, minimizing complexity.
Single Clock Edge Operation: Simplifies timing and reduces power usage, critical for battery-operated devices.
Three-State Control: The protocol operates in three distinct states—IDLE, SETUP, and ACCESS—to manage data transfer efficiently.
