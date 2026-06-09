`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09.06.2026 16:18:45
// Design Name: 
// Module Name: sr_flip_flop_tb
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


module sr_flip_flop_tb;

reg clk;
reg s;
reg r;
wire q;

sr_flip_flop uut (
    .clk(clk),
    .s(s),
    .r(r),
    .q(q)
);

// Clock generation
always #5 clk = ~clk;

initial begin
    clk = 0;

    // Hold
    s = 0; r = 0;
    #10;

    // Set
    s = 1; r = 0;
    #10;

    // Hold
    s = 0; r = 0;
    #10;

    // Reset
    s = 0; r = 1;
    #10;

    // Hold
    s = 0; r = 0;
    #10;

    // Invalid
    s = 1; r = 1;
    #10;

    $finish;
end

endmodule
