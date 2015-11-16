module counter_tb;
	logic clk, rst_s, asc, preload;
	wire din[31:0];
	wire dout[31:0];
	//wire temp;
	
	counter test(.clk(clk),
			   .rst_s(rst_s),
			   .asc(asc),
			   .preload(preload),
			   .din(din),
			   .dout(dout)
			);
	
	always
		begin
			clk=~clk;
			#10;
		end	
	initial begin
		#100
		$finish
	end
	always@(negedge clk) begin
	rst_s=$random;
	asc=$random;
	preload=$random;
	din[31:0]=$random;
	end
endmodule