module asynch_fifo(wr_clk_i,rd_clk_i,rst_i,
			      wr_en_i,wdata_i,full_o,overflow_o,
				  rd_en_i,rdata_o,empty_o,underflow_o);
	parameter DEPTH=16;
	parameter DATA_WIDTH=10;
	parameter PTR_WIDTH=$clog2(DEPTH);

	input wr_clk_i,rd_clk_i,rst_i,wr_en_i,rd_en_i;
	input [DATA_WIDTH-1:0]wdata_i;
	output reg [DATA_WIDTH-1:0]rdata_o;
	output reg full_o,overflow_o,empty_o,underflow_o;
//FIFO memory declaration	
	reg [DATA_WIDTH-1:0] fifo[DEPTH-1:0];
//internal registers
	reg[PTR_WIDTH-1:0]wr_ptr,rd_ptr;
	reg[PTR_WIDTH-1:0]wr_ptr_rd_clk,rd_ptr_wr_clk;
	reg wr_toggle_f_rd_clk,rd_toggle_f_wr_clk;

	reg wr_toggle_f,rd_toggle_f;
	integer i;
//FIFO functionality
	always@(posedge wr_clk_i)begin
		if(rst_i==1)begin
			rdata_o=0;
			full_o=0;
			empty_o=1;
			overflow_o=0;
			underflow_o=0;
			wr_ptr=0;
			wr_ptr_rd_clk=0;
			rd_ptr=0;
			rd_ptr_wr_clk=0;
			wr_toggle_f=0;
			wr_toggle_f_rd_clk=0;
			rd_toggle_f=0;
			rd_toggle_f_wr_clk=0;
			for(i=0;i<DEPTH;i=i+1)begin
				fifo[i]=0;
			end
		end
		else begin
			if(wr_en_i==1)begin
				if(full_o==1)begin
					overflow_o=1;
				end
				else begin
			       overflow_o=0;
					fifo[wr_ptr]=wdata_i;
					if(wr_ptr==DEPTH-1)begin
						wr_toggle_f=~wr_toggle_f;
					end
					wr_ptr=wr_ptr+1;
				end
			end
		end
	end
//FIFO read logic
		always@(posedge rd_clk_i)begin
			if(!rst_i)begin
				if(rd_en_i==1)begin
					if(empty_o==1)begin
						underflow_o=1;
					end
					else begin
			           underflow_o=0;
						rdata_o=fifo[rd_ptr];
						if(rd_ptr==DEPTH-1)begin
							rd_toggle_f=~rd_toggle_f;
						end
						rd_ptr=rd_ptr+1;
					end
				end
			end
		end

//synchnorization b/w the two clks
	always@(posedge rd_clk_i)begin
		wr_ptr_rd_clk=wr_ptr;
		wr_toggle_f_rd_clk=wr_toggle_f;
	end
	always@(posedge wr_clk_i)begin
		rd_ptr_wr_clk=rd_ptr;
		rd_toggle_f_wr_clk=rd_toggle_f;
	end
//full and empth conditions
	always@(*)begin
		full_o=0;
		empty_o=0;
		if(wr_ptr==rd_ptr_wr_clk && wr_toggle_f!=rd_toggle_f_wr_clk)begin
		full_o=1;
		end
		if(wr_ptr_rd_clk==rd_ptr && wr_toggle_f_rd_clk==rd_toggle_f)begin
		empty_o=1;
		end

	end
endmodule
