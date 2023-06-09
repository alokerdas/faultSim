module test;
  reg [7:0] pattin;
  wire [3:0] a, b, s, pattout;
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
// subtr starts line no 4
wire [4:0] fsbaro0;
buf (fsbaro0[0], _LOGIC0);
wire [3:0] hsres0, hsresnot0, in0not0, hs0baro0, hs1baro0;
// bit no 0
xor (hsres0[0], a[0], b[0]);
not (in0not0[0], a[0]);
and (hs0baro0[0], in0not0[0], b[0]);
xor (s[0], hsres0[0], fsbaro0[0]);
not (hsresnot0[0], hsres0[0]);
and (hs1baro0[0], hsresnot0[0], fsbaro0[0]);
or (fsbaro0[1], hs0baro0[0], hs1baro0[0]);
// bit no 1
xor (hsres0[1], a[1], b[1]);
not (in0not0[1], a[1]);
and (hs0baro0[1], in0not0[1], b[1]);
xor (s[1], hsres0[1], fsbaro0[1]);
not (hsresnot0[1], hsres0[1]);
and (hs1baro0[1], hsresnot0[1], fsbaro0[1]);
or (fsbaro0[2], hs0baro0[1], hs1baro0[1]);
// bit no 2
xor (hsres0[2], a[2], b[2]);
not (in0not0[2], a[2]);
and (hs0baro0[2], in0not0[2], b[2]);
xor (s[2], hsres0[2], fsbaro0[2]);
not (hsresnot0[2], hsres0[2]);
and (hs1baro0[2], hsresnot0[2], fsbaro0[2]);
or (fsbaro0[3], hs0baro0[2], hs1baro0[2]);
// bit no 3
xor (hsres0[3], a[3], b[3]);
not (in0not0[3], a[3]);
and (hs0baro0[3], in0not0[3], b[3]);
xor (s[3], hsres0[3], fsbaro0[3]);
not (hsresnot0[3], hsres0[3]);
and (hs1baro0[3], hsresnot0[3], fsbaro0[3]);
or (fsbaro0[4], hs0baro0[3], hs1baro0[3]);
// subtr ends line no 4
endmodule
