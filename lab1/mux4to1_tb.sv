module mux4to1_tb;
	logic in0, in1, in2, in3, sel0, sel1;
	wire f;
	
	mux4to1 test(.in0(in0),
			.in1(in1),
			.in2(in2),
			.in3(in3),
			.sel0(sel0),
			.sel1(sel1),
			.f(f)
			);
	
	initial begin
	sel1=1'b0;
	sel0=1'b0;
	in3=1'b0;
	in2=1'b0;
	in1=1'b0;
	in0=1'b0;
	#10
	in0=1'b1;
	#10
	sel0=1'b1;
	#10
	in1=1'b1;
	#10
	sel1=1'b1;
	sel0=1'b0;
	#10
	in2=1'b1;
	#10
	sel0=1'b1;
	#10
	in3=1'b1;
	end
	
endmodule