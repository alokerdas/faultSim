module test;
  reg [1:0] pattin;
  wire a, b;
  wire o, pattout;
  reg [10*8:0] patFile, fltFile, rptFile;

  assign {a, b} = pattin;
  assign pattout = o;
  gate g1(a, b, o);
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
a,
b,
o
);
input  a;
input  b;
output  o;
nor (o, a, b);
endmodule
