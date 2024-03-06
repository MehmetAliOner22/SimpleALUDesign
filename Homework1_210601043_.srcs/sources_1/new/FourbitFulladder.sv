module FourbitFulladder(
input logic [3:0] a, b,
input logic cin,
output logic [3:0] s,
output logic cout );
wire [2:0] c;
fulladder i_0 (a[0],b[0],cin,s[0],c[0]);
fulladder i_1 (a[1],b[1],c[0],s[1],c[1]);
fulladder i_2 (a[2],b[2],c[1],s[2],c[2]);
fulladder i_7 (a[3],b[3],c[2],s[3],cout);
endmodule