`ifndef ADDER_FIXED_SEQ_INCLUDED_
`define ADDER_FIXED_SEQ_INCLUDED_

//--------------------------------------------------------------------------------------------
// Class: adder_fixed seq
// Extends the adder_base_seq and passes the fixed item
//--------------------------------------------------------------------------------------------
class adder_fixed_seq extends adder_base_seq;
  `uvm_object_utils(adder_fixed_seq)

  //--------------------------------------------------------------------------------------------
  // Externally defined Tasks and Functions
  //--------------------------------------------------------------------------------------------
  extern function new(string name = "adder_fixed_seq");
  extern task body();

endclass : adder_fixed_seq

//--------------------------------------------------------------------------------------------
// Construct: new
//--------------------------------------------------------------------------------------------
function adder_fixed_seq::new(string name = "adder_fixed_seq");
  super.new(name);
endfunction: new

//--------------------------------------------------------------------------------------------
// Task: body
// Creates the req of adder transaction and pass the fixed items.
//--------------------------------------------------------------------------------------------
task adder_fixed_seq::body();
  super.body();
  req = adder_tx::type_id::create("req");

  start_item(req);
    req.A = 32'h5A5A5A5A;
    req.B = 32'h5A5A5A5A;
    req.Cin = 0;
    `uvm_info(get_type_name,$sformatf("req random packet: \n%s",req.sprint()),UVM_HIGH)
  finish_item(req);

endtask: body

`endif
