`ifndef ADDER_ENV_INCLUDED_
`define ADDER_ENV_INCLUDED_

//--------------------------------------------------------------------------------------------
//Class : adder_env
//Creates adder_agent and scoreboard
//--------------------------------------------------------------------------------------------
class adder_env extends uvm_env;
  `uvm_component_utils(adder_env)
  
  //Declaring agent handle
  adder_agent adder_agent_h;

  //Declaring scoreboard handle
  adder_scoreboard adder_sb_h;

  //Variable: adder-env_cfg_h
  //Declaring handle for adder_env_config object
  adder_env_config adder_env_cfg_h;

  //--------------------------------------------------------------------------------------------
  // Externally defined Tasks and Functions
  //--------------------------------------------------------------------------------------------
  extern function new(string name="adder_env", uvm_component parent = null);
  extern virtual function void build_phase(uvm_phase phase);
  extern virtual function void connect_phase(uvm_phase phase);

endclass

  //--------------------------------------------------------------------------------------------
  //Construct : new
  //--------------------------------------------------------------------------------------------
  function adder_env::new(string name="adder_env", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  //--------------------------------------------------------------------------------------------
  //Function : build_phase 
  //Builds : agent and scoreboard
  //--------------------------------------------------------------------------------------------
  function void adder_env::build_phase(uvm_phase phase);
    super.build_phase(phase);

    if(!uvm_config_db #(adder_env_config)::get(this,"","adder_env_config",adder_env_cfg_h)) begin
      `uvm_fatal("FATAL_ENV_CONFIG","couldn't get the env_config from config db")
    end

    adder_agent_h = adder_agent::type_id::create("adder_agent_h",this);

    if(adder_env_cfg_h.has_scoreboard) begin
      adder_sb_h = adder_scoreboard::type_id::create("adder_sb_h",this);
    end

  endfunction: build_phase

  //--------------------------------------------------------------------------------------------
  //Function : connect_phase
  //Connects monitor analysis export to scoreboard analysis fifo export
  //--------------------------------------------------------------------------------------------
  function void adder_env::connect_phase(uvm_phase phase);
    super.build_phase(phase);

    if(adder_env_cfg_h.has_scoreboard) begin
      adder_agent_h.adder_mon_h.adder_mon_ap_h.connect(adder_sb_h.adder_sb_analysis_fifo.analysis_export);
    end

  endfunction: connect_phase

`endif
