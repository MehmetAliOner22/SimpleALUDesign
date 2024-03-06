module fulladder(input logic a, b, cin,
output logic s, cout);

 assign s=a^b^cin;
 assign cout= a&b|b&cin|cin&a;
endmodule