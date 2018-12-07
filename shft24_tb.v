module shft24_tb ;
reg [23:0] sig;
reg [7:0] exp;
wire [23:0] rslt;
shft24 tb (.sig(sig), .exp(exp), .rslt(rslt));
initial begin 
	sig = {24{1'b1}};
	exp = 8'd4;

end
endmodule
