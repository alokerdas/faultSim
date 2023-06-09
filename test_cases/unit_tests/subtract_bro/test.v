module test;
  reg [1:0] pattin;
  wire a, b, c, s, pattout;
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
wire [1:0] _ivl_11;
wire [1:0] _ivl_3;
wire  _ivl_6;
wire [1:0] _ivl_7;
input  a;
input  b;
output  c;
output  s;
assign _ivl_10 = 1'b0;
assign _ivl_6 = 1'b0;
buf (c, _ivl_11[1]);
buf (s, _ivl_11[0]);
// concat starts line no 4
buf (_ivl_3[0], a);
buf (_ivl_3[1], _ivl_6);
// concat ends line no 4
// concat starts line no 4
buf (_ivl_7[0], b);
buf (_ivl_7[1], _ivl_10);
// concat ends line no 4
// subtr starts line no 4
wire [2:0] fsbaro4;
buf (fsbaro4[0], _LOGIC0);
wire [1:0] hsres4, hsresnot4, in0not4, hs0baro4, hs1baro4;
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
// subtr ends line no 4
endmodule
