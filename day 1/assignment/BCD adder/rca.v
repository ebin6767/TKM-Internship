`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09.06.2026 12:47:19
// Design Name: 
// Module Name: rca
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


module rca_4bit (
    input [3:0] A,
    input [3:0] B,
    input cin,
    output [3:0] S,
    output cout
);
    wire c1, c2, c3;
    full_adder fa0 (A[0], B[0], cin, S[0], c1);
    full_adder fa1 (A[1], B[1], c1,  S[1], c2);
    full_adder fa2 (A[2], B[2], c2,  S[2], c3);
    full_adder fa3 (A[3], B[3], c3,  S[3], cout);
endmodule
