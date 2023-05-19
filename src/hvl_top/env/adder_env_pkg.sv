`ifndef ADDER_ENV_PKG_INCLUDED_
`define ADDER_ENV_PKG_INCLUDED_

//--------------------------------------------------------------------------------------------
// Package: adder_env_pkg
// Includes all the files related to adder env
//--------------------------------------------------------------------------------------------
package adder_env_pkg;

  //--------------------------------------
  // Importing uvm packages
  //--------------------------------------
  `include "uvm_macros.svh"
  import uvm_pkg::*;

  //--------------------------------------
  // Importing the required packages
  //--------------------------------------
  import adder_global_pkg::*;
  import adder_agent_pkg::*;

  //--------------------------------------
  // Including the required files
  //--------------------------------------
  `include "adder_env_config.sv"
  `include "adder_scoreboard.sv"
  `include "adder_env.sv"

endpackage: adder_env_pkg

`endif
