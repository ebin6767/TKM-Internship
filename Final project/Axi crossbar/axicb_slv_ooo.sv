        axicb_round_robin_core
        #(
            .REQ_NB  (NB_ID)
        )
        cch_round_robin
        (
            .aclk    (aclk),
            .aresetn (aresetn),
            .srst    (srst),
            .en      (c_en),
            .req     (c_reqs),
            .grant   (id_grant)
        );

        // Multiplexer to extract the right FIFO and its corresponding empty flag
        always_comb begin
            c_select = '0;
            c_empty = '0;
            for (int i=0; i<NB_ID; i++) begin
                if (id_grant[i]) begin
                    c_select = fifo_out[i*FIFO_WIDTH +: FIFO_WIDTH];
                    c_empty = id_empty[i];
                end
            end
        end

    end
    endgenerate
    //--------------------------------------------------------------------------


    //--------------------------------------------------------------------------
    // Third stage, we drive the completion attribute back to the slave switch
    // When only a single OR is supported, just put here a pipeline to store the
    // transaction attribute and drive back to the switch once the initiator
    // is ready to accept a completion
    //--------------------------------------------------------------------------
    generate

    // Single oustanding request management
    if (OSTDREQ_NUM==1) begin : NO_PATH_CPL

        localparam PIPE_W = (RD_PATH) ? 1 + AXI_ID_W + 8 : 
                                        1 + AXI_ID_W;

        logic [PIPE_W-1:0] pipe_in;
        logic [PIPE_W-1:0] pipe_out;
        logic              pipe_aready;
        logic              pipe_valid;

        assign pipe_in = (RD_PATH) ? {a_len, a_id, a_mr} : {a_id, a_mr};
        assign a_full = !pipe_aready;

        // Pass the tansaction attributes to a pipeline to store them
        axicb_pipeline 
        #(
            .DATA_BUS_W  (PIPE_W),
            .NB_PIPELINE (1)
        )
        rd_cpl_pipe_no_or 
        (
            .aclk    (aclk),
            .aresetn (aresetn),
            .srst    (srst),
            .i_valid (a_valid & a_ready),
            .i_ready (pipe_aready),
            .i_data  (pipe_in),
            .o_valid (pipe_valid),
            .o_ready (c_end),
            .o_data  (pipe_out)
        );

        // Granted completion is just the one active
        assign c_grant = c_valid;

        if (RD_PATH) begin: C_LEN_RD_PATH
            always @ (*) begin
                // Read completion path also comprise the ALEN
                if (pipe_valid)
                    c_len = pipe_out[(1+AXI_ID_W)+:8];
                else
                    c_len = '0;
            end
        end else begin: NO_C_LEN_WR_PATH
            assign c_len = '0;
        end

        always @ (*) begin
            // For read and write completion path
            // pass back the ID and misrouteed flag
            if (pipe_valid) begin
                c_id = pipe_out[1+:AXI_ID_W];
                c_mr = pipe_out[0];
            end else begin
                c_id = '0;
                c_mr = '0;
            end
        end

    // OR > 1, Read completion path 
    end else if (RD_PATH) begin: RD_PATH_CPL

        always @ (*) begin
            if (c_empty)
                {c_len,c_grant,c_mr,c_id} = '0;
            else
                {c_len,c_grant,c_mr,c_id} = c_select;
        end

    // OR > 1, Write completion path (no ALEN)
    end else begin: WR_PATH_CPL

        always @ (*) begin
            if (c_empty)
                {c_grant,c_mr,c_id} = '0;
            else
                {c_grant,c_mr,c_id} = c_select;
            c_len = '0;
        end

    end


    endgenerate

endmodule

`resetall
