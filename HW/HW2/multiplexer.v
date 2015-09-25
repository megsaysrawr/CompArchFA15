// define gates with delays
`define AND and #50
`define OR or #50
`define NOT not #50

//the behavioral testing conditions to check the structural function
module behavioralMultiplexer(out, address0,address1, in0,in1,in2,in3);
output out;					//output
input address0, address1;			//A0 and A1 inputs
input in0, in1, in2, in3;			//I0-I3 inputs
wire[3:0] inputs = {in3, in2, in1, in0};	//wires for I0-I3 inputs
wire[1:0] address = {address1, address0};	//wires for A0 and A1 inputs
assign out = inputs[address];			//writing the assignments for testing
endmodule

//the structural, gate-by-gate code
module structuralMultiplexer(out, address0,address1, in0,in1,in2,in3);
output out;					//one output
input address0, address1;			//A0 and A1 inputs
input in0, in1, in2, in3;			//I0-I3 inputs
wire nA0, nA1, i0and, i1and, i2and, i3and;	//not wires and the the in-between and wires

//NOT gates for the two address inputs
`NOT notA0(nA0, address0);
`NOT notA1(nA1, address1); 

//AND gates for each I input
`AND and0(i0and,address0,address1,in3);
`AND and1(i1and,nA0,address1,in2);
`AND and2(i2and,address0,nA1,in1);
`AND and3(i3and,nA0,nA1,in0);

//ORing together all of the 4 AND gates
`OR finalor(out,i0and,i1and,i2and,i3and);

endmodule

//start the testing module
module testMultiplexer;
reg address0, address1;		//define two input variables with memory
wire out;			//define the output as a wire
reg in0, in1, in2, in3;		//define four more input variables with memory

//uncomment the behavioral for testing purposes and to compare function with structural
//behavioralMultiplexer multiplexer (out, address0,address1, in0,in1,in2,in3);
structuralMultiplexer multiplexer (out, address0,address1, in0,in1,in2,in3);

initial begin	//starts printing to the transcript
$display("A0 A1| I0 I1 I2 I3 | Output | Expected Output");	//nice formatting for the title line
address0=1;address1=1; in0=1'bX;in1=1'bX;in2=1'bX;in3=0; #1000		//sets all inputs to defined values, 1'bX means "don't care" aka X, adds a delay of 1000 time units
$display("%b  %b |  %b  %b  %b  %b | %b | 0", address0, address1, in0, in1, in2, in3, out);	//displays formatted inputs and outputs alongside expected outcomes
address0=1;address1=1; in0=1'bX;in1=1'bX;in2=1'bX;in3=1; #1000
$display("%b  %b |  %b  %b  %b  %b | %b | 1", address0, address1, in0, in1, in2, in3, out);
address0=0;address1=1; in0=1'bX;in1=1'bX;in2=0;in3=1'bX; #1000
$display("%b  %b |  %b  %b  %b  %b | %b | 0", address0, address1, in0, in1, in2, in3, out);
address0=0;address1=1; in0=1'bX;in1=1'bX;in2=1;in3=1'bX; #1000
$display("%b  %b |  %b  %b  %b  %b | %b | 1", address0, address1, in0, in1, in2, in3, out);
address0=1;address1=0; in0=1'bX;in1=0;in2=1'bX;in3=1'bX; #1000
$display("%b  %b |  %b  %b  %b  %b | %b | 0", address0, address1, in0, in1, in2, in3, out);
address0=1;address1=0; in0=1'bX;in1=1;in2=1'bX;in3=1'bX; #1000
$display("%b  %b |  %b  %b  %b  %b | %b | 1", address0, address1, in0, in1, in2, in3, out);
address0=0;address1=0; in0=0;in1=1'bX;in2=1'bX;in3=1'bX; #1000
$display("%b  %b |  %b  %b  %b  %b | %b | 0", address0, address1, in0, in1, in2, in3, out);
address0=0;address1=0; in0=1;in1=1'bX;in2=1'bX;in3=1'bX; #1000
$display("%b  %b |  %b  %b  %b  %b | %b | 1", address0, address1, in0, in1, in2, in3, out);
end
endmodule
