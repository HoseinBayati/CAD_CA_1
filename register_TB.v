`timescale 1ns/1ns

module register_TB();
	reg [31:0] in;
	reg clk, rst, en;
	wire [31:0] out;

	register r(.clk(clk), .rst(rst), .en(en), .in(in), .out(out));

	always begin 
		#10 clk = ~clk;
	end

	initial begin
	clk = 0;
	rst = 1;
	en = 0;
	in = 0;
	#10 rst = 0;
	#15
	en = 1;
	in = 32'd13;
	#10 en = 0;
	#5 in = 32'd335;
	#20 en = 1;
	#10 en = 0;
	
	#40;
	$stop;
	end

endmodule
