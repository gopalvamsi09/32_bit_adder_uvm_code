`ifndef ADDER_COVERAGE_INCLUDED_
`define ADDER_COVERAGE_INCLUDED_

//--------------------------------------------------------------------------------------------
// Class: adder_covergae
// This class is used to include covergroups and bins for functional coverage 
//--------------------------------------------------------------------------------------------
class adder_coverage extends uvm_subscriber #(adder_tx);
  `uvm_component_utils(adder_coverage)

  //--------------------------------------------------------------------------------------------
  // Covergroup: apb_adder_covergroup
  //  Covergroup consists of the various coverpoints based on
  //  no. of the variables used to improve the covergae
  //--------------------------------------------------------------------------------------------
  covergroup adder_covergroup with function sample(adder_tx packet);
    option.per_instance = 1;

    //To check the variable A
    A : coverpoint packet.A{
      option.comment = "32 bit A";
      bins Avar[] = {[0:1000]}; 
      }
      
    //To check the variable A
    B : coverpoint packet.B{
      option.comment = "32 bit B";
      bins Bvar[] = {[0:1000]}; 
      }

    //To check the variable Cin
    Cin : coverpoint packet.Cin{
      option.comment = "1 bit Cin";
      bins Cinvar[] = {0,1}; 
      }

    //To check the variable Sum
    Sum : coverpoint packet.Sum{
      option.comment = "32 bit Sum";
      bins Sumvar[] = {[0:1000]}; 
      }

    //To check the variable Cout
    Cout : coverpoint packet.Cout{
      option.comment = "1 bit Cout";
      bins Coutvar[] = {0,1}; 
      }

    //Cross covergae b/w A, B and Cin to check whether the adder has covered all possible cross cases
    //Cross covergae b/w Sum and Cout to check whether the adder has covered all possible cross cases
    AxBxCin : cross A, B, Cin;
    SumxCout : cross Sum, Cout;

  endgroup : adder_covergroup

  //--------------------------------------------------------------------------------------------
  // Externally defined Tasks and Functions
  //--------------------------------------------------------------------------------------------
  extern function new(string name = "adder_coverage", uvm_component parent = null);
  extern function void write(adder_tx t);
  extern virtual function void report_phase(uvm_phase phase);

endclass : adder_coverage

//--------------------------------------------------------------------------------------------
// Construct: new
//  Initializes memory for new object
//
// Parameters:
//  name - adder_coverage
//  parent - parent under which this component is created
//---------------------------------------------------------------------------------------------
function adder_coverage::new(string name = "adder_coverage", uvm_component parent = null);
  super.new(name,parent);
  adder_covergroup = new();
endfunction : new

//--------------------------------------------------------------------------------------------
// Function: write
// Overriding the write method declared in the parent class
//
// Parameters:
//  t - adder_tx
//--------------------------------------------------------------------------------------------
function void adder_coverage::write(adder_tx t);
  `uvm_info(get_type_name(),$sformatf("Before calling SAMPLE METHOD"),UVM_HIGH)
  adder_covergroup.sample(t);
  `uvm_info(get_type_name(),"After calling SAMPLE METHOD",UVM_HIGH)

endfunction : write

//--------------------------------------------------------------------------------------------
// Function: report_phase
// Used for reporting the covergae instance percantage calues
//--------------------------------------------------------------------------------------------
function void adder_coverage::report_phase(uvm_phase phase);
  `uvm_info(get_type_name(), $sformatf("Adder Agent coverage = %0.2f %%", adder_covergroup.get_coverage()), UVM_NONE)
endfunction: report_phase

`endif
