
/* Example 4.12 */

import "DPI-C" context encoder= function void encoder(input int data, output logic [10:0] outData,  output int parity );


module dpi_example ();
   parameter size = 15;
   parameter p_size = 4;

   logic   dpi_out  [0:size-1] ;
   logic   dpi_p_out [0:p_size-1] ;

   logic   dpi_in [0:size-1] ;
   logic   [10:0] rtl_data_in;
   logic   [14:0] rtl_data_out;
   logic   [14:0] exp_data_out;
   logic   [p_size-1:0] parity_out;

   logic   [size-1:0] decoder_data_out;

   bit clk;       

   initial begin
      clk =0;
      #80;
      $finish;
   end

   always #1 clk = ~clk; //generate clock with period 2ns

   always @(posedge clk) begin
       
      rtl_data_in = $urandom % 2048; //generate 11 random bits
      $display("rtl_in: %b", rtl_data_in);      //display the random data 
      encoder(rtl_data_in, rtl_data_out, parity_out); // feed the data to c programming
	  exp_data_out = parity_out[0:2], rtl_data_out[0:1], parity_out[3], rtl_data_out[2:6], parity_out[4], rtl_data_out[7:14] //might be reversed due to it being defined as DOWNTO, please check!
   end
   
   // generate the rtl output
   ham1511_encode L1( .d(rtl_data_in), .o(rtl_data_out));  // make sure you are using your entity name and port name
   ham1511_decode L2( .i(exp_data_out), .out_vec(decoder_data_out) );

   //compare expected output and encoder output
   always @(negedge clk) begin
       if (exp_data_out = rtl_data_out) begin
           $display("%t: PASS, Encoder Input: %b, Output (Expected/RTL) (%b/%b)", $time, $rtl_data_in, $exp_data_out, $rtl_data_out);
       end else begin
           $display("%t: FAIL, Encoder Input: %b, Output (Expected/RTL) (%b/%b)", $time, $rtl_data_in, $exp_data_out, $rtl_data_out);
       end
   end
   //compare original data and decoder output
   always @(decoder_data_out) begin
       if (decoder_data_out = rtl_data_in) begin
           $display("%t: PASS, Decoder Input: %b, Output (Expected/RTL) (%b/%b)", $time, $exp_data_out, $rtl_data_in, $decoder_data_out);
       end else begin
           $display("%t: FAIL, Decoder Input: %b, Output (Expected/RTL) (%b/%b)", $time, $exp_data_out, $rtl_data_in, $decoder_data_out);
       end 

 
endmodule

