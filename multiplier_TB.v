
`timescale 1ns/1ns

module multiplier_TB();
	reg [31:0] operand_a, operand_b;
	wire [31:0] result;

	multiplier m(.a(operand_a), .b(operand_b), .result(result));

	initial begin
	operand_a = 32'h40490FDB; // 3.14
	operand_b = 32'h40A99999; // 5.1
	
	#40;
	operand_a = 32'hC0490FDB; // -3.14
	operand_b = 32'hC0A99999; // -5.1

	#40;
	operand_a = 32'h40490FDB; // 3.14
	operand_b = 32'hC0A99999; // -5.1

	#40;
	operand_a = 32'h40490FDB; // 3.14
	operand_b = 32'h00000000; // 0.0

	#40;
	operand_a = 32'h7F800000; // +inf
	operand_b = 32'h40490FDB; // 3.14

	#40;
	operand_a = 32'h00000001; // Smallest positive denormalized number
	operand_b = 32'hC0000001; // Smallest negative denormalized number


	#40;
	operand_a = 32'h7F7FFFFF; // Largest positive finite number
	operand_b = 32'h40490FDB; // 3.14


	#40;
	operand_a = 32'h00000001; // Smallest positive denormalized number
	operand_b = 32'h00000001; // Smallest positive denormalized number

	#40;
	$stop;
	end

endmodule