`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09.06.2026 12:48:51
// Design Name: 
// Module Name: bcdadder
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


module bcd_adder (
    input [3:0] A,     
    input [3:0] B,    
    input cin,         
    output [3:0] Sum,  
    output cout       
);

    wire [3:0] rca1_sum;
    wire rca1_cout;
    wire [3:0] correction_bits;
    wire dummy_cout;
    
    rca_4bit rca1 (
        .A(A),
        .B(B),
        .cin(cin),
        .S(rca1_sum),
        .cout(rca1_cout)
    );
    assign cout = rca1_cout | (rca1_sum[3] & rca1_sum[2]) | (rca1_sum[3] & rca1_sum[1]);
    assign correction_bits = {1'b0, cout, cout, 1'b0};
    rca_4bit rca2 (
        .A(rca1_sum),
        .B(correction_bits),
        .cin(1'b0),            
        .S(Sum),
        .cout(dummy_cout)      
    );
endmodule