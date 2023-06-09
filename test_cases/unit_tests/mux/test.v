module test;
  reg [2:0] pattin;
  wire c, d;
  wire sl;
  wire o, pattout;
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
input  c;
input  d;
output  o;
input  sl;
// mux starts line no 4
wire wireSnot0, wireASnot0, wireBS0;
not (wireSnot0, sl);
and (wireASnot0, d, wireSnot0);
and (wireBS0, c, sl);
or (o, wireASnot0, wireBS0);
// mux ends line no 4
endmodule
