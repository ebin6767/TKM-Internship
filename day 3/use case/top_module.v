`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10.06.2026 21:06:58
// Design Name: 
// Module Name: top_module
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


module top_module(input clk,
    input rst,
    input [7:0] S_in,
    output [7:0] final_out
);
    wire [7:0] face_to_fifo_data;
    wire face_wr_en;
    wire fifo_empty_sig;
    wire fifo_full_sig;
    wire mod_rd_en;
    wire [7:0] fifo_to_mod_data;

    face_mod u1 (
        .clk(clk),
        .S_in(S_in),
        .S_out(face_to_fifo_data),
        .wr_en(face_wr_en)
    );

    fifo u2 (
        .clk(clk),
        .rst(rst),
        .wr_en(face_wr_en),
        .rd_en(mod_rd_en),
        .data_in(face_to_fifo_data),
        .data_out(fifo_to_mod_data),
        .full(fifo_full_sig),
        .empty(fifo_empty_sig)
    );

    mod_out u3 (
        .clk(clk),
        .rst(rst),
        .d_in(fifo_to_mod_data),
        .fifo_empty(fifo_empty_sig),
        .rd_en(mod_rd_en),
        .d_out(final_out)
    );
endmodule
