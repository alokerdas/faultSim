module test;
  reg [34:0] pattin;
  wire [3:0] a, b, c, d, e, f, g, h;
  wire [2:0] sl;
  wire [3:0] o, pattout;
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
input [3:0] a;
input [3:0] b;
input [3:0] c;
input [3:0] d;
input [3:0] e;
input [3:0] f;
input [3:0] g;
input [3:0] h;
output [3:0] o;
input [2:0] sl;
pullup (_LOGIC1);
pulldown (_LOGIC0);
// mux starts line no 0
wire [2:0] wireSnot0;
not (wireSnot0[0], sl[0]);
not (wireSnot0[1], sl[1]);
not (wireSnot0[2], sl[2]);
wire [3:0] wireASnot000, wireBS000, muxOut000;
and (wireASnot000[0], a[0], wireSnot0[0]);
and (wireBS000[0], b[0], sl[0]);
or (muxOut000[0], wireASnot000[0], wireBS000[0]);
and (wireASnot000[1], c[0], wireSnot0[0]);
and (wireBS000[1], d[0], sl[0]);
or (muxOut000[1], wireASnot000[1], wireBS000[1]);
and (wireASnot000[2], e[0], wireSnot0[0]);
and (wireBS000[2], f[0], sl[0]);
or (muxOut000[2], wireASnot000[2], wireBS000[2]);
and (wireASnot000[3], g[0], wireSnot0[0]);
and (wireBS000[3], h[0], sl[0]);
or (muxOut000[3], wireASnot000[3], wireBS000[3]);
wire [1:0] wireASnot001, wireBS001, muxOut001;
and (wireASnot001[0], muxOut000[0], wireSnot0[1]);
and (wireBS001[0], muxOut000[1], sl[1]);
or (muxOut001[0], wireASnot001[0], wireBS001[0]);
and (wireASnot001[1], muxOut000[2], wireSnot0[1]);
and (wireBS001[1], muxOut000[3], sl[1]);
or (muxOut001[1], wireASnot001[1], wireBS001[1]);
wire [0:0] wireASnot002, wireBS002, muxOut002;
and (wireASnot002[0], muxOut001[0], wireSnot0[2]);
and (wireBS002[0], muxOut001[1], sl[2]);
or (o[0], wireASnot002[0], wireBS002[0]);
wire [3:0] wireASnot010, wireBS010, muxOut010;
and (wireASnot010[0], a[1], wireSnot0[0]);
and (wireBS010[0], b[1], sl[0]);
or (muxOut010[0], wireASnot010[0], wireBS010[0]);
and (wireASnot010[1], c[1], wireSnot0[0]);
and (wireBS010[1], d[1], sl[0]);
or (muxOut010[1], wireASnot010[1], wireBS010[1]);
and (wireASnot010[2], e[1], wireSnot0[0]);
and (wireBS010[2], f[1], sl[0]);
or (muxOut010[2], wireASnot010[2], wireBS010[2]);
and (wireASnot010[3], g[1], wireSnot0[0]);
and (wireBS010[3], h[1], sl[0]);
or (muxOut010[3], wireASnot010[3], wireBS010[3]);
wire [1:0] wireASnot011, wireBS011, muxOut011;
and (wireASnot011[0], muxOut010[0], wireSnot0[1]);
and (wireBS011[0], muxOut010[1], sl[1]);
or (muxOut011[0], wireASnot011[0], wireBS011[0]);
and (wireASnot011[1], muxOut010[2], wireSnot0[1]);
and (wireBS011[1], muxOut010[3], sl[1]);
or (muxOut011[1], wireASnot011[1], wireBS011[1]);
wire [0:0] wireASnot012, wireBS012, muxOut012;
and (wireASnot012[0], muxOut011[0], wireSnot0[2]);
and (wireBS012[0], muxOut011[1], sl[2]);
or (o[1], wireASnot012[0], wireBS012[0]);
wire [3:0] wireASnot020, wireBS020, muxOut020;
and (wireASnot020[0], a[2], wireSnot0[0]);
and (wireBS020[0], b[2], sl[0]);
or (muxOut020[0], wireASnot020[0], wireBS020[0]);
and (wireASnot020[1], c[2], wireSnot0[0]);
and (wireBS020[1], d[2], sl[0]);
or (muxOut020[1], wireASnot020[1], wireBS020[1]);
and (wireASnot020[2], e[2], wireSnot0[0]);
and (wireBS020[2], f[2], sl[0]);
or (muxOut020[2], wireASnot020[2], wireBS020[2]);
and (wireASnot020[3], g[2], wireSnot0[0]);
and (wireBS020[3], h[2], sl[0]);
or (muxOut020[3], wireASnot020[3], wireBS020[3]);
wire [1:0] wireASnot021, wireBS021, muxOut021;
and (wireASnot021[0], muxOut020[0], wireSnot0[1]);
and (wireBS021[0], muxOut020[1], sl[1]);
or (muxOut021[0], wireASnot021[0], wireBS021[0]);
and (wireASnot021[1], muxOut020[2], wireSnot0[1]);
and (wireBS021[1], muxOut020[3], sl[1]);
or (muxOut021[1], wireASnot021[1], wireBS021[1]);
wire [0:0] wireASnot022, wireBS022, muxOut022;
and (wireASnot022[0], muxOut021[0], wireSnot0[2]);
and (wireBS022[0], muxOut021[1], sl[2]);
or (o[2], wireASnot022[0], wireBS022[0]);
wire [3:0] wireASnot030, wireBS030, muxOut030;
and (wireASnot030[0], a[3], wireSnot0[0]);
and (wireBS030[0], b[3], sl[0]);
or (muxOut030[0], wireASnot030[0], wireBS030[0]);
and (wireASnot030[1], c[3], wireSnot0[0]);
and (wireBS030[1], d[3], sl[0]);
or (muxOut030[1], wireASnot030[1], wireBS030[1]);
and (wireASnot030[2], e[3], wireSnot0[0]);
and (wireBS030[2], f[3], sl[0]);
or (muxOut030[2], wireASnot030[2], wireBS030[2]);
and (wireASnot030[3], g[3], wireSnot0[0]);
and (wireBS030[3], h[3], sl[0]);
or (muxOut030[3], wireASnot030[3], wireBS030[3]);
wire [1:0] wireASnot031, wireBS031, muxOut031;
and (wireASnot031[0], muxOut030[0], wireSnot0[1]);
and (wireBS031[0], muxOut030[1], sl[1]);
or (muxOut031[0], wireASnot031[0], wireBS031[0]);
and (wireASnot031[1], muxOut030[2], wireSnot0[1]);
and (wireBS031[1], muxOut030[3], sl[1]);
or (muxOut031[1], wireASnot031[1], wireBS031[1]);
wire [0:0] wireASnot032, wireBS032, muxOut032;
and (wireASnot032[0], muxOut031[0], wireSnot0[2]);
and (wireBS032[0], muxOut031[1], sl[2]);
or (o[3], wireASnot032[0], wireBS032[0]);
// mux ends line no 0
endmodule
