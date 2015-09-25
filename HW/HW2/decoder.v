// define gates with delays
`define AND and #50
`define OR or #50
`define NOT not #50

//the behavioral testing conditions to check the structural function
module behavioralDecoder(out0,out1,out2,out3, address0,address1, enable);
output out0, out1, out2, out3;		//all outputs, O0-O3
input address0, address1;		//A0 and A1 inputs
input enable;				//Enable input
assign {out3,out2,out1,out0}=enable<<{address1,address0};	//writing the assignments for testing
endmodule

//the structural, gate-by-gate code
module structuralDecoder(out0,out1,out2,out3, address0,address1, enable);
output out0, out1, out2, out3;		//all outputs, O0-O3
input address0, address1;		//A0 and A1 inputs
input enable;				//Enable input
wire notA0, notA1;			//not wires for A0 and A1

//NOT gates for the two address inputs
`NOT nA0(notA0, address0);
`NOT nA1(notA1, address1);

//AND gates for each O output
`AND and0(out0,enable,notA0,notA1);
`AND and1(out1,enable,address0,notA1);
`AND and2(out2,enable,notA0,address1);
`AND and3(out3,enable,address0,address1);

endmodule

//start the testing module
module testDecoder; 
reg addr0, addr1;		//define two input variables with memory
reg enable;			//define the enable input with memory
wire out0,out1,out2,out3;	//define the four outputs as wires

//uncomment the behavioral for testing purposes and to compare function with structural
//behavioralDecoder decoder (out0,out1,out2,out3,addr0,addr1,enable);
structuralDecoder decoder (out0,out1,out2,out3,addr0,addr1,enable);

initial begin	//starts printing to the transcript
$display("En A0 A1| O0 O1 O2 O3 | Expected Output");		//nice formatting for the title line
enable=0;addr0=0;addr1=0; #1000 			//sets all inputs to defined values, adds a delay of 1000 time units
$display("%b  %b  %b |  %b  %b  %b  %b | All false", enable, addr0, addr1, out0, out1, out2, out3);	//displays formatted inputs and outputs alongside expected outcomes
enable=0;addr0=1;addr1=0; #1000
$display("%b  %b  %b |  %b  %b  %b  %b | All false", enable, addr0, addr1, out0, out1, out2, out3);
enable=0;addr0=0;addr1=1; #1000 
$display("%b  %b  %b |  %b  %b  %b  %b | All false", enable, addr0, addr1, out0, out1, out2, out3);
enable=0;addr0=1;addr1=1; #1000 
$display("%b  %b  %b |  %b  %b  %b  %b | All false", enable, addr0, addr1, out0, out1, out2, out3);
enable=1;addr0=0;addr1=0; #1000 
$display("%b  %b  %b |  %b  %b  %b  %b | O0 Only", enable, addr0, addr1, out0, out1, out2, out3);
enable=1;addr0=1;addr1=0; #1000 
$display("%b  %b  %b |  %b  %b  %b  %b | O1 Only", enable, addr0, addr1, out0, out1, out2, out3);
enable=1;addr0=0;addr1=1; #1000 
$display("%b  %b  %b |  %b  %b  %b  %b | O2 Only", enable, addr0, addr1, out0, out1, out2, out3);
enable=1;addr0=1;addr1=1; #1000 
$display("%b  %b  %b |  %b  %b  %b  %b | O3 Only", enable, addr0, addr1, out0, out1, out2, out3);
end
endmodule
