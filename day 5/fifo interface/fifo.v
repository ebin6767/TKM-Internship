interface fifo_if;
    logic clk;
    logic rst;
    logic wr_en;
    logic rd_en;
    logic [7:0] data_in;
    logic [7:0] data_out;
    logic full;
    logic empty;
endinterface
module tb;
    fifo_if f_if();
    fifo dut (
        .clk(f_if.clk), 
        .rst(f_if.rst), 
        .wr_en(f_if.wr_en), 
        .rd_en(f_if.rd_en), 
        .data_in(f_if.data_in), 
        .data_out(f_if.data_out), 
        .full(f_if.full), 
        .empty(f_if.empty)
    );
    always #5 f_if.clk = ~f_if.clk;
    initial begin
        $monitor("Time=%0t | rst=%b | wr=%b rd=%b | data_in=%h data_out=%h | full=%b empty=%b", 
                 $time, f_if.rst, f_if.wr_en, f_if.rd_en, f_if.data_in, f_if.data_out, f_if.full, f_if.empty);
    end
    initial begin
        $dumpfile("dump.vcd"); 
        $dumpvars(0, tb);
        f_if.clk = 0;
        f_if.rst = 1;
        f_if.wr_en = 0;
        f_if.rd_en = 0;
        f_if.data_in = 0;
        #20;
        f_if.rst = 0; 
        #10;        
        write_data(8'hAA);
        write_data(8'hBB);
        write_data(8'hCC);
        write_data(8'hDD);
        write_data(8'hEE);
        write_data(8'hFF);
        write_data(8'h11);        
        write_data(8'h22); 
        #10;
        read_data();
        read_data();
        read_data();
        read_data();
        read_data();
        read_data();
        read_data();
        read_data();
        #10;
        $finish();
    end
    task write_data(input [7:0] data);
        begin
            @(negedge f_if.clk); 
            if (!f_if.full) begin
                f_if.wr_en = 1;
                f_if.data_in = data;
            end
            #10;
            f_if.wr_en = 0;
        end
    endtask

    task read_data();
        begin
            @(negedge f_if.clk);
            if (!f_if.empty) begin
                f_if.rd_en = 1;
            end
            #10;
            f_if.rd_en = 0;
        end
    endtask
      
endmodule
