module test;
  reg [7:0] pattin;
  wire c;
  wire [3:0] a, b, s;
  wire [4:0] pattout;
  reg [10*8:0] patFile, fltFile, rptFile;

  assign {a, b} = pattin;
  assign pattout = {s, c};
  gate g1(s, c, a, b);
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
c,
a,
b
);
wire  _ivl_10;
wire [4:0] _ivl_11;
wire [4:0] _ivl_3;
wire  _ivl_6;
wire [4:0] _ivl_7;
input [3:0] a;
input [3:0] b;
output  c;
output [3:0] s;
assign _ivl_10 = 1'b0;
assign _ivl_6 = 1'b0;
buf (c, _ivl_11[4]);
buf (s[0], _ivl_11[0]);
buf (s[1], _ivl_11[1]);
buf (s[2], _ivl_11[2]);
buf (s[3], _ivl_11[3]);
// concat starts line no 5
buf (_ivl_3[0], a[0]);
buf (_ivl_3[1], a[1]);
buf (_ivl_3[2], a[2]);
buf (_ivl_3[3], a[3]);
buf (_ivl_3[4], _ivl_6);
// concat ends line no 5
// concat starts line no 5
buf (_ivl_7[0], b[0]);
buf (_ivl_7[1], b[1]);
buf (_ivl_7[2], b[2]);
buf (_ivl_7[3], b[3]);
buf (_ivl_7[4], _ivl_10);
// concat ends line no 5
// subtr starts line no 5
wire [5:0] fsbaro4;
buf (fsbaro4[0], _LOGIC0);
wire [4:0] hsres4, hsresnot4, in0not4, hs0baro4, hs1baro4;
// bit no 0
xor (hsres4[0], _ivl_3[0], _ivl_7[0]);
not (in0not4[0], _ivl_3[0]);
and (hs0baro4[0], in0not4[0], _ivl_7[0]);
xor (_ivl_11[0], hsres4[0], fsbaro4[0]);
not (hsresnot4[0], hsres4[0]);
and (hs1baro4[0], hsresnot4[0], fsbaro4[0]);
or (fsbaro4[1], hs0baro4[0], hs1baro4[0]);
// bit no 1
xor (hsres4[1], _ivl_3[1], _ivl_7[1]);
not (in0not4[1], _ivl_3[1]);
and (hs0baro4[1], in0not4[1], _ivl_7[1]);
xor (_ivl_11[1], hsres4[1], fsbaro4[1]);
not (hsresnot4[1], hsres4[1]);
and (hs1baro4[1], hsresnot4[1], fsbaro4[1]);
or (fsbaro4[2], hs0baro4[1], hs1baro4[1]);
// bit no 2
xor (hsres4[2], _ivl_3[2], _ivl_7[2]);
not (in0not4[2], _ivl_3[2]);
and (hs0baro4[2], in0not4[2], _ivl_7[2]);
xor (_ivl_11[2], hsres4[2], fsbaro4[2]);
not (hsresnot4[2], hsres4[2]);
and (hs1baro4[2], hsresnot4[2], fsbaro4[2]);
or (fsbaro4[3], hs0baro4[2], hs1baro4[2]);
// bit no 3
xor (hsres4[3], _ivl_3[3], _ivl_7[3]);
not (in0not4[3], _ivl_3[3]);
and (hs0baro4[3], in0not4[3], _ivl_7[3]);
xor (_ivl_11[3], hsres4[3], fsbaro4[3]);
not (hsresnot4[3], hsres4[3]);
and (hs1baro4[3], hsresnot4[3], fsbaro4[3]);
or (fsbaro4[4], hs0baro4[3], hs1baro4[3]);
// bit no 4
xor (hsres4[4], _ivl_3[4], _ivl_7[4]);
not (in0not4[4], _ivl_3[4]);
and (hs0baro4[4], in0not4[4], _ivl_7[4]);
xor (_ivl_11[4], hsres4[4], fsbaro4[4]);
not (hsresnot4[4], hsres4[4]);
and (hs1baro4[4], hsresnot4[4], fsbaro4[4]);
or (fsbaro4[5], hs0baro4[4], hs1baro4[4]);
// subtr ends line no 5
endmodule
