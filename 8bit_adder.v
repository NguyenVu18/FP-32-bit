module add8bit(a,b,cin,out,cout);
input [7:0] a;
input [7:0] b;
input cin;
output [7:0] out;
output cout;
wire [7:0] a;
wire [7:0] b;
wire cin, cout;
wire [7:0] out;
wire [6:0] c_out;
add_bit add0 (a[0],b[0],cin,out[0],c_out[0]);
add_bit add1 (a[1],b[1],c_out[0],out[1],c_out[1]);
add_bit add2 (a[2],b[2],c_out[1],out[2],c_out[2]);
add_bit add3 (a[3],b[3],c_out[2],out[3],c_out[3]);
add_bit add4 (a[4],b[4],c_out[3],out[4],c_out[4]);
add_bit add5 (a[5],b[5],c_out[4],out[5],c_out[5]);
add_bit add6 (a[6],b[6],c_out[5],out[6],c_out[6]);
add_bit add7 (a[7],b[7],c_out[6],out[7],cout);
endmodule

