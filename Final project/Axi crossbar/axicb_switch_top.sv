        )
        awch_mst_pipe
        (
            .aclk    (aclk),
            .aresetn (aresetn),
            .srst    (srst),
            .i_valid (pipe_awvalid),
            .i_ready (pipe_awready),
            .i_data  (pipe_awch),
            .o_valid (o_awvalid[i]),
            .o_ready (o_awready[i]),
            .o_data  (o_awch[i*AWCH_W+:AWCH_W])
        );

        axicb_pipeline
        #(
            .DATA_BUS_W  (WCH_W+1),
            .NB_PIPELINE (MST_PIPELINE)
        )
        wch_mst_pipe
        (
            .aclk    (aclk),
            .aresetn (aresetn),
            .srst    (srst),
            .i_valid (pipe_wvalid),
            .i_ready (pipe_wready),
            .i_data  ({pipe_wlast, pipe_wch}),
            .o_valid (o_wvalid[i]),
            .o_ready (o_wready[i]),
            .o_data  ({o_wlast[i], o_wch[i*WCH_W+:WCH_W]})
        );

        axicb_pipeline
        #(
            .DATA_BUS_W  (BCH_W),
            .NB_PIPELINE (MST_PIPELINE)
        )
        bch_mst_pipe
        (
            .aclk    (aclk),
            .aresetn (aresetn),
            .srst    (srst),
            .i_valid (o_bvalid[i]),
            .i_ready (o_bready[i]),
            .i_data  (o_bch[i*BCH_W+:BCH_W]),
            .o_valid (pipe_bvalid),
            .o_ready (pipe_bready),
            .o_data  (pipe_bch)
        );


        axicb_pipeline
        #(
            .DATA_BUS_W  (ARCH_W),
            .NB_PIPELINE (MST_PIPELINE)
        )
        arch_mst_pipe
        (
            .aclk    (aclk),
            .aresetn (aresetn),
            .srst    (srst),
            .i_valid (pipe_arvalid),
            .i_ready (pipe_arready),
            .i_data  (pipe_arch),
            .o_valid (o_arvalid[i]),
            .o_ready (o_arready[i]),
            .o_data  (o_arch[i*ARCH_W+:ARCH_W])
        );

        axicb_pipeline
        #(
            .DATA_BUS_W  (RCH_W+1),
            .NB_PIPELINE (MST_PIPELINE)
        )
        rch_mst_pipe
        (
            .aclk    (aclk),
            .aresetn (aresetn),
            .srst    (srst),
            .i_valid (o_rvalid[i]),
            .i_ready (o_rready[i]),
            .i_data  ({o_rlast[i], o_rch[i*RCH_W+:RCH_W]}),
            .o_valid (pipe_rvalid),
            .o_ready (pipe_rready),
            .o_data  ({pipe_rlast, pipe_rch})
        );

    end
    endgenerate

endmodule
`resetall
