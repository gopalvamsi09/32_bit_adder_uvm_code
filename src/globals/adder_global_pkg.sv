 `ifndef ADDER_GLOBAL_PKG_INCLUDED_
 `define ADDER_GLOBAL_PKG_INCLUDED_

 //--------------------------------------------------------------------------------------------
 // Package: adder_global_pkg
 //  Used for storing required configurations
 //--------------------------------------------------------------------------------------------
package adder_global_pkg;

  //Parameter: ADDER_AGENT_ACTIVE
  //Used to set the adder agent either active or passive
  parameter bit ADDER_AGENT_ACTIVE = 1;

  //Parameter: ADDER_SCOREBOARD_ENABLE
  //Used to set the adder scoreboard either enabling or disabling
  parameter bit ADDER_SCOREBOARD_ENABLE = 1;

  //Parameter: DELAY
  //Used to sync between driver, monitor and testcase
  parameter int DELAY = 5;

endpackage: adder_global_pkg

`endif
