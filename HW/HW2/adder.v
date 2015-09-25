// define gates with delays
`define AND and #50
`define OR or #50
`define NOT not #50

//the behavioral testing conditions to check the structural function
module behavioralFullAdder(sum, carryout, a, b, carryin);
output sum, carryout;			//two outputs
input a, b, carryin;			//two + one input
assign {carryout, sum}=a+b+carryin;	//the function, an adder
endmodule

//the structural, gate-by-gate code
module structuralFullAdder(out, carryout, a, b, carryin);

output out, carryout;			//two outputs
input a, b, carryin;			//two + one input
wire nA, nB, nCi, a0, a1, a2, a3;	//creating all the not wires, as well as the in-between and output wires

//NOT gates for each of the three inputs
`NOT notA(nA,a);
`NOT notB(nB,b);
`NOT notCi(nCi,carryin);

//the AND gates needed for the carry out equation
`AND and0(a0,nA,nB,carryin);
`AND and1(a1,a,nB,nCi);
`AND and2(a2,nA,b,nCi);
`AND and3(a3,a,b,carryin);
//ORing together all the needed AND gates
`OR orCout(out,a0,a1,a2,a3);

//the AND gates needed for the output equation
`AND anda(aa,a,nB,carryin);
`AND andb(ab,nA,b,carryin);
`AND andc(ac,a,b,nCi);
`AND andd(ad,a,b,carryin);
//ORing together all the needed AND gates
`OR orOut(carryout,aa,ab,ac,ad);
endmodule

//start the testing module
module testFullAdder;
//define three input variables with memory
reg a, b, carryin;
//define the two output variables as wires
wire sum, carryout;

//uncomment the behavioral for testing purposes and to compare function with structural
//behavioralFullAdder adder (sum, carryout, a, b, carryin);
structuralFullAdder adder (sum, carryout, a, b, carryin);

initial begin	//starts printing to the transcript
$display("A  B Cin | Cout Output| Expected Output");	//nice formatting for a title line
a=0;b=0;carryin=0; #1000	//sets three inputs to defined values, adds a delay of 1000 time units
$display("%b  %b  %b  |  %b     %b   |     0 0", a, b, carryin, carryout, sum);		//displays formatted inputs and outputs alongside expected outcomes
a=0;b=0;carryin=1; #1000
$display("%b  %b  %b  |  %b     %b   |     0 1", a, b, carryin, carryout, sum);
a=1;b=0;carryin=0; #1000
$display("%b  %b  %b  |  %b     %b   |     0 1", a, b, carryin, carryout, sum);
a=1;b=0;carryin=1; #1000
$display("%b  %b  %b  |  %b     %b   |     1 0", a, b, carryin, carryout, sum);
a=0;b=1;carryin=0; #1000
$display("%b  %b  %b  |  %b     %b   |     0 1", a, b, carryin, carryout, sum);
a=0;b=1;carryin=1; #1000
$display("%b  %b  %b  |  %b     %b   |     1 0", a, b, carryin, carryout, sum);
a=1;b=1;carryin=0; #1000
$display("%b  %b  %b  |  %b     %b   |     1 0", a, b, carryin, carryout, sum);
a=1;b=1;carryin=1; #1000
$display("%b  %b  %b  |  %b     %b   |     1 1", a, b, carryin, carryout, sum);
end
endmodule
