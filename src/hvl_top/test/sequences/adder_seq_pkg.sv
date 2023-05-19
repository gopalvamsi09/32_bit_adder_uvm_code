`ifndef ADDER_SEQ_PKG_INCLUDED_
`define ADDER_SEQ_PKG_INCLUDED_

//--------------------------------------------------------------------------------------------
// Package: adder_seq_pkg
//  Includes all the adder seq files declared
//--------------------------------------------------------------------------------------------
package adder_seq_pkg;

  //---------------------------------------------------------------------
  // Importing UVM pkg and including global and adder_agent_packages
  //---------------------------------------------------------------------
  `include "uvm_macros.svh"
  import uvm_pkg::*;
  import adder_global_pkg::*;
  import adder_agent_pkg::*;

  //------------------------------------------------------
  // including required adder seq files
  //------------------------------------------------------
  `include "adder_base_seq.sv"
  `include "adder_fixed_seq.sv"
  `include "adder_random_seq.sv"

endpackage: adder_seq_pkg

`endif
