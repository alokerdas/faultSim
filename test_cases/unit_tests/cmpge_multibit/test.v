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
// cmpge starts line no 4
wire [3:0] cmpgeIN0not0, cmpgeIN1not0, cmpgeGT0, cmpgeLT0, cmpgeEQ0;
not (cmpgeIN0not0[0], a[0]);
not (cmpgeIN1not0[0], b[0]);
and (cmpgeGT0[0], a[0], cmpgeIN1not0[0]);
and (cmpgeLT0[0], cmpgeIN0not0[0], b[0]);
nor (cmpgeEQ0[0], cmpgeGT0[0], cmpgeLT0[0]);
not (cmpgeIN0not0[1], a[1]);
not (cmpgeIN1not0[1], b[1]);
and (cmpgeGT0[1], a[1], cmpgeIN1not0[1]);
and (cmpgeLT0[1], cmpgeIN0not0[1], b[1]);
nor (cmpgeEQ0[1], cmpgeGT0[1], cmpgeLT0[1]);
not (cmpgeIN0not0[2], a[2]);
not (cmpgeIN1not0[2], b[2]);
and (cmpgeGT0[2], a[2], cmpgeIN1not0[2]);
and (cmpgeLT0[2], cmpgeIN0not0[2], b[2]);
nor (cmpgeEQ0[2], cmpgeGT0[2], cmpgeLT0[2]);
not (cmpgeIN0not0[3], a[3]);
not (cmpgeIN1not0[3], b[3]);
and (cmpgeGT0[3], a[3], cmpgeIN1not0[3]);
and (cmpgeLT0[3], cmpgeIN0not0[3], b[3]);
nor (cmpgeEQ0[3], cmpgeGT0[3], cmpgeLT0[3]);
wire [2:0] cmpgeout0, cmpgeEQand0, cmpgeLTEQ0;
buf (cmpgeEQand0[2], cmpgeEQ0[3]);
buf (cmpgeout0[2], cmpgeLT0[3]);
and (cmpgeEQand0[1], cmpgeEQand0[2], cmpgeEQ0[2]);
and (cmpgeLTEQ0[2], cmpgeEQand0[2], cmpgeLT0[2]);
or (cmpgeout0[1], cmpgeout0[2], cmpgeLTEQ0[2]);
and (cmpgeEQand0[0], cmpgeEQand0[1], cmpgeEQ0[1]);
and (cmpgeLTEQ0[1], cmpgeEQand0[1], cmpgeLT0[1]);
or (cmpgeout0[0], cmpgeout0[1], cmpgeLTEQ0[1]);
and (cmpgeLTEQ0[0], cmpgeEQand0[0], cmpgeLT0[0]);
nor (o, cmpgeout0[0], cmpgeLTEQ0[0]);
// cmpge ends line no 4
endmodule
