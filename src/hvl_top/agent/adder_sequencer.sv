`ifndef ADDER_SEQUENCER_INCLUDED_
`define ADDER_SEQUENCER_INCLUDED_

//--------------------------------------------------------------------------------------------
// Class: adder_sequencer
//--------------------------------------------------------------------------------------------
class adder_sequencer extends uvm_sequencer #(adder_tx);
  `uvm_component_utils(adder_sequencer)

  //--------------------------------------------------------------------------------------------
  // Externally defined Tasks and Functions
  //--------------------------------------------------------------------------------------------
  extern function new(string name = "adder_sequencer", uvm_component parent);

endclass: adder_sequencer

//--------------------------------------------------------------------------------------------
// Construct: new
//  Initializes the adder sequencer class component
//
// Parameters:
//  name - apb_master_sequences
//  parent - parent under which this component is created
//--------------------------------------------------------------------------------------------
function adder_sequencer::new(string name = "adder_sequencer", uvm_component parent);
  super.new(name,parent);
endfunction: new

`endif
