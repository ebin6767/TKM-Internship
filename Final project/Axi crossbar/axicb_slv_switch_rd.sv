            i_arready = '0;
            for (int i = 0; i < SLV_NB; i++)
                if (slv_ar_targeted[i])
                    i_arready = o_arready[i] & !rch_full;
    end

    assign o_arch = i_arch;

    assign ar_misrouting_c = slv_ar_targeted=='0;

    // Create a fake ready handshake in case a master agent targets a
    // forbidden or undefined memory space
    always @ (posedge aclk or negedge aresetn) begin
        if (!aresetn) begin
            ar_misrouting <= 1'b0;
        end else if (srst) begin
            ar_misrouting <= 1'b0;
        end else begin
            if (ar_misrouting) begin
                ar_misrouting <= 1'b0;
            end else if (i_arvalid && ar_misrouting_c) begin
                ar_misrouting <= 1'b1;
            end
        end
    end

    ///////////////////////////////////////////////////////////////////////////
    // Read Data Channel
    ///////////////////////////////////////////////////////////////////////////

    generate
    if (AXI_SIGNALING) begin: AXI4_ALEN
        assign a_len = i_arch[AXI_ADDR_W+AXI_ID_W+:8];
    end else begin: AXI4LITE_ALEN0
        assign a_len = '0;
    end
    endgenerate

    // OoO ID Management
    axicb_slv_ooo
    #(
        .RD_PATH         (1),
        .AXI_ID_W        (AXI_ID_W),
        .SLV_NB          (SLV_NB),
        .MST_OSTDREQ_NUM (MST_OSTDREQ_NUM),
        .MST_ID_MASK     (MST_ID_MASK),
        .CCH_W           (RCH_W)
    )
    rresp_ooo
    (
        .aclk    (aclk),
        .aresetn (aresetn),
        .srst    (srst),
        .a_valid (i_arvalid),
        .a_ready (i_arready),
        .a_full  (rch_full),
        .a_id    (i_arch[AXI_ADDR_W+:AXI_ID_W]),
        .a_len   (a_len),
        .a_ix    (slv_ar_targeted),
        .a_mr    (ar_misrouting_c),
        .c_en    (rch_en),
        .c_grant (rch_grant),
        .c_mr    (rch_mr),
        .c_id    (rch_id),
        .c_len   (rch_len),
        .c_valid (o_rvalid),
        .c_ready (i_rready),
        .c_ch    (o_rch),
        .c_end   (c_end)
    );


    assign c_end = i_rvalid & i_rready & i_rlast;

    // Follow-up completion len for misrouted traffic
    // to create RLAST flag
    always @ (posedge aclk or negedge aresetn) begin
        if (!aresetn) begin
            rlen <= 8'h0;
        end else if (srst) begin
            rlen <= 8'h0;
        end else begin

            if (i_rvalid && i_rready && i_rlast) begin
                rlen <= 8'h0;
            end else begin
                if (i_rvalid && i_rready) begin
                    rlen <= rlen + 1'b1;
                end
            end
        end
    end

    // Indicates the first read completion dataphase
    always @ (posedge aclk or negedge aresetn) begin
        if (!aresetn) begin
            rfirst <= 1'b1;
        end else if (srst) begin
            rfirst <= 1'b1;
        end else begin
            if (i_rvalid && i_rready) begin
                if (i_rlast) rfirst <= 1'b1;
                else         rfirst <= 1'b0;
            end
        end
    end

    // Activates the arbiter in OoO module on first read completion dataphase
    assign rch_en = rfirst;

    // Switching logic for RRESP channel

    always_comb begin

        i_rvalid = '0;
        i_rlast = '0;
        i_rch = '0;

        // RVALID Signal
        if (rch_mr)
            i_rvalid = '1;
        else if (rch_grant == '0)
            i_rvalid = '0;
        else
            for (int i=0;i<SLV_NB;i++)
                if (rch_grant[i])
                    i_rvalid = o_rvalid[i];

        // RLAST Signal
        if (rch_mr)
            i_rlast = (rlen==rch_len) & i_rvalid & i_rready;
        else if (rch_grant == '0)
            i_rlast = '0;
        else
            for (int i=0;i<SLV_NB;i++)
                if (rch_grant[i])
                    i_rlast = o_rlast[i];

        // RRESP / RDATA / RUSER
        if (rch_mr)
            i_rch = {'0, 2'h3, rch_id} ;
        else if (rch_grant == '0)
            i_rch = '0;
        else
            for (int i=0;i<SLV_NB;i++)
                if (rch_grant[i])
                    i_rch = o_rch[i*RCH_W+:RCH_W];
    end

    generate
    genvar m;
        for (m = 0; m < SLV_NB; m = m + 1) begin : SLV_R_READY
            assign o_rready[m] = rch_grant[m] & i_rready & !rch_mr;
        end
    endgenerate

endmodule

`resetall
