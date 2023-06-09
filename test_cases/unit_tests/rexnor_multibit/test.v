module test;
  reg [7:0] pattin;
  wire a, o, pattout;
  reg [10*8:0] patFile, fltFile, rptFile;

  assign a = pattin;
  assign pattout = o;
  gate g1(o, a);
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
a
);
input [7:0] a;
output  o;
// renxor starts line no 4
wire [6:0] rewire0;
xor (rewire0[0], a[1], a[0]);
xor (rewire0[1], a[2], rewire0[0]);
xor (rewire0[2], a[3], rewire0[1]);
xor (rewire0[3], a[4], rewire0[2]);
xor (rewire0[4], a[5], rewire0[3]);
xor (rewire0[5], a[6], rewire0[4]);
xor (rewire0[6], a[7], rewire0[5]);
not (o, rewire0[6]);
// renxor ends line no 4
endmodule
