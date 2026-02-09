`include "asyn_fifo.v"
module top();
	parameter DEPTH=16;
	parameter DATA_WIDTH=10;
	parameter PTR_WIDTH=$clog2(DEPTH);

	reg wr_clk_i,rd_clk_i,rst_i,wr_en_i,rd_en_i;
	reg [DATA_WIDTH-1:0]wdata_i;
	wire [DATA_WIDTH-1:0]rdata_o;
	wire full_o,overflow_o,empty_o,underflow_o;
	integer wr_delay,rd_delay;
	integer i,k,j;
	reg [25*8:0] test;

	 asynch_fifo #(.DEPTH(DEPTH),.DATA_WIDTH(DATA_WIDTH)) dut(.wr_clk_i(wr_clk_i),.rd_clk_i(rd_clk_i),.rst_i(rst_i),
			      .wr_en_i(wr_en_i),.wdata_i(wdata_i),.full_o(full_o),.overflow_o(overflow_o),
				  .rd_en_i(rd_en_i),.rdata_o(rdata_o),.empty_o(empty_o),.underflow_o(underflow_o));

//clock generation
	initial begin
		wr_clk_i=0;
		forever #5 wr_clk_i=~wr_clk_i;
	end
	initial begin
		rd_clk_i=0;
		forever #8 rd_clk_i=~rd_clk_i;
	end
	initial begin
		reset_fifo();
		$value$plusargs("test=%s",test);
		case(test)
			"test_2_writes":begin
				write_fifo(0,2);
			end
			"test_2_reads":begin
				read_fifo(0,2);
			end
			"test_2_write_2_read":begin
				write_fifo(0,2);
				read_fifo(0,2);
			end
			"test_5_write_6_read":begin
				write_fifo(0,5);
				read_fifo(0,6);
			end
			"test_full_write":begin
				write_fifo(0,DEPTH-1);
			end
			"test_full_read":begin
				read_fifo(0,5);
			end
			"test_full_write_full_read":begin
				write_fifo(0,DEPTH-1);
				read_fifo(0,DEPTH-1);
			end
			"test_5_write_5_read":begin
				write_fifo(0,5);
				read_fifo(0,5);
			end
			"test_full_write_full_read":begin
				write_fifo(0,DEPTH);
				read_fifo(0,DEPTH);
			end
			"test_full":begin
				write_fifo(0,DEPTH);
			end
			"test_overflow":begin
				write_fifo(0,DEPTH+5);
			end
			"test_empty":begin
				write_fifo(0,DEPTH);
				read_fifo(0,DEPTH);
			end
			"test_underflow":begin
				write_fifo(0,DEPTH);
				read_fifo(0,DEPTH+8);
			end
			"test_over_underflow":begin
			write_fifo(0,DEPTH+5);
			read_fifo(0,DEPTH+5);
			end
			"test_concurrent":begin
				fork
					begin
						for(k=0;k<10;k=k+1)begin
							wr_delay=$urandom_range(1,10);
							repeat(wr_delay)@(posedge wr_clk_i);
							write_fifo(0,10);
						end
					end
						begin
						for(j=0;j<10;j=j+1)begin
							rd_delay=$urandom_range(1,10);
							repeat(rd_delay)@(posedge rd_clk_i);
							read_fifo(0,10);
						end
					end

				join
			end
		endcase
	//	write_fifo();
	//	read_fifo();
		#100;
		$finish();
	end

	task reset_fifo();
		begin
			rst_i=1;
			wr_en_i=0;
			rd_en_i=0;
			wdata_i=0;
			repeat(2)@(posedge wr_clk_i);
			rst_i=0;
		end
	endtask
	task write_fifo(input integer start_loc,input integer end_loc);
		begin
			for(i=start_loc;i<end_loc;i=i+1)begin
				@(posedge wr_clk_i);
				wr_en_i=1;
				wdata_i=$random;
			end
				@(posedge wr_clk_i);
				wr_en_i=0;
				wdata_i=0;
		end
	endtask
	task read_fifo(input integer start_loc,input integer end_loc);
		begin
			for(i=start_loc;i<end_loc;i=i+1)begin
				@(posedge rd_clk_i);
				rd_en_i=1;
			end
				@(posedge rd_clk_i);
				rd_en_i=0;
			end
	endtask

endmodule
