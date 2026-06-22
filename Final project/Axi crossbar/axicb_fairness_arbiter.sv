    requester_mask <= '0;
    served_mask    <= '0;

end
else if (srst) begin

    state          <= IDLE;
    blocked_master <= '0;
    requester_mask <= '0;
    served_mask    <= '0;

end
else begin

    case(state)

    //////////////////////////////////////////////
    // NORMAL MODE
    //////////////////////////////////////////////

    IDLE:
    begin

        served_mask <= '0;

        if (dominance_cnt >= DOMINANCE_LIMIT) begin

            state <= FAIRNESS;

            blocked_master <= dominant_master;

            requester_mask <= req & ~dominant_master;

            served_mask <= '0;

        end

        if (req == '0) begin

            blocked_master <= '0;
            requester_mask <= '0;
            served_mask    <= '0;

        end
    end

    //////////////////////////////////////////////
    // FAIRNESS MODE
    //////////////////////////////////////////////

    FAIRNESS:
    begin

        if (service_done)
            served_mask <= served_mask | completed_master;

        if (next_served_mask == requester_mask) begin

            state <= IDLE;

            blocked_master <= '0;
            requester_mask <= '0;
            served_mask    <= '0;

        end

        if (req == '0) begin

            state <= IDLE;

            blocked_master <= '0;
            requester_mask <= '0;
            served_mask    <= '0;

        end
    end

    endcase
end


end

//////////////////////////////////////////////////////
// Status
//////////////////////////////////////////////////////

always_comb begin
fairness_mode = (state == FAIRNESS);
end

endmodule
