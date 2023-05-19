`ifndef HVL_TOP_INCLUDED_
`define HVL_TOP_INCLUDED_
  
module hvl_top;
  //-----------------------------------------------------------
  // Imporitng UVM and test package
  //-----------------------------------------------------------
  `include "uvm_macros.svh"
  import uvm_pkg::*;
  import adder_base_test_pkg::*;
  
  //giving reset from system
  bit rst = 0;
  
  initial begin
    //setting the reset
    #5 rst = 1;
    //#100 $finish;
  end
  //Instantiating the interface
  adder_if adder_intf(rst);

  //Instantiating the adder_dut
  adder_dut adder_dut_inst(.Sum(adder_intf.Sum),.Cout(adder_intf.Cout),.rst(adder_intf.rst),.A(adder_intf.A),.B(adder_intf.B),.Cin(adder_intf.Cin));


  initial begin
    //setting the confidb for interface
    uvm_config_db#(virtual adder_if)::set(uvm_root::get(),"*","adder_intf",adder_intf);
  end

  initial begin
    //running the test
    run_test("adder_base_test");
  end

endmodule:hvl_top

`endif
