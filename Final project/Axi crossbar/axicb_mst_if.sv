    // Write Data Channel
    ///////////////////////////////////////////////////////////////////////////

    axicb_scfifo
    #(
    .PASS_THRU  (PASS_THRU),
    .ADDR_WIDTH (W_ASIZE),
    .DATA_WIDTH (WCH_W+1)
    )
    w_scfifo
    (
    .aclk     (i_aclk),
    .aresetn  (i_aresetn),
    .srst     (i_srst),
    .flush    (1'b0),
    .data_in  ({i_wlast, i_wch}),
    .push     (i_wvalid),
    .full     (w_full),
    .data_out ({wlast_r, wch}),
    .pull     (o_wready),
    .empty    (w_empty)
    );
    assign i_wready = ~w_full;
    assign o_wvalid = ~w_empty;
    assign o_wlast = (w_empty) ? 1'b0 : wlast_r;

    ///////////////////////////////////////////////////////////////////////////
    // Write Response Channel
    ///////////////////////////////////////////////////////////////////////////

    axicb_scfifo
    #(
    .PASS_THRU  (PASS_THRU),
    .ADDR_WIDTH (B_ASIZE),
    .DATA_WIDTH (BCH_W)
    )
    b_scfifo
    (
    .aclk     (o_aclk),
    .aresetn  (o_aresetn),
    .srst     (o_srst),
    .flush    (1'b0),
    .data_in  (bch),
    .push     (o_bvalid),
    .full     (b_full),
    .data_out (bch_f),
    .pull     (i_bready),
    .empty    (b_empty)
    );

    assign i_bvalid = ~b_empty;
    assign i_bch = (b_empty) ? '0 : bch_f;
    assign o_bready = ~b_full;

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
    .data_in  (i_arch),
    .push     (i_arvalid),
    .full     (ar_full),
    .data_out (arch),
    .pull     (o_arready),
    .empty    (ar_empty)
    );

    assign i_arready = ~ar_full;
    assign o_arvalid = ~ar_empty;

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
    .data_in  ({rlast, rch}),
    .push     (o_rvalid),
    .full     (r_full),
    .data_out ({rlast_r,rch_f}),
    .pull     (i_rready),
    .empty    (r_empty)
    );

    assign i_rvalid = ~r_empty;
    assign i_rlast = (r_empty) ? 1'b0 : rlast_r;
    assign o_rready = ~r_full;

    always @ (*) begin

        // +2 = RESP width
        i_rch[AXI_ID_W+2 +: (RCH_W-AXI_ID_W-2)] = rch_f[AXI_ID_W+2 +: (RCH_W-AXI_ID_W-2)];

        // Tied off ID and RESP to ensure correct values
        if (r_empty) begin
            i_rch[0 +: (AXI_ID_W+2)] = '0;
        end else begin
            i_rch[0 +: (AXI_ID_W+2)] = rch_f[0 +: (AXI_ID_W+2)];
        end
    end

    ///////////////////////////////////////////////////////////////////////////
    ///////////////////////////////////////////////////////////////////////////
    end else begin: NO_CDC_NO_BUFFERING
    ///////////////////////////////////////////////////////////////////////////
    ///////////////////////////////////////////////////////////////////////////

    assign o_awvalid = i_awvalid;
    assign i_awready = o_awready;
    assign awch = i_awch;

    assign o_wvalid = i_wvalid;
    assign i_wready = o_wready;
    assign o_wlast = i_wlast;

    assign wch = i_wch;

    assign i_bvalid = o_bvalid;
    assign o_bready = i_bready;
    assign i_bch = bch;

    assign o_arvalid = i_arvalid;
    assign i_arready = o_arready;
    assign arch = i_arch;

    assign i_rvalid = o_rvalid;
    assign o_rready = i_rready;
    assign i_rlast = rlast;
    assign i_rch = rch;

    end
    endgenerate

    generate

    if (AXI_SIGNALING==0) begin : AXI4LITE_MODE

        if (USER_SUPPORT>0 && AXI_AUSER_W>0) begin: AUSER_ON

            assign {
                o_awuser,
                o_awprot,
                o_awid,
                awaddr
            } = awch;

            assign {
                o_aruser,
                o_arprot,
                o_arid,
                araddr
            }  = arch;

            end else begin: AUSER_OFF

            assign {
                o_awprot,
                o_awid,
                awaddr
            } = awch;

            assign {
                o_arprot,
                o_arid,
                araddr
            }  = arch;

            end

        end else begin : AXI4_MODE

            if (USER_SUPPORT>0 && AXI_AUSER_W>0) begin: AUSER_ON

            assign {
                o_awuser,
                o_awregion,
                o_awqos,
                o_awprot,
                o_awcache,
                o_awlock,
                o_awburst,
                o_awsize,
                o_awlen,
                o_awid,
                awaddr
            } = awch;

            assign {
                o_aruser,
                o_arregion,
                o_arqos,
                o_arprot,
                o_arcache,
                o_arlock,
                o_arburst,
                o_arsize,
                o_arlen,
                o_arid,
                araddr
            } = arch;

            end else begin: AUSER_OFF

            assign {
                o_awregion,
                o_awqos,
                o_awprot,
                o_awcache,
                o_awlock,
                o_awburst,
                o_awsize,
                o_awlen,
                o_awid,
                awaddr
            } = awch;

            assign {
                o_arregion,
                o_arqos,
                o_arprot,
                o_arcache,
                o_arlock,
                o_arburst,
                o_arsize,
                o_arlen,
                o_arid,
                araddr
            } = arch;
        end

    end

    endgenerate

    generate

        if (KEEP_BASE_ADDR>0) begin: KEEP_BASE_ADDRESS
            assign o_awaddr = awaddr;
            assign o_araddr = araddr;
        end else begin: REMOVE_BASE_ADDRESS
            assign o_awaddr = awaddr - BASE_ADDR[0+:AXI_ADDR_W];
            assign o_araddr = araddr - BASE_ADDR[0+:AXI_ADDR_W];
        end

    endgenerate

    generate

        if (USER_SUPPORT>0 && AXI_WUSER_W>0) begin: WUSER_ON
            assign{o_wuser, o_wstrb, o_wdata} = wch;
        end else begin: WUSER_OFF
            assign {o_wstrb, o_wdata} = wch;
        end

    endgenerate

    generate
        if (USER_SUPPORT>0 && AXI_BUSER_W>0) begin: BUSER_ON
            assign bch = {o_buser, o_bresp, o_bid};
        end else begin: BUSER_OFF
            assign bch = {o_bresp, o_bid};
        end
    endgenerate

    generate
        if (USER_SUPPORT>0 && AXI_RUSER_W>0) begin: RUSER_ON
            assign rch = {o_ruser, o_rdata, o_rresp, o_rid};
        end else begin: RUSER_OFF
            assign rch = {o_rdata, o_rresp, o_rid};
        end
    endgenerate

    generate
        if (AXI_SIGNALING==0) begin: AXI4_LITE_RLAST
            assign rlast = 1'b1;
        end else begin: AXI4_RLAST
            assign rlast = o_rlast;
        end
    endgenerate
    
    axicb_resp_monitor
#(
    .COUNTER_W(32)
)
u_resp_monitor
(
    .aclk          (o_aclk),
    .aresetn       (o_aresetn),
    .srst          (i_srst),

    .bvalid        (o_bvalid),
    .bready        (o_bready),
    .bresp         (o_bresp),

    .rvalid        (o_rvalid),
    .rready        (o_rready),
    .rresp         (o_rresp),

    .b_error_flag  (b_error_flag),
    .r_error_flag  (r_error_flag),

    .b_error_count (b_error_count),
    .r_error_count (r_error_count)
);

endmodule

`resetall
