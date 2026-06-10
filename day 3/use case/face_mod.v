`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10.06.2026 21:13:53
// Design Name: 
// Module Name: face_mod
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


module face_mod(input clk,
    input [7:0] S_in,
    output reg [7:0] S_out,
    output reg wr_en
);
    always @(posedge clk) begin
        S_out <= S_in;
        wr_en <= 1'b1;
    end
endmodule
