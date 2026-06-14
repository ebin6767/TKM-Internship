interface bcd_if;
    logic [3:0] A;
    logic [3:0] B;
    logic cin;
    logic [3:0] Sum;
    logic cout;
endinterface
module tb;
    bcd_if bif();
    bcd_adder dut (
        .A(bif.A),
        .B(bif.B),
        .cin(bif.cin),
        .Sum(bif.Sum),
        .cout(bif.cout)
    );
  initial begin
        $dumpfile("dump.vcd"); 
        $dumpvars(0, tb);      
    end
    initial begin
        bif.A = 4'd0; bif.B = 4'd0; bif.cin = 1'b0;       
        #10;
        bif.A = 4'd4; bif.B = 4'd4; bif.cin = 1'b0;
        #10;
        bif.A = 4'd7; bif.B = 4'd6; bif.cin = 1'b0;
        #10;
        bif.A = 4'd9; bif.B = 4'd9; bif.cin = 1'b1;
    end
    initial begin
        #40;
        $finish();
    end
endmodule
