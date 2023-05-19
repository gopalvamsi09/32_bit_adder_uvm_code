`ifndef ADDER_MONITOR_INCLUDED_
`define ADDER_MONITOR_INCLUDED_

//--------------------------------------------------------------------------------------------
// Class: adder_monitor
//  It gets the sampled data from the interface and converts them into transaction items
//--------------------------------------------------------------------------------------------
class adder_monitor extends uvm_monitor;
  `uvm_component_utils(adder_monitor)

  //Variable: adder_intf
  //Declaring handle for virtual interface
  virtual adder_if adder_intf;
  
  //Variable: adder_mon_ap_h
  //Declaring analysis port for the monitor port
  uvm_analysis_port #(adder_tx) adder_mon_ap_h;

  //Varaible: flag
  //Used for giving delay to monitor un phase
  bit flag = 1;

  //--------------------------------------------------------------------------------------------
  // Externally defined Tasks and Functions
  //--------------------------------------------------------------------------------------------
  extern function new(string name = "adder_monitor", uvm_component parent = null);
  extern virtual function void build_phase(uvm_phase phase);
  extern virtual task run_phase(uvm_phase phase);

endclass : adder_monitor

//--------------------------------------------------------------------------------------------
// Construct: new
//  Initializes memory for new object and analysis port
//--------------------------------------------------------------------------------------------
function adder_monitor::new(string name = "adder_monitor", uvm_component parent = null);
  super.new(name,parent);
  adder_mon_ap_h = new("adder_mon_ap_h", this);
endfunction

//--------------------------------------------------------------------------------------------
// Function: build_phase
//  gets the required virtual interafce from config db
//--------------------------------------------------------------------------------------------
function void adder_monitor::build_phase(uvm_phase phase);
  super.build_phase(phase);
  if(!uvm_config_db#(virtual adder_if) :: get(this, "", "adder_intf", adder_intf)) begin
    `uvm_fatal(get_type_name(), "cannot get the interface in monitor")
  end
endfunction

//--------------------------------------------------------------------------------------------
// task: run_phase
//  This task recieves data packet from interface and conerts into the transaction objects
//  And publish the packet to the subscribers.
//--------------------------------------------------------------------------------------------
task adder_monitor::run_phase(uvm_phase phase);
  adder_tx adder_packet;

  `uvm_info(get_type_name(), $sformatf("Inside the adder monitor"),UVM_LOW);

  adder_packet = adder_tx::type_id::create("adder_packet");

  wait(adder_intf.rst);
  forever begin
    adder_tx adder_clone_packet;
    
    //wait(adder_intf.rst);
    if(flag == 1) begin
      #(flag);
    end
    else begin
      #(DELAY);
    end
    adder_packet.A = adder_intf.A;
    adder_packet.B = adder_intf.B;
    adder_packet.Cin = adder_intf.Cin;
    adder_packet.Sum = adder_intf.Sum;
    adder_packet.Cout = adder_intf.Cout;
    
    `uvm_info(get_type_name(),$sformatf("Recieved packet from interface: \n %s",adder_packet.sprint()),UVM_HIGH)
    
    //clone and publish the cloned item to the subscribers
    $cast(adder_clone_packet, adder_packet.clone());
    `uvm_info(get_type_name(),$sformatf("Sending packet via analysis port: \n %s", adder_clone_packet.sprint()),UVM_HIGH)
    adder_mon_ap_h.write(adder_clone_packet);

    flag = 0;


  end

endtask : run_phase

`endif
