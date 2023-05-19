`ifndef ADDER_SCOREBOARD_INCLUDED_
`define ADDER_SCOREBOARD_INCLUDED_

//--------------------------------------------------------------------------------------------
// Class: adder_scoreboard
// Used to compare the data sent by the driver with the duplicate dut predictor.
//--------------------------------------------------------------------------------------------
class adder_scoreboard extends uvm_scoreboard;
  `uvm_component_utils(adder_scoreboard)

  //Variable: adder_tx_h
  //Handle for adder_tx
  adder_tx adder_tx_h;

  //Variable: adder_sb_analysis_fifo
  //Used to store the adder_tx data
  uvm_tlm_analysis_fifo#(adder_tx) adder_sb_analysis_fifo;

  //Variable: byte_data_cmp_verified_count
  //To keep track of number of byte wise compared verified data
  int byte_data_cmp_verified_count = 0;

  //Variable: byte_data_cmp_failed_count
  //To keep track of byte wise compared verified data
  int byte_data_cmp_failed_count = 0;

  //--------------------------------------------------------------------------------------------
  // Externally defined Tasks and Functions
  //--------------------------------------------------------------------------------------------
  extern function new(string name = "adder_scoreboard", uvm_component parent = null);
  extern virtual function void build_phase(uvm_phase phase);
  extern virtual task run_phase(uvm_phase phase);
  extern virtual function void check_phase(uvm_phase phase);
  extern virtual function void report_phase(uvm_phase phase);

endclass: adder_scoreboard

//--------------------------------------------------------------------------------------------
// Construct: new
// Initialization of new memory
//
// Parameters:
//  name - adder_scoreboard
//  parent - parent under which this component is created
//--------------------------------------------------------------------------------------------
function adder_scoreboard::new(string name = "adder_scoreboard", uvm_component parent = null);
  super.new(name,parent);
  adder_sb_analysis_fifo = new("adder_sb_analysis_fifo",this);
endfunction: new

//--------------------------------------------------------------------------------------------
// Function: build_phase
//
// Parameters:
//  phase - uvm phase
//--------------------------------------------------------------------------------------------
function void adder_scoreboard::build_phase(uvm_phase phase);
  super.build_phase(phase);
endfunction: build_phase

//--------------------------------------------------------------------------------------------
// Task: run_phase
// Used to give delays and check the Sum and predictor values
//
// Parameters:
//  phase - uvm_phase
//--------------------------------------------------------------------------------------------
task adder_scoreboard::run_phase(uvm_phase phase);
  super.run_phase(phase);

  forever begin
    `uvm_info(get_type_name(),$sformatf("before calling adder analysis fifo get method"), UVM_HIGH)
    adder_sb_analysis_fifo.get(adder_tx_h);
    
    `uvm_info(get_type_name(),$sformatf("after calling adder analysis fifo get method"),UVM_HIGH)
    `uvm_info(get_type_name(),$sformatf("printing adder_tx_h, \n %s",adder_tx_h.sprint()),UVM_HIGH)

    //--------------------------------------------------------------------------------------------
    // Data comparision for adder
    //--------------------------------------------------------------------------------------------

   `uvm_info(get_type_name(),$sformatf("-------------------------------------------------SCOREBOARD COMPARISIONS--------------------------------------------------"),UVM_LOW)

   //--------------------------------------------------------------------------------------------
   // Verifying the data
   //--------------------------------------------------------------------------------------------
    if(adder_tx_h.A+adder_tx_h.B+adder_tx_h.Cin == {adder_tx_h.Cout,adder_tx_h.Sum}) begin
      `uvm_info(get_type_name(),$sformatf("DATA MATCHED"),UVM_LOW)
      `uvm_info(get_type_name(),$sformatf("A = %0d, B = %0d, Cin = %0d, {Cout,Sum} = %0d",adder_tx_h.A,adder_tx_h.B,adder_tx_h.Cin,{adder_tx_h.Cout,adder_tx_h.Sum}),UVM_LOW);
      byte_data_cmp_verified_count++;
    end
    else begin
      `uvm_info(get_type_name(),$sformatf("DATA MISMATCHED"),UVM_LOW)
      `uvm_error(get_type_name(),$sformatf("A = %0d, B = %0d, Cin = %0d, A+B+Cin = %0d, predictor {Cout,Sum} = %0d",adder_tx_h.A,adder_tx_h.B,adder_tx_h.Cin,adder_tx_h.A+adder_tx_h.B+adder_tx_h.Cin,{adder_tx_h.Cout,adder_tx_h.Sum}))
      byte_data_cmp_failed_count++;
    end

    `uvm_info(get_type_name(),$sformatf("-------------------------------------------END OF SCOREBOARD COMPARISIONS--------------------------------------------------"),UVM_LOW)

  end

endtask: run_phase

//--------------------------------------------------------------------------------------------
// Function: check_phase
//  Display the result of simulation
// Parameter:
//  phase - uvm phase
//--------------------------------------------------------------------------------------------
function void adder_scoreboard::check_phase(uvm_phase phase);
  super.check_phase(phase);

  `uvm_info(get_type_name(),$sformatf("-------------------------------------------SCOREBOARD CHECK PHASE--------------------------------------------------"),UVM_LOW)
  `uvm_info(get_type_name(),"Scoreboard Check phase is starting",UVM_HIGH);

  //--------------------------------------------------------------------------------------------
  // Checks if the comparisions counter is Non-zero
  // A non-zero value indicates that the comparisions never happened and throw error 
  //--------------------------------------------------------------------------------------------
  if((byte_data_cmp_verified_count != 0) && (byte_data_cmp_failed_count == 0)) begin
    `uvm_info(get_type_name(),$sformatf("All data comparisions are succesfull"),UVM_LOW);
  end
  else begin
    `uvm_info(get_type_name(),$sformatf("byte_data_cmp_verified_count: %0d",byte_data_cmp_verified_count),UVM_LOW)
    `uvm_info(get_type_name(),$sformatf("byte_data_cmp_failed_count: %0d",byte_data_cmp_failed_count),UVM_LOW)
    `uvm_error("SC_CHECKPHASE","comparisions of data not happened");
  end

  //--------------------------------------------------------------------------------------------
  // Analysis fifos must be zero - This will indicate that all the packets have been compared
  // This is to make sure that we have taken all packets from FIFO and made the comparision
  //--------------------------------------------------------------------------------------------
  if(adder_sb_analysis_fifo.size() == 0)begin
    `uvm_info ("SC_CHECKPHASE", $sformatf ("Adder analysis FIFO is empty"),UVM_LOW);
  end
  else begin
    `uvm_info (get_type_name(), $sformatf("adder_sb_analysis_fifo size : %0d",adder_sb_analysis_fifo.size() ),UVM_LOW);
    `uvm_error ("SC_CHECKPHASE", $sformatf ("apb Master analysis FIFO is not empty"));
  end

  `uvm_info(get_type_name(),$sformatf("--------------------------------------END OF SCOREBOARD CHECK PHASE--------------------------------------------------"),UVM_LOW)

endfunction: check_phase

function void adder_scoreboard::report_phase(uvm_phase phase);
  super.report_phase(phase);
  `uvm_info(get_type_name(),$sformatf("--------------------------------------SCOREBOARD REPORT PHASE--------------------------------------------------"),UVM_HIGH)

  //Number of comparisions passed
  `uvm_info(get_type_name(),$sformatf("Total no. of data comparisions passed: %0d",byte_data_cmp_verified_count),UVM_HIGH)

  //Number of comparisions failed
  `uvm_info(get_type_name(),$sformatf("Total no. of data comparisions failed: %0d",byte_data_cmp_failed_count),UVM_HIGH)
  `uvm_info(get_type_name(),$sformatf("---------------------------------END OF SCOREBOARD REPORT PHASE--------------------------------------------------"),UVM_HIGH)

endfunction: report_phase

`endif
