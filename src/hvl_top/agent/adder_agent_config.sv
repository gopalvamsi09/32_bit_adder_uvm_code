`ifndef ADDER_AGENT_CONFIG_INCLUDED_
`define ADDER_AGENT_CONFIG_INCLUDED_

//--------------------------------------------------------------------------------------------
// Class: adder_agent_config
// Used as the configuration class for adder agent and number of
// active passive agents to be created.
//--------------------------------------------------------------------------------------------
class adder_agent_config extends uvm_object;
  `uvm_object_utils(adder_agent_config)
  
  //Variable: is_active
  //Used for creating the agent in either passive or active mode
  uvm_active_passive_enum is_active = UVM_ACTIVE;
  
  //Variable: has_coverage
  //Used for enabling the agent coverage
  bit has_coverage;
  
  //--------------------------------------------------------------------------------------------
  // Externally defined Tasks and Functions
  //--------------------------------------------------------------------------------------------
  extern function new(string name = "adder_agent_config");
  extern function void do_print(uvm_printer printer);

endclass : adder_agent_config

//--------------------------------------------------------------------------------------------
// Construct: new
// Initializes memory for new object
//
// Parameter;
//  name - adder_agent_config
//--------------------------------------------------------------------------------------------
function adder_agent_config::new(string name = "adder_agent_config");
  super.new(name);
endfunction

//--------------------------------------------------------------------------------------------
// Function: do_print method
// Print method can be added to display the data members values
//
// Parameters:
//  printer - uvm_printer
//--------------------------------------------------------------------------------------------
function void adder_agent_config::do_print(uvm_printer printer);
  super.do_print(printer);

  printer.print_field("is_active", is_active, $bits(is_active),  UVM_DEC);
  printer.print_field("has_coverage", has_coverage, $bits(has_coverage), UVM_DEC);

endfunction : do_print

`endif
