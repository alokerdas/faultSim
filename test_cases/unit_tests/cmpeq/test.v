module test;
  reg [3:0] pattin;
  wire [1:0] a, b;
  wire o, pattout;
  reg [10*8:0] patFile, fltFile, rptFile;

  assign {a, b} = pattin;
  assign pattout = o;
  gate g1(o, a, b);
  initial
  begin
    patFile = "pat.txt";
    fltFile = "fault.txt";
    rptFile = "fault.rpt";
    $faultEnumerate(fltFile);
    $generatePatterns(pattin, pattout, fltFile, patFile, rptFile);
  end
endmodule
						      
module gate (
o,
a,
b
);
input [1:0] a;
input [1:0] b;
output  o;
// cmpeq starts line no 4
wire [1:0] cmpeqwire0;
wire [0:0] reorwire0;
xor (cmpeqwire0[0], a[0], b[0]);
xor (cmpeqwire0[1], a[1], b[1]);
or (reorwire0[0], cmpeqwire0[1], cmpeqwire0[0]);
not (o, reorwire0[0]);
// cmpeq ends line no 4
endmodule
