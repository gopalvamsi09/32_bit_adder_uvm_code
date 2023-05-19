`ifndef ADDER_FIXED_TEST_INCLUDED_
`define ADDER_FIXED_TEST_INCLUDED_

//--------------------------------------------------------------------------------------------
// Class: adder_fixed_test
// Extends the base_test and starts the fixed sequence
//--------------------------------------------------------------------------------------------
class adder_fixed_test extends adder_base_test;
  `uvm_component_utils(adder_fixed_test)

  //Variable: adder_fixed_seq_h
  //Instantiation of adder_fixed_seq
  adder_fixed_seq adder_fixed_seq_h;

  //--------------------------------------------------------------------------------------------
  // Externally defined Functions and Tasks
  //--------------------------------------------------------------------------------------------
  extern function new(string name = "adder_fixed_test", uvm_component parent = null);
  extern virtual task run_phase(uvm_phase phase);

endclass: adder_fixed_test

//--------------------------------------------------------------------------------------------
// Construct: new
//--------------------------------------------------------------------------------------------
function adder_fixed_test::new(string name = "adder_fixed_test", uvm_component parent = null);
  super.new(name,parent);
endfunction: new

//--------------------------------------------------------------------------------------------
// Task: run_phase
//  Creates the adder_fixed_seq and starts the sequence
//--------------------------------------------------------------------------------------------
task adder_fixed_test::run_phase(uvm_phase phase);
  
  adder_fixed_seq_h = adder_fixed_seq::type_id::create("adder_fixed_seq_h");
  `uvm_info(get_type_name(),$sformatf("adder_fixed_test"),UVM_LOW);
  
  phase.raise_objection(this);
  
  repeat(10) begin
    #(DELAY);
    adder_fixed_seq_h.start(adder_env_h.adder_agent_h.adder_seqr_h);
  end
  #1;
  phase.drop_objection(this);

endtask: run_phase

`endif
