module encoder_tb;
	logic in0, in1;
	wire f;
	
	addsub test(.in0(in0),
				.in1(in1),
				.cin(cin),
				.f(f)
				);
	
	initial begin
	in0=1'b0;
	in1=1'b0;
	#10
	in0=1'b1;
	#10
	in0=1'b0;
	in1=1'b1;
	#10
	in0=1'b1;
	end
	
endmodule