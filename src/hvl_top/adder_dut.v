`ifndef ADDER_DUT_INCLUDED_
`define ADDER_IF_INCLUDED_

module adder_dut(Sum, Cout, rst, A, B, Cin);

  //Input Signals
  input rst;
  input [31:0] A;
  input [31:0] B;
  input Cin;

  //Output Signals
  output reg [31:0] Sum;
  output reg Cout;

  always @(A or B or Cin or rst) begin
    if(!rst) begin
      Sum <= 0;
      Cout <= 0;
    end
    else begin
      {Cout,Sum} <= A + B + Cin;
      //$display("pora rey A=%0d B=%0d , sum =%0d",A,B,Sum);
    end
  end
  endmodule:adder_dut

`endif
