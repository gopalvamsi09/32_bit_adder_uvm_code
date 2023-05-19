`ifndef adder_random_test_INCLUDED_
`define adder_random_test_INCLUDED_

//--------------------------------------------------------------------------------------------
// Class: adder_random_test
// Extends the base_test and starts the random sequence
//--------------------------------------------------------------------------------------------
class adder_random_test extends adder_base_test;
  `uvm_component_utils(adder_random_test)

  //Variable: adder_fixed_seq_h
  //Instantiation of adder_fixed_seq
  adder_random_seq adder_random_seq_h;

  //--------------------------------------------------------------------------------------------
  // Externally defined Functions and Tasks
  //--------------------------------------------------------------------------------------------
  extern function new(string name = "adder_random_test", uvm_component parent = null);
  extern virtual task run_phase(uvm_phase phase);

endclass: adder_random_test

//--------------------------------------------------------------------------------------------
// Construct: new
//--------------------------------------------------------------------------------------------
function adder_random_test::new(string name = "adder_random_test", uvm_component parent = null);
  super.new(name,parent);
endfunction: new

//--------------------------------------------------------------------------------------------
// Task: run_phase
//  Creates the adder_random_seq and starts the sequence
//--------------------------------------------------------------------------------------------
task adder_random_test::run_phase(uvm_phase phase);
  
  adder_random_seq_h = adder_random_seq::type_id::create("adder_random_seq_h");
  `uvm_info(get_type_name(),$sformatf("adder_random_test"),UVM_LOW);

  phase.raise_objection(this);

  repeat(10) begin
    #(DELAY); adder_random_seq_h.start(adder_env_h.adder_agent_h.adder_seqr_h);
  end
  #1;
  phase.drop_objection(this);

endtask: run_phase

`endif
