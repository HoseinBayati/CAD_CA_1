`timescale 1ns/1ns

module mux_2(in_0, in_1, select, out);
	input [31:0] in_0, in_1;
	input select;
	output [31:0] out;

	assign out = select ? in_1 : in_0;
endmodule