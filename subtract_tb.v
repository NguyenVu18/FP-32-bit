////////////////////////////////////////////////////////////////////////////////
//
// Arrive Technologies
//
// Filename     : subtract_tb.v
// Description  : .
//
// Author       : nguyentvd@atvn
// Created On   : Fri Oct 26 10:40:46 2018
// History (Date, Changed By)
//
////////////////////////////////////////////////////////////////////////////////

module subtract_tb ;
reg [31:0] input_01;
reg [31:0] input_02;
wire [31:0] result_subtract;
subtract tb (.input_01(input_01), .input_02(input_02), .result_subtract(result_subtract));
initial begin 
    input_01 = 32'b10111111110000000000000000000000;
    input_02 = 32'b01000000010000000000000000000000;
end


endmodule 
