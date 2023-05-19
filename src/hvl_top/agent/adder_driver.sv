`ifndef ADDER_DRIVER_INCLUDED_
`define ADDER_DRIVER_INCLUDED_

//--------------------------------------------------------------------------------------------
//Class : adder driver
//--------------------------------------------------------------------------------------------
class adder_driver extends uvm_driver #(adder_tx);
  `uvm_component_utils(adder_driver)

  //Declaring virtual interface
  virtual adder_if adder_intf;

//--------------------------------------------------------------------------------------------
// Externally defined tasks and functions
//--------------------------------------------------------------------------------------------
  extern function new(string name = "adder_driver", uvm_component parent = null);
  extern virtual function void build_phase(uvm_phase phase);
  extern virtual task run_phase(uvm_phase phase);

endclass : adder_driver

//--------------------------------------------------------------------------------------------
// Function: new
// Parameters - name, uvm_component parent
//--------------------------------------------------------------------------------------------
function adder_driver::new(string name = "adder_driver", uvm_component parent = null);
  super.new(name, parent);
endfunction: new

//--------------------------------------------------------------------------------------------
//  Function: build_phase
//   get the virtual interface from top.
//--------------------------------------------------------------------------------------------
function void adder_driver::build_phase(uvm_phase phase);
  super.build_phase(phase);

  if(!(uvm_config_db#(virtual adder_if)::get(this,"*","adder_intf",adder_intf))) begin
    `uvm_fatal(get_type_name(),"cannot get adder interface in adder driver")
  end

endfunction: build_phase

//--------------------------------------------------------------------------------------------
// Task: run_phase
//  Driving the stimulus to the interface.
//--------------------------------------------------------------------------------------------
task adder_driver::run_phase(uvm_phase phase);

  wait(!adder_intf.rst);
  adder_intf.A<=0;
  adder_intf.B<=0;
  adder_intf.Cin<=0;
  wait(adder_intf.rst);

  forever begin
    seq_item_port.get_next_item(req);

      `uvm_info(get_type_name(),$sformatf("REQ-DRIVER_TX \n %s",req.sprint()),UVM_HIGH)
      adder_intf.A   <= req.A;
      adder_intf.B   <= req.B;
      adder_intf.Cin <= req.Cin;

      `uvm_info(get_type_name(),$sformatf("AFTER :: received req packet \n %s",req.sprint()),UVM_NONE)
    
    //#1;
    seq_item_port.item_done();
    

  end
endtask : run_phase

`endif
