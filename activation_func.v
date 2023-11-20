`timescale 1ns/1ns

module activation_func(in, out);
	input [31:0] in;
	output [31:0] out;

	assign out = in[31] == 1 ? 32'b0 : in;
endmodule