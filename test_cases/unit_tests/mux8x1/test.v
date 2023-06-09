module test;
  reg [10:0] pattin;
  wire a, b, c, d, e, f, g, h;
  wire [2:0] sl;
  wire o, pattout;
  reg [10*8:0] patFile, fltFile, rptFile;

  assign {a, b, c, d, e, f, g, h, sl} = pattin;
  assign pattout = o;
  gate g1(o, a, b, d, c, e, f, g, h, sl);
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
b,
d,
c,
e,
f,
g,
h,
sl
);
wire  _LOGIC0;
wire  _LOGIC1;
input  a;
input  b;
input  c;
input  d;
input  e;
input  f;
input  g;
input  h;
output  o;
input [2:0] sl;
pullup (_LOGIC1);
pulldown (_LOGIC0);
// mux starts line no 0
wire [2:0] wireSnot0;
wire [3:0] wireASnot00, wireBS00, muxOut00;
not (wireSnot0[0], sl[0]);
and (wireASnot00[0], a, wireSnot0[0]);
and (wireBS00[0], b, sl[0]);
or (muxOut00[0], wireASnot00[0], wireBS00[0]);
and (wireASnot00[1], c, wireSnot0[0]);
and (wireBS00[1], d, sl[0]);
or (muxOut00[1], wireASnot00[1], wireBS00[1]);
and (wireASnot00[2], e, wireSnot0[0]);
and (wireBS00[2], f, sl[0]);
or (muxOut00[2], wireASnot00[2], wireBS00[2]);
and (wireASnot00[3], g, wireSnot0[0]);
and (wireBS00[3], h, sl[0]);
or (muxOut00[3], wireASnot00[3], wireBS00[3]);
wire [1:0] wireASnot01, wireBS01, muxOut01;
not (wireSnot0[1], sl[1]);
and (wireASnot01[0], muxOut00[0], wireSnot0[1]);
and (wireBS01[0], muxOut00[1], sl[1]);
or (muxOut01[0], wireASnot01[0], wireBS01[0]);
and (wireASnot01[1], muxOut00[2], wireSnot0[1]);
and (wireBS01[1], muxOut00[3], sl[1]);
or (muxOut01[1], wireASnot01[1], wireBS01[1]);
wire [0:0] wireASnot02, wireBS02, muxOut02;
not (wireSnot0[2], sl[2]);
and (wireASnot02[0], muxOut01[0], wireSnot0[2]);
and (wireBS02[0], muxOut01[1], sl[2]);
or (o, wireASnot02[0], wireBS02[0]);
// mux ends line no 0
endmodule
