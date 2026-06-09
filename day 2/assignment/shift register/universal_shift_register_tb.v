`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09.06.2026 16:38:18
// Design Name: 
// Module Name: universal_shift_register_tb
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


`timescale 1ns/1ps

module universal_shift_register_tb;

reg clk;
reg reset;
reg [1:0] sel;
reg serial_in_left;
reg serial_in_right;
reg [3:0] parallel_in;

wire [3:0] q;

universal_shift_register uut (
    .clk(clk),
    .reset(reset),
    .sel(sel),
    .serial_in_left(serial_in_left),
    .serial_in_right(serial_in_right),
    .parallel_in(parallel_in),
    .q(q)
);

always #5 clk = ~clk;

initial
begin
    clk = 0;
    reset = 1;
    sel = 2'b00;
    serial_in_left = 0;
    serial_in_right = 0;
    parallel_in = 4'b0000;

    #10 reset = 0;

    // Parallel Load
    sel = 2'b11;
    parallel_in = 4'b1010;
    #10;

    // Hold
    sel = 2'b00;
    #10;

    // Shift Right
    sel = 2'b01;
    serial_in_right = 1;
    #10;

    // Shift Left
    sel = 2'b10;
    serial_in_left = 0;
    #10;

    #20 $finish;
end

endmodule
