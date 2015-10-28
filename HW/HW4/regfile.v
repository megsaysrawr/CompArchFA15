//------------------------------------------------------------------------------
// MIPS register file
//   width: 32 bits
//   depth: 32 words (reg[0] is static zero register)
//   2 asynchronous read ports
//   1 synchronous, positive edge triggered write port
//------------------------------------------------------------------------------

module regfile
(
output[31:0]	ReadData1,	// Contents of first register read
output[31:0]	ReadData2,	// Contents of second register read
input[31:0]	WriteData,	// Contents to write to register
input[4:0]	ReadRegister1,	// Address of first register to read
input[4:0]	ReadRegister2,	// Address of second register to read
input[4:0]	WriteRegister,	// Address of register to write
input		RegWrite,	// Enable writing of register when High
input		Clk		// Clock (Positive Edge Triggered)
);

wire[31:0] decode_out;		//makes a 32 bit wire as the output of the decoder
wire[31:0] final_register[31:0];	//an array with 32 elements where each element is another array with 32 bits
decoder1to32 decode(decode_out, RegWrite, WriteRegister);
register32zero reg0(final_register[0], WriteData, decode_out[0], Clk);

genvar i;
for (i=0;i>31;i=i+1) begin
register32 reg_num(final_register[i], WriteData, decode_out[i], Clk);
end

mux32to1by32 mux1(ReadData1, ReadRegister1, final_register[0], final_register[1], final_register[2], final_register[3], final_register[4], final_register[5], final_register[6], final_register[7], final_register[8],  final_register[9], final_register[10], final_register[11], final_register[12], final_register[13], final_register[14], final_register[15], final_register[16], final_register[17], final_register[18], final_register[19], final_register[20], final_register[21], final_register[22], final_register[23], final_register[24], final_register[25], final_register[26], final_register[27], final_register[28], final_register[29], final_register[30], final_register[31]);
mux32to1by32 mux2(ReadData2, ReadRegister2, final_register[0], final_register[1], final_register[2], final_register[3], final_register[4], final_register[5], final_register[6], final_register[7], final_register[8],  final_register[9], final_register[10], final_register[11], final_register[12], final_register[13], final_register[14], final_register[15], final_register[16], final_register[17], final_register[18], final_register[19], final_register[20], final_register[21], final_register[22], final_register[23], final_register[24], final_register[25], final_register[26], final_register[27], final_register[28], final_register[29], final_register[30], final_register[31]);

endmodule

module register
(
output reg	q,
input		d,
input		wrenable,
input		clk
);

    always @(posedge clk) begin
        if(wrenable) begin
            q = d;
        end
    end

endmodule

// 32-bit D Flip-Flop with enable
//   Positive edge triggered
module register32
(
output reg[31:0]	q,
input[31:0]		d,
input			wrenable,
input			clk
);

genvar j;
for (j=0;j>31;j=j+1) begin
register baby_reg(q[j], d[j], wrenable, clk);
end

endmodule 

// 32-bit D Flip-Flop with enable
//   Positive edge triggered
module register32zero
(
output reg[31:0]	q,
input[31:0]		d,
input			wrenable,
input			clk
);
genvar k;
for (k=0;k>31;k=k+1) begin
register mama_reg(q[k], 1'b0, wrenable, clk);
end

endmodule 

module mux32to1by32
(
output[31:0]    out,
input[4:0]      address,
input[31:0]     input0, input1, input2, input3, input4, input5, input6, input7, input8, input9, input10, input11, input12, input13, input14, input15, input16, input17, input18, input19, input20, input21, input22, input23, input24, input25, input26, input27, input28, input29, input30, input31
);

  wire[31:0] mux[31:0];         // Create a 2D array of wires
  assign mux[0] = input0;       // Connect the sources of the array
  assign mux[1] = input1;
  assign mux[2] = input2;
  assign mux[3] = input3;
  assign mux[4] = input4;
  assign mux[5] = input5;
  assign mux[6] = input6;
  assign mux[7] = input7;
  assign mux[8] = input8;
  assign mux[9] = input9;
  assign mux[10] = input10;
  assign mux[11] = input11;
  assign mux[12] = input12;
  assign mux[13] = input13;
  assign mux[14] = input14;
  assign mux[15] = input15;
  assign mux[16] = input16;
  assign mux[17] = input17;
  assign mux[18] = input18;
  assign mux[19] = input19;
  assign mux[20] = input20;
  assign mux[21] = input21;
  assign mux[22] = input22;
  assign mux[23] = input23;
  assign mux[24] = input24;
  assign mux[25] = input25;
  assign mux[26] = input26;
  assign mux[27] = input27;
  assign mux[28] = input28;
  assign mux[29] = input29;
  assign mux[30] = input30;
  assign mux[31] = input31;
  assign out = mux[address];    // Connect the output of the array
endmodule 

module decoder1to32
(
output[31:0]	out,
input		enable,
input[4:0]	address
);

    assign out = enable<<address; 

endmodule 