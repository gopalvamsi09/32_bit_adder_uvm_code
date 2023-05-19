`ifndef ADDER_AGENT_PKG_INCLUDED_
`define ADDER_AGENT_PKG_INCLUDED_

//--------------------------------------------------------------------------------------------
// Package: adder_agent_pkg
//  Includes all the files related to adder agent
//--------------------------------------------------------------------------------------------
package adder_agent_pkg;

  //--------------------------------------------------------------------------------------------
  // Import uvm package
  //--------------------------------------------------------------------------------------------
  `include "uvm_macros.svh"
  import uvm_pkg::*;

  //--------------------------------------------------------------------------------------------
  // Import adder_global_pkg
  //--------------------------------------------------------------------------------------------
  import adder_global_pkg::*;

  //--------------------------------------------------------------------------------------------
  // Include all other files
  //--------------------------------------------------------------------------------------------
  `include "adder_agent_config.sv"
  `include "adder_tx.sv"
  `include "adder_sequencer.sv"
  `include "adder_driver.sv"
  `include "adder_monitor.sv"
  `include "adder_coverage.sv"
  `include "adder_agent.sv"

endpackage: adder_agent_pkg

`endif
