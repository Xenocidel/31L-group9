module ALU_1bit_tb;
  logic A;
  logic B;
  logic[2:0] opsel;
  logic mode;
  wire cout;
  wire output1;
  
ALU_1bit L1(
          .A(A)
         ,.B(B)
         ,.opsel(opsel)
         ,.mode(mode)
         ,.cout(cout)
         ,.output1(output1)
         );

initial begin
/*arithmetic operation*/
       A = 1'b0;
	   B = 1'b1;
	   mode = 1'b0;
	   opsel = 3'b000;
       #10; /*--add*/
	   opsel = 3'b001;	/*--sub with borrowed carry*/	
	   #10;
	   opsel = 3'b010;	/*--move*/
	   #10;
	   opsel = 3'b011;	/*--sub*/
	   #10	;
	   opsel = 3'b100;	/*--increment*/
	   #10;
       opsel = 3'b101;	/*--DEcrement*/
       #10;
	   opsel = 3'b110;	/*--add & increment*/
       #10;
            
	   mode= 1'b1;		/*--------Logic operations starts at 80ns*/
	   opsel = 3'b000;	/*--AND*/
	   #10;
	   opsel = 3'b001;	/*--OR*/
	   #10;
       opsel = 3'b010;	/*--XOR*/
	   #10;
	   opsel = 3'b011;	/*--NOT*/
	   #10;
	   opsel = 3'b101;	/*--SHl*/
       #10;
	   
       /*round 2*/
	   A = 1'b1;
	   B = 1'b0;
	   mode = 1'b0;
	   opsel = 3'b000;
       #10; /*--add*/
	   opsel = 3'b001;	/*--sub with borrowed carry*/	
	   #10;
	   opsel = 3'b010;	/*--move*/
	   #10;
	   opsel = 3'b011;	/*--sub*/
	   #10	;
	   opsel = 3'b100;	/*--increment*/
	   #10;
       opsel = 3'b101;	/*--DEcrement*/
       #10;
	   opsel = 3'b110;	/*--add & increment*/
       #10;
            
	   mode= 1'b1;		/*--------Logic operations starts at 80ns*/
	   opsel = 3'b000;	/*--AND*/
	   #10;
	   opsel = 3'b001;	/*--OR*/
	   #10;
       opsel = 3'b010;	/*--XOR*/
	   #10;
	   opsel = 3'b011;	/*--NOT*/
	   #10;
	   opsel = 3'b101;	/*--SHL*/
     #10;
            /*round 3*/
	   A = 1'b1;
	   B = 1'b1;
	   mode = 1'b0;
	   opsel = 3'b000;
       #10; /*--add*/
	   opsel = 3'b001;	/*--sub with borrowed carry*/	
	   #10;
	   opsel = 3'b010;	/*--move*/
	   #10;
	   opsel = 3'b011;	/*--sub*/
	   #10	;
	   opsel = 3'b100;	/*--increment*/
	   #10;
       opsel = 3'b101;	/*--DEcrement*/
       #10;
	   opsel = 3'b110;	/*--add & increment*/
       #10;
            
	   mode= 1'b1;		/*--------Logic operations starts at 80ns*/
	   opsel = 3'b000;	/*--AND*/
	   #10;
	   opsel = 3'b001;	/*--OR*/
	   #10;
       opsel = 3'b010;	/*--XOR*/
	   #10;
	   opsel = 3'b011;	/*--NOT*/
	   #10;
	   opsel = 3'b101;	/*--SHL*/
     #10;
     
            /*round 4*/
	   A = 1'b0;
	   B = 1'b0;
	   mode = 1'b0;
	   opsel = 3'b000;
       #10; /*--add*/
	   opsel = 3'b001;	/*--sub with borrowed carry*/	
	   #10;
	   opsel = 3'b010;	/*--move*/
	   #10;
	   opsel = 3'b011;	/*--sub*/
	   #10	;
	   opsel = 3'b100;	/*--increment*/
	   #10;
       opsel = 3'b101;	/*--DEcrement*/
       #10;
	   opsel = 3'b110;	/*--add & increment*/
       #10;
            
	   mode= 1'b1;		/*--------Logic operations starts at 80ns*/
	   opsel = 3'b000;	/*--AND*/
	   #10;
	   opsel = 3'b001;	/*--OR*/
	   #10;
       opsel = 3'b010;	/*--XOR*/
	   #10;
	   opsel = 3'b011;	/*--NOT*/
	   #10;
	   opsel = 3'b101;	/*--SHL*/
     #10;
end
endmodule
    