`timescale 1ns/1ns

module controller(clk, rst, start, done, en_x, en_w, init_mux, en_pu, en_a);
    input  clk, start, rst, done;
    output reg en_x, en_w, init_mux, en_pu, en_a;

    parameter IDLE = 3'd0, INIT = 3'd1, MULTIPLY = 3'd2, ADD_AND_ACTIVATION = 3'd3, WRITE = 3'd4;

    reg[2:0] ps, ns;

    always @ (*) begin
        case (ps)
            IDLE: 
            begin
                ns = start ? INIT: IDLE;
            end
            INIT: 
            begin
                ns = MULTIPLY;
            end
            MULTIPLY: 
            begin
                ns = ADD_AND_ACTIVATION;
            end
            ADD_AND_ACTIVATION: 
            begin
                ns = WRITE;
            end
            WRITE: 
            begin
                ns = done ? IDLE: MULTIPLY;
            end
            default:
                ns = IDLE;
        endcase
    end

    always @ (*) begin
        en_x = 1'b0;
        en_w = 1'b0;
        init_mux = 1'b0;
        en_pu = 1'b0;
        en_a = 1'b0;
        
        case (ps)
            IDLE: 
                begin  
                end
            INIT: 
                begin
                    en_x = 1'b1;
                    en_w = 1'b1;
                    init_mux = 1'b1;
                end
            MULTIPLY: 
                begin
                    en_pu = 1'b1;
                end
            ADD_AND_ACTIVATION: 
                begin
                    en_a = 1'b1;
                end
            WRITE: 
                begin
                    en_x = 1'b1;
                end
        endcase
    end
    
    always @ (posedge clk or posedge rst) begin
        if (rst) 
            ps <= IDLE;
        else 
            ps <= ns;
    end

endmodule