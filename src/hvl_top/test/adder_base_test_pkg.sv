`ifndef ADDER_BASE_TEST_PKG_INCLUDED_
`define ADDER_BASE_TEST_PKG_INCLUDED_

//--------------------------------------------------------------------------------------------
// Package: adder_base_test_pkg
// Includes all the files written to run the simulation
//--------------------------------------------------------------------------------------------
package adder_base_test_pkg;

  //-------------------------------------------
  // Import uvm package
  //-------------------------------------------
  `include "uvm_macros.svh"
  import uvm_pkg::*;

  //-------------------------------------------
  // Importing required packages
  //-------------------------------------------
  import adder_global_pkg::*;
  import adder_agent_pkg::*;
  import adder_env_pkg::*;
  import adder_seq_pkg::*;

  //-------------------------------------------
  // Includeing test files
  //-------------------------------------------
  `include "adder_base_test.sv"
  `include "adder_fixed_test.sv"
  `include "adder_random_test.sv"

endpackage: adder_base_test_pkg

`endif
