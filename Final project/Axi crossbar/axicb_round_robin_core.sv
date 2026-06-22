        end else if (srst) begin
            mask <= '0;
        end else begin
            if (en && |grant) begin
                if      (grant[0]) mask <= 31'b1111111111111111111111111111110;
                else if (grant[1]) mask <= 31'b1111111111111111111111111111100;
                else if (grant[2]) mask <= 31'b1111111111111111111111111111000;
                else if (grant[3]) mask <= 31'b1111111111111111111111111110000;
                else if (grant[4]) mask <= 31'b1111111111111111111111111100000;
                else if (grant[5]) mask <= 31'b1111111111111111111111111000000;
                else if (grant[6]) mask <= 31'b1111111111111111111111110000000;
                else if (grant[7]) mask <= 31'b1111111111111111111111100000000;
                else if (grant[8]) mask <= 31'b1111111111111111111111000000000;
                else if (grant[9]) mask <= 31'b1111111111111111111110000000000;
                else if (grant[10]) mask <= 31'b1111111111111111111100000000000;
                else if (grant[11]) mask <= 31'b1111111111111111111000000000000;
                else if (grant[12]) mask <= 31'b1111111111111111110000000000000;
                else if (grant[13]) mask <= 31'b1111111111111111100000000000000;
                else if (grant[14]) mask <= 31'b1111111111111111000000000000000;
                else if (grant[15]) mask <= 31'b1111111111111110000000000000000;
                else if (grant[16]) mask <= 31'b1111111111111100000000000000000;
                else if (grant[17]) mask <= 31'b1111111111111000000000000000000;
                else if (grant[18]) mask <= 31'b1111111111110000000000000000000;
                else if (grant[19]) mask <= 31'b1111111111100000000000000000000;
                else if (grant[20]) mask <= 31'b1111111111000000000000000000000;
                else if (grant[21]) mask <= 31'b1111111110000000000000000000000;
                else if (grant[22]) mask <= 31'b1111111100000000000000000000000;
                else if (grant[23]) mask <= 31'b1111111000000000000000000000000;
                else if (grant[24]) mask <= 31'b1111110000000000000000000000000;
                else if (grant[25]) mask <= 31'b1111100000000000000000000000000;
                else if (grant[26]) mask <= 31'b1111000000000000000000000000000;
                else if (grant[27]) mask <= 31'b1110000000000000000000000000000;
                else if (grant[28]) mask <= 31'b1100000000000000000000000000000;
                else if (grant[29]) mask <= 31'b1000000000000000000000000000000;
                else if (grant[30]) mask <= '1;
            end
        end
    end

    end
    
    if (REQ_NB==32) begin : GRANT_32

    // Compute the requester granted based on mask state
    always @ (*) begin

        // 1. Applies the mask and init the granted output
        masked = mask & req;

        // 2. Zeroes the grants once found a first activated one

        // 2.1 handles first the reqs which fall into the mask
        if (|masked) begin
            if      (masked[0]) grant_c = 32'd1;
            else if (masked[1]) grant_c = 32'd2;
            else if (masked[2]) grant_c = 32'd4;
            else if (masked[3]) grant_c = 32'd8;
            else if (masked[4]) grant_c = 32'd16;
            else if (masked[5]) grant_c = 32'd32;
            else if (masked[6]) grant_c = 32'd64;
            else if (masked[7]) grant_c = 32'd128;
            else if (masked[8]) grant_c = 32'd256;
            else if (masked[9]) grant_c = 32'd512;
            else if (masked[10]) grant_c = 32'd1024;
            else if (masked[11]) grant_c = 32'd2048;
            else if (masked[12]) grant_c = 32'd4096;
            else if (masked[13]) grant_c = 32'd8192;
            else if (masked[14]) grant_c = 32'd16384;
            else if (masked[15]) grant_c = 32'd32768;
            else if (masked[16]) grant_c = 32'd65536;
            else if (masked[17]) grant_c = 32'd131072;
            else if (masked[18]) grant_c = 32'd262144;
            else if (masked[19]) grant_c = 32'd524288;
            else if (masked[20]) grant_c = 32'd1048576;
            else if (masked[21]) grant_c = 32'd2097152;
            else if (masked[22]) grant_c = 32'd4194304;
            else if (masked[23]) grant_c = 32'd8388608;
            else if (masked[24]) grant_c = 32'd16777216;
            else if (masked[25]) grant_c = 32'd33554432;
            else if (masked[26]) grant_c = 32'd67108864;
            else if (masked[27]) grant_c = 32'd134217728;
            else if (masked[28]) grant_c = 32'd268435456;
            else if (masked[29]) grant_c = 32'd536870912;
            else if (masked[30]) grant_c = 32'd1073741824;
            else if (masked[31]) grant_c = 32'd2147483648;
            else                grant_c = '0;

        // 2.2 if the mask doesn't match the reqs, uses the unmasked ones
        end else begin
            if      (req[0]) grant_c = 32'd1;
            else if (req[1]) grant_c = 32'd2;
            else if (req[2]) grant_c = 32'd4;
            else if (req[3]) grant_c = 32'd8;
            else if (req[4]) grant_c = 32'd16;
            else if (req[5]) grant_c = 32'd32;
            else if (req[6]) grant_c = 32'd64;
            else if (req[7]) grant_c = 32'd128;
            else if (req[8]) grant_c = 32'd256;
            else if (req[9]) grant_c = 32'd512;
            else if (req[10]) grant_c = 32'd1024;
            else if (req[11]) grant_c = 32'd2048;
            else if (req[12]) grant_c = 32'd4096;
            else if (req[13]) grant_c = 32'd8192;
            else if (req[14]) grant_c = 32'd16384;
            else if (req[15]) grant_c = 32'd32768;
            else if (req[16]) grant_c = 32'd65536;
            else if (req[17]) grant_c = 32'd131072;
            else if (req[18]) grant_c = 32'd262144;
            else if (req[19]) grant_c = 32'd524288;
            else if (req[20]) grant_c = 32'd1048576;
            else if (req[21]) grant_c = 32'd2097152;
            else if (req[22]) grant_c = 32'd4194304;
            else if (req[23]) grant_c = 32'd8388608;
            else if (req[24]) grant_c = 32'd16777216;
            else if (req[25]) grant_c = 32'd33554432;
            else if (req[26]) grant_c = 32'd67108864;
            else if (req[27]) grant_c = 32'd134217728;
            else if (req[28]) grant_c = 32'd268435456;
            else if (req[29]) grant_c = 32'd536870912;
            else if (req[30]) grant_c = 32'd1073741824;
            else if (req[31]) grant_c = 32'd2147483648;
            else             grant_c = '0;
        end
    end

    // Generate the next mask
    always @ (posedge aclk or negedge aresetn) begin : MASK_32

        if (!aresetn) begin
            mask <= '0;
        end else if (srst) begin
            mask <= '0;
        end else begin
            if (en && |grant) begin
                if      (grant[0]) mask <= 32'b11111111111111111111111111111110;
                else if (grant[1]) mask <= 32'b11111111111111111111111111111100;
                else if (grant[2]) mask <= 32'b11111111111111111111111111111000;
                else if (grant[3]) mask <= 32'b11111111111111111111111111110000;
                else if (grant[4]) mask <= 32'b11111111111111111111111111100000;
                else if (grant[5]) mask <= 32'b11111111111111111111111111000000;
                else if (grant[6]) mask <= 32'b11111111111111111111111110000000;
                else if (grant[7]) mask <= 32'b11111111111111111111111100000000;
                else if (grant[8]) mask <= 32'b11111111111111111111111000000000;
                else if (grant[9]) mask <= 32'b11111111111111111111110000000000;
                else if (grant[10]) mask <= 32'b11111111111111111111100000000000;
                else if (grant[11]) mask <= 32'b11111111111111111111000000000000;
                else if (grant[12]) mask <= 32'b11111111111111111110000000000000;
                else if (grant[13]) mask <= 32'b11111111111111111100000000000000;
                else if (grant[14]) mask <= 32'b11111111111111111000000000000000;
                else if (grant[15]) mask <= 32'b11111111111111110000000000000000;
                else if (grant[16]) mask <= 32'b11111111111111100000000000000000;
                else if (grant[17]) mask <= 32'b11111111111111000000000000000000;
                else if (grant[18]) mask <= 32'b11111111111110000000000000000000;
                else if (grant[19]) mask <= 32'b11111111111100000000000000000000;
                else if (grant[20]) mask <= 32'b11111111111000000000000000000000;
                else if (grant[21]) mask <= 32'b11111111110000000000000000000000;
                else if (grant[22]) mask <= 32'b11111111100000000000000000000000;
                else if (grant[23]) mask <= 32'b11111111000000000000000000000000;
                else if (grant[24]) mask <= 32'b11111110000000000000000000000000;
                else if (grant[25]) mask <= 32'b11111100000000000000000000000000;
                else if (grant[26]) mask <= 32'b11111000000000000000000000000000;
                else if (grant[27]) mask <= 32'b11110000000000000000000000000000;
                else if (grant[28]) mask <= 32'b11100000000000000000000000000000;
                else if (grant[29]) mask <= 32'b11000000000000000000000000000000;
                else if (grant[30]) mask <= 32'b10000000000000000000000000000000;
                else if (grant[31]) mask <= '1;
            end
        end
    end

    end
    
    endgenerate

    always @ (posedge aclk or negedge aresetn) begin
        if (!aresetn) begin
            grant_r <= '0;
        end else if (srst) begin
            grant_r <= '0;
        end else begin
            if (en) begin
                grant_r <= grant_c;
            end
        end
    end

    always @ (*) begin
        if (en)
            grant = grant_c;
        else
            grant = grant_r;
    end

endmodule

`resetall
