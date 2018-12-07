module shft24 (sig, exp, rslt);

input [23:0] sig;
input [7:0] exp;
output [23:0] rslt;

wire shft0;
assign shft0 = exp[7] & exp[6] & exp[5];

wire [23:0] omux;



mux32 u0 
({sig[0], sig[1], sig[2], sig[3], sig[4], sig[5],
 sig[6], sig[7], sig[8], sig[9], sig[10], sig[11],
 sig[12], sig[13], sig[14], sig[15], sig[16], sig[17], 
 sig[18], sig[19], sig[20], sig[21], sig[22], sig[23], 8'd0},
 exp[4:0], omux[0]);

mux32 u1 
({sig[1], sig[2], sig[3], sig[4], sig[5],
 sig[6], sig[7], sig[8], sig[9], sig[10], sig[11],
 sig[12], sig[13], sig[14], sig[15], sig[16], sig[17], 
 sig[18], sig[19], sig[20], sig[21], sig[22], sig[23], 9'd0},
 exp[4:0], omux[1]); 

mux32 u2 
({sig[2], sig[3], sig[4], sig[5],
 sig[6], sig[7], sig[8], sig[9], sig[10], sig[11],
 sig[12], sig[13], sig[14], sig[15], sig[16], sig[17], 
 sig[18], sig[19], sig[20], sig[21], sig[22], sig[23], 10'd0},
 exp[4:0], omux[2]);

mux32 u3 
({sig[3], sig[4], sig[5],
 sig[6], sig[7], sig[8], sig[9], sig[10], sig[11],
 sig[12], sig[13], sig[14], sig[15], sig[16], sig[17], 
 sig[18], sig[19], sig[20], sig[21], sig[22], sig[23], 11'd0},
 exp[4:0], omux[3]); 

mux32 u4 
({sig[4], sig[5],
 sig[6], sig[7], sig[8], sig[9], sig[10], sig[11],
 sig[12], sig[13], sig[14], sig[15], sig[16], sig[17], 
 sig[18], sig[19], sig[20], sig[21], sig[22], sig[23], 12'd0},
 exp[4:0], omux[4]);

mux32 u5
({sig[5],
 sig[6], sig[7], sig[8], sig[9], sig[10], sig[11],
 sig[12], sig[13], sig[14], sig[15], sig[16], sig[17], 
 sig[18], sig[19], sig[20], sig[21], sig[22], sig[23], 13'd0},
 exp[4:0], omux[5]);

mux32 u6 
({sig[6], sig[7], sig[8], sig[9], sig[10], sig[11],
 sig[12], sig[13], sig[14], sig[15], sig[16], sig[17], 
 sig[18], sig[19], sig[20], sig[21], sig[22], sig[23], 14'd0},
 exp[4:0], omux[6]);

mux32 u7 
({sig[7], sig[8], sig[9], sig[10], sig[11],
 sig[12], sig[13], sig[14], sig[15], sig[16], sig[17], 
 sig[18], sig[19], sig[20], sig[21], sig[22], sig[23], 15'd0},
 exp[4:0], omux[7]);

mux32 u8 
({sig[8], sig[9], sig[10], sig[11],
 sig[12], sig[13], sig[14], sig[15], sig[16], sig[17], 
 sig[18], sig[19], sig[20], sig[21], sig[22], sig[23], 16'd0},
 exp[4:0], omux[8]);

mux32 u9 
({sig[9], sig[10], sig[11],
 sig[12], sig[13], sig[14], sig[15], sig[16], sig[17], 
 sig[18], sig[19], sig[20], sig[21], sig[22], sig[23], 17'd0},
 exp[4:0], omux[9]);

mux32 u10 
({sig[10], sig[11],
 sig[12], sig[13], sig[14], sig[15], sig[16], sig[17], 
 sig[18], sig[19], sig[20], sig[21], sig[22], sig[23], 18'd0},
 exp[4:0], omux[10]);

mux32 u11 
({sig[11],
 sig[12], sig[13], sig[14], sig[15], sig[16], sig[17], 
 sig[18], sig[19], sig[20], sig[21], sig[22], sig[23], 19'd0},
 exp[4:0], omux[11]);

mux32 u12
({sig[12], sig[13], sig[14], sig[15], sig[16], sig[17], 
 sig[18], sig[19], sig[20], sig[21], sig[22], sig[23], 20'd0},
 exp[4:0], omux[12]);

mux32 u13
({sig[13], sig[14], sig[15], sig[16], sig[17], 
 sig[18], sig[19], sig[20], sig[21], sig[22], sig[23], 21'd0},
 exp[4:0], omux[13]);

mux32 u14
({sig[14], sig[15], sig[16], sig[17], 
 sig[18], sig[19], sig[20], sig[21], sig[22], sig[23], 22'd0},
 exp[4:0], omux[14]);

mux32 u15
({sig[15], sig[16], sig[17], 
 sig[18], sig[19], sig[20], sig[21], sig[22], sig[23], 23'd0},
 exp[4:0], omux[15]);

mux32 u16
({sig[16], sig[17], 
 sig[18], sig[19], sig[20], sig[21], sig[22], sig[23], 24'd0},
 exp[4:0], omux[16]);

mux32 u17
({sig[17], 
 sig[18], sig[19], sig[20], sig[21], sig[22], sig[23], 25'd0},
 exp[4:0], omux[17]);

mux32 u18
({sig[18], sig[19], sig[20], sig[21], sig[22], sig[23], 26'd0},
 exp[4:0], omux[18]);

mux32 u19
({sig[19], sig[20], sig[21], sig[22], sig[23], 27'd0},
 exp[4:0], omux[19]);

mux32 u20
({sig[20], sig[21], sig[22], sig[23], 28'd0},
 exp[4:0], omux[20]);

mux32 u21
({sig[21], sig[22], sig[23], 29'd0},
 exp[4:0], omux[21]);

mux32 u22
({sig[22], sig[23], 30'd0},
 exp[4:0], omux[22]);

mux32 u23
({sig[23], 31'd0},
 exp[4:0], omux[23]);


assign rslt[23] = omux[23] & ~shft0;
assign rslt[22] = omux[22] & ~shft0;
assign rslt[21] = omux[22] & ~shft0;
assign rslt[20] = omux[20] & ~shft0;
assign rslt[19] = omux[19] & ~shft0;
assign rslt[18] = omux[18] & ~shft0;
assign rslt[17] = omux[17] & ~shft0;
assign rslt[16] = omux[16] & ~shft0;
assign rslt[15] = omux[15] & ~shft0;
assign rslt[14] = omux[14] & ~shft0;
assign rslt[13] = omux[13] & ~shft0;
assign rslt[12] = omux[12] & ~shft0;
assign rslt[11] = omux[11] & ~shft0;
assign rslt[10] = omux[10] & ~shft0;
assign rslt[9] = omux[9] & ~shft0;
assign rslt[8] = omux[8] & ~shft0;
assign rslt[7] = omux[7] & ~shft0;
assign rslt[6] = omux[6] & ~shft0;
assign rslt[5] = omux[5] & ~shft0;
assign rslt[4] = omux[4] & ~shft0;
assign rslt[3] = omux[3] & ~shft0;
assign rslt[2] = omux[2] & ~shft0;
assign rslt[1] = omux[1] & ~shft0;
assign rslt[0] = omux[0] & ~shft0;

endmodule