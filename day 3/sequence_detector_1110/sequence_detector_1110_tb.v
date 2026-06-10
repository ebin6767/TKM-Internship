`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10.06.2026 11:39:51
// Design Name: 
// Module Name: sequence_detector_1110_tb
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

module sequence_detector_1110_tb;

reg clk;
reg rst;
reg din;
wire detected;

// Instantiate DUT
sequence_detector_1110 uut (
    .clk(clk),
    .rst(rst),
    .din(din),
    .detected(detected)
);

// Clock generation (10 ns period)
always #5 clk = ~clk;

initial begin
    clk = 0;
    rst = 1;
    din = 0;

    // Reset
    #12;
    rst = 0;

    // Sequence 1110 (should detect)
    @(posedge clk) din = 1;
    @(posedge clk) din = 1;
    @(posedge clk) din = 1;
    @(posedge clk) din = 0;

    // Random bits
    @(posedge clk) din = 0;
    @(posedge clk) din = 1;
    @(posedge clk) din = 0;

    // Sequence 1110 again
    @(posedge clk) din = 1;
    @(posedge clk) din = 1;
    @(posedge clk) din = 1;
    @(posedge clk) din = 0;

    #20;
    $finish;
end

// Monitor values in console
initial begin
    $monitor("Time=%0t rst=%b din=%b detected=%b",
              $time, rst, din, detected);
end

endmodule
