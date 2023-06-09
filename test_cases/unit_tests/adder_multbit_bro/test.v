module test;
  reg [7:0] pattin;
  wire [4:0] pattout;
  wire [3:0] a, b, s;
  wire c;
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
wire  _LOGIC0;
pulldown (_LOGIC0);
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
// adr starts line no 5
wire [5:0] facry4;
buf (facry4[0], _LOGIC0);
wire [4:0] hares4, haresnot4, in0not4, ha0cry4, ha1cry4;
// bit no 0
xor (hares4[0], _ivl_3[0], _ivl_7[0]);
and (ha0cry4[0], _ivl_3[0], _ivl_7[0]);
xor (_ivl_11[0], hares4[0], facry4[0]);
and (ha1cry4[0], hares4[0], facry4[0]);
or (facry4[1], ha0cry4[0], ha1cry4[0]);
// bit no 1
xor (hares4[1], _ivl_3[1], _ivl_7[1]);
and (ha0cry4[1], _ivl_3[1], _ivl_7[1]);
xor (_ivl_11[1], hares4[1], facry4[1]);
and (ha1cry4[1], hares4[1], facry4[1]);
or (facry4[2], ha0cry4[1], ha1cry4[1]);
// bit no 2
xor (hares4[2], _ivl_3[2], _ivl_7[2]);
and (ha0cry4[2], _ivl_3[2], _ivl_7[2]);
xor (_ivl_11[2], hares4[2], facry4[2]);
and (ha1cry4[2], hares4[2], facry4[2]);
or (facry4[3], ha0cry4[2], ha1cry4[2]);
// bit no 3
xor (hares4[3], _ivl_3[3], _ivl_7[3]);
and (ha0cry4[3], _ivl_3[3], _ivl_7[3]);
xor (_ivl_11[3], hares4[3], facry4[3]);
and (ha1cry4[3], hares4[3], facry4[3]);
or (facry4[4], ha0cry4[3], ha1cry4[3]);
// bit no 4
xor (hares4[4], _ivl_3[4], _ivl_7[4]);
and (ha0cry4[4], _ivl_3[4], _ivl_7[4]);
xor (_ivl_11[4], hares4[4], facry4[4]);
and (ha1cry4[4], hares4[4], facry4[4]);
or (facry4[5], ha0cry4[4], ha1cry4[4]);
// adr ends line no 5
endmodule
