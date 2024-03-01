module cpu(
    input clk_i,
    input rst_n_i,
    output [63:0] pc_o
);

    wire [63:0] pc;
    wire [63:0] next_pc;
    pc pc_inst(
        .clk_i(clk_i),
        .rst_n_i(rst_n_i),
        .next_pc_i(next_pc),
        .pc_o(pc)
    );

    wire            branch;
    wire [63:0]     pc_b;
    wire            jump_jal;
    wire [63:0]     pc_jal;
    wire            jump_jalr;
    wire [63:0]     pc_jalr;  
    next_pc next_pc_inst(
        .pc_i(pc),
        .branch_i(branch),
        .pc_b_i(pc_b),
        .jump_jal_i(jump_jal),
        .pc_jal_i(pc_jal),
        .jump_jalr_i(jump_jalr),
        .pc_jalr_i(pc_jalr),
        .next_pc_o(next_pc)
    );

    wire [63:0] pc_f_d;
    wire [31:0] instr_f_d;
    fetch fetct_inst(
        .f_pc_i(pc),
        .f_pc_o(pc_f_d),
        .f_instr_o(instr_f_d)
    );

    wire [63:0] pc_d_e;
    wire [4:0]  reg_raddr1_d_regs;
    wire [4:0]  reg_raddr2_d_regs;
    wire [4:0]  reg_waddr_d_e;
    wire [63:0] reg_rdata1_regs_d;
    wire [63:0] reg_rdata2_regs_d;
    wire [63:0] imm_d_e;
    wire [63:0] reg_rdata1_d_e;
    wire [63:0] reg_rdata2_d_e;
    wire [2:0]  l_mux_d_e;
    wire [2:0]  s_mux_d_e;
    wire        reg_mux_d_e;
    wire [4:0]  alu_op_d_e;
    wire [1:0]  aludata1_mux_d_e;
    wire [1:0]  aludata2_mux_d_e;
    wire        mem_wen_d_e;
    wire [63:0] mem_wdata_temp_d_e;
    wire        reg_wen_d_e;


    decode decode_inst(
        .d_instr_i(instr_f_d),
        .d_pc_i(pc_f_d),
        .d_pc_o(pc_d_e),
        .d_reg_raddr1_o(reg_raddr1_d_regs),
        .d_reg_raddr2_o(reg_raddr2_d_regs),
        .d_reg_waddr_o(reg_waddr_d_e),
        .d_reg_rdata1_i(reg_rdata1_regs_d),
        .d_reg_rdata2_i(reg_rdata2_regs_d),
        .d_imm_o(imm_d_e),
        .d_reg_rdata1_o(reg_rdata1_d_e),
        .d_reg_rdata2_o(reg_rdata2_d_e),
        .d_branch_o(branch),
        .d_pc_b_o(pc_b),
        .d_jump_jal_o(jump_jal),
        .d_pc_jal_o(pc_jal),
        .d_jump_jalr_o(jump_jalr),
        .d_pc_jalr_o(pc_jalr),
        .d_l_mux_o(l_mux_d_e),
        .d_s_mux_o(s_mux_d_e),
        .d_reg_mux_o(reg_mux_d_e),
        .d_alu_op_o(alu_op_d_e),
        .d_aludata1_mux_o(aludata1_mux_d_e),
        .d_aludata2_mux_o(aludata2_mux_d_e),
        .d_mem_wen_o(mem_wen_d_e),
        .d_mem_wdata_temp_o(mem_wdata_temp_d_e),
        .d_reg_wen_o(reg_wen_d_e)
    );

    wire [63:0] pc_e_m;
    wire [63:0] alu_result_e_m;
    wire        reg_wen_e_m;
    wire        reg_mux_e_m;
    wire [4:0]  reg_waddr_e_m;
    wire        mem_wen_e_m;
    wire [63:0] mem_wdata_temp_e_m;
    wire [63:0] mem_addr_e_m;
    wire [2:0]  l_mux_e_m;
    wire [2:0]  s_mux_e_m;
    exe exe_inst(
        .e_pc_i(pc_d_e),
        .e_pc_o(pc_e_m),
        .e_imm_i(imm_d_e),
        .e_reg_rdata1_i(reg_rdata1_d_e),
        .e_reg_rdata2_i(reg_rdata2_d_e),
        .e_alu_op_i(alu_op_d_e),
        .e_aludata1_mux_i(aludata1_mux_d_e),
        .e_aludata2_mux_i(aludata2_mux_d_e),
        .e_alu_result_o(alu_result_e_m),
        .e_reg_wen_i(reg_wen_d_e),
        .e_reg_mux_i(reg_mux_d_e),
        .e_reg_waddr_i(reg_waddr_d_e),
        .e_reg_wen_o(reg_wen_e_m),
        .e_reg_mux_o(reg_mux_e_m),
        .e_reg_waddr_o(reg_waddr_e_m),
        .e_mem_wen_i(mem_wen_d_e),
        .e_mem_wdata_temp_i(mem_wdata_temp_d_e),
        .e_mem_wen_o(mem_wen_e_m),
        .e_mem_wdata_temp_o(mem_wdata_temp_e_m),
        .e_mem_addr_o(mem_addr_e_m),
        .e_l_mux_i(l_mux_d_e),
        .e_s_mux_i(s_mux_d_e),
        .e_l_mux_o(l_mux_e_m),
        .e_s_mux_o(s_mux_e_m)
    );

    wire [63:0] pc_m_w;
    wire [63:0] alu_result_m_w;
    wire [63:0] mem_rdata_m_w;
    wire        reg_wen_m_w;
    wire        reg_mux_m_w;
    wire [4:0]  reg_waddr_m_w;

    mem_access mem_access_inst(
        .clk_i(clk_i),
        .m_pc_i(pc_e_m),
        .m_pc_o(pc_m_w),
        .m_alu_result_i(alu_result_e_m),
        .m_alu_result_o(alu_result_m_w),
        .m_l_mux_i(l_mux_e_m),
        .m_s_mux_i(s_mux_e_m),
        .m_mem_wen_i(mem_wen_e_m),
        .m_mem_wdata_temp_i(mem_wdata_temp_e_m),
        .m_mem_addr_i(mem_addr_e_m),
        .m_mem_rdata_o(mem_rdata_m_w),
        .m_reg_wen_i(reg_wen_e_m),
        .m_reg_mux_i(reg_mux_e_m),
        .m_reg_waddr_i(reg_waddr_e_m),
        .m_reg_wen_o(reg_wen_m_w),
        .m_reg_mux_o(reg_mux_m_w),
        .m_reg_waddr_o(reg_waddr_m_w)
    );

    wire        reg_wen_w_regs;
    wire [4:0]  reg_waddr_w_regs;
    wire [63:0] reg_wdata_w_regs;
    wb wb_inst(
        .w_pc_i(pc_m_w),
        .w_pc_o(pc_o),
        .w_alu_result_i(alu_result_m_w),
        .w_mem_rdata_i(mem_rdata_m_w),
        .w_reg_wen_i(reg_wen_m_w),
        .w_reg_mux_i(reg_mux_m_w),
        .w_reg_waddr_i(reg_waddr_m_w),
        .w_reg_wen_o(reg_wen_w_regs),
        .w_reg_waddr_o(reg_waddr_w_regs),
        .w_reg_wdata_o(reg_wdata_w_regs)
    );

    regs regs_inst(
        .clk_i(clk_i),
        .reg_raddr1_i(reg_raddr1_d_regs),
        .reg_raddr2_i(reg_raddr2_d_regs),
        .reg_wen_i(reg_wen_w_regs),
        .reg_waddr_i(reg_waddr_w_regs),
        .reg_wdata_i(reg_wdata_w_regs),
        .reg_rdata1_o(reg_rdata1_regs_d),
        .reg_rdata2_o(reg_rdata2_regs_d)
    );

endmodule