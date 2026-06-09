`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09.06.2026 12:13:22
// Design Name: 
// Module Name: tb_ripple_carry_adder
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

module tb_ripple_carry_adder;

reg [3:0] a, b;
reg cin;
wire [3:0] sum;
wire cout;

ripple_carry_adder DUT (
    .a(a),
    .b(b),
    .cin(cin),
    .sum(sum),
    .cout(cout)
);

initial begin
    a = 4'b0000; b = 4'b0000; cin = 0;
    #10 a = 4'b0011; b = 4'b0101; cin = 0; // 3+5=8
    #10 a = 4'b0111; b = 4'b0001; cin = 0; // 7+1=8
    #10 a = 4'b1111; b = 4'b0001; cin = 0; // 15+1=16
    #10 a = 4'b1010; b = 4'b0101; cin = 1; // 10+5+1=16
    #10 $finish;
end

initial begin
    $monitor("Time=%0t A=%b B=%b Cin=%b Sum=%b Cout=%b",
              $time, a, b, cin, sum, cout);
end

endmodule