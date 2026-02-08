# Verilog Memory Design & Testbench 

This project implements a **synchronous memory module** and a **comprehensive testbench** using **Verilog HDL**.

It supports multiple verification scenarios such as:
- Single and multiple read/write operations
- Partial and full memory access
- Front-door and back-door memory access using external files


## Overview 

The **Memory module** is a parameterized synchronous design supporting configurable **WIDTH** and **DEPTH**.

The **Testbench** verifies the memory’s functionality using multiple automated testcases to ensure correctness and reliable behavior.

This design is written using **standard Verilog syntax** and is compatible with common simulators.


## Features 

- ✅ Parameterized design (`WIDTH`, `DEPTH`)
- ✅ Synchronous reset and clock operation
- ✅ Read/Write operations with valid/ready handshake
- ✅ Automated testbench using reusable Verilog tasks
- ✅ Supports front-door and back-door memory access
- ✅ Plusarg support: `+test=<testcase_name>`
- ✅ Compatible with Icarus Verilog, ModelSim, and QuestaSim


## Memory Module Description 

**File:** `memory.v`

### Parameters 

| Parameter| Description                   | Default     |
|----------|-------------------------------|-------------|
| WIDTH    | Data width (bits)             | 8           |
| DEPTH    | Number of memory locations    | 16          |
| ADDR     | Address width (`log2(DEPTH)`) | Calculated  |


### I/O Ports 

| Port     | Direction| Description             |
|----------|----------|-------------------------|
| clk_i    | Input    | Clock signal            |
| rst_i    | Input    | Reset (active high)     |
| wr_rd_i  | Input    | 1 → Write, 0 → Read     |
| valid_i  | Input    | Valid operation         |
| addr_i   | Input    | Memory address          |
| wdata_i  | Input    | Write data              |
| rdata_o  | Output   | Read data               |
| ready_o  | Output   | Memory ready signal     |


## Testbench Description 

**File:** `top.v`

The testbench verifies memory functionality using a set of **predefined and selectable testcases**.

Testcases are selected dynamically using **plusargs**, enabling flexible simulation control.


### Main Tasks 

- `reset_mem()`  
  Initializes memory and control signals

- `write_mem(start, end)`  
  Writes random data to memory locations

- `read_mem(start, end)`  
  Reads data from memory locations

- `mem_bd_write()`  
  Loads memory content from `data.hex`

- `mem_bd_read()`  
  Dumps memory content to `output.bin`



## Supported Testcases 

| Testcase Name           | Description                                  |
|-------------------------|----------------------------------------------|
| test_5_writes           | Write 5 memory locations                     |
| test_1write_1read       | Single write followed by single read         |
| test_2write_2read       | Two writes followed by two reads             |
| test_3write_4read       | Partial write with extended read             |
| test_write_read         | Full memory write and read                   |
| test_first_half         | Write and read first quarter of memory       |
| test_half               | Write and read half of memory                |
| test_3/4_write          | Write and read three-fourths of memory       |
| test_3rd_portion_only   | Access third portion of memory only          |
| test_bd_wr_bd_rd        | Back-door write and back-door read           |
| test_bd_wr_fd_rd        | Back-door write and front-door read          |
| test_fd_wr_bd_rd        | Front-door write and back-door read          |
| test_fd_wr_fd_rd        | Front-door write and front-door read         |


## How to Run Simulation 

### ModelSim / QuestaSim 

vlib work                 
vlog memory.v top.v                   
vsim top +test=test_write_read                  
add wave -position insertpoint sim:/top/dut/*           
run -all 





