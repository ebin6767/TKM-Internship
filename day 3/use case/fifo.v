`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10.06.2026 21:12:56
// Design Name: 
// Module Name: fifo
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


module fifo(input clk, rst, wr_en, rd_en,
    input [7:0] data_in,
    output reg [7:0] data_out,
    output full, empty
);
    
    reg [7:0] mem [7:0]; // ???????? 8 ??? ??????????????
    reg [2:0] wr_ptr = 0;
    reg [2:0] rd_ptr = 0;

    assign full = ((wr_ptr + 3'b001) == rd_ptr) ? 1'b1 : 1'b0;
    assign empty = (wr_ptr == rd_ptr) ? 1'b1 : 1'b0;

    always @(posedge clk) begin
        if(rst) begin
            wr_ptr <= 0;
            rd_ptr <= 0;
            data_out <= 0;
            // ??????? ???????? ????????? for-loop ?????????!
        end
        else begin
            if(wr_en == 1 && full == 0) begin
                mem[wr_ptr] <= data_in;
                wr_ptr <= wr_ptr + 3'b001;
            end
            
            if(rd_en == 1 && empty == 0) begin
                data_out <= mem[rd_ptr];
                rd_ptr <= rd_ptr + 3'b001;
            end
        end
    end 
endmodule
