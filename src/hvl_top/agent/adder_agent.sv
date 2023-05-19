`ifndef ADDER_AGENT_INCLUDED_
`define ADDER_AGENT_INCLUDED_

//--------------------------------------------------------------------------------------------
// Class: adder_agent
//  This agent is a configurable with respect to configuration which can create active and passive
//  components. It contains testbench components like sequencer, driver, monitor and covergae for
//  adder
//--------------------------------------------------------------------------------------------
class adder_agent extends uvm_agent;
  `uvm_component_utils(adder_agent)

  //Variable: adder_agent_cfg_h
  //Declaring handle for adder configuration class
  adder_agent_config adder_agent_cfg_h;

  //Variable: adder_seqr_h
  //Handle for adder sequencer
  adder_sequencer adder_seqr_h;

  //Variable: adder_drv_h
  //Handle for adder driver
  adder_driver adder_drv_h;

  //Variable: adder_mon_h
  //Handle for adder_monitor
  adder_monitor adder_mon_h;

  //Variable: adder_cov_h
  //Handle for adder_coverage
  adder_coverage adder_cov_h;

  //--------------------------------------------------------------------------------------------
  // Externally defined Tasks and Functions
  //--------------------------------------------------------------------------------------------
  extern function new(string name = "adder_agent", uvm_component parent = null);
  extern virtual function void build_phase(uvm_phase phase);
  extern virtual function void connect_phase(uvm_phase phase);

endclass : adder_agent

//--------------------------------------------------------------------------------------------
// Construct: new
//  Initializes memory for new object
//
// Parameters:
//  name - instance name of the adder_agent
//  parent - parent under which this component is created
//--------------------------------------------------------------------------------------------
function adder_agent::new(string name = "adder_agent", uvm_component parent = null);
  super.new(name,parent);
endfunction

//--------------------------------------------------------------------------------------------
// Function: build_phase
// Creates the required ports, gets the required configuration from config db
//
// Parameters:
// phase - uvm_phase
//--------------------------------------------------------------------------------------------
function void adder_agent::build_phase(uvm_phase phase);
  super.build_phase(phase);

  if(!uvm_config_db #(adder_agent_config)::get(this,"","adder_agent_config",adder_agent_cfg_h))
    begin
      `uvm_fatal(get_type_name(),"cannot get the adder agent configuration from confgig db")
    end

  if(adder_agent_cfg_h.is_active == UVM_ACTIVE) begin
    adder_drv_h = adder_driver::type_id::create("adder_drv_h",this);
    adder_seqr_h = adder_sequencer::type_id::create("adder_seqr_h",this);
  end

  adder_mon_h = adder_monitor::type_id::create("adder_mon_h",this);

  if(adder_agent_cfg_h.has_coverage) begin
    adder_cov_h = adder_coverage::type_id::create("adder_cov_h",this);
  end

endfunction : build_phase

//--------------------------------------------------------------------------------------------
// Function: connect_phase
// Connecting adder_driver, adder_monitor, adder_sequencer and adder_coverage
//
// Parameters:
// phase - uvm_phase
//--------------------------------------------------------------------------------------------
function void adder_agent::connect_phase(uvm_phase phase);
  if(adder_agent_cfg_h.is_active == UVM_ACTIVE) begin
    //connecting the driver port to sequencer export
    adder_drv_h.seq_item_port.connect(adder_seqr_h.seq_item_export);
  end
  
  if(adder_agent_cfg_h.has_coverage) begin
    adder_mon_h.adder_mon_ap_h.connect(adder_cov_h.analysis_export);
  end

endfunction : connect_phase

`endif
