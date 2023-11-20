`timescale 1ns/1ns

module max_net_TB();

    reg clk, rst, start;
    reg [31:0] x_init_1, x_init_2, x_init_3, x_init_4;
    wire done;
    wire [3:0] out;

    max_net mn(
        .clk(clk), 
        .rst(rst), 
        .start(start), 
        .x_init_1(x_init_1), 
        .x_init_2(x_init_2), 
        .x_init_3(x_init_3), 
        .x_init_4(x_init_4), 
        .done(done), 
        .out(out)
    );

    always begin
        #20 clk = ~clk;
    end

    initial begin
        clk = 1'b0;
        rst = 1'b1;
        start = 1'b0;
        
        #19 
        rst = 1'b0; 
        start = 1'b1;
        
        #17 
        x_init_1 = 32'b00111110010011001100110011001101; // 0.2
        x_init_2 = 32'b00111110110011001100110011001101; // 0.4
        x_init_3 = 32'b00111111000110011001100110011010; // 0.6
        x_init_4 = 32'b00111111010011001100110011001101; // 0.8
         
	#20 
	start = 1'b0;

	#1000
	start = 1'b1;
	x_init_1 = 32'b10110010010011001101110011001101; // 0.2
        x_init_2 = 32'b00111111110011001111111011001101; // 0.4
        x_init_3 = 32'b00000111000110011001101110011010; // 0.6
        x_init_4 = 32'b00110111010011001100000011001101; // 0.8	
	
	#20
	start = 1'b0;

        #10000
        $stop;
    end

endmodule