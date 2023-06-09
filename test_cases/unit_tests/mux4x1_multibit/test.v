module test;
  reg [17:0] pattin;
  wire [3:0] a, b, c, d;
  wire [1:0] sl;
  wire [3:0] o, pattout;
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
input [3:0] a;
input [3:0] b;
input [3:0] c;
input [3:0] d;
output [3:0] o;
input [1:0] sl;
pullup (_LOGIC1);
pulldown (_LOGIC0);
// mux starts line no 0
wire [1:0] wireSnot0;
not (wireSnot0[0], sl[0]);
not (wireSnot0[1], sl[1]);
wire [1:0] wireASnot000, wireBS000, muxOut000;
and (wireASnot000[0], a[0], wireSnot0[0]);
and (wireBS000[0], b[0], sl[0]);
or (muxOut000[0], wireASnot000[0], wireBS000[0]);
and (wireASnot000[1], c[0], wireSnot0[0]);
and (wireBS000[1], d[0], sl[0]);
or (muxOut000[1], wireASnot000[1], wireBS000[1]);
wire [0:0] wireASnot001, wireBS001, muxOut001;
and (wireASnot001[0], muxOut000[0], wireSnot0[1]);
and (wireBS001[0], muxOut000[1], sl[1]);
or (o[0], wireASnot001[0], wireBS001[0]);
wire [1:0] wireASnot010, wireBS010, muxOut010;
and (wireASnot010[0], a[1], wireSnot0[0]);
and (wireBS010[0], b[1], sl[0]);
or (muxOut010[0], wireASnot010[0], wireBS010[0]);
and (wireASnot010[1], c[1], wireSnot0[0]);
and (wireBS010[1], d[1], sl[0]);
or (muxOut010[1], wireASnot010[1], wireBS010[1]);
wire [0:0] wireASnot011, wireBS011, muxOut011;
and (wireASnot011[0], muxOut010[0], wireSnot0[1]);
and (wireBS011[0], muxOut010[1], sl[1]);
or (o[1], wireASnot011[0], wireBS011[0]);
wire [1:0] wireASnot020, wireBS020, muxOut020;
and (wireASnot020[0], a[2], wireSnot0[0]);
and (wireBS020[0], b[2], sl[0]);
or (muxOut020[0], wireASnot020[0], wireBS020[0]);
and (wireASnot020[1], c[2], wireSnot0[0]);
and (wireBS020[1], d[2], sl[0]);
or (muxOut020[1], wireASnot020[1], wireBS020[1]);
wire [0:0] wireASnot021, wireBS021, muxOut021;
and (wireASnot021[0], muxOut020[0], wireSnot0[1]);
and (wireBS021[0], muxOut020[1], sl[1]);
or (o[2], wireASnot021[0], wireBS021[0]);
wire [1:0] wireASnot030, wireBS030, muxOut030;
and (wireASnot030[0], a[3], wireSnot0[0]);
and (wireBS030[0], b[3], sl[0]);
or (muxOut030[0], wireASnot030[0], wireBS030[0]);
and (wireASnot030[1], c[3], wireSnot0[0]);
and (wireBS030[1], d[3], sl[0]);
or (muxOut030[1], wireASnot030[1], wireBS030[1]);
wire [0:0] wireASnot031, wireBS031, muxOut031;
and (wireASnot031[0], muxOut030[0], wireSnot0[1]);
and (wireBS031[0], muxOut030[1], sl[1]);
or (o[3], wireASnot031[0], wireBS031[0]);
// mux ends line no 0
endmodule
