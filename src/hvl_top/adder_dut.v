`ifndef ADDER_DUT_INCLUDED_
`define ADDER_IF_INCLUDED_

module adder_dut(Sum, Cout, rst, A, B, Cin);
   parameter N=32;
   input [N-1:0] A,B;
   input Cin, rst;
   output reg [N-1:0] Sum;
   output reg Cout;
   wire [N-1:0] carry;

   always @(*) begin
      if(!rst) begin
        Sum<=0;
        Cout<=0;
      end
      else begin
        Cout = carry[N-1];
      end
   end
   
   genvar i;
   generate
   for(i=0;i<N;i=i+1)
      begin: generate_N_bit_Adder
       if(i==0) 
          full_adder f(A[0],B[0],Cin,Sum[0],carry[0]);
       else
          full_adder f(A[i],B[i],carry[i-1],Sum[i],carry[i]);
      end
   endgenerate
endmodule : adder_dut

module full_adder(x,y,c_in,s,c_out);
   input x,y,c_in;
   output s,c_out;
 assign s = (x^y) ^ c_in;
 assign c_out = (y&c_in)| (x&y) | (x&c_in);
endmodule : full_adder// full_adder

`endif
