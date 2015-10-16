module addsub_tb;
	logic addsub, in0, in1, cin;
	wire sum, cout;
	
	addsub test(.in0(in0),
				.in1(in1),
				.cin(cin),
				.addsub(addsub),
				.sum(sum),
				.cout(cout)
				);
	
	initial begin
	addsub=1'b0;
	in1=1'b0;
	in0=1'b0;
	cin=1'b0;
	#10
	cin=1'b1;
	#10
	in0=1'b1;
	cin=1'b0;
	#10
	cin=1'b1;
	#10
	in1=1'b1;
	in0=1'b0;
	cin=1'b0;
	#10
	cin=1'b1;
	#10
	in0=1'b1;
	cin=1'b0;
	#10
	cin=1'b1;
	#10
	addsub=1'b1;
	in1=1'b0;
	in0=1'b0;
	cin=1'b0;
	#10
	cin=1'b1;
	#10
	in0=1'b1;
	cin=1'b0;
	#10
	cin=1'b1;
	#10
	in1=1'b1;
	in0=1'b0;
	cin=1'b0;
	#10
	cin=1'b1;
	#10
	in0=1'b1;
	cin=1'b0;
	#10
	cin=1'b1;
	end
	
endmodule