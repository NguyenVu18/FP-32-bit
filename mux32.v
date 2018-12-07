module mux32 (i,s,o);

input [31:0] i;
input [4:0] s;
output o;

wire o1, o2, o3, o4, o5, o6, o7, o8, o9, o10;
// 1st mux16
mux4 u1 (i[31:28], s[1:0], o1);
mux4 u2 (i[27:24], s[1:0], o2);
mux4 u3 (i[23:20], s[1:0], o3);
mux4 u4 (i[19:16], s[1:0], o4);
mux4 u5 ({o1,o2,o3,o4}, s[3:2], o5);

// 2nd mux16
mux4 u6 (i[15:12], s[1:0], o6);
mux4 u7 (i[11:8], s[1:0], o7);
mux4 u8 (i[7:4], s[1:0], o8);
mux4 u9 (i[3:0], s[1:0], o9);
mux4 u10 ({o6,o7,o8,o9}, s[3:2], o10);

// mux32
mux2 u11 (o5, o10, s[4], o);

endmodule