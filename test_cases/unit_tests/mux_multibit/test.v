module test;
  reg [8:0] pattin;
  wire [3:0] c, d;
  wire sl;
  wire [3:0] o, pattout;
  reg [10*8:0] patFile, fltFile, rptFile;

  assign {c, d, sl} = pattin;
  assign pattout = o;
  gate g1(o, d, c, sl);
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
d,
c,
sl
);
input [3:0] c;
input [3:0] d;
output [3:0] o;
input  sl;
// mux starts line no 5
wire wireSnot0;
not (wireSnot0, sl);
wire wireASnot00, wireBS00;
and (wireASnot00, d[0], wireSnot0);
and (wireBS00, c[0], sl);
or (o[0], wireASnot00, wireBS00);
wire wireASnot01, wireBS01;
and (wireASnot01, d[1], wireSnot0);
and (wireBS01, c[1], sl);
or (o[1], wireASnot01, wireBS01);
wire wireASnot02, wireBS02;
and (wireASnot02, d[2], wireSnot0);
and (wireBS02, c[2], sl);
or (o[2], wireASnot02, wireBS02);
wire wireASnot03, wireBS03;
and (wireASnot03, d[3], wireSnot0);
and (wireBS03, c[3], sl);
or (o[3], wireASnot03, wireBS03);
// mux ends line no 5
endmodule
