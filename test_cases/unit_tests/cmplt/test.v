module test;
  reg [1:0] pattin;
  wire a, b;
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
input  a;
input  b;
output  o;
// cmpgt starts line no 4
wire cmpgtIN1not0;
not (cmpgtIN1not0, a);
and (o, b, cmpgtIN1not0);
// cmpgt ends line no 4
endmodule
