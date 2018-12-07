module mux2 (a, b, s, z);

input a, b;
input s;
output z;

assign z = a & ~s | b & s;

endmodule