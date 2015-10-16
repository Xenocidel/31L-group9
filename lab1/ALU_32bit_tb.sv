module ALU_32bit_tb;
  logic[31:0] A;
  logic[31:0]  B;
  logic[2:0] opsel;
  logic mode;
  wire cout;
  wire[31:0] output1;
  
ALU_32bit L1(
          .A(A)
         ,.B(B)
         ,.opsel(opsel)
         ,.mode(mode)
         ,.cout(cout)
         ,.output1(output1)
         );

initial begin
/*arithmetic operation*/
       A = 32'b01010101010101010101010101010101;
	     B = 32'b10101010101010101010101010101010;
	   mode = 1'b0;
	   opsel = 3'b000;
       #100; /*--add*/
	   opsel = 3'b001;	/*--sub with borrowed carry*/	
	   #100;
	   opsel = 3'b010;	/*--move*/
	   #100;
	   opsel = 3'b011;	/*--sub*/
	   #100	;
	   opsel = 3'b100;	/*--increment*/
	   #100;
       opsel = 3'b101;	/*--DEcrement*/
       #100;
	   opsel = 3'b110;	/*--add & increment*/
       #100;
            
	   mode= 1'b1;		/*--------Logic operations starts at 80ns*/
	   opsel = 3'b000;	/*--AND*/
	   #100;
	   opsel = 3'b001;	/*--OR*/
	   #100;
       opsel = 3'b010;	/*--XOR*/
	   #100;
	   opsel = 3'b011;	/*--NOT*/
	   #100;
	   opsel = 3'b101;	/*--SHL*/
       #100;
	   
       /*round 2*/
	   A = 32'b10101010101010101010101010101010;
	   B = 32'b01010101010101010101010101010101;
	   mode = 1'b0;
	   opsel = 3'b000;
       #100; /*--add*/
	   opsel = 3'b001;	/*--sub with borrowed carry*/	
	   #100;
	   opsel = 3'b010;	/*--move*/
	   #100;
	   opsel = 3'b011;	/*--sub*/
	   #100	;
	   opsel = 3'b100;	/*--increment*/
	   #100;
       opsel = 3'b101;	/*--DEcrement*/
       #100;
	   opsel = 3'b110;	/*--add & increment*/
       #100;
            
	   mode= 1'b1;		/*--------Logic operations starts at 80ns*/
	   opsel = 3'b000;	/*--AND*/
	   #100;
	   opsel = 3'b001;	/*--OR*/
	   #100;
       opsel = 3'b010;	/*--XOR*/
	   #100;
	   opsel = 3'b011;	/*--NOT*/
	   #100;
	   opsel = 3'b101;	/*--SHL*/
       #100;
             /*round 3*/
	   A = 32'b00000000000000000000000000000000;
	   B = 32'b10101010101010101010101010101010;
	   mode = 1'b0;
	   opsel = 3'b000;
       #100; /*--add*/
	   opsel = 3'b001;	/*--sub with borrowed carry*/	
	   #100;
	   opsel = 3'b010;	/*--move*/
	   #100;
	   opsel = 3'b011;	/*--sub*/
	   #100	;
	   opsel = 3'b100;	/*--increment*/
	   #100;
       opsel = 3'b101;	/*--DEcrement*/
       #100;
	   opsel = 3'b110;	/*--add & increment*/
       #100;
            
	   mode= 1'b1;		/*--------Logic operations starts at 80ns*/
	   opsel = 3'b000;	/*--AND*/
	   #100;
	   opsel = 3'b001;	/*--OR*/
	   #100;
       opsel = 3'b010;	/*--XOR*/
	   #100;
	   opsel = 3'b011;	/*--NOT*/
	   #100;
	   opsel = 3'b101;	/*--SHL*/
       #100; 
        /*round 4*/
	   A = 32'b11111111111111111111111111111111;
	   B = 32'b01010101010101010101010101010101;
	   mode = 1'b0;
	   opsel = 3'b000;
       #100; /*--add*/
	   opsel = 3'b001;	/*--sub with borrowed carry*/	
	   #100;
	   opsel = 3'b010;	/*--move*/
	   #100;
	   opsel = 3'b011;	/*--sub*/
	   #100	;
	   opsel = 3'b100;	/*--increment*/
	   #100;
       opsel = 3'b101;	/*--DEcrement*/
       #100;
	   opsel = 3'b110;	/*--add & increment*/
       #100;
            
	   mode= 1'b1;		/*--------Logic operations starts at 80ns*/
	   opsel = 3'b000;	/*--AND*/
	   #100;
	   opsel = 3'b001;	/*--OR*/
	   #100;
       opsel = 3'b010;	/*--XOR*/
	   #100;
	   opsel = 3'b011;	/*--NOT*/
	   #100;
	   opsel = 3'b101;	/*--SHL*/
       #100; 
end
endmodule
    