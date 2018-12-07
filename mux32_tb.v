module mux32_tb ;
reg [31:0] i;
reg [4:0] s;
wire o;
mux32_tb tb (.i(i), .s(s), .o(o));
initial begin 
	i = 32'hABCD;
	s = 5'd3;
end
endmodule
