module test;
  reg [3:0] pattin;
  wire [1:0] a, b;
  wire [3:0] o, pattout;
  reg [10*8:0] patFile, fltFile, rptFile;
  
  assign {a, b} = pattin;
  assign pattout = o;
  gate g1(a, b, o);
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
a,
b,
o
);
wire [3:0] _ivl_0;
wire [1:0] _ivl_3;
wire [3:0] _ivl_4;
wire [1:0] _ivl_7;
input [1:0] a;
input [1:0] b;
output [3:0] o;
assign _ivl_3 = 2'b00;
assign _ivl_7 = 2'b00;
// concat starts line no 4
buf (_ivl_0[0], a[0]);
buf (_ivl_0[1], a[1]);
buf (_ivl_0[2], _ivl_3[0]);
buf (_ivl_0[3], _ivl_3[1]);
// concat ends line no 4
// concat starts line no 4
buf (_ivl_4[0], b[0]);
buf (_ivl_4[1], b[1]);
buf (_ivl_4[2], _ivl_7[0]);
buf (_ivl_4[3], _ivl_7[1]);
// concat ends line no 4
// mult starts line no 4
wire [3:0] multwire20;
and (multwire20[0], _ivl_0[0], _ivl_4[0]);
and (multwire20[1], _ivl_0[0], _ivl_4[1]);
and (multwire20[2], _ivl_0[0], _ivl_4[2]);
and (multwire20[3], _ivl_0[0], _ivl_4[3]);
wire [3:0] multwire21;
and (multwire21[0], _ivl_0[1], _ivl_4[0]);
and (multwire21[1], _ivl_0[1], _ivl_4[1]);
and (multwire21[2], _ivl_0[1], _ivl_4[2]);
and (multwire21[3], _ivl_0[1], _ivl_4[3]);
wire [3:0] multwire22;
and (multwire22[0], _ivl_0[2], _ivl_4[0]);
and (multwire22[1], _ivl_0[2], _ivl_4[1]);
and (multwire22[2], _ivl_0[2], _ivl_4[2]);
and (multwire22[3], _ivl_0[2], _ivl_4[3]);
wire [3:0] multwire23;
and (multwire23[0], _ivl_0[3], _ivl_4[0]);
and (multwire23[1], _ivl_0[3], _ivl_4[1]);
and (multwire23[2], _ivl_0[3], _ivl_4[2]);
and (multwire23[3], _ivl_0[3], _ivl_4[3]);
buf (o[0], multwire20[0]);
wire [3:0] partCry20;
wire [2:0] partSum20, haSum20, ha0Cry20, ha1Cry20;
xor (o[1], multwire20[1], multwire21[0]);
and (partCry20[0], multwire20[1], multwire21[0]);
xor (haSum20[0], multwire20[2], multwire21[1]);
xor (partSum20[0], haSum20[0], partCry20[0]);
and (ha0Cry20[0], multwire20[2], multwire21[1]);
and (ha1Cry20[0], haSum20[0], partCry20[0]);
or (partCry20[1], ha0Cry20[0], ha1Cry20[0]);
xor (haSum20[1], multwire20[3], multwire21[2]);
xor (partSum20[1], haSum20[1], partCry20[1]);
and (ha0Cry20[1], multwire20[3], multwire21[2]);
and (ha1Cry20[1], haSum20[1], partCry20[1]);
or (partCry20[2], ha0Cry20[1], ha1Cry20[1]);
xor (partSum20[2], partCry20[2], multwire21[3]);
and (partCry20[3], partCry20[2], multwire21[3]);
wire [3:0] partCry21;
wire [2:0] partSum21, haSum21, ha0Cry21, ha1Cry21;
xor (o[2], partSum20[0], multwire22[0]);
and (partCry21[0], partSum20[0], multwire22[0]);
xor (haSum21[0], partSum20[1], multwire22[1]);
xor (partSum21[0], haSum21[0], partCry21[0]);
and (ha0Cry21[0], partSum20[1], multwire22[1]);
and (ha1Cry21[0], haSum21[0], partCry21[0]);
or (partCry21[1], ha0Cry21[0], ha1Cry21[0]);
xor (haSum21[1], partSum20[2], multwire22[2]);
xor (partSum21[1], haSum21[1], partCry21[1]);
and (ha0Cry21[1], partSum20[2], multwire22[2]);
and (ha1Cry21[1], haSum21[1], partCry21[1]);
or (partCry21[2], ha0Cry21[1], ha1Cry21[1]);
xor (haSum21[2], partCry20[3], multwire22[3]);
xor (partSum21[2], haSum21[2], partCry21[2]);
and (ha0Cry21[2], partCry20[3], multwire22[3]);
and (ha1Cry21[2], haSum21[2], partCry21[2]);
or (partCry21[3], ha0Cry21[2], ha1Cry21[2]);
wire [3:0] partCry22;
wire [2:0] partSum22, haSum22, ha0Cry22, ha1Cry22;
xor (o[3], partSum21[0], multwire23[0]);
and (partCry22[0], partSum21[0], multwire23[0]);
xor (haSum22[0], partSum21[1], multwire23[1]);
xor (partSum22[0], haSum22[0], partCry22[0]);
and (ha0Cry22[0], partSum21[1], multwire23[1]);
and (ha1Cry22[0], haSum22[0], partCry22[0]);
or (partCry22[1], ha0Cry22[0], ha1Cry22[0]);
xor (haSum22[1], partSum21[2], multwire23[2]);
xor (partSum22[1], haSum22[1], partCry22[1]);
and (ha0Cry22[1], partSum21[2], multwire23[2]);
and (ha1Cry22[1], haSum22[1], partCry22[1]);
or (partCry22[2], ha0Cry22[1], ha1Cry22[1]);
xor (haSum22[2], partCry21[3], multwire23[3]);
xor (partSum22[2], haSum22[2], partCry22[2]);
and (ha0Cry22[2], partCry21[3], multwire23[3]);
and (ha1Cry22[2], haSum22[2], partCry22[2]);
or (partCry22[3], ha0Cry22[2], ha1Cry22[2]);
// mult ends line no 4
endmodule
