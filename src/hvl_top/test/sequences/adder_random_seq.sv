`ifndef ADDER_RANDOM_SEQ_INCLUDED_
`define ADDER_RANDOM_SEQ_INCLUDED_

//--------------------------------------------------------------------------------------------
// class: adder_random_seq
// Extends the adder_base_seq and randomizes the req item
//--------------------------------------------------------------------------------------------
class adder_random_seq extends adder_base_seq;
  `uvm_object_utils(adder_random_seq)

  //--------------------------------------------------------------------------------------------
  // Externally defined Tasks and Functions
  //--------------------------------------------------------------------------------------------
  extern function new(string name = "adder_random_seq");
  extern task body();

endclass: adder_random_seq

//--------------------------------------------------------------------------------------------
// Construct: new
// For cra=eating memory for object
//--------------------------------------------------------------------------------------------
function adder_random_seq::new(string name = "adder_random_seq");
  super.new(name);
endfunction: new

//--------------------------------------------------------------------------------------------
// Task: body
//  Creates the req of type adder_tx and randomizes the req item
//--------------------------------------------------------------------------------------------
task adder_random_seq::body();
  super.body();
  req = adder_tx::type_id::create("req");
  start_item(req);
  if(!req.randomize()) begin
    `uvm_fatal("ADDER","rand failed");
  end
  `uvm_info(get_type_name,$sformatf("req random packet: \n%s",req.sprint()),UVM_NONE)
  finish_item(req);

endtask: body

`endif
