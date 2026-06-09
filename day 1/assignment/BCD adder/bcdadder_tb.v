`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09.06.2026 12:50:35
// Design Name: 
// Module Name: bcdadder_tb
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


module tb_bcd_adder;
    reg [3:0] A;
    reg [3:0] B;
    reg cin;
    wire [3:0] Sum;
    wire cout;
    
    bcd_adder mygate(
        .A(A), 
        .B(B), 
        .cin(cin), 
        .Sum(Sum), 
        .cout(cout)
    );

    initial begin
        A = 4'd3; B = 4'd4; cin = 0; #10;
        A = 4'd7; B = 4'd6; cin = 0; #10;
        A = 4'd4; B = 4'd5; cin = 0; #10;
        A = 4'd9; B = 4'd9; cin = 1; #10;
    end
endmodule