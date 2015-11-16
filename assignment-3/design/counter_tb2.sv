
module counter_tb2;
   
   parameter NBIT = 32;
   bit clk;
   logic rst_s, asc, preload;
   wire [NBIT-1:0] din;
   wire [NBIT-1:0] dout;
   
   counter L1(
          .clk(clk)
         ,.rst_s(rst_s)
         ,.opsel(opsel)
         ,.mode(mode)
         ,.cout(cout)
         ,.output1(output1)
         );

   initial begin
		clk =0;
		//Round 1
		asc = 1'b1; //Ascend for two cycles
		#20;
		$display("Output: %b", dout);
		//Round 2
		asc = 1'b0; //Descend for two cycles back to 0
		#20;
		$display("Output: %b", dout);
		//Round 3
		preload = 1'b1; //Load in a random number and Ascend for two cycles
		asc = 1'b1;
		din = $unsigned($random);
		#20;
		$display("Output: %b", dout);
		//Round 4
		preload = 1'b0; //Descend for two cycles back to original loaded din
		asc = 1'b0; 
		#20;
		$display("Output: %b", dout);
		//Round 5
		preload = 1'b1; //Load in a random number and Ascend for two cycles
		asc = 1'b1;
		din = $unsigned($random);
		#20;
		$display("Output: %b", dout);
		//Round 6
		preload = 1'b0; //Test synchronous reset 
		rst_s = 1'b1;
		#10
		$display("Output: %b", dout);
      $finish;
   end
   always #5 clk = ~clk;
 
endmodule

