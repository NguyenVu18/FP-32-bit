////////////////////////////////////////////////////////////////////////////////
//
// Arrive Technologies
//
// Filename     : compare_exp.v
// Description  : .
//
// Author       : ngyentvd@atvn.com
// Created On   : Thu Oct 25 09:12:53 2018
// History (Date, Changed By)
//
////////////////////////////////////////////////////////////////////////////////

module compare_exp
    (
     exp_input_01,
     exp_input_02,
     is_exp2_lgr_eqr_exp1
     );

////////////////////////////////////////////////////////////////////////////////
// Parameter declarations
parameter DATA_WIDTH = 32;
parameter EXP_WIDTH = 8;
parameter SIGNIFICANDS_WIDTH = 23;
parameter ADDER_WIDTH=25;

////////////////////////////////////////////////////////////////////////////////
// Port declarations
input [EXP_WIDTH-1:0] exp_input_01,
                      exp_input_02;

output is_exp2_lgr_eqr_exp1;


////////////////////////////////////////////////////////////////////////////////
// Output declarations
wire   is_exp2_lgr_eqr_exp1;

////////////////////////////////////////////////////////////////////////////////
// Local logic and instantiation

wire e0, 
     e1, 
     e2, 
     e3, 
     e4, 
     e5, 
     e6, 
     e7;
assign e0 = (!exp_input_01[0]) || exp_input_02[0]; 
assign e1 = (e0 && exp_input_02[1]) || ( (!exp_input_01[1]) && (exp_input_02[1] || e0) );
assign e2 = (e1 && exp_input_02[2]) || ( (!exp_input_01[2]) && (exp_input_02[2] || e1) );
assign e3 = (e2 && exp_input_02[3]) || ( (!exp_input_01[3]) && (exp_input_02[3] || e2) );
assign e4 = (e3 && exp_input_02[4]) || ( (!exp_input_01[4]) && (exp_input_02[4] || e3) );
assign e5 = (e4 && exp_input_02[5]) || ( (!exp_input_01[5]) && (exp_input_02[5] || e4) );
assign e6 = (e5 && exp_input_02[6]) || ( (!exp_input_01[6]) && (exp_input_02[6] || e5) );
assign e7 = (e6 && exp_input_02[7]) || ( (!exp_input_01[7]) && (exp_input_02[7] || e6) );
assign is_exp2_lgr_eqr_exp1 = e7; // exp2 >= exp1 --> e7 = 1

endmodule 
