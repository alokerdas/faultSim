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
// reand starts line no 4
wire [6:0] rewire0;
and (rewire0[0], a[1], a[0]);
and (rewire0[1], a[2], rewire0[0]);
and (rewire0[2], a[3], rewire0[1]);
and (rewire0[3], a[4], rewire0[2]);
and (rewire0[4], a[5], rewire0[3]);
and (rewire0[5], a[6], rewire0[4]);
and (rewire0[6], a[7], rewire0[5]);
buf (o, rewire0[6]);
// reand ends line no 4
endmodule
