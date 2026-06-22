    ///////////////////////////////////////////////////////////////////////////
    // Read Address Channel
    ///////////////////////////////////////////////////////////////////////////

    axicb_scfifo
    #(
    .PASS_THRU  (PASS_THRU),
    .ADDR_WIDTH (AR_ASIZE),
    .DATA_WIDTH (ARCH_W)
    )
    ar_scfifo
    (
    .aclk     (i_aclk),
    .aresetn  (i_aresetn),
    .srst     (i_srst),
    .flush    (1'b0),
    .data_in  (arch),
    .push     (i_arvalid),
    .full     (ar_full),
    .data_out (arch_f),
    .pull     (o_arready),
    .empty    (ar_empty)
    );

    assign i_arready = ~ar_full;
    assign o_arvalid = ~ar_empty;

    always @ (*) begin
        o_arch[AXI_ADDR_W +: (ARCH_W-AXI_ADDR_W)] = arch_f[AXI_ADDR_W +: (ARCH_W-AXI_ADDR_W)];
        // tied off ARADDR to avoid x in switches
        o_arch[0 +: AXI_ADDR_W] = (ar_empty) ? '0 : arch_f[0 +: AXI_ADDR_W];;
    end

    ///////////////////////////////////////////////////////////////////////////
    // Read Data Channel
    ///////////////////////////////////////////////////////////////////////////

    axicb_scfifo
    #(
    .PASS_THRU  (PASS_THRU),
    .ADDR_WIDTH (R_ASIZE),
    .DATA_WIDTH (RCH_W+1)
    )
    r_scfifo
    (
    .aclk     (o_aclk),
    .aresetn  (o_aresetn),
    .srst     (o_srst),
    .flush    (1'b0),
    .data_in  ({o_rlast,o_rch}),
    .push     (o_rvalid),
    .full     (r_full),
    .data_out ({i_rlast, rch}),
    .pull     (i_rready),
    .empty    (r_empty)
    );

    assign i_rvalid = ~r_empty;
    assign o_rready = ~r_full;


    ///////////////////////////////////////////////////////////////////////////
    ///////////////////////////////////////////////////////////////////////////
    end else begin: NO_CDC_NO_BUFFERING
    ///////////////////////////////////////////////////////////////////////////
    ///////////////////////////////////////////////////////////////////////////

    assign o_awvalid = i_awvalid;
    assign i_awready = o_awready;

    assign o_awch = awch;

    assign o_wvalid = i_wvalid;
    assign i_wready = o_wready;
    assign o_wlast = wlast;

    assign o_wch = wch;

    assign i_bvalid = o_bvalid;
    assign o_bready = i_bready;

    assign bch = o_bch;

    assign o_arvalid = i_arvalid;
    assign i_arready = o_arready;

    assign o_arch = arch;

    assign i_rvalid = o_rvalid;
    assign o_rready = i_rready;
    assign i_rlast = o_rlast;

    assign rch = o_rch;

    end

    endgenerate

endmodule

`resetall
