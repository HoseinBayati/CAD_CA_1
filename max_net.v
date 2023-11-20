`timescale 1ns/1ns

module max_net(clk, rst, start, x_init_1, x_init_2, x_init_3, x_init_4, done, out);

    input clk, rst, start;
    input [31:0]  x_init_1, x_init_2, x_init_3, x_init_4;

    output done;
    output [3:0] out;

    wire en_x, en_w, init_mux, en_pu, en_a;

    controller ctrl(
        .clk(clk), 
        .rst(rst), 
        .start(start),
        .done(done), 
        .en_x(en_x), 
        .en_w(en_w), 
        .init_mux(init_mux), 
        .en_pu(en_pu), 
        .en_a(en_a)
    );

    datapath dp(
        .clk(clk), 
        .rst(rst), 
        .init_mux(init_mux), 
        .en_x(en_x), 
        .en_w(en_w), 
        .en_pu(en_pu), 
        .en_a(en_a), 
        .x_init_1(x_init_1), 
        .x_init_2(x_init_2), 
        .x_init_3(x_init_3), 
        .x_init_4(x_init_4), 
        .done(done), 
        .out(out)
    );



endmodule
