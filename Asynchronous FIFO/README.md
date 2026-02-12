# Asynchronous FIFO Design and Verification

This repository contains a Verilog implementation of an **Asynchronous FIFO** along with a **testbench** to verify its functionality.  
The FIFO supports **independent write and read clocks** and provides status flags for **full, empty, overflow, and underflow** conditions.



## Overview

An asynchronous FIFO is used to transfer data safely between two different clock domains.  
This design uses separate write and read pointers along with toggle flags to distinguish between **full** and **empty** states when pointers are equal.



## Design Features

- Independent write and read clock domains
- Parameterized FIFO depth and data width
- Full and empty detection
- Overflow and underflow indication
- Pointer synchronization between clock domains
- Memory reset and pointer initialization


## Parameters

| Parameter    | Description                     | Default |
|--------------|---------------------------------|---------|
| `DEPTH`      | FIFO depth 					 | 16      |
| `DATA_WIDTH` | Data width                      | 10      |
| `PTR_WIDTH`  | Pointer width (`$clog2(DEPTH)`) | Auto    |



## Port Description

### Inputs
- `wr_clk_i` : Write clock  
- `rd_clk_i` : Read clock  
- `rst_i` : Active-high reset  
- `wr_en_i` : Write enable  
- `rd_en_i` : Read enable  
- `wdata_i` : Write data  

### Outputs
- `rdata_o` : Read data  
- `full_o` : FIFO full flag  
- `empty_o` : FIFO empty flag  
- `overflow_o` : Overflow flag  
- `underflow_o` : Underflow flag  


## Architecture

- FIFO memory implemented using a register array
- Separate write and read pointers
- Toggle flags used to differentiate wrap-around
- Pointer and toggle synchronization across clock domains
- Full and empty conditions derived using synchronized pointers



## Testbench Description

The testbench verifies FIFO behavior using:
- Different write and read clock frequencies
- Directed test cases selected via **plusargs**
- Concurrent read/write operations using `fork-join`
- Tasks for write, read, and reset operations


## Test Selection

Test cases are selected using the plusarg:


+test=<test_name>

## Supported Tests

- test_2_writes
- test_2_reads
- test_2_write_2_read
- test_5_write_6_read
- test_full_write
- test_full_read
- test_full_write_full_read
- test_5_write_5_read
- test_full
- test_overflow
- test_empty
- test_underflow
- test_over_underflow
- test_concurrent

### Simulation Steps
vlib work 
vlog asyn_fifo.v top.v 
vsim top +test=test_concurrent. 
run -all


