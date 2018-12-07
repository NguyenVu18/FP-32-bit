////////////////////////////////////////////////////////////////////////////////
//
// Arrive Technologies
//
// Filename     : consider_sign_output.v
// Description  : .
//
// Author       : nguyentvd@atvn.com
// Created On   : Thu Oct 25 22:18:53 2018
// History (Date, Changed By)
//
////////////////////////////////////////////////////////////////////////////////

module consider_sign_output
    (
     is_add_sub_result_zero,
     same_sign,
     is_factor_01_zero,
     is_factor_02_zero,
     exp_eql,
     is_sig2_lgr_eqr_sig1,
     is_exp2_lgr_eqr_exp1,
     sign_input_01,
     sign_input_02,

     add_output_sign
     
     );
////////////////////////////////////////////////////////////////////////////////
// Parameter declarations
parameter DATA_WIDTH = 32;
parameter EXP_WIDTH = 8;
parameter SIGNIFICANDS_WIDTH = 23;
parameter ADDER_WIDTH=25;

////////////////////////////////////////////////////////////////////////////////
// Port declarations
input   is_add_sub_result_zero,
        same_sign,
        is_factor_01_zero,
        is_factor_02_zero,
        exp_eql,
        is_sig2_lgr_eqr_sig1,
        is_exp2_lgr_eqr_exp1,
        sign_input_01,
        sign_input_02;

output  add_output_sign;

      
////////////////////////////////////////////////////////////////////////////////
// Output declarations
reg     add_output_sign;


////////////////////////////////////////////////////////////////////////////////
// Local logic and instantiation
wire    is_add_sub_result_zero,
        same_sign,
        is_input_01_zero,
        is_input_02_zero,
        exp_eql,
        is_sig2_lgr_eqr_sig1,
        is_exp2_lgr_eqr_exp1,
        sign_input_01,
        sign_input_02;

always@(*) 
    begin
    if(is_add_sub_result_zero)
        begin // result = 0
        add_output_sign <= 0;
        end
    else if(same_sign) 
        begin // same sign
        add_output_sign <= sign_input_01;
        end
    else 
        begin 
        if(is_input_01_zero)
            begin // factor 1 is zero
            add_output_sign <= sign_input_02; 
            end
        else if(is_input_02_zero) 
            begin // factor 2 is zero
            add_output_sign <= sign_input_01; 
            end
        else if(exp_eql) 
            begin // same exponent
            if(is_sig2_lgr_eqr_sig1) 
                begin // signi 2 > signi 1
                add_output_sign <= sign_input_02 && (!sign_input_01); 
                end
            else 
                begin
                add_output_sign <= (!sign_input_02) && sign_input_01;
                end
            end
        else if(is_exp2_lgr_eqr_exp1)   
            begin
            add_output_sign <= sign_input_02 && (!sign_input_01);
            end
        else // TH exp 1> exp 2
            begin     
            add_output_sign <= (!sign_input_02) && sign_input_01;
            end            
        end                
    end   
endmodule 
