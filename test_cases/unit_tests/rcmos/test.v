module test;
  reg [1:0] pattin;
  wire a, ctl, o, pattout;
  reg [10*8:0] patFile, fltFile, rptFile;

  assign {a, ctl} = pattin;
  assign pattout = o;
  gate g1(a, ctl, o);
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
ctrl,
o
);
input  a;
input  ctrl;
output  o;
rcmos (o, a, ctrl, ctrl);
endmodule
