module mips_tb ();

	bit clk, rst, req, ack, rwb, oeb;
	logic [5:0] dma_addr, dma_addrout, instr_addr;
	logic [31:0] dma_data, dma_dataout, instr_data;
	reg [31:0] reg_file [63 :0]; 
	
	dma D1(
        .clk(clk)
        ,.rst(rst)
        ,.req(req)
        ,.addr(dma_addr)
        ,.data(dma_data)
        ,.ack(ack)
		,.addr_o(dma_addrout)
		,.data_o(dma_dataout)
        );
	
	mem64x32 M1(
		,.a(instr_addr)
		,.d(instr_data)
		,.rwb(rwb)
		,.oeb(oeb)
	);
	
	controller_2 C1(
		.clk(clk)
		,.rst(rst)
	);
	initial begin 
	
	clk = 0;
	//Main Memory (64 addresses)
	reg_file [0] <= 32'b10000000000011011111111111111111;
	reg_file [1] <= 32'b10000010000101011011111111111101;
	reg_file [2] <= 32'b10000100000111011000000110111111;
	reg_file [3] <= 32'b10000110001001011101101010001001;
	reg_file [4] <= 32'b00000010001010000000010000000000;
	reg_file [5] <= 32'b00000100001100001000011000000000;
	reg_file [6] <= 32'b00001000001110010000010000000000;
	reg_file [7] <= 32'b00000010010000011000100000000000;
	reg_file [8] <= 32'b00001000010010101000011000000000;
	reg_file [9] <= 32'b00000110010100110000001000000000;
	reg_file [10] <= 32'b00000010010110111000010000000000;
	reg_file [11] <= 32'b00000010011001000000100000000000;
	reg_file [12] <= 32'b00000100011011001000001000000000;
	reg_file [13] <= 32'b00001000011101011000010000000000;
	reg_file [14] <= 32'b00000110011111011000100000000000;
	reg_file [15] <= 32'b00000100100001001000011000000000;
	reg_file [16] <= 32'b00001000100011000000001000000000;
	reg_file [17] <= 32'b00000010100100111000010000000000;
	reg_file [18] <= 32'b00000100100110110000100000000000;
	reg_file [19] <= 32'b00001000101000101000001000000000;
	reg_file [20] <= 32'b00000110101010011000010000000000;
	reg_file [21] <= 32'b00000100101100010000100000000000;
	reg_file [22] <= 32'b00001000101110001000001000000000;
	reg_file [23] <= 32'b00000110110000000000010000000000;
	reg_file [24] <= 32'b00000010110010000000100000000000;
	reg_file [25] <= 32'b00001000110100001000001000000000;
	reg_file [26] <= 32'b00000110110110010000010000000000;
	reg_file [27] <= 32'b00000100111000011000100000000000;
	reg_file [28] <= 32'b00000110111010101000001000000000;
	reg_file [29] <= 32'b00000110111100110000100000000000;
	reg_file [30] <= 32'b00000010111110111000010000000000;
	reg_file [31] <= 32'b00001001000001000000001000000000;
	reg_file [32] <= 32'b00000011000011011000010000001011;
	reg_file [33] <= 32'b00001001000101011000100000001011;
	reg_file [34] <= 32'b00000111000111011001000000001011;
	reg_file [35] <= 32'b00000101001001011001011000001111;
	reg_file [36] <= 32'b10000101001010000001001000010000;
	reg_file [37] <= 32'b10001001001100001000101000000000;
	reg_file [38] <= 32'b10000011001110010001001000000000;
	reg_file [39] <= 32'b10001001010000011010010000000000;
	reg_file [40] <= 32'b10000111010010101001011000000000;
	reg_file [41] <= 32'b10000011010100110010010000000000;
	reg_file [42] <= 32'b10000011010110111100100000000000;
	reg_file [43] <= 32'b10000101011001000100100000000000;
	reg_file [44] <= 32'b10001001011011001100101000000000;
	reg_file [45] <= 32'b10000111011101011100110000000000;
	reg_file [46] <= 32'b10000101011111011110110000000000;
	reg_file [47] <= 32'b10001001100001001010110000000000;
	reg_file [48] <= 32'b10000011100011000011101000000000;
	reg_file [49] <= 32'b10001001100100111000001000000000;
	reg_file [50] <= 32'b10000011100110110000000000000000;
	reg_file [51] <= 32'b10000101101000101000100000000000;
	reg_file [52] <= 32'b10001001101010011000001000000000;
	reg_file [53] <= 32'b10000111101100010000100000000000;
	reg_file [54] <= 32'b10000101101110001000110000000000;
	reg_file [55] <= 32'b10001001110000000000111000000000;
	reg_file [56] <= 32'b10000111110010001001000000000000;
	reg_file [57] <= 32'b10000011110100010001001000000000;
	reg_file [58] <= 32'b10000101101110011010000000000000;
	reg_file [59] <= 32'b10000101111000101100010000000000;
	reg_file [60] <= 32'b10000011111010110000010000000000;
	reg_file [61] <= 32'b10001001111100111000001000000000;
	reg_file [62] <= 32'b10000111111111000000000000000000;
	reg_file [63] <= 32'b10000010000000000000000000000000;
	
	for (x = 0; x < 64; x = x + 1) begin		//Load instructions from main memory through DMA to instruction memory
		#50;
		req = 1'b1;
		dma_data <= reg_file[x];
		dma_addr <= $realtobits($itor(x));
		if (ack == 1) begin
			#100
			rwb = 1'b0;
			instr_addr <= dma_addr;
			instr_data <= dma_data;
		end
		#50;
	end	
	
	$finish;
end

always #50 clk = ~clk;	
	
	