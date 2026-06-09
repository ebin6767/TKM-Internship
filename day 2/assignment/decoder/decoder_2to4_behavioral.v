`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09.06.2026 16:23:38
// Design Name: 
// Module Name: decoder_2to4_behavioral
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


module decoder_2to4_behavioral (
    input wire [1:0] in,   // 2-bit input selection
    input wire en,         // Enable signal (active high)
    output reg [3:0] out   // 4-bit output
);

    always @(*) begin
        if (!en) begin
            out = 4'b0000; // If disabled, all outputs are 0
        end else begin
            case (in)
                2'b00: out = 4'b0001;
                2'b01: out = 4'b0010;
                2'b10: out = 4'b0100;
                2'b11: out = 4'b1000;
                default: out = 4'b0000;
            endcase
        end
    end

endmodule