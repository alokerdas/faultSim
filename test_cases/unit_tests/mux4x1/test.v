module test;
  reg [5:0] pattin;
  wire a, b, c, d;
  wire [1:0] sl;
  wire o, pattout;
  reg [10*8:0] patFile, fltFile, rptFile;

  assign {a, b, c, d, sl} = pattin;
  assign pattout = o;
  gate g1(o, a, b, d, c, sl);
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
sl
);
wire  _LOGIC0;
wire  _LOGIC1;
input  a;
input  b;
input  c;
input  d;
output  o;
input [1:0] sl;
pullup (_LOGIC1);
pulldown (_LOGIC0);
// mux starts line no 0
wire [1:0] wireSnot0;
wire [1:0] wireASnot00, wireBS00, muxOut00;
not (wireSnot0[0], sl[0]);
and (wireASnot00[0], a, wireSnot0[0]);
and (wireBS00[0], b, sl[0]);
or (muxOut00[0], wireASnot00[0], wireBS00[0]);
and (wireASnot00[1], c, wireSnot0[0]);
and (wireBS00[1], d, sl[0]);
or (muxOut00[1], wireASnot00[1], wireBS00[1]);
wire [0:0] wireASnot01, wireBS01, muxOut01;
not (wireSnot0[1], sl[1]);
and (wireASnot01[0], muxOut00[0], wireSnot0[1]);
and (wireBS01[0], muxOut00[1], sl[1]);
or (o, wireASnot01[0], wireBS01[0]);
// mux ends line no 0
endmodule
