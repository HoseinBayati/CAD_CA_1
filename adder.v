`timescale 1ns/1ns

module adder(a, b, result);
	input [31:0] a,b;
	output reg [31:0] result;


	wire sign_a = a[31];
 	wire sign_b = b[31];
	wire [23:0] complete_mantissa_a = {1'b1, a[22:0]};
	wire [23:0] complete_mantissa_b = {1'b1, b[22:0]};
	wire [7:0] exp_a = a[30:23];
	wire [7:0] exp_b = b[30:23];
	
	reg sign_r;
	reg [7:0] exp_g;
	reg [7:0] exp_r;
	reg [24:0] sum_mantissa;
	reg [7:0] diff_exp;
	reg [23:0] shifted_mantissa;
	reg [22:0] mantissa_r;
	reg [24:0] shifted_sum_mantissa;

	integer i = 24;
	integer first_one = 0;

	always @(*) begin
		diff_exp = exp_a > exp_b ? exp_a - exp_b : exp_b - exp_a;
		if (exp_a > exp_b) begin
			shifted_mantissa = complete_mantissa_b >> diff_exp;
			sum_mantissa = sign_a != sign_b ? complete_mantissa_a - shifted_mantissa : complete_mantissa_a + shifted_mantissa;
			sign_r = sign_a;
			exp_g = exp_a;
		end else if (exp_b > exp_a) begin
			shifted_mantissa = complete_mantissa_a >> diff_exp;
			sum_mantissa = sign_a != sign_b ? complete_mantissa_b - shifted_mantissa : complete_mantissa_b + shifted_mantissa;
			sign_r = sign_b;
			exp_g = exp_b;
		end else begin
			sum_mantissa = sign_a == sign_b ? (complete_mantissa_a + complete_mantissa_b) :
						(complete_mantissa_a > complete_mantissa_b ? 
						(complete_mantissa_a - complete_mantissa_b) : 
						(complete_mantissa_b - complete_mantissa_a));
			sign_r = complete_mantissa_a > complete_mantissa_b ? sign_a : sign_b;
			exp_g = exp_a;
		end
			
		i = 24;
		first_one = 0;
		while (i >= 0) begin
			if (sum_mantissa[i] == 1'b1) begin
				first_one = i;
				i = -1;
			end
			i = i - 1;
		end

		exp_r = exp_g - (23 - first_one);
		if (first_one == 24) shifted_sum_mantissa = sum_mantissa >> 1;
		else shifted_sum_mantissa = sum_mantissa << (23 - first_one);

		mantissa_r = shifted_sum_mantissa[22:0];

	 	result = {sign_r, exp_r, mantissa_r};
	end
endmodule
