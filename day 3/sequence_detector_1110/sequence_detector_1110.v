`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10.06.2026 11:37:43
// Design Name: 
// Module Name: sequence_detector_1110
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


module sequence_detector_1110(
    input clk,
    input rst,
    input din,
    output reg detected
);

parameter idle = 2'b00;
parameter s1   = 2'b01;
parameter s2   = 2'b10;
parameter s3   = 2'b11;

reg [1:0] ps, ns;

// Present state logic
always @(posedge clk) begin
    if (rst)
        ps <= idle;
    else
        ps <= ns;
end

// Next state logic
always @(*) begin
    ns = ps;
    detected = 0;

    case(ps)

        idle: begin
            if(din)
                ns = s1;
            else
                ns = idle;
        end

        s1: begin
            if(din)
                ns = s2;
            else
                ns = idle;
        end

        s2: begin
            if(din)
                ns = s3;
            else
                ns = idle;
        end

        s3: begin
            if(din)
                ns = s3;      
            else begin
                ns = idle;
                detected = 1; 
            end
        end

    endcase
end

endmodule
