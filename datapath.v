`timescale 1ns/1ns

module datapath(clk, rst, init_mux, en_x, en_w, en_pu, en_a, x_init_1, x_init_2, x_init_3, x_init_4, done, out);
	input clk, rst, init_mux, en_x, en_w, en_pu, en_a;
	input [31:0] x_init_1, x_init_2, x_init_3, x_init_4;

	output done;
	output [3:0] out;

	wire [31:0] x_in_1, x_in_2, x_in_3, x_in_4;
	wire [31:0] x1, x2, x3, x4;
	wire [31:0] one, epsilon;
	wire [31:0] one_in, epsilon_in;
	wire [31:0] pu_out_1, pu_out_2, pu_out_3, pu_out_4;
	wire [31:0] a1, a2, a3, a4;

	assign one_in = 32'h3f800000; // one
	assign epsilon_in = 32'hbe4ccccd; // 0.2

	mux_2 mux1(.in_0(a1), .in_1(x_init_1), .select(init_mux), .out(x_in_1));
	mux_2 mux2(.in_0(a2), .in_1(x_init_2), .select(init_mux), .out(x_in_2));
	mux_2 mux3(.in_0(a3), .in_1(x_init_3), .select(init_mux), .out(x_in_3));
	mux_2 mux4(.in_0(a4), .in_1(x_init_4), .select(init_mux), .out(x_in_4));

	register xr1(.clk(clk), .rst(rst), .en(en_x), .in(x_in_1), .out(x1));
	register xr2(.clk(clk), .rst(rst), .en(en_x), .in(x_in_2), .out(x2));
	register xr3(.clk(clk), .rst(rst), .en(en_x), .in(x_in_3), .out(x3));
	register xr4(.clk(clk), .rst(rst), .en(en_x), .in(x_in_4), .out(x4));

	register one_reg(.clk(clk), .rst(rst), .en(en_w), .in(one_in), .out(one));
	register epsilon_reg(.clk(clk), .rst(rst), .en(en_w), .in(epsilon_in), .out(epsilon));

	pu pu1(.clk(clk), .rst(rst), .en(en_pu), .x1(x1), .x2(x2), .x3(x3), .x4(x4), .w1(one), .w2(epsilon), .w3(epsilon), .w4(epsilon), .out(pu_out_1));
	pu pu2(.clk(clk), .rst(rst), .en(en_pu), .x1(x2), .x2(x1), .x3(x3), .x4(x4), .w1(one), .w2(epsilon), .w3(epsilon), .w4(epsilon), .out(pu_out_2));
	pu pu3(.clk(clk), .rst(rst), .en(en_pu), .x1(x3), .x2(x2), .x3(x2), .x4(x4), .w1(one), .w2(epsilon), .w3(epsilon), .w4(epsilon), .out(pu_out_3));
	pu pu4(.clk(clk), .rst(rst), .en(en_pu), .x1(x4), .x2(x2), .x3(x3), .x4(x1), .w1(one), .w2(epsilon), .w3(epsilon), .w4(epsilon), .out(pu_out_4));

	register ar1(.clk(clk), .rst(rst), .en(en_a), .in(pu_out_1), .out(a1));
	register ar2(.clk(clk), .rst(rst), .en(en_a), .in(pu_out_2), .out(a2));
	register ar3(.clk(clk), .rst(rst), .en(en_a), .in(pu_out_3), .out(a3));
	register ar4(.clk(clk), .rst(rst), .en(en_a), .in(pu_out_4), .out(a4));

	zero_comparator z1(.in(a1), .gt(out[0]));
	zero_comparator z2(.in(a2), .gt(out[1]));
	zero_comparator z3(.in(a3), .gt(out[2]));
	zero_comparator z4(.in(a4), .gt(out[3]));


	sso single_one_observer(.in_1(out[0]), .in_2(out[1]), .in_3(out[2]), .in_4(out[3]), .out(done));
endmodule