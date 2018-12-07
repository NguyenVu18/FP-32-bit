module mux4 (i, s, o);

input [3:0] i;
input [1:0] s;
output o;

wire o1, o2;

mux2 u1 (i[3], i[2], s[0], o1);
mux2 u2 (i[1], i[0], s[0], o2);
mux2 u3 (o1, o2, s[1], o);

endmodule
