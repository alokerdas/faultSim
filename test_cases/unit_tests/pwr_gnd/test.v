module test;
  reg pattin;
  wire a, o, pattout;
  reg [10*8:0] patFile, fltFile, rptFile;
    
  assign pattout = {a, o};
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
wire  _vdd;
wire  _vss;
output  a;
output  o;
pullup (_vdd);
pulldown (_vss);
buf (o, _vdd);
buf (a, _vss);
endmodule
