`ifndef ADDER_TX_INCLUDED_
`define ADDER_TX_INCLUDED_

//--------------------------------------------------------------------------------------------
//Class: adder_tx.
// This class holds the data items required to drive stimulus to dut
// and also holds methods that manipulate those data items
//--------------------------------------------------------------------------------------------

class adder_tx extends uvm_sequence_item;
  `uvm_object_utils(adder_tx)
  
  //Variable: A
  //32 bit 
  rand bit[31:0] A;

  //Variable: B
  //32 bit
  rand bit[31:0] B;

  //Variable: Cin
  //1 bit carry in to lsb
  rand bit Cin;

  //Variable: Sum
  //32 bit Sum
  bit[31:0] Sum;

  //Variable: Cout
  //1 bit carry out of msb
  bit Cout;

//--------------------------------------------------------------------------------------------
// Externally defined Tasks and Functions 
//--------------------------------------------------------------------------------------------
  extern function new(string name = "adder_tx");
  extern function void do_copy(uvm_object rhs);
  extern function bit do_compare(uvm_object rhs, uvm_comparer comparer);
  extern function void do_print(uvm_printer printer);

endclass:adder_tx

//--------------------------------------------------------------------------------------------
//Construct: new
//Initialize the class object
//
//Parameters:
// name - adder_tx
//--------------------------------------------------------------------------------------------
function adder_tx::new(string name = "adder_tx");
  super.new(name);
endfunction: new

//--------------------------------------------------------------------------------------------
//Function: do_copy
// Copy method is implemented using handle rhs
//
//Parameters:
// rhs - uvm_object
//--------------------------------------------------------------------------------------------
function void adder_tx::do_copy(uvm_object rhs);
  adder_tx adder_tx_copy_obj;

  if(!$cast(adder_tx_copy_obj,rhs)) begin
    `uvm_fatal("do_copy","cast of the rhs object failed")
  end
  super.do_copy(rhs);

  A    = adder_tx_copy_obj.A;
  B    = adder_tx_copy_obj.B;
  Cin  = adder_tx_copy_obj.Cin;
  Sum  = adder_tx_copy_obj.Sum;
  Cout = adder_tx_copy_obj.Cout;

endfunction: do_copy

//--------------------------------------------------------------------------------------------
// Function : do_compare
//  Compare method is implmented using handle rhs
//
// Parameters:
//  phase - uvm_phase
//--------------------------------------------------------------------------------------------
function bit adder_tx::do_compare(uvm_object rhs, uvm_comparer comparer);
  adder_tx adder_tx_compare_obj;

  if(!$cast(adder_tx_compare_obj,rhs)) begin
    `uvm_fatal("FATAL_ADDER_TX_DO_COMPARE_FAILED","cast of the rhs object failed")
  end

  return super.do_compare(adder_tx_compare_obj, comparer) && A == adder_tx_compare_obj.A && B    == adder_tx_compare_obj.B && Cin  == adder_tx_compare_obj.Cin && Sum  == adder_tx_compare_obj.Sum && Cout == adder_tx_compare_obj.Cout;

endfunction : do_compare

//--------------------------------------------------------------------------------------------
// Function: do_print method
//  Print method can be added to display the data members values
//
// Parameters:
//  printer - uvm_printer
//--------------------------------------------------------------------------------------------
function void adder_tx::do_print(uvm_printer printer);

  printer.print_field ("A",A,$bits(A),UVM_DEC);
  printer.print_field ("B",B,$bits(B),UVM_DEC);
  printer.print_field ("Cin",Cin,$bits(Cin),UVM_DEC);
  printer.print_field ("Sum",Sum,$bits(Sum),UVM_DEC);
  printer.print_field ("Cout",Cout,$bits(Cout),UVM_DEC);

endfunction : do_print

`endif
