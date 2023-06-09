module test;
  reg [7:0] pattin;
  wire [3:0] pattout;
  wire [3:0] a, b, s;
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
input [3:0] a;
input [3:0] b;
output [3:0] s;
// adr starts line no 4
wire [4:0] facry0;
wire  _LOGIC0;
pulldown (_LOGIC0);
buf (facry0[0], _LOGIC0);
wire [3:0] hares0, haresnot0, in0not0, ha0cry0, ha1cry0;
// bit no 0
xor (hares0[0], a[0], b[0]);
and (ha0cry0[0], a[0], b[0]);
xor (s[0], hares0[0], facry0[0]);
and (ha1cry0[0], hares0[0], facry0[0]);
or (facry0[1], ha0cry0[0], ha1cry0[0]);
// bit no 1
xor (hares0[1], a[1], b[1]);
and (ha0cry0[1], a[1], b[1]);
xor (s[1], hares0[1], facry0[1]);
and (ha1cry0[1], hares0[1], facry0[1]);
or (facry0[2], ha0cry0[1], ha1cry0[1]);
// bit no 2
xor (hares0[2], a[2], b[2]);
and (ha0cry0[2], a[2], b[2]);
xor (s[2], hares0[2], facry0[2]);
and (ha1cry0[2], hares0[2], facry0[2]);
or (facry0[3], ha0cry0[2], ha1cry0[2]);
// bit no 3
xor (hares0[3], a[3], b[3]);
and (ha0cry0[3], a[3], b[3]);
xor (s[3], hares0[3], facry0[3]);
and (ha1cry0[3], hares0[3], facry0[3]);
or (facry0[4], ha0cry0[3], ha1cry0[3]);
// adr ends line no 4
endmodule
