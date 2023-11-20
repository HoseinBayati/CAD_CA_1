`timescale 1ns/1ns

module pu(clk, rst, en, x1, x2, x3, x4, w1, w2, w3, w4, out);
	input clk, rst, en;
	input [31:0] x1, x2, x3, x4, w1, w2, w3, w4;
	output [31:0] out;

	wire [31:0] m_in_1, m_in_2, m_in_3, m_in_4;
	wire [31:0] m_out_1, m_out_2, m_out_3, m_out_4;
	wire [31:0] a1, a2, a3;

	multiplier m1(.a(x1), .b(w1), .result(m_in_1));
	multiplier m2(.a(x2), .b(w2), .result(m_in_2));
	multiplier m3(.a(x3), .b(w3), .result(m_in_3));
	multiplier m4(.a(x4), .b(w4), .result(m_in_4));


	register mr1(.clk(clk), .rst(rst), .en(en), .in(m_in_1), .out(m_out_1));
	register mr2(.clk(clk), .rst(rst), .en(en), .in(m_in_2), .out(m_out_2));
	register mr3(.clk(clk), .rst(rst), .en(en), .in(m_in_3), .out(m_out_3));
	register mr4(.clk(clk), .rst(rst), .en(en), .in(m_in_4), .out(m_out_4));

	adder add1(.a(m_out_1), .b(m_out_2), .result(a1));
	adder add2(.a(m_out_3), .b(m_out_4), .result(a2));
	adder add3(.a(a1), .b(a2), .result(a3));

	activation_func af(.in(a3), .out(out));
	
endmodule
