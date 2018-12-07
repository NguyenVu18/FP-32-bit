////////////////////////////////////////////////////////////////////////////////
//
// Arrive Technologies
//
// Filename     : adder_tb.v
// Description  : .
//
// Author       : nguyentvd@atvn
// Created On   : Fri Oct 26 10:40:46 2018
// History (Date, Changed By)
//
////////////////////////////////////////////////////////////////////////////////

module adder_tb ;
reg [31:0] input_01;
reg [31:0] input_02;
wire [31:0] result_adder;
adder tb (.input_01(input_01), .input_02(input_02), .result_adder(result_adder));
initial begin 
    input_01 = 32'b10111111100100000000000000000000;
    input_02 = 32'b00111111110000000000000000000000;
end


endmodule 
