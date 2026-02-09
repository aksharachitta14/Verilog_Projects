# Synchronous FIFO Design & Testbench (Verilog)

This project implements a **parameterized synchronous FIFO (First-In First-Out)** memory and a **self-checking testbench** using **Verilog HDL**.

The FIFO supports configurable depth and data width, along with status flags for full, empty, overflow, and underflow conditions.



## Overview

The **FIFO module** is a synchronous design operating on a single clock domain.  
It uses read and write pointers with toggle flags to accurately detect **full** and **empty** conditions.

The **testbench** verifies FIFO behavior using multiple test scenarios selected via **plusargs**, making simulation flexible and reusable.



## Features

- ✅ Fully synchronous FIFO design  
- ✅ Parameterized `DEPTH` and `DATA_WIDTH`  
- ✅ Separate read and write enable controls  
- ✅ Full and empty detection using pointer toggle technique  
- ✅ Overflow and underflow flag support  
- ✅ Automated testbench with reusable tasks  
- ✅ Plusarg-based testcase selection  
- ✅ Compatible with ModelSim, QuestaSim, and Icarus Verilog  



## FIFO Module Description

**File:** `synch_fifo.v`

### Parameters

| Parameter     | Description                     | Default |
|---------------|---------------------------------|---------|
| DEPTH         | Number of FIFO entries          | 16      |
| DATA_WIDTH    | Width of each data word (bits)  | 10      |
| PTR_WIDTH     | Pointer width (`$clog2(DEPTH)`) | Auto    |



### I/O Ports

| Port Name     | Direction | Description                        |
|---------------|-----------|------------------------------------|
| clk_i         | Input     | Clock signal                       |
| rst_i         | Input     | Synchronous reset (active high)    |
| wr_en_i       | Input     | Write enable                       |
| wdata_i       | Input     | Write data                         |
| rd_en_i       | Input     | Read enable                        |
| rdata_o       | Output    | Read data                          |
| full_o        | Output    | FIFO full flag                     |
| empty_o       | Output    | FIFO empty flag                    |
| overflow_o    | Output    | Overflow indicator                 |
| underflow_o   | Output    | Underflow indicator                |

---

## Testbench Description

**File:** `top.v`

The testbench applies different FIFO access patterns using **Verilog tasks**.  
Testcases are selected dynamically using the `+test=<testcase_name>` plusarg.



## Testbench Tasks

- `reset_fifo()`  
  Initializes FIFO signals and applies reset

- `write_fifo(start, end)`  
  Writes random data into FIFO

- `read_fifo(start, end)`  
  Reads data from FIFO


## Supported Testcases

| Testcase Name              | Description                                  |
|----------------------------|----------------------------------------------|
| test_2_writes              | Write 2 entries into FIFO                    |
| test_2_write_2_read        | Write 2 entries, then read 2 entries         |
| test_5_write_6_read        | Overflow and underflow scenario              |
| test_full_write            | Fill FIFO completely                         |
| test_full_write_full_read  | Full write followed by full read             |
| test_overflow              | Write beyond FIFO depth                      |
| test_empty                 | Empty FIFO read check                        |
| test_underflow             | Read beyond FIFO capacity                    |
| test_over_underflow        | Combined overflow and underflow test         |



## How to Run Simulation

### ModelSim / QuestaSim


vlib work
vlog synch_fifo.v top.v
vsim top +test=test_full_write_full_read
run -all

