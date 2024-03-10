`include "define.v"
module exe(
    // pc
    input [63:0]    e_pc_i,
    output [63:0]   e_pc_o,
    // alu
    input [63:0]    e_imm_i,
    input [63:0]    e_reg_rdata1_i,
    input [63:0]    e_reg_rdata2_i,
    input [4:0]     e_alu_op_i,
    input [1:0]     e_aludata1_mux_i,
    input [1:0]     e_aludata2_mux_i,
    output [63:0]   e_alu_result_o,
    // reg
    input           e_reg_wen_i,
    input           e_reg_mux_i,
    input [4:0]     e_reg_raddr1_i,
    input [4:0]     e_reg_raddr2_i,
    input [4:0]     e_reg_waddr_i,
    output          e_reg_wen_o,
    output          e_reg_mux_o,
    output [4:0]    e_reg_waddr_o,
    // mem
    input           e_mem_wen_i,
    input  [63:0]   e_mem_wdata_temp_i,
    output          e_mem_wen_o,
    output [63:0]   e_mem_wdata_temp_o,
    output [63:0]   e_mem_addr_o,
    // l_type or s_type
    input [2:0]     e_l_mux_i,
    input [2:0]     e_s_mux_i,
    output [2:0]    e_l_mux_o,
    output [2:0]    e_s_mux_o
);

    assign e_pc_o = e_pc_i;
    assign e_reg_wen_o = e_reg_wen_i;
    assign e_reg_mux_o = e_reg_mux_i;
    assign e_reg_waddr_o = e_reg_waddr_i;

    assign e_mem_wen_o = e_mem_wen_i;
    assign e_mem_wdata_temp_o = e_mem_wdata_temp_i;
    assign e_l_mux_o = e_l_mux_i;
    assign e_s_mux_o = e_s_mux_i;

    wire [63:0] alu_op_data1;
    wire [63:0] alu_op_data2;

    assign alu_op_data1 = (e_aludata1_mux_i == 2'b00) ? 64'b0 :
                          (e_aludata1_mux_i == 2'b01) ? e_pc_i :
                          (e_aludata1_mux_i == 2'b10) ? e_reg_rdata1_i :
                          (e_aludata1_mux_i == 2'b11) ? 64'b0 : 64'b0;
    
    assign alu_op_data2 = (e_aludata2_mux_i == 2'b00) ? e_reg_rdata2_i :
                          (e_aludata2_mux_i == 2'b01) ? e_imm_i :
                          (e_aludata2_mux_i == 2'b10) ? 64'd4 :
                          (e_aludata2_mux_i == 2'b11) ? 64'b0 : 64'b0;

    wire [63:0] alu_add_result;
    wire [63:0] alu_addw_result;
    wire [63:0] alu_sub_result;
    wire [63:0] alu_sub_data1;
    wire [63:0] alu_sub_data2;
    wire        alu_sub_cin;
    wire        alu_sub_of;
    wire        alu_sub_sf;
    wire [63:0] alu_subw_result;
    wire [63:0] alu_or_result;
    wire [63:0] alu_xor_result;
    wire [63:0] alu_and_result;
    wire [63:0] alu_slt_result;
    wire [63:0] alu_sltu_result;
    wire [63:0] alu_sll_result;
    wire [63:0] alu_sllw_result;
    wire [63:0] alu_srl_result;
    wire [63:0] alu_srlw_result;
    wire [63:0] alu_sra_result;
    wire [63:0] alu_sraw_result;

    assign alu_add_result   = alu_op_data1 + alu_op_data2;
    assign alu_addw_result  = {{32{alu_add_result[31]}},alu_add_result[31:0]};
    assign alu_sub_data1 = alu_op_data1;
    assign alu_sub_data2 = (~alu_op_data2) + 1'b1;
    assign {alu_sub_cin,alu_sub_result} = alu_sub_data1 + alu_sub_data2;
    assign alu_sub_of = (alu_sub_data1[63] == alu_sub_data2[63]) && (alu_sub_data1[63] != alu_sub_result[63]);
    assign alu_sub_sf = alu_sub_result[63];
    assign alu_subw_result = {{32{alu_sub_result[31]}},alu_sub_result[31:0]};
    assign alu_or_result = alu_op_data1 | alu_op_data2;
    assign alu_xor_result = alu_op_data1 ^ alu_op_data2;
    assign alu_and_result = alu_op_data1 & alu_op_data2;
    assign alu_slt_result = {63'b0,alu_sub_sf ^ alu_sub_of};
    assign alu_sltu_result = {63'b0,~alu_sub_cin};
    assign alu_sll_result = alu_op_data1 << alu_op_data2[5:0];
    wire [31:0] alu_sllw_result_temp;
    assign alu_sllw_result_temp = alu_op_data1[31:0] << alu_op_data2[4:0];
    assign alu_sllw_result = {{32{alu_sllw_result_temp[31]}},alu_sllw_result_temp[31:0]};
    assign alu_srl_result = alu_op_data1 >> alu_op_data2[5:0];
    wire [31:0] alu_srlw_result_temp;
    assign alu_srlw_result_temp = alu_op_data1[31:0] >> alu_op_data2[4:0];
    assign alu_srlw_result = {{32{alu_srlw_result_temp[31]}},alu_srlw_result_temp[31:0]};
    assign alu_sra_result = ({{63{alu_op_data1[63]}},1'b0} << (~alu_op_data2[5:0])) | (alu_op_data1 >> alu_op_data2[5:0]);
    wire [31:0] alu_sraw_result_temp;
    assign alu_sraw_result_temp = ({{31{alu_op_data1[31]}},1'b0} << (~alu_op_data2[4:0])) | (alu_op_data1[31:0] >> alu_op_data2[4:0]);
    assign alu_sraw_result = {{32{alu_sraw_result_temp[31]}},alu_sraw_result_temp[31:0]};

    assign e_alu_result_o = (e_alu_op_i == `alu_add) ? alu_add_result :
                            (e_alu_op_i == `alu_addw) ? alu_addw_result :
                            (e_alu_op_i == `alu_sub) ? alu_sub_result :
                            (e_alu_op_i == `alu_subw) ? alu_subw_result :
                            (e_alu_op_i == `alu_or) ? alu_or_result :
                            (e_alu_op_i == `alu_xor) ? alu_xor_result :
                            (e_alu_op_i == `alu_and) ? alu_and_result :
                            (e_alu_op_i == `alu_slt) ? alu_slt_result :
                            (e_alu_op_i == `alu_sltu) ? alu_sltu_result :
                            (e_alu_op_i == `alu_sll) ? alu_sll_result :
                            (e_alu_op_i == `alu_sllw) ? alu_sllw_result :
                            (e_alu_op_i == `alu_srl) ? alu_srl_result :
                            (e_alu_op_i == `alu_srlw) ? alu_srlw_result :
                            (e_alu_op_i == `alu_sra) ? alu_sra_result :
                            (e_alu_op_i == `alu_sraw) ? alu_sraw_result : 64'b0;
    
    assign e_mem_addr_o = alu_add_result;

endmodule
