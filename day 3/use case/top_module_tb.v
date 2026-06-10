`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10.06.2026 21:15:26
// Design Name: 
// Module Name: top_module_tb
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


module top_module_tb;
reg clk;
    reg rst;
    reg [7:0] S_in;
    wire [7:0] final_out;

    top_module uut (
        .clk(clk),
        .rst(rst),
        .S_in(S_in),
        .final_out(final_out)
    );

    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin
        rst = 1;
        S_in = 0;
        #20;
        
        rst = 0;
        #10;
        
        S_in = 8'hD1; #10;
        S_in = 8'hD2; #10;
        S_in = 8'hD3; #10;
        S_in = 8'hD4; #10;
        S_in = 8'hD5; #10;
        
        S_in = 8'h00;
        
        #300;
        $finish;
    end
endmodule
