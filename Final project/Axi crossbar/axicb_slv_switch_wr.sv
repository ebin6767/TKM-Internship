    // Global timeout watchdog.
    // Tracks whether any write response is outstanding.
    // This implementation uses one timer for all outstanding writes
    // and does not maintain a separate timer per transaction.
    always_ff @(posedge aclk or negedge aresetn) begin
        if (!aresetn) begin
            outstanding_tx_cnt <= '0;
            timeout_timer      <= '0;
            timeout_triggered  <= 1'b0;
        end else if (srst) begin
            outstanding_tx_cnt <= '0;
            timeout_timer      <= '0;
            timeout_triggered  <= 1'b0;
        end else if (TIMEOUT_ENABLE) begin
            
            // Track outstanding write responses normal operations & boundary guard protection
            if (!timeout_triggered) begin
                case ({ (i_awvalid && i_awready), (i_bvalid && i_bready) })
                    2'b10: begin
                        outstanding_tx_cnt <= outstanding_tx_cnt + 1'b1;
                    end
                    2'b01: begin
                        if (outstanding_tx_cnt != '0)
                            outstanding_tx_cnt <= outstanding_tx_cnt - 1'b1;
                    end
                    default: begin
                        outstanding_tx_cnt <= outstanding_tx_cnt;
                    end
                endcase
            end

            // Timer management & terminal state tracking
            if (outstanding_tx_cnt > 0 && !timeout_triggered) begin
                if (timeout_timer >= TIMEOUT_VAL - 1) begin
                    timeout_triggered <= 1'b1;
                end else if (|o_bvalid) begin
                    timeout_timer <= '0; // Reset timer if slave shows progress
                end else begin
                    timeout_timer <= timeout_timer + 1'b1;
                end
            end else if (timeout_triggered) begin
                // Update outstanding transaction count when timeout DECERR is accepted by Master
                if (i_bvalid && i_bready) begin
                    timeout_triggered <= 1'b0;
                    timeout_timer      <= '0;
                    if (outstanding_tx_cnt != '0)
                        outstanding_tx_cnt <= outstanding_tx_cnt - 1'b1;
                end
            end else begin
                timeout_timer <= '0;
            end
        end
    end


    always_comb begin

        i_bvalid = '0;
        i_bch = '0;

        if (TIMEOUT_ENABLE && timeout_triggered) begin
            i_bvalid = 1'b1;
            i_bch    = {2'h3, bch_id}; // Inject DECERR (2'h3) with active transaction ID
        end else begin
            // BVALID Signal
            if (bch_mr)
                i_bvalid = '1;
            else if (bch_grant == '0)
                i_bvalid = '0;
            else begin
                for (int i=0;i<SLV_NB;i++)
                    if (bch_grant[i])
                        i_bvalid = o_bvalid[i];
            end

            // BRESP / BUSER
            if (bch_mr)
                i_bch = {2'h3, bch_id} ;
            else if (bch_grant == '0)
                i_bch = '0;
            else begin
                for (int i=0;i<SLV_NB;i++)
                    if (bch_grant[i])
                        i_bch = o_bch[i*BCH_W+:BCH_W];
            end
        end
    end


endmodule

`resetall
