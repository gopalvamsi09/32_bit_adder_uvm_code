module tb();
  reg [31:0] A;
  reg [31:0] B;
  reg Cin;
  reg rst;
  
  wire [31:0] Sum;
  wire Cout;

  adder_dut adder_dut_inst(.Sum(Sum),.Cout(Cout),.rst(rst),.A(A),.B(B),.Cin(Cin));

  initial begin
    $monitor("rst=%0d, A=%0d, B=%0d, Cin=%0d, Sum=%0d,Cout=%0d,{Cout,Sum}=%0d",rst,A,B,Cin,Sum,Cout,{Cout,Sum});
  end

  initial begin
        rst = 0; A = 0;  B = 0;  Cin = 1;

    #10 rst = 1; A = 2147483648; B = 2147483648; Cin = 0;
    
    #10 rst = 1; A = 12; B = 12; Cin = 0;

    #10 rst = 0;
    
    #20 $finish;
  end

endmodule:tb
