`include "memory.v"
module top;
	parameter DEPTH=16;
	parameter WIDTH=16;
	parameter ADDR_WIDTH= $clog2(DEPTH);
	reg clk_i,wr_rd_i,rst_i,valid_i;
	reg [ADDR_WIDTH-1:0]addr_i;
	reg [WIDTH-1:0]wdata_i;
	wire[WIDTH-1:0]rdata_o;
	wire ready_o;

	integer i;
    reg [25*8:0] test;//used to store a string 25=characters,8=bits(one ASCLL character)
//using parameters
	 memory #(.DEPTH(DEPTH),.WIDTH(WIDTH)) dut(.clk_i(clk_i),.rst_i(rst_i),.wr_rd_i(wr_rd_i),.addr_i(addr_i),.wdata_i(wdata_i),.rdata_o(rdata_o),.valid_i(valid_i),.ready_o(ready_o));
	 //using list
//	 memory dut(.clk_i(clk_i),.rst_i(rst_i),.wr_rd_i(wr_rd_i),.addr_i(addr_i),.wdata_i(wdata_i),.rdata_o(rdata_o),.valid_i(valid_i),.ready_o(ready_o));

//clock Generation
	initial begin
		clk_i=0;
		forever #5 clk_i=~clk_i;
	end
	initial begin
		reset_mem();
		$value$plusargs("test=%s",test);
		$display("Passing Testcase=%0s",test);
		case(test)
			"test_5_writes":begin
			write_mem(0,5);
			end
			"test_1write_1read":begin
				write_mem(0,1);
				read_mem (0,1);
			end
			"test_2write_2read":begin
				write_mem(0,2);
				read_mem (0,2);
			end
			"test_3write_4read":begin
				write_mem(1,4);
				read_mem (0,4);
			end
			"test_write_read":begin
				write_mem(0,DEPTH);
				read_mem(0,DEPTH);
			end
			"test_first_half":begin
				write_mem(0,(DEPTH/4));
				read_mem(0,(DEPTH/4));
			end
				"test_half":begin
				write_mem(0,(DEPTH/2));
				read_mem(0,(DEPTH/2));
			end
				"test_3/4_write":begin
				write_mem(0,3*(DEPTH/4));
				read_mem(0,3*(DEPTH/4));
			end
				"test_3rd_portion_only":begin
				write_mem(DEPTH/2,3*(DEPTH/4));
				read_mem(DEPTH/2,3*(DEPTH/4));
			end
			"test_bd_wr_bd_rd":begin
				mem_bd_write();
				mem_bd_read();
			end
			"test_bd_wr_fd_rd":begin
				mem_bd_write();
				read_mem(0,DEPTH);
			end
			"test_fd_wr_bd_rd":begin
				write_mem(0,DEPTH);
				mem_bd_read();

			end
			"test_fd_wr_fd_rd":begin
				write_mem(0,DEPTH);
				read_mem(0,DEPTH);
			end
		endcase

		#100;
		$finish();
	end
	
		//reset task
	task reset_mem();
		begin
			rst_i   =1;
			wr_rd_i =0;
			addr_i  =0;
			wdata_i =0;
			valid_i =0;
			repeat(2)@(posedge clk_i);
			rst_i=0;
		end
	endtask
//memory write task
	task write_mem(input integer start_loc,input integer end_loc);
		begin
			for(i=start_loc;i<end_loc; i=i+1)begin
				@(posedge clk_i);
				valid_i=1;
				wr_rd_i=1;
				addr_i =i;
				wdata_i=$random;
				wait(ready_o==1);
				$display("Adress=%d Write_data=%0h",addr_i,wdata_i);
			end
				@(posedge clk_i);
				valid_i=0;
				wr_rd_i=0;
				addr_i =0;
				wdata_i=0;
		end
	endtask

//memory read task
	task read_mem(input integer start_loc,input integer end_loc);
		begin
			for(i=start_loc;i<end_loc;i=i+1)begin
				@(posedge clk_i);
				valid_i=1;
				wr_rd_i=0;
				addr_i =i;
				wait(ready_o==1);
				#1;
				$display("Address=%d Read_data=%0h",addr_i,rdata_o);
			end
				@(posedge clk_i);
				valid_i=0;
				wr_rd_i=0;
				addr_i =0;
		end
	endtask
//memory back dorr access
//back_door_write_task
	task mem_bd_write();
		begin
			$readmemh("data.hex",dut.mem);
		end
	endtask

//back_door_read_tesk
	task mem_bd_read();
		begin
			$writememb("output.bin",dut.mem);
		end
	endtask
    
endmodule

