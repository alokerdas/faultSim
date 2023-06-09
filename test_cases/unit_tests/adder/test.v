module test;
  reg [1:0] pattin;
  wire pattout;
  wire a, b, s;
  reg [10*8:0] patFile, fltFile, rptFile;
  
  assign {a, b} = pattin;
  assign pattout = s;
  gate g1(s, a, b);
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
s,
a,
b
);
input  a;
input  b;
output  s;
// adr starts line no 4
wire [1:0] facry0;
wire  _LOGIC0;
pulldown (_LOGIC0);
buf (facry0[0], _LOGIC0);
wire hares0, haresnot0, in0not0, ha0cry0, ha1cry0;
xor (hares0, a, b);
and (ha0cry0, a, b);
xor (s, hares0, facry0[0]);
and (ha1cry0, hares0, facry0[0]);
or (facry0[1], ha0cry0, ha1cry0);
// adr ends line no 4
endmodule
