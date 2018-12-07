////////////////////////////////////////////////////////////////////////////////
//
// Arrive Technologies
//
// Filename     : normalize.v
// Description  : .
//
// Author       : nguyentvd@atvn.com
// Created On   : Thu Oct 25 23:01:07 2018
// History (Date, Changed By)
//
////////////////////////////////////////////////////////////////////////////////

module normalize
    (
     add_sub_result,
     larger_exponent,
     is_factor_01_zero,
     is_factor_02_zero,
     is_add_sub_result_zero,
     exp_input_02,
     exp_input_01,
     significand_input_02,
     significand_input_01,
     
     add_output_exponent,
     add_output_significands
     );

////////////////////////////////////////////////////////////////////////////////
// Parameter declarations
parameter DATA_WIDTH = 32;
parameter EXP_WIDTH = 8;
parameter SIGNIFICANDS_WIDTH = 23;
parameter ADDER_WIDTH = 25;

////////////////////////////////////////////////////////////////////////////////
// Port declarations
input   [ADDER_WIDTH-1:0]      add_sub_result;
input   [EXP_WIDTH-1:0] larger_exponent;
input   [EXP_WIDTH-1:0] exp_input_01,
                        exp_input_02;
input [SIGNIFICANDS_WIDTH-1:0]  significand_input_01,
                                significand_input_02;
input   is_factor_01_zero,
        is_factor_02_zero,
        is_add_sub_result_zero;

output  add_output_exponent,
        add_output_significands;


////////////////////////////////////////////////////////////////////////////////
// Output declaration

reg  [EXP_WIDTH-1:0]     add_output_exponent;
reg  [SIGNIFICANDS_WIDTH-1:0] add_output_significands;

////////////////////////////////////////////////////////////////////////////////
// find the first bit 1
wire bit_00, 
     bit_01,  
     bit_02,  
     bit_03,  
     bit_04,  
     bit_05,  
     bit_06,  
     bit_07,  
     bit_08,  
     bit_09,
     bit_10, 
     bit_11,  
     bit_12,  
     bit_13,  
     bit_14,  
     bit_15,  
     bit_16,  
     bit_17,
     bit_18, 
     bit_19,  
     bit_20, 
     bit_21, 
     bit_22, 
     bit_23, 
     bit_24;
assign  bit_24 = add_sub_result[24];
assign  bit_23 = add_sub_result[23] && (!add_sub_result[24]);
assign  bit_22 = add_sub_result[22] && (!(|add_sub_result[24:23]));
assign  bit_21 = add_sub_result[21] && (!(|add_sub_result[24:22]));
assign  bit_20 = add_sub_result[20] && (!(|add_sub_result[24:21]));
assign  bit_19 = add_sub_result[19] && (!(|add_sub_result[24:20]));
assign  bit_18 = add_sub_result[18] && (!(|add_sub_result[24:19]));
assign  bit_17 = add_sub_result[17] && (!(|add_sub_result[24:18]));
assign  bit_16 = add_sub_result[16] && (!(|add_sub_result[24:17]));
assign  bit_15 = add_sub_result[15] && (!(|add_sub_result[24:16]));
assign  bit_14 = add_sub_result[14] && (!(|add_sub_result[24:15]));
assign  bit_13 = add_sub_result[13] && (!(|add_sub_result[24:14]));
assign  bit_12 = add_sub_result[12] && (!(|add_sub_result[24:13]));
assign  bit_11 = add_sub_result[11] && (!(|add_sub_result[24:12]));
assign  bit_10 = add_sub_result[10] && (!(|add_sub_result[24:11]));
assign  bit_09 = add_sub_result[9] && (!(|add_sub_result[24:10]));
assign  bit_08 = add_sub_result[8] && (!(|add_sub_result[24:9] ));
assign  bit_07 = add_sub_result[7] && (!(|add_sub_result[24:8] ));
assign  bit_06 = add_sub_result[6] && (!(|add_sub_result[24:7] ));
assign  bit_05 = add_sub_result[5] && (!(|add_sub_result[24:6] ));
assign  bit_04 = add_sub_result[4] && (!(|add_sub_result[24:5] ));
assign  bit_03 = add_sub_result[3] && (!(|add_sub_result[24:4] ));
assign  bit_02 = add_sub_result[2] && (!(|add_sub_result[24:3] ));
assign  bit_01 = add_sub_result[1] && (!(|add_sub_result[24:2] ));
assign  bit_00 = add_sub_result[0] && (!(|add_sub_result[24:1] ));

wire    bit_temp_01,
        bit_temp_02;

assign  bit_temp_01 = bit_24|bit_23; // TH can shift left
assign  bit_temp_02 = bit_22|bit_21|bit_20|bit_19|bit_18|bit_17|bit_16|bit_15|bit_14|bit_13|bit_12|bit_11|bit_10|bit_09|bit_08|bit_07|bit_06|bit_05|bit_04|bit_03|bit_02|bit_01|bit_00;// TH can shift right
////////////////////////////////////////////////////////////////////////////////
// normalize
reg [EXP_WIDTH-1:0] shift_temp_01;
reg [EXP_WIDTH-1:0] shift_temp_02;
reg [SIGNIFICANDS_WIDTH-1:0] pre_sig_res_01;
reg [SIGNIFICANDS_WIDTH-1:0] pre_sig_res_02;
always@(*) 
    begin
    if(bit_24) 
        begin
        shift_temp_01  <= 1;
        pre_sig_res_01 <= add_sub_result[23:1]; // pre_sig_res 23 bit
        end
    else 
        begin
        shift_temp_01  <= 0;
        pre_sig_res_01 <= add_sub_result[22:0];
        end
    end 
                     
always@(*) 
    begin
    if(bit_22) 
        begin
        shift_temp_02  <= 1; 
        pre_sig_res_02 <= {add_sub_result[21:0],1'b0};
        end
    else if(bit_21) 
        begin
        shift_temp_02  <= 2;
        pre_sig_res_02 <= {add_sub_result[20:0],{2{1'b0}}};
        end
    else if(bit_20) 
        begin
        shift_temp_02  <= 3;
        pre_sig_res_02 <= {add_sub_result[19:0],{3{1'b0}}};
        end
    else if(bit_19)
        begin
        shift_temp_02  <= 4; 
        pre_sig_res_02 <= {add_sub_result[18:0],{4{1'b0}}};
        end
    else if(bit_18) 
        begin
        shift_temp_02  <= 5;
        pre_sig_res_02 <= {add_sub_result[17:0],{5{1'b0}}};
        end
    else if(bit_17) 
        begin
        shift_temp_02  <= 6;
        pre_sig_res_02 <= {add_sub_result[16:0],{6{1'b0}}};
        end
    else if(bit_16) 
        begin
        shift_temp_02  <= 7;
        pre_sig_res_02 <= {add_sub_result[15:0],{7{1'b0}}};
        end
    else if(bit_15)
        begin
        shift_temp_02  <= 8;
        pre_sig_res_02 <= {add_sub_result[14:0],{8{1'b0}}};
        end

    else if(bit_14) 
        begin
        shift_temp_02  <= 9;
        pre_sig_res_02 <= {add_sub_result[13:0],{9{1'b0}}};
        end
    else if(bit_13)     
        begin
        shift_temp_02  <= 10;
        pre_sig_res_02 <= {add_sub_result[12:0],{10{1'b0}}};
        end
    else if(bit_12) 
        begin
        shift_temp_02  <= 11;
        pre_sig_res_02 <= {add_sub_result[11:0],{11{1'b0}}};
        end
    else if(bit_11) 
        begin
        shift_temp_02  <= 12;
        pre_sig_res_02 <= {add_sub_result[10:0],{12{1'b0}}};
        end
    else if(bit_10) 
        begin
        shift_temp_02  <= 13;
        pre_sig_res_02 <= {add_sub_result[9:0], {13{1'b0}}};
        end
    else if(bit_09) 
        begin
        shift_temp_02  <= 14;
        pre_sig_res_02 <= {add_sub_result[8:0], {14{1'b0}}};
        end
    else if(bit_08)
        begin
        shift_temp_02  <= 15; 
        pre_sig_res_02 <= {add_sub_result[7:0], {15{1'b0}}};
        end
    else if(bit_07) 
        begin
        shift_temp_02  <= 16;
        pre_sig_res_02 <= {add_sub_result[6:0], {16{1'b0}}};
        end
    else if(bit_06) 
        begin
        shift_temp_02 <= 17;
        pre_sig_res_02 <= {add_sub_result[5:0], {17{1'b0}}};
        end
    else if(bit_05) 
        begin
        shift_temp_02 <= 18;
        pre_sig_res_02 <= {add_sub_result[4:0], {18{1'b0}}};
        end
    else if(bit_04) 
        begin
        shift_temp_02 <= 19;
        pre_sig_res_02 <= {add_sub_result[3:0], {19{1'b0}}};
        end
    else if(bit_03) 
        begin
        shift_temp_02 <= 20;
        pre_sig_res_02 <= {add_sub_result[2:0], {20{1'b0}}};
        end
    else if(bit_02) 
        begin
        shift_temp_02 <= 21;
        pre_sig_res_02 <= {add_sub_result[1:0], {21{1'b0}}};
        end
    else if(bit_01) 
        begin
        shift_temp_02 <= 22;
        pre_sig_res_02 <= {add_sub_result[0],   {22{1'b0}}};
        end
    else 
        begin
        shift_temp_02  <= 23; 
        pre_sig_res_02 <= {23{1'b0}};
        end
    end

wire [EXP_WIDTH-1:0]     add_output_exponent_w1;
wire [EXP_WIDTH-1:0]     add_output_exponent_w2;
add8bit add8_03(
                .out(add_output_exponent_w1),
                .a(larger_exponent),
                .b(shift_temp_01),
                .cin(1'b0)
                );
add8bit add8_04(
                .out(add_output_exponent_w2),   
                .a(larger_exponent),
                .b(~shift_temp_02),
                .cin(1'b1)
                );

always@(*) 
    begin
    if(is_factor_01_zero) 
        begin
         add_output_exponent     <= exp_input_02;
         add_output_significands <= significand_input_02;
        end
    else if(is_factor_02_zero) 
        begin
         add_output_exponent     <= exp_input_01;
         add_output_significands <= significand_input_01;
        end
    else  if(is_add_sub_result_zero) 
        begin
         add_output_exponent     <= 0;
         add_output_significands <= 0;
        end
    else if(bit_temp_01) 
        begin
         add_output_exponent     <= add_output_exponent_w1;//larger_exponent + shift_temp_01
         add_output_significands <= pre_sig_res_01;
        end
    else if(bit_temp_02) 
        begin
         add_output_exponent     <= add_output_exponent_w2;//larger_exponent - shift_temp_02
         add_output_significands <= pre_sig_res_02;
        end
  
end
endmodule 
