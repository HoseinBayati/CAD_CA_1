`timescale 1ns/1ns

module sso(in_1, in_2, in_3, in_4, out);
	input in_1, in_2, in_3, in_4;
	output out;

	assign out = (in_1 + in_2 + in_3 + in_4) == 1;
endmodule