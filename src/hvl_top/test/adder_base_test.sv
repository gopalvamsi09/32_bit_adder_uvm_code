`ifndef ADDER_BASE_TEST_INCLUDED_
`define ADDER_BASE_TEST_INCLUDED_

//--------------------------------------------------------------------------------------------
// Class: adder_base_test
//  base test has the testcase scenarious for testbench
//  Env and config are created in adder_base_test
//  Sequences are ctreated and started in the test
//--------------------------------------------------------------------------------------------
class adder_base_test extends uvm_test;
  `uvm_component_utils(adder_base_test)

  //variable: adder_env_h
  //handle for adder env
  adder_env adder_env_h;

  //Variable: adder_env_cfg_h
  //Declaring  handle for adder_env_config
  adder_env_config adder_env_cfg_h;

  //--------------------------------------------------------------------------------------------
  // Externally defined Tasks and Functions 
  //--------------------------------------------------------------------------------------------
  extern function new(string name = "adder_base_test", uvm_component parent = null);
  extern virtual function void build_phase(uvm_phase phase);
  extern virtual function void setup_adder_env_config();
  extern virtual function void setup_adder_agent_config();
  extern virtual function void end_of_elaboration_phase(uvm_phase phase);
  extern virtual task run_phase(uvm_phase phase);

endclass: adder_base_test

//--------------------------------------------------------------------------------------------
// Construct: new
//--------------------------------------------------------------------------------------------
function adder_base_test::new(string name = "adder_base_test", uvm_component parent = null);
  super.new(name,parent);
endfunction: new

//--------------------------------------------------------------------------------------------
// Function: build_phase
//  Creates env and required configurations
//--------------------------------------------------------------------------------------------
function void adder_base_test::build_phase(uvm_phase phase);
  super.build_phase(phase);
  setup_adder_env_config();
  adder_env_h = adder_env::type_id::create("adder_env_h",this);
endfunction: build_phase

//--------------------------------------------------------------------------------------------
// Function: setup_adder_env_config
//  it calls the adder_agent_config setup.
//--------------------------------------------------------------------------------------------
function void adder_base_test::setup_adder_env_config();
  adder_env_cfg_h = adder_env_config::type_id::create("adder_env_cfg_h");

  if(ADDER_SCOREBOARD_ENABLE === 1) begin
    adder_env_cfg_h.has_scoreboard = 1;
  end
  else begin
    adder_env_cfg_h.has_scoreboard = 0;
  end

  //setting up the configuration for adder agent
  setup_adder_agent_config();

  //setting the adder agent configuration into config db
  uvm_config_db#(adder_agent_config)::set(this,"*","adder_agent_config",adder_env_cfg_h.adder_agent_cfg_h);

  //Dsiplaying the adder agent configuration
  `uvm_info(get_type_name(),$sformatf("\nADDER_AGENT_CONFIG\n%s",adder_env_cfg_h.adder_agent_cfg_h.sprint()),UVM_LOW)

  uvm_config_db#(adder_env_config)::set(this,"*","adder_env_config",adder_env_cfg_h);
  `uvm_info(get_type_name(),$sformatf("\nADDER_ENV_CONFIG\n%s",adder_env_cfg_h.sprint()),UVM_LOW)

endfunction: setup_adder_env_config

//--------------------------------------------------------------------------------------------
// Function: setup_adder_agent_config
//  sets the adder agent config into configdb
//--------------------------------------------------------------------------------------------
function void adder_base_test::setup_adder_agent_config();
  adder_env_cfg_h.adder_agent_cfg_h = adder_agent_config::type_id::create("adder_agent_cfg_h");

  if(ADDER_AGENT_ACTIVE === 1) begin
    adder_env_cfg_h.adder_agent_cfg_h.is_active = uvm_active_passive_enum'(UVM_ACTIVE);
  end
  else begin
    adder_env_cfg_h.adder_agent_cfg_h.is_active = uvm_active_passive_enum'(UVM_PASSIVE);
  end

  adder_env_cfg_h.adder_agent_cfg_h.has_coverage = 1;

endfunction: setup_adder_agent_config

//--------------------------------------------------------------------------------------------
// Function: end_of_elaboration_phase
//  Used to print topology
//
// Parameters:
//  Phase - uvm_phase
//--------------------------------------------------------------------------------------------
function void adder_base_test::end_of_elaboration_phase(uvm_phase phase);
  super.end_of_elaboration_phase(phase);
  uvm_top.print_topology();
endfunction: end_of_elaboration_phase

//--------------------------------------------------------------------------------------------
// Task: run_phase
//  Used to give 100ns delay to complete the run_phase
//--------------------------------------------------------------------------------------------
task adder_base_test::run_phase(uvm_phase phase);

  phase.raise_objection(this);
  super.run_phase(phase);
  #100;
  phase.drop_objection(this);

endtask: run_phase

`endif
