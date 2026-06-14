module full_adder (
    input a, b, cin,
    output sum, cout
);
    assign sum = a ^ b ^ cin;
    assign cout = (a & b) | (b & cin) | (cin & a);
endmodule

module rca_4bit (
    input [3:0] A, B,
    input cin,
    output [3:0] S,
    output cout
);
    wire c1, c2, c3;
    full_adder fa0 (A[0], B[0], cin, S[0], c1);
    full_adder fa1 (A[1], B[1], c1,  S[1], c2);
    full_adder fa2 (A[2], B[2], c2,  S[2], c3);
    full_adder fa3 (A[3], B[3], c3,  S[3], cout);
endmodule

module bcd_adder (
    input [3:0] A, B,
    input cin,
    output [3:0] Sum,
    output cout
);
    wire [3:0] rca1_sum;
    wire rca1_cout;
    wire [3:0] correction_bits;
    wire dummy_cout;
    
    rca_4bit rca1 (
        .A(A), .B(B), .cin(cin),
        .S(rca1_sum), .cout(rca1_cout)
    );
    
    assign cout = rca1_cout | (rca1_sum[3] & rca1_sum[2]) | (rca1_sum[3] & rca1_sum[1]);
    assign correction_bits = {1'b0, cout, cout, 1'b0};
    
    rca_4bit rca2 (
        .A(rca1_sum), .B(correction_bits), .cin(1'b0),            
        .S(Sum), .cout(dummy_cout)      
    );
endmodule
