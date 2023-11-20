`timescale 1ns/1ns

module zero_comparator(in, gt);
	input [31:0] in;
	output gt;

	assign gt = in > 0 ? 1 : 0;
endmodule
