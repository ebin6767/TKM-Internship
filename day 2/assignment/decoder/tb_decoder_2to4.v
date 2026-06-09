`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09.06.2026 16:26:37
// Design Name: 
// Module Name: tb_decoder_2to4
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



module tb_decoder_2to4;
    reg [1:0] tb_in;
    reg tb_en;
    wire [3:0] tb_out;
    decoder_2to4_behavioral uut (
        .in(tb_in),
        .en(tb_en),
        .out(tb_out)
    );

    
    initial begin
       
       
        tb_en = 0;
        tb_in = 2'b00; #10;
        tb_in = 2'b01; #10;
        tb_in = 2'b10; #10;
        tb_in = 2'b11; #10;
        
        
        tb_en = 1;
        tb_in = 2'b00; #10; 
        tb_in = 2'b01; #10; 
        tb_in = 2'b10; #10; 
        tb_in = 2'b11; #10; 
        tb_en = 0;
        tb_in = 2'b10; #10;
    end

endmodule