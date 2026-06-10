`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10.06.2026 21:11:41
// Design Name: 
// Module Name: mod_out
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module mod_out(input clk, rst,
    input [7:0] d_in,
    input fifo_empty,
    output reg rd_en,
    output reg [7:0] d_out
);

    parameter IDLE      = 2'b00;
    parameter READ_PROC = 2'b01;
    parameter DONE      = 2'b10;

    reg [1:0] state = IDLE;

    always @(posedge clk) begin
        if (rst) begin
            state  <= IDLE;
            rd_en  <= 1'b0;
            d_out  <= 8'h0;
        end else begin
            case (state)
                IDLE: begin
                    if (!fifo_empty) begin
                        rd_en <= 1'b1;
                        state <= READ_PROC;
                    end else begin
                        rd_en <= 1'b0;
                    end
                end
                
                READ_PROC: begin
                    rd_en <= 1'b0;
                    state <= DONE;
                end
                
                DONE: begin
                    d_out <= d_in;
                    state <= IDLE;
                end
                
                default: state <= IDLE;
            endcase
        end
    end
endmodule
