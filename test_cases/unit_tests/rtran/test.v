module test;
  reg pattin;
  wire a, o, pattout;
  reg [10*8:0] patFile, fltFile, rptFile;

  assign a = pattin;
  assign pattout = o;
  gate g1(a, o);
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
o
);
input  a;
output  o;
rtran (a, o);
endmodule
