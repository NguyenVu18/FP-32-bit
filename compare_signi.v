////////////////////////////////////////////////////////////////////////////////
//
// Arrive Technologies
//
// Filename     : compare_signi.v
// Description  : .
//
// Author       : nguyentvd@atvn.com
// Created On   : Thu Oct 25 09:46:17 2018
// History (Date, Changed By)
//
////////////////////////////////////////////////////////////////////////////////

module compare_signi
    (
     significand_input_01,
     significand_input_02,
     is_sig2_lgr_eqr_sig1
     );

////////////////////////////////////////////////////////////////////////////////
// Parameter declarations
parameter DATA_WIDTH = 32;
parameter EXP_WIDTH = 8;
parameter SIGNIFICANDS_WIDTH = 23;
parameter ADDER_WIDTH=25;

////////////////////////////////////////////////////////////////////////////////
// Port declarations
input [ SIGNIFICANDS_WIDTH-1:0]  significand_input_01,
                                 significand_input_02;
output                           is_sig2_lgr_eqr_sig1;

////////////////////////////////////////////////////////////////////////////////
// Output declarations
wire                             is_sig2_lgr_eqr_sig1;


////////////////////////////////////////////////////////////////////////////////
// Local logic and instantiation
wire s0, s1, s2, s3, s4, s5, s6, s7, s8, s9, 
     s10, s11, s12, s13, s14, s15, s16, s17, 
     s18, s19, s20, s21, s22;
assign s0  = (!significand_input_01[0]) || significand_input_02[0]; 
assign s1  = (s0  && significand_input_02[1 ]) || ( (!significand_input_01[1 ]) && (significand_input_02[1 ] || s0 ) );
assign s2  = (s1  && significand_input_02[2 ]) || ( (!significand_input_01[2 ]) && (significand_input_02[2 ] || s1 ) );
assign s3  = (s2  && significand_input_02[3 ]) || ( (!significand_input_01[3 ]) && (significand_input_02[3 ] || s2 ) );
assign s4  = (s3  && significand_input_02[4 ]) || ( (!significand_input_01[4 ]) && (significand_input_02[4 ] || s3 ) );
assign s5  = (s4  && significand_input_02[5 ]) || ( (!significand_input_01[5 ]) && (significand_input_02[5 ] || s4 ) );
assign s6  = (s5  && significand_input_02[6 ]) || ( (!significand_input_01[6 ]) && (significand_input_02[6 ] || s5 ) );
assign s7  = (s6  && significand_input_02[7 ]) || ( (!significand_input_01[7 ]) && (significand_input_02[7 ] || s6 ) );
assign s8  = (s7  && significand_input_02[8 ]) || ( (!significand_input_01[8 ]) && (significand_input_02[8 ] || s7 ) );
assign s9  = (s8  && significand_input_02[9 ]) || ( (!significand_input_01[9 ]) && (significand_input_02[9 ] || s8 ) );
assign s10 = (s9  && significand_input_02[10]) || ( (!significand_input_01[10]) && (significand_input_02[10] || s9 ) );
assign s11 = (s10 && significand_input_02[11]) || ( (!significand_input_01[11]) && (significand_input_02[11] || s10) );
assign s12 = (s11 && significand_input_02[12]) || ( (!significand_input_01[12]) && (significand_input_02[12] || s11) );
assign s13 = (s12 && significand_input_02[13]) || ( (!significand_input_01[13]) && (significand_input_02[13] || s12) );
assign s14 = (s13 && significand_input_02[14]) || ( (!significand_input_01[14]) && (significand_input_02[14] || s13) );
assign s15 = (s14 && significand_input_02[15]) || ( (!significand_input_01[15]) && (significand_input_02[15] || s14) );
assign s16 = (s15 && significand_input_02[16]) || ( (!significand_input_01[16]) && (significand_input_02[16] || s15) );
assign s17 = (s16 && significand_input_02[17]) || ( (!significand_input_01[17]) && (significand_input_02[17] || s16) );
assign s18 = (s17 && significand_input_02[18]) || ( (!significand_input_01[18]) && (significand_input_02[18] || s17) );
assign s19 = (s18 && significand_input_02[19]) || ( (!significand_input_01[19]) && (significand_input_02[19] || s18) );
assign s20 = (s19 && significand_input_02[20]) || ( (!significand_input_01[20]) && (significand_input_02[20] || s19) );
assign s21 = (s20 && significand_input_02[21]) || ( (!significand_input_01[21]) && (significand_input_02[21] || s20) );
assign s22 = (s21 && significand_input_02[22]) || ( (!significand_input_01[22]) && (significand_input_02[22] || s21) );
assign is_sig2_lgr_eqr_sig1 = s22;
endmodule 
