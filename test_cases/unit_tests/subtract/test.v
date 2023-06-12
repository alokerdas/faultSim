module test;
  reg [1:0] pattin;
  wire a, b, c, s, pattout;
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
// subtr starts line no 4
wire [1:0] fsbaro0;
buf (fsbaro0[0], _LOGIC0);
wire hsres0, hsresnot0, in0not0, hs0baro0, hs1baro0;
xor (hsres0, a, b);
not (in0not0, a);
and (hs0baro0, in0not0, b);
xor (s, hsres0, fsbaro0[0]);
not (hsresnot0, hsres0);
and (hs1baro0, hsresnot0, fsbaro0[0]);
or (fsbaro0[1], hs0baro0, hs1baro0);
// subtr ends line no 4
endmodule
