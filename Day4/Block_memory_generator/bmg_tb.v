`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11.06.2026 13:46:12
// Design Name: 
// Module Name: blockmemory_tb
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


module tb_block_ram_8x8;
    reg        clk;
    reg        arstn;
    reg        wr_enb;
    reg  [7:0] wr_address;
    reg  [7:0] rd_address;
    reg  [7:0] data_in;
    wire [7:0] data_out;
    block_ram_8x8 uut (
        .clk(clk),
        .arstn(arstn),
        .wr_enb(wr_enb),
        .wr_address(wr_address),
        .rd_address(rd_address),
        .data_in(data_in),
        .data_out(data_out)
    );
    always begin
        #5 clk = ~clk; 
    end
    initial begin
        clk = 0;
        arstn = 1;
        wr_enb = 0;
        wr_address = 8'b0;
        rd_address = 8'b0;
        data_in = 8'b0;
        #2;
        arstn = 0; 
        #15;       
        arstn = 1; 
        #10; 
        @(posedge clk);
        wr_enb = 1;
        wr_address = 8'd10;
        data_in = 8'hAA;
        @(posedge clk);
        wr_address = 8'd20;
        data_in = 8'hBB;
        @(posedge clk);
        wr_address = 8'd30;
        data_in = 8'hc;
        @(posedge clk);
        wr_enb = 0; 
        rd_address = 8'd10;
        @(posedge clk); 
        #1;          
        rd_address = 8'd20;
        @(posedge clk);
        #1;
        rd_address = 8'd30;
        @(posedge clk);
        #1;
        rd_address = 8'd50;
        @(posedge clk);
        #1;
        end
endmodule
