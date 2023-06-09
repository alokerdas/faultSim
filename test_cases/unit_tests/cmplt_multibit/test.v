module test;
  reg [7:0] pattin;
  wire [3:0] a, b;
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
input [3:0] a;
input [3:0] b;
output  o;
// cmpgt starts line no 4
wire [3:0] cmpgtIN0not0, cmpgtIN1not0, cmpgtGT0, cmpgtLT0, cmpgtEQ0;
not (cmpgtIN0not0[0], b[0]);
not (cmpgtIN1not0[0], a[0]);
and (cmpgtGT0[0], b[0], cmpgtIN1not0[0]);
and (cmpgtLT0[0], cmpgtIN0not0[0], a[0]);
nor (cmpgtEQ0[0], cmpgtGT0[0], cmpgtLT0[0]);
not (cmpgtIN0not0[1], b[1]);
not (cmpgtIN1not0[1], a[1]);
and (cmpgtGT0[1], b[1], cmpgtIN1not0[1]);
and (cmpgtLT0[1], cmpgtIN0not0[1], a[1]);
nor (cmpgtEQ0[1], cmpgtGT0[1], cmpgtLT0[1]);
not (cmpgtIN0not0[2], b[2]);
not (cmpgtIN1not0[2], a[2]);
and (cmpgtGT0[2], b[2], cmpgtIN1not0[2]);
and (cmpgtLT0[2], cmpgtIN0not0[2], a[2]);
nor (cmpgtEQ0[2], cmpgtGT0[2], cmpgtLT0[2]);
not (cmpgtIN0not0[3], b[3]);
not (cmpgtIN1not0[3], a[3]);
and (cmpgtGT0[3], b[3], cmpgtIN1not0[3]);
and (cmpgtLT0[3], cmpgtIN0not0[3], a[3]);
nor (cmpgtEQ0[3], cmpgtGT0[3], cmpgtLT0[3]);
wire [2:0] cmpgtout0, cmpgtEQand0, cmpgtGTEQ0;
buf (cmpgtEQand0[2], cmpgtEQ0[3]);
buf (cmpgtout0[2], cmpgtGT0[3]);
and (cmpgtEQand0[1], cmpgtEQand0[2], cmpgtEQ0[2]);
and (cmpgtGTEQ0[2], cmpgtEQand0[2], cmpgtGT0[2]);
or (cmpgtout0[1], cmpgtout0[2], cmpgtGTEQ0[2]);
and (cmpgtEQand0[0], cmpgtEQand0[1], cmpgtEQ0[1]);
and (cmpgtGTEQ0[1], cmpgtEQand0[1], cmpgtGT0[1]);
or (cmpgtout0[0], cmpgtout0[1], cmpgtGTEQ0[1]);
and (cmpgtGTEQ0[0], cmpgtEQand0[0], cmpgtGT0[0]);
or (o, cmpgtout0[0], cmpgtGTEQ0[0]);
// cmpgt ends line no 4
endmodule
