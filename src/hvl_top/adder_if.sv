`ifndef ADDER_IF_INCLUDED_
`define ADDER_IF_INCLUDED_


interface adder_if(input logic rst);
  logic [31:0] A;
  logic [31:0] B;
  logic Cin;

  logic [31:0] Sum;
  logic Cout;

endinterface:adder_if

`endif
