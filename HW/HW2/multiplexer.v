// define gates with delays
`define AND and #50
`define OR or #50
`define NOT not #50

module behavioralMultiplexer(out, address0,address1, in0,in1,in2,in3);
output out;
input address0, address1;
input in0, in1, in2, in3;
wire[3:0] inputs = {in3, in2, in1, in0};
wire[1:0] address = {address1, address0};
assign out = inputs[address];
endmodule

module structuralMultiplexer(out, address0,address1, in0,in1,in2,in3);
output out;
input address0, address1;
input in0, in1, in2, in3;
wire nA0, nA1, i0and, i1and, i2and, i3and;

`NOT notA0(nA0, address0);
`NOT notA1(nA1, address1); 

`AND and0(i0and,address0,address1,in3);
`AND and1(i1and,nA0,address1,in2);
`AND and2(i2and,address0,nA1,in1);
`AND and3(i3and,nA0,nA1,in0);

`OR finalor(out,i0and,i1and,i2and,i3and);

endmodule

module testMultiplexer;
reg address0, address1;
wire out;
reg in0, in1, in2, in3;
//behavioralMultiplexer multiplexer (out, address0,address1, in0,in1,in2,in3);
structuralMultiplexer multiplexer (out, address0,address1, in0,in1,in2,in3);
initial begin
$display("A0 A1| I0 I1 I2 I3 | Output | Expected Output");
address0=1;address1=1; in0=1'bX;in1=1'bX;in2=1'bX;in3=0; #1000
$display("%b  %b |  %b  %b  %b  %b | %b | 0", address0, address1, in0, in1, in2, in3, out);
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
