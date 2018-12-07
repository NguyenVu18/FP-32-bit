////////////////////////////////////////////////////////////////////////////////
//
// Arrive Technologies
//
// Filename     : adder.v
// Description  : .
//
// Author       : nguyentvd@atvn.com
// Created On   : Thu Oct 25 08:36:25 2018
// History (Date, Changed By)
//
////////////////////////////////////////////////////////////////////////////////

module adder
    (
     input_01,
     input_02,
     result_adder
     );

////////////////////////////////////////////////////////////////////////////////
// Parameter declarations
parameter DATA_WIDTH = 32;
parameter EXP_WIDTH = 8;
parameter SIGNIFICANDS_WIDTH = 23;
parameter ADDER_WIDTH = 25;

////////////////////////////////////////////////////////////////////////////////
// Port declarations
input [DATA_WIDTH-1:0] input_01,
                       input_02;
output [DATA_WIDTH-1:0] result_adder;


////////////////////////////////////////////////////////////////////////////////
// Output declarations
wire [DATA_WIDTH-1:0]    result_adder;

////////////////////////////////////////////////////////////////////////////////
// check input 1, input 2 is zero

wire is_input_01_zero,
     is_input_02_zero;

assign is_input_01_zero = !(|input_01) ;  // check factor 1 is zero
assign is_input_02_zero = !(|input_02) ; // check factor 2 is zero

////////////////////////////////////////////////////////////////////////////////
// compare significands
// signi 2 > signi 1 --> is_sig2_lgr_eqr_sig1 = 1
wire [SIGNIFICANDS_WIDTH-1:0] significand_input_01,
                              significand_input_02;
wire                          is_sig2_lgr_eqr_sig1 ;

assign significand_input_01 = input_01[SIGNIFICANDS_WIDTH-1: 0]; 
assign significand_input_02 = input_02[SIGNIFICANDS_WIDTH-1: 0];

compare_signi comps(
                    .significand_input_01(significand_input_01),
                    .significand_input_02(significand_input_02),
                    .is_sig2_lgr_eqr_sig1(is_sig2_lgr_eqr_sig1)
                    );



///////////////////////////////////////////////////////////////////////////////
// Same sign ??

wire sign_input_01,
     sign_input_02,
     same_sign;

assign sign_input_01        = input_01[DATA_WIDTH-1]; 
assign sign_input_02        = input_02[DATA_WIDTH-1]; 
assign same_sign = !(sign_input_01 ^ sign_input_02); 
// same_sign = 1 if sign 1 = sign 2


////////////////////////////////////////////////////////////////////////////////
// compare exp
wire [EXP_WIDTH-1:0] exp_input_01,
                     exp_input_02;

wire [EXP_WIDTH-1:0] exp_xor_bit,
                     exp_eql;
wire                 is_exp2_lgr_eqr_exp;

wire                 is_input01_Nan_or_Inf;
wire                 is_input02_Nan_or_Inf;

assign exp_input_01    = input_01[DATA_WIDTH-2: DATA_WIDTH-9]; 
assign exp_input_02    = input_02[DATA_WIDTH-2: DATA_WIDTH-9];

assign is_input01_Nan_or_Inf = & exp_input_01; // check Is input Nan , infinity
assign is_input02_Nan_or_Inf = & exp_input_02;
 
assign exp_xor_bit = exp_input_01 ^ exp_input_02; 
assign exp_eql = !(|exp_xor_bit);
// exp_eql = 1 if exp2 = exp1

compare_exp comp(.exp_input_01(exp_input_01),
                 .exp_input_02(exp_input_02),
                 .is_exp2_lgr_eqr_exp1(is_exp2_lgr_eqr_exp1)
                 );

// exp 2 > exp 1 --> is_exp2_lgr_eqr_exp1 = 1 
////////////////////////////////////////////////////////////////////////////////
// shift value
reg [EXP_WIDTH-1:0] exp_diff_value;
wire [EXP_WIDTH-1:0]   exp_input_21; // exp 2 - exp 1
wire [EXP_WIDTH-1:0]   exp_input_12; // exp 1 - exp 2
always@(*) begin
    if(exp_eql)begin
        exp_diff_value <= 0; // diff = 0 if exp2 = exp1
    end
    else if(is_exp2_lgr_eqr_exp1) begin // is exp2 > exp1
        exp_diff_value <= exp_input_21; // diff = exponent_factor_21 = exp2 - exp1
    end
    else begin                          // is exp1 > exp 2
        exp_diff_value <= exp_input_12; // diff = exponent_factor_12 = exp1 -exp2
    end
end

// use adder 8 bit to calculate diff_value
add8bit add8_01(.out(exp_input_21),
                .a(exp_input_02),
                .b(~exp_input_01),
                .cin(1'b1)
                );
add8bit add8_02(.out(exp_input_12),
                .a(exp_input_01),
                .b(~exp_input_02),
                .cin(1'b1)
                );

////////////////////////////////////////////////////////////////////////////////
// add bit 1 in front of the dot

wire [SIGNIFICANDS_WIDTH:0] add_1_significand_01,
                            add_1_significand_02;
assign add_1_significand_01[SIGNIFICANDS_WIDTH-1:0] = significand_input_01; 
assign add_1_significand_02[SIGNIFICANDS_WIDTH-1:0] = significand_input_02;
assign add_1_significand_01[SIGNIFICANDS_WIDTH] = 1'b1;
assign add_1_significand_02[SIGNIFICANDS_WIDTH] = 1'b1;

////////////////////////////////////////////////////////////////////////////////
// Shift right

reg [SIGNIFICANDS_WIDTH:0] shift_smaller_factor,
                           larger_factor;
reg [EXP_WIDTH-1:0] larger_exponent;

wire [SIGNIFICANDS_WIDTH:0] add_1_significand_01_shr;
wire [SIGNIFICANDS_WIDTH:0] add_1_significand_02_shr;


shft24 shr01(.sig(add_1_significand_01),
               .exp(exp_diff_value),
               .rslt(add_1_significand_01_shr)
               );

shft24 shr02(.sig(add_1_significand_02),
               .exp(exp_diff_value),
               .rslt(add_1_significand_02_shr)
               );

always@(*) 
    begin 
    if(exp_eql)
        begin // if exp2 = exp1
        if(is_sig2_lgr_eqr_sig1) 
            begin
            shift_smaller_factor <= add_1_significand_01;
            larger_factor        <= add_1_significand_02;
            larger_exponent      <= exp_input_01;
            end
        else 
            begin
            shift_smaller_factor <= add_1_significand_02;
            larger_factor        <= add_1_significand_01;
            larger_exponent      <= exp_input_01;
            end
        end
    else if(is_exp2_lgr_eqr_exp1) 
        begin // if exp2 >= exp1
        shift_smaller_factor <= add_1_significand_01_shr; 
        larger_factor        <= add_1_significand_02;
        larger_exponent      <= exp_input_02;
        end   
    else 
        begin  // exp2 < exp1
        shift_smaller_factor <= add_1_significand_02_shr; 
        larger_factor        <= add_1_significand_01;
        larger_exponent      <= exp_input_01;
        end
    end                



////////////////////////////////////////////////////////////////////////////////
// use adder 25 bit to add or subtract 2 significand
// bit 24 is over flow bit, bit 23 is infront the dot 1(0).1110101...
wire [ADDER_WIDTH-1:0]      add_sub_result;
wire [ADDER_WIDTH-1:0]      sub_result;
wire [ADDER_WIDTH-1:0]      add_result;

assign add_sub_result         = (same_sign) ? add_result : sub_result;
assign is_add_sub_result_zero = !(|add_sub_result);
add25bit add25_01(.out(sub_result),
                  .a({1'b0,larger_factor}),
                  .b({1'b1,~shift_smaller_factor}),
                  .cin(1'b1)
                  );
add25bit add25_02(.out(add_result),
                  .a({1'b0,larger_factor}),
                  .b({1'b0,shift_smaller_factor}),
                  .cin(1'b0)
                  );

////////////////////////////////////////////////////////////////////////////////
// consider sign of output

consider_sign_output consider(.is_add_sub_result_zero(is_add_sub_result_zero),
                              .same_sign(same_sign),
                              .is_factor_01_zero(is_factor_01_zero),
                              .is_factor_02_zero(is_factor_02_zero),
                              .exp_eql(exp_eql),
                              .is_sig2_lgr_eqr_sig1(is_sig2_lgr_eqr_sig1),
                              .is_exp2_lgr_eqr_exp1(is_exp2_lgr_eqr_exp1),
                              .sign_input_01(sign_input_01),
                              .sign_input_02(sign_input_02),
                              .add_output_sign(add_output_sign)
                              );
////////////////////////////////////////////////////////////////////////////////
// Normalize
wire [EXP_WIDTH-1:0]     add_output_exponent;
wire [SIGNIFICANDS_WIDTH-1:0] add_output_significands;

normalize normal(
                 .add_sub_result(add_sub_result),
                 .larger_exponent(larger_exponent),
                 .is_factor_01_zero(is_factor_01_zero),
                 .is_factor_02_zero(is_factor_02_zero),
                 .is_add_sub_result_zero(is_add_sub_result_zero),
                 .exp_input_02(exp_input_02),
                 .exp_input_01(exp_input_01),
                 .significand_input_02(significand_input_02),
                 .significand_input_01(significand_input_01),
     
                 .add_output_exponent(add_output_exponent),
                 .add_output_significands(add_output_significands)
                 
                 );

////////////////////////////////////////////////////////////////////////////////
// Result
//wire     [DATA_WIDTH-1:0]     result_infi_Nan;
//assign                        result_infi_Nan = is_input01_Nan_or_Inf ? input_01 : (is_input02_Nan_or_Inf ? input_02 : ) ;

//assign result_adder[DATA_WIDTH-1]                  = add_output_sign;
//assign result_adder[(DATA_WIDTH-2):(DATA_WIDTH-9)] = add_output_exponent;
//assign result_adder[(DATA_WIDTH-10):0]             = add_output_significands;

assign result_adder = is_input01_Nan_or_Inf ? input_01 : (is_input02_Nan_or_Inf ? input_02 : {add_output_sign,add_output_exponent,add_output_significands});
 

endmodule 
