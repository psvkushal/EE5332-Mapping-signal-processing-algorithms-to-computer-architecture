//                              -*- Mode: Verilog -*-
// Filename        : seq-mult.v
// Description     : Sequential multiplier
// Author          : Nitin Chandrachoodan

// This implementation corresponds to a sequential multiplier 
// resulting module implements multiplication of two numbers in
// twos complement format.

`define width 8
`define ctrwidth 4

module seq_mult (
		 // Outputs
		 p, rdy, 
		 // Inputs
		 clk, reset, a, b
		 ) ;
   input 		 clk, reset;
   input [`width-1:0] 	 a, b;
   output reg [2*(`width)-1:0] p;
   output 		 rdy;
   
   reg [2*(`width)-1:0] multiplier, multiplicand;
   reg 			 rdy;
   reg [`ctrwidth:0] 	 ctr;

   always @(posedge clk or posedge reset)
     if (reset) begin
	   rdy 		<= 0;
	   p 		<= 0;
	   ctr 		<= 0;
	   multiplier 	<= {{(`width){b[`width-1]}}, b}; // sign-extend
	   multiplicand <= {{(`width){a[`width-1]}}, a}; // sign-extend
     end else begin 
	if (ctr <  2*`width ) 
	  begin
	      p <= ((multiplier & {(2*(`width)){multiplicand[ctr]}})<<ctr) + p;
	      ctr <= ctr + 1;
	  end else begin
	     rdy <= 1; 		// Assert 'rdy' signal to indicate end of multiplication
	  end
     end
   
endmodule // seqmult
