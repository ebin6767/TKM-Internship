`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09.06.2026 15:48:32
// Design Name: 
// Module Name: d flip flop_tb
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

module d_flip_flop_tb;

reg clk;
reg d;
wire q;

d_flip_flop uut (
    .clk(clk),
    .d(d),
    .q(q)
);

always #5 clk = ~clk;

initial begin
    clk = 0;
    d = 0;

    #10 d = 1;
    #10 d = 0;
    #10 d = 1;
    #10 d = 0;

    #20 $finish;
end

endmodule
