`timescale 1ns/1ns

module multiplier(a, b, result);
	input [31:0] a,b;
	output reg [31:0] result;

	wire sign_a = a[31];
 	wire sign_b = b[31];
	wire [22:0] mantissa_a = a[22:0];
	wire [22:0] mantissa_b = b[22:0];
	wire [7:0] exp_a = a[30:23];
	wire [7:0] exp_b = b[30:23];
	
	reg sign_r;
	reg [7:0] exp_r;
	reg [47:0] mantissa_r;

	always @(*) begin
		sign_r = sign_a ^ sign_b;
		if (a == 0 || b == 0) result = 0;
		else if (a == 32'h7F800000 || b == 32'h7F800000 || a == 32'hFF800000 || b == 32'hFF800000) begin
			result = {sign_r, 8'hFF, 23'b0};
		end
		else begin
			exp_r = exp_a + exp_b - 127;
			mantissa_r = {1'b1, mantissa_a} * {1'b1, mantissa_b};
	
			if (mantissa_r[47] == 1'b1) begin
				mantissa_r = mantissa_r >> 1;
				exp_r = exp_r + 1;
			end

			result = {sign_r, exp_r, mantissa_r[45:23]};
		end
	end
endmodule