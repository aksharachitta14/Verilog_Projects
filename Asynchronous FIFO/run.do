vlib work
vlog asyn_fifo_tb.v 
vsim -novopt -suppress 12110 top +test=test_full_write_full_read
#add wave -position insertpoint sim:/top/dut/*
do wave.do
run -all
