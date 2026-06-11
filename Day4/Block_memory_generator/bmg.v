`timescale 1ns / 1ps


module block_ram_8x8 (
    input  clk, 
    input  arstn, 
    input  wr_enb, 
    input  [7:0] wr_address, 
    input  [7:0] rd_address, 
    input  [7:0] data_in, 
    output reg [7:0] data_out );
    reg [7:0] ram [0:255];
     integer i;
    always @(posedge clk or negedge arstn) begin
        if (!arstn) begin
            data_out <= 8'b0;
            for (i = 0; i < 256; i = i + 1) begin
                ram[i] <= 8'b0;
            end
        end
        else
        begin
            if (wr_enb == 1'b1) begin
                ram[wr_address] <= data_in;
            end
            if (wr_enb == 1'b0) begin
                data_out <= ram[rd_address];
            end
        end
    end

endmodule
