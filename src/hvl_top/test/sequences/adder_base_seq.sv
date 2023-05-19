`ifndef ADDER_BASE_SEQ_INCLUDED_
`define ADDER_BASE_SEQ_INCLUDED_

//--------------------------------------------------------------------------------------------
// Class: adder_base_seq
// Creating adder_base_seq from uvm_sequence
//--------------------------------------------------------------------------------------------
class adder_base_seq extends uvm_sequence#(adder_tx);
  `uvm_object_utils(adder_base_seq)

  `uvm_declare_p_sequencer(adder_sequencer)

  //--------------------------------------------------------------------------------------------
  // Externally defined Tasks and Functions
  //--------------------------------------------------------------------------------------------
  extern function new(string name = "adder_base_seq");
  extern task body();

endclass: adder_base_seq

//--------------------------------------------------------------------------------------------
// Construct: new
//
// Parameters:
//  name - adder_base_seq
//--------------------------------------------------------------------------------------------
function adder_base_seq::new(string name = "adder_base_seq");
  super.new(name);
endfunction: new

//--------------------------------------------------------------------------------------------
// Task: body
//--------------------------------------------------------------------------------------------
task adder_base_seq::body();

  //dynamic casting of p_sequencer and m_sequencer
  if(!$cast(p_sequencer, m_sequencer)) begin
    `uvm_error(get_full_name(),"Sequncer pointer cast failed")
  end

endtask: body

`endif
