module reg_tb ();
	//register width
	parameter n_size = 32;
	
	//number of registers for reg_file and variable for correct number of randomly generated bits
	parameter reg_size = 8;
	parameter address = 3;
	logic [n_size-1 : 0] numBits = (2**n_size); 
	
	//variables for inputs and outputs of SystemVerilog equivalents of design components for checking
	logic [n_size-1: 0] rtl_data_in;
	logic [n_size-1: 0] rtl_data_out;
	logic [n_size-1: 0] exp_data_out_reg;
	logic [n_size-1: 0] reg_data_out; 
	
	bit clk, clk2,  we, inc, rst_a, rst_s;
	
	//regfile signals
	logic [n_size-1: 0] exp_rdata1;
	logic [n_size-1: 0] exp_rdata2;
	logic [n_size-1: 0] rdata1;
	logic [n_size-1: 0] rdata2;
	logic [n_size-1: 0] wdata;
	logic[address-1:0] r_addr1, r_addr2, w_addr;
	
	reg [n_size-1:0] reg_file [reg_size -1 :0]; 
	
	//counter signals
	logic counter_rs, asc, preload;
	logic [n_size - 1 : 0]exp_counter_out;
	logic [n_size -1 : 0]counter_out;
	logic [n_size -1 : 0]counter_in;
	integer step = 1; 
	
	
	
	bit reset_rf, rf_we;
	
	//loop variables
	integer x, y;
	
	initial begin 
	//initialize stored register values to 0
	
	for (y = 0; y < reg_size; y = y + 1) begin
		reg_file[y] <= 'b0;
	end
      clk =0;
	  //register test
	  //asynchronous reset for register test
	  rst_a <= #75 1;
	  rst_a <= #125 1;
	  //initialize SystemVerilog register to 0
	  exp_data_out_reg <= '0;
	  rst_a = 0;
	  rst_s = 0;
	  inc = 0;
	  we = 0;
	  //regfile test
	  reset_rf = 0;
	  rf_we = 0; 
	  r_addr1 = 3'b000;
	  r_addr2 = 3'b011;
	  w_addr = 3'b010;
	  //counter test
	  exp_counter_out <= '0;
	  asc = 1'b1;
	  counter_rs = 1'b0;
	  preload = 1'b0;
	  #100;
	  
	  //register test
	  rst_s = 1;
	  inc = 0;
	  we = 0;
	  //regfile tests
	  reset_rf = 0;
	  rf_we = 1; 
	  r_addr1 = 3'b000;
	  r_addr2 = 3'b001;
	  w_addr = 3'b000;
	  //counter test
	  asc = 1'b1;
	  #100;
	  
	  //register test
	  rst_s = 0;
	  inc = 1;
	  we = 0;
	  //regfile tests
	  reset_rf = 0;
	  rf_we = 1; 
	  r_addr1 = 3'b000;
	  r_addr2 = 3'b010;
	  w_addr = 3'b000;
	  //counter test
	  asc = 1'b0;
	  #100;
	  
	  //register test
	  rst_s = 1;
	  inc = 1;
	  we = 0;
	  //regfile tests
	  reset_rf = 0;
	  rf_we = 1; 
	  r_addr1 = 3'b011;
	  r_addr2 = 3'b000;
	  w_addr = 3'b100;
	  //counter test
	  asc = 1'b0; 
	  #100;
	  
	  //register test
	  rst_s = 0;
	  inc = 0;
	  we = 1;
	  //regfile tests
	  reset_rf = 0;
	  rf_we = 0; 
	  r_addr1 = 3'b000;
	  r_addr2 = 3'b100;
	  w_addr = 3'b010;
	  //counter test
	  asc = 1'b0; 
	  #100;
	  
	  //register test
	  rst_s = 1;
	  inc = 0;
	  we = 1;
	  //regfile tests
	  reset_rf = 0;
	  rf_we = 1; 
	  r_addr1 = 3'b010;
	  r_addr2 = 3'b101;
	  w_addr = 3'b000;
	  //counter test
	  preload = 1'b1;
	  #100;
	  
	  //register test
	  rst_s = 0;
	  inc = 1;
	  we = 1;
	  //regfile tests
	  reset_rf = 1;
	  rf_we = 1; 
	  r_addr1 = 3'b000;
	  r_addr2 = 3'b110;
	  w_addr = 3'b010;
	  //counter test
	  preload = 1'b0;
	  asc = 1'b1;
	  #100;
	  
	  //register test
	  rst_s = 1;
	  inc = 1;
	  we = 1;
	  //regfile tests
	  reset_rf = 0;
	  rf_we = 1; 
	  r_addr1 = 3'b000;
	  r_addr2 = 3'b111;
	  w_addr = 3'b101;
	  //counter test
	  preload = 1'b0;
	  asc = 1'b1; 
	  #100;
	  
	  //register test
	  rst_s = 0;
	  inc = 1;
	  we = 1;
	  //regfile tests
	  reset_rf = 0;
	  rf_we = 1; 
	  r_addr1 = 3'b101;
	  r_addr2 = 3'b000;
	  w_addr = 3'b010;
	  //counter test
	  asc = 1'b0;
	  #100;
	  
	  //register test
	  rst_s = 0;
	  inc = 0;
	  we = 1;
	  //regfile tests
	  reset_rf = 0;
	  rf_we = 1; 
	  r_addr1 = 3'b000;
	  r_addr2 = 3'b011;
	  w_addr = 3'b111;
	  //counter test
	  asc = 1'b0;
	  #100;
	  
	  //regfile tests
	  reset_rf = 0;
	  rf_we = 0; 
	  r_addr1 = 3'b000;
	  r_addr2 = 3'b111;
	  w_addr = 3'b001;
	  //counter tests
	  preload = 1'b1;
	  #100;
	  
	  reset_rf = 0;
	  rf_we = 0; 
	  r_addr1 = 3'b001;
	  r_addr2 = 3'b010;
	  w_addr = 3'b000;
	  //counter test
	  asc = 1'b1; 
	  #100;
	  
	  //counter test
	  asc = 1'b1;
	  #100
	  
	  //counter test
	  counter_rs = 1'b1;
	  #100
	  
	  
      $finish;
    end
   
	always #50 clk = ~clk; //generate clock with period 100ns
	always #48 clk2 = ~clk2; //generate 2nd clock to imitate input skew
	
	//generate random values for input 	
	always @ (posedge clk2) begin
		if (n_size < 32) begin
			rtl_data_in <= $urandom %numBits;
			wdata <= $urandom % numBits;
			counter_in <= $urandom % numBits;
		end else begin
			rtl_data_in <= $urandom;
			wdata <= $urandom;
			counter_in <= $urandom;
		end
	end
	
	reg_N R1( .clk(clk), .rst_a(rst_a), .rst_s(rst_s), .inc(inc), .we(we), .din(rtl_data_in), .dout(reg_data_out));
	regfile RF1(.clk(clk), .rst_s(reset_rf),.we(rf_we), .raddr_1(r_addr1), .raddr_2(r_addr2), .waddr(w_addr), .rdata_1(rdata1), .rdata_2(rdata2), .wdata(wdata) );
	counter C1(.clk(clk), .rst_s(counter_rs), .asc(asc), .preload(preload), .din(counter_in), .dout(counter_out)); 

	//regfile SystemVerilog equivalent
	always @ (posedge clk) begin
		if (reset_rf) begin
			for (x = 0; x < 8; x = x +1) begin
				reg_file [x] <= 0;
			end
		end else begin
		//reg_file assignment of values at read addresses to rdata outputs
			exp_rdata1 = reg_file[r_addr1];
			exp_rdata2 = reg_file[r_addr2];
			if(rf_we) begin
				reg_file[w_addr] = wdata;				
			end
		end
	end
	//counter SystemVerilog equivalent
	always @(posedge clk) begin
		if (counter_rs) begin
			exp_counter_out <= 0;
		end else begin
			if (preload) begin
				exp_counter_out <= counter_in;
			end
			else begin
				if (asc) begin
					exp_counter_out <= exp_counter_out + step;
				end else begin
					exp_counter_out <= exp_counter_out - step;
				end
			end
		end
	end
	//register SystemVerilog equivalent
	always @(rst_a) begin
		if (rst_a) begin
		exp_data_out_reg <= 0;
		rst_a <= 0; 
		end
	end
	
	
	always @(posedge clk) begin
      if (rst_s)begin
		exp_data_out_reg <= 0;
	  end else if (we && inc == 0) begin
		exp_data_out_reg <= rtl_data_in;
	  end else if (we && inc == 1) begin
		exp_data_out_reg <= rtl_data_in + 1;
	  end else if (we == 0 && inc == 1)begin
		exp_data_out_reg <= exp_data_out_reg +1; 
	  end else begin
		exp_data_out_reg <= exp_data_out_reg; 
	  end
    end
		
	
	//register check against SystemVerilog equivalent
	always @ (posedge clk) begin
           $display("%t: \n\nRegister Input: %b, Clock: %b, Reset_A: %b, Reset_S: %b, W_Enable: %b\nInc: %b\n", $time, rtl_data_in, clk, rst_a, rst_s, we, inc);
	end
	always @ (negedge clk) begin
		if (exp_data_out_reg == reg_data_out) begin
           $display("\nRegister: PASS, \nOutput (Expected/RTL) (%b/%b)\n", exp_data_out_reg, reg_data_out);
       end else begin
           $display("\nRegister: FAIL, \nOutput (Expected/RTL) (%b/%b)\n", exp_data_out_reg, reg_data_out);
       end
	end
	
	//regfile check against SystemVerilog equivalent
	always @ (posedge clk) begin
           $display("%t: \n\nRegister File Input: %b, Clock: %b, Reset_S: %b, W_Enable: %b", $time, wdata,clk, reset_rf, rf_we);
		   $display("\nR1_addr: %b, R2_addr: %b, W_addr: %b\n", r_addr1, r_addr2, w_addr);       
	end
	always @ (negedge clk) begin
		if (exp_rdata1 == rdata1 && exp_rdata2 == rdata2) begin
		   $display("\nRegister File: PASS, \nR1_Output (Expected/RTL) (%b/%b) \nR2_Output (Expected/RTL) (%b/%b)", exp_rdata1, rdata1, exp_rdata2, rdata2);
       end else begin
		   $display("\nRegister FIle: FAIL, \nR1_Output (Expected/RTL) (%b/%b) \nR2_Output (Expected/RTL) (%b/%b)", exp_rdata1, rdata1, exp_rdata2, rdata2);
       end
	end
	
	//counter check against SystemVerilog equivalent
	always @ (posedge clk) begin
          $display("%t: \n\nCounter Input: %b, Clock: %b, Reset_S: %b, Asc: %b, Preload: %b\n", $time, counter_in, clk, rst_s, asc, preload);
		  $display("%t: ", $time);
       
	end
	always @ (negedge clk) begin 
		if (counter_out == exp_counter_out) begin
           $display("\nCounter: PASS, \nOutput (Expected/RTL) (%b/%b)\n",exp_counter_out, counter_out);
       end else begin
           $display("\nCounter: FAIL, \nOutput (Expected/RTL) (%b/%b)\n",exp_counter_out, counter_out);
       end
	end
	
	
endmodule 