module test;
  reg [1:0] pattin;
  wire [1:0] pattout;
  wire a, b, s, c;
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
wire  _LOGIC0;
pulldown (_LOGIC0);
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
// adr starts line no 4
wire [2:0] facry4;
buf (facry4[0], _LOGIC0);
wire [1:0] hares4, haresnot4, in0not4, ha0cry4, ha1cry4;
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
// adr ends line no 4
endmodule
