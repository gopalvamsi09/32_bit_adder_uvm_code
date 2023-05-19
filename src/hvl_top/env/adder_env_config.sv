`ifndef ADDER_ENV_CONFIG_INCLUDED_
`define ADDER_ENV_CONFIG_INCLUDED_

//--------------------------------------------------------------------------------------------
// Class: adder_env_config
// This class is used to cinfiguration class for adder environment and its components.
//--------------------------------------------------------------------------------------------
class adder_env_config extends uvm_object;
  `uvm_object_utils(adder_env_config)

  //Variable: has_scoreboard
  //Enables the scoreboard. Default value is 1
  bit has_scoreboard = 1;

  //Variable: adder_agent_cfg_h
  //Handle for adder agent configuration
  adder_agent_config adder_agent_cfg_h;

  //--------------------------------------------------------------------------------------------
  // Externally defined Functions and Tasks
  //--------------------------------------------------------------------------------------------
  extern function new(string name = "adder_env_config");
  extern function void do_print(uvm_printer printer);

endclass: adder_env_config

//--------------------------------------------------------------------------------------------
// Construct: new
//  Initialize of new memory
//
// Parameters:
//  name - adder_env_config
//--------------------------------------------------------------------------------------------
function adder_env_config::new(string name = "adder_env_config");
  super.new(name);
endfunction: new

//--------------------------------------------------------------------------------------------
// Function: do_print method
//  Print method can be added to display the data members values
//
// Parameters:
//  printer - uvm_printer
//--------------------------------------------------------------------------------------------
function void adder_env_config::do_print(uvm_printer printer);
  super.do_print(printer);

  printer.print_field("has_scoreboard", has_scoreboard, $bits(has_scoreboard), UVM_DEC);

endfunction: do_print

`endif
