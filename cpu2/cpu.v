module cpu(
    input clk_i,
    input rst_n_i,
    output [63:0] pc_o
);

    wire pc_stall;
    wire D_bubble;
    wire D_stall;
    wire E_bubble;
    wire E_stall;
    wire M_bubble;
    wire M_stall;
    wire W_bubble;
    wire W_stall;

    wire [63:0] pc;
    wire [63:0] next_pc;
    pc pc_inst(
        .clk_i(clk_i),
        .rst_n_i(rst_n_i),
        .pc_stall_i(pc_stall),
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

    wire [63:0] pc_f_D;
    wire [31:0] instr_f_D;
    fetch fetct_inst(
        .f_pc_i(pc),
        .f_pc_o(pc_f_D),
        .f_instr_o(instr_f_D)
    );

    wire [63:0] pc_D_d;
    wire [31:0] instr_D_d;

    pipe_D_reg pipe_D_reg_inst(
        .clk_i(clk_i),
        .rst_n_i(rst_n_i),
        .D_bubble_i(D_bubble),
        .D_stall_i(D_stall),
        .D_pc_i(pc_f_D),
        .D_pc_o(pc_D_d),
        .D_instr_i(instr_f_D),
        .D_instr_o(instr_D_d)
    );

    wire [63:0] pc_d_E;
    wire [4:0]  reg_waddr_d_E;
    wire [63:0] imm_d_E;
    wire [63:0] reg_rdata1_d_E;
    wire [63:0] reg_rdata2_d_E;
    wire [2:0]  l_mux_d_E;
    wire [2:0]  s_mux_d_E;
    wire        reg_mux_d_E;
    wire [4:0]  alu_op_d_E;
    wire [1:0]  aludata1_mux_d_E;
    wire [1:0]  aludata2_mux_d_E;
    wire        mem_wen_d_E;
    wire        reg_wen_d_E;   
    wire [4:0]  reg_raddr1_d_regs;
    wire [4:0]  reg_raddr2_d_regs;
    wire [63:0] reg_rdata1_regs_d;
    wire [63:0] reg_rdata2_regs_d;
    wire [63:0] branch_opdata1;
    wire [63:0] branch_opdata2;
    wire        branch_type;
    wire        alu_data1_rs1;
    wire        alu_data2_rs2;
    wire [63:0] jump_opdata1;
    wire [63:0] mem_wdata_temp_d_E;
    wire [63:0] mem_wdata_temp;
    wire        store_type; 

    decode decode_inst(
        .d_instr_i(instr_D_d),
        .d_pc_i(pc_D_d),
        .d_pc_o(pc_d_E),
        .d_reg_raddr1_o(reg_raddr1_d_regs),
        .d_reg_raddr2_o(reg_raddr2_d_regs),
        .d_reg_waddr_o(reg_waddr_d_E),
        .d_reg_rdata1_i(reg_rdata1_regs_d),
        .d_reg_rdata2_i(reg_rdata2_regs_d),
        .d_imm_o(imm_d_E),
        .d_reg_rdata1_o(reg_rdata1_d_E),
        .d_reg_rdata2_o(reg_rdata2_d_E),
        .d_branch_opdata1_i(branch_opdata1),
        .d_branch_opdata2_i(branch_opdata2),
        .d_branch_o(branch),
        .d_branch_type_o(branch_type),
        .d_store_type_o(store_type),
        .d_pc_b_o(pc_b),
        .d_jump_opdata1_i(jump_opdata1),
        .d_jump_jal_o(jump_jal),
        .d_pc_jal_o(pc_jal),
        .d_jump_jalr_o(jump_jalr),
        .d_pc_jalr_o(pc_jalr),
        .d_alu_data1_rs1_o(alu_data1_rs1),
        .d_alu_data2_rs2_o(alu_data2_rs2),
        .d_l_mux_o(l_mux_d_E),
        .d_s_mux_o(s_mux_d_E),
        .d_reg_mux_o(reg_mux_d_E),
        .d_alu_op_o(alu_op_d_E),
        .d_aludata1_mux_o(aludata1_mux_d_E),
        .d_aludata2_mux_o(aludata2_mux_d_E),
        .d_mem_wen_o(mem_wen_d_E),
        .d_mem_wdata_temp_i(mem_wdata_temp),
        .d_mem_wdata_temp_o(mem_wdata_temp_d_E),
        .d_reg_wen_o(reg_wen_d_E)
    );

    wire [63:0] pc_E_e;
    wire [63:0] imm_E_e;
    wire [63:0] reg_rdata1_E_fwd;
    wire [63:0] reg_rdata2_E_fwd;
    wire [4:0]  reg_raddr1_E_e;
    wire [4:0]  reg_raddr2_E_e;
    wire [4:0]  reg_waddr_E_e;
    wire        reg_mux_E_e;
    wire        reg_wen_E_e;
    wire [2:0]  l_mux_E_e;
    wire [2:0]  s_mux_E_e;
    wire [4:0]  alu_op_E_e;
    wire [1:0]  aludata1_mux_E_e;
    wire [1:0]  aludata2_mux_E_e;
    wire        mem_wen_E_e;
    wire [63:0] mem_wdata_temp_E_e;

    pipe_E_reg pipe_E_reg_inst(
        .clk_i(clk_i),
        .rst_n_i(rst_n_i),
        .E_stall_i(E_stall),
        .E_bubble_i(E_bubble),
        .E_pc_i(pc_d_E),
        .E_pc_o(pc_E_e),
        .E_imm_i(imm_d_E),
        .E_imm_o(imm_E_e),
        .E_reg_rdata1_i(reg_rdata1_d_E),
        .E_reg_rdata1_o(reg_rdata1_E_fwd),
        .E_reg_rdata2_i(reg_rdata2_d_E),
        .E_reg_rdata2_o(reg_rdata2_E_fwd),
        .E_reg_raddr1_i(reg_raddr1_d_regs),
        .E_reg_raddr1_o(reg_raddr1_E_e),
        .E_reg_raddr2_i(reg_raddr2_d_regs),
        .E_reg_raddr2_o(reg_raddr2_E_e),
        .E_reg_waddr_i(reg_waddr_d_E),
        .E_reg_waddr_o(reg_waddr_E_e),
        .E_reg_mux_i(reg_mux_d_E),
        .E_reg_mux_o(reg_mux_E_e),
        .E_reg_wen_i(reg_wen_d_E),
        .E_reg_wen_o(reg_wen_E_e),
        .E_l_mux_i(l_mux_d_E),
        .E_l_mux_o(l_mux_E_e),
        .E_s_mux_i(s_mux_d_E),
        .E_s_mux_o(s_mux_E_e),
        .E_alu_op_i(alu_op_d_E),
        .E_alu_op_o(alu_op_E_e),         
        .E_aludata1_mux_i(aludata1_mux_d_E),
        .E_aludata1_mux_o(aludata1_mux_E_e),
        .E_aludata2_mux_i(aludata2_mux_d_E),
        .E_aludata2_mux_o(aludata2_mux_E_e),
        .E_mem_wen_i(mem_wen_d_E),
        .E_mem_wen_o(mem_wen_E_e),
        .E_mem_wdata_temp_i(mem_wdata_temp_d_E),
        .E_mem_wdata_temp_o(mem_wdata_temp_E_e)
    );

    wire [63:0] pc_e_M;
    wire [63:0] alu_result_e_M;
    wire        reg_wen_e_M;
    wire        reg_mux_e_M;
    wire [4:0]  reg_waddr_e_M;
    wire        mem_wen_e_M;
    wire [63:0] mem_wdata_temp_e_M;
    wire [63:0] mem_addr_e_M;
    wire [2:0]  l_mux_e_M;
    wire [2:0]  s_mux_e_M;   
    wire [63:0] alu_opdata1_fwd_e;
    wire [63:0] alu_opdata2_fwd_e;

    exe exe_inst(
        .e_pc_i(pc_E_e),
        .e_pc_o(pc_e_M),
        .e_imm_i(imm_E_e),
        .e_reg_rdata1_i(alu_opdata1_fwd_e),
        .e_reg_rdata2_i(alu_opdata2_fwd_e),
        .e_alu_op_i(alu_op_E_e),
        .e_aludata1_mux_i(aludata1_mux_E_e),
        .e_aludata2_mux_i(aludata2_mux_E_e),
        .e_alu_result_o(alu_result_e_M),
        .e_reg_wen_i(reg_wen_E_e),
        .e_reg_mux_i(reg_mux_E_e),
        .e_reg_raddr1_i(reg_raddr1_E_e),
        .e_reg_raddr2_i(reg_raddr2_E_e),
        .e_reg_waddr_i(reg_waddr_E_e),
        .e_reg_wen_o(reg_wen_e_M),
        .e_reg_mux_o(reg_mux_e_M),
        .e_reg_waddr_o(reg_waddr_e_M),
        .e_mem_wen_i(mem_wen_E_e),
        .e_mem_wen_o(mem_wen_e_M),
        .e_mem_wdata_temp_i(mem_wdata_temp_E_e),
        .e_mem_wdata_temp_o(mem_wdata_temp_e_M),
        .e_mem_addr_o(mem_addr_e_M),    
        .e_l_mux_i(l_mux_E_e),
        .e_s_mux_i(s_mux_E_e),
        .e_l_mux_o(l_mux_e_M),
        .e_s_mux_o(s_mux_e_M)
    );

    wire [63:0] pc_M_m;
    wire [63:0] alu_result_M_m;
    wire        reg_wen_M_m;
    wire        reg_mux_M_m;
    wire [4:0]  reg_waddr_M_m;
    wire        mem_wen_M_m;
    wire [63:0] mem_wdata_temp_M_m;
    wire [63:0] mem_addr_M_m;
    wire [2:0]  l_mux_M_m;
    wire [2:0]  s_mux_M_m;

    pipe_M_reg pipe_M_reg_inst(
        .clk_i(clk_i),              
        .rst_n_i(rst_n_i),
        .M_stall_i(M_stall),
        .M_bubble_i(M_bubble),
        .M_pc_i(pc_e_M), 
        .M_pc_o(pc_M_m),
        .M_alu_result_i(alu_result_e_M),
        .M_alu_result_o(alu_result_M_m),
        .M_reg_wen_i(reg_wen_e_M),
        .M_reg_wen_o(reg_wen_M_m),
        .M_reg_mux_i(reg_mux_e_M),
        .M_reg_mux_o(reg_mux_M_m),
        .M_reg_waddr_i(reg_waddr_e_M),
        .M_reg_waddr_o(reg_waddr_M_m), 
        .M_mem_wen_i(mem_wen_e_M),
        .M_mem_wen_o(mem_wen_M_m),
        .M_mem_wdata_temp_i(mem_wdata_temp_e_M),
        .M_mem_wdata_temp_o(mem_wdata_temp_M_m),
        .M_mem_addr_i(mem_addr_e_M),
        .M_mem_addr_o(mem_addr_M_m),
        .M_l_mux_i(l_mux_e_M),
        .M_l_mux_o(l_mux_M_m),
        .M_s_mux_i(s_mux_e_M),
        .M_s_mux_o(s_mux_M_m)
    );

    wire [63:0] pc_m_W;
    wire [63:0] alu_result_m_W;
    wire [63:0] mem_rdata_m_W;
    wire        reg_wen_m_W;
    wire        reg_mux_m_W;
    wire [4:0]  reg_waddr_m_W;  

    mem_access mem_access_inst(
        .clk_i(clk_i),
        .m_pc_i(pc_M_m),
        .m_pc_o(pc_m_W),
        .m_alu_result_i(alu_result_M_m),
        .m_alu_result_o(alu_result_m_W),
        .m_l_mux_i(l_mux_M_m),
        .m_s_mux_i(s_mux_M_m),
        .m_mem_wen_i(mem_wen_M_m),
        .m_mem_wdata_temp_i(mem_wdata_temp_M_m),
        .m_mem_addr_i(mem_addr_M_m),
        .m_mem_rdata_o(mem_rdata_m_W),
        .m_reg_wen_i(reg_wen_M_m),
        .m_reg_mux_i(reg_mux_M_m),
        .m_reg_waddr_i(reg_waddr_M_m),
        .m_reg_wen_o(reg_wen_m_W),
        .m_reg_mux_o(reg_mux_m_W),
        .m_reg_waddr_o(reg_waddr_m_W)
    );

    wire [63:0] pc_W_w;
    wire [63:0] alu_result_W_w;
    wire [63:0] mem_rdata_W_w;
    wire        reg_wen_W_w;
    wire        reg_mux_W_w;
    wire [4:0]  reg_waddr_W_w;  

    pipe_W_reg pipe_W_reg_inst(
        .clk_i(clk_i),                
        .rst_n_i(rst_n_i),
        .W_bubble_i(W_bubble),
        .W_stall_i(W_stall),
        .W_pc_i(pc_m_W),        
        .W_pc_o(pc_W_w),
        .W_alu_result_i(alu_result_m_W),
        .W_alu_result_o(alu_result_W_w),
        .W_mem_rdata_i(mem_rdata_m_W),
        .W_mem_rdata_o(mem_rdata_W_w),
        .W_reg_wen_i(reg_wen_m_W),
        .W_reg_wen_o(reg_wen_W_w),
        .W_reg_mux_i(reg_mux_m_W),
        .W_reg_mux_o(reg_mux_W_w),
        .W_reg_waddr_i(reg_waddr_m_W),
        .W_reg_waddr_o(reg_waddr_W_w) 
    );

    wire        reg_wen_w_regs;
    wire [4:0]  reg_waddr_w_regs;
    wire [63:0] reg_wdata_w_regs;

    wb wb_inst(
        .w_pc_i(pc_W_w),
        .w_pc_o(pc_o),
        .w_alu_result_i(alu_result_W_w),
        .w_mem_rdata_i(mem_rdata_W_w),
        .w_reg_wen_i(reg_wen_W_w),
        .w_reg_mux_i(reg_mux_W_w),
        .w_reg_waddr_i(reg_waddr_W_w),
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

    forward forward_inst(
        // from regs
        .fwd_d_reg_raddr1_i(reg_raddr1_d_regs),
        .fwd_d_reg_raddr2_i(reg_raddr2_d_regs),
        // from mem_access
        .fwd_m_reg_wen_i(reg_wen_m_W),
        .fwd_m_reg_waddr_i(reg_waddr_m_W),
        .fwd_m_alu_result_i(alu_result_m_W),
        // from E_output
        .fwd_E_reg_raddr1_i(reg_raddr1_E_e),
        .fwd_E_reg_raddr2_i(reg_raddr2_E_e),
        .fwd_E_reg_rdata1_i(reg_rdata1_E_fwd),
        .fwd_E_reg_rdata2_i(reg_rdata2_E_fwd),
        // from regs
        .fwd_d_reg_rdata1_i(reg_rdata1_regs_d),
        .fwd_d_reg_rdata2_i(reg_rdata2_regs_d),
        // from M_output
        .fwd_M_reg_wen_i(reg_wen_M_m),
        .fwd_M_reg_waddr_i(reg_waddr_M_m),
        .fwd_M_reg_wdata_i(alu_result_M_m),
        // from W_output
        .fwd_W_reg_wen_i(reg_wen_W_w),
        .fwd_W_reg_waddr_i(reg_waddr_W_w),
        .fwd_W_reg_wdata_i(reg_wdata_w_regs),
        // to alu
        .fwd_alu_opdata1_o(alu_opdata1_fwd_e),
        .fwd_alu_opdata2_o(alu_opdata2_fwd_e),
        // to branch
        .fwd_branch_opdata1_o(branch_opdata1),
        .fwd_branch_opdata2_o(branch_opdata2),
        // to jump
        .fwd_jump_opdata1_o(jump_opdata1),
        // to mem_wdata
        .fwd_mem_wdata_temp_o(mem_wdata_temp)
    );

    pipe_control pipe_control_inst(
        // from d
        .d_reg_raddr1_i(reg_raddr1_d_regs),
        .d_reg_raddr2_i(reg_raddr2_d_regs),
        .d_branch_i(branch),
        .d_branch_type_i(branch_type),
        .d_store_type_i(store_type),
        .d_jump_jal_i(jump_jal),
        .d_jump_jalr_i(jump_jalr),
        .d_alu_data1_rs1_i(alu_data1_rs1),
        .d_alu_data2_rs2_i(alu_data2_rs2),
        // from E
        .E_reg_waddr_i(reg_waddr_E_e),
        .E_reg_mux_i(reg_mux_E_e),
        .E_reg_wen_i(reg_wen_E_e),
        // from M
        .M_reg_waddr_i(reg_waddr_M_m),
        .M_reg_mux_i(reg_mux_M_m),
        // pipe_regs_control
        .pc_stall_o(pc_stall),
        .D_bubble_o(D_bubble),
        .D_stall_o(D_stall),
        .E_bubble_o(E_bubble),
        .E_stall_o(E_stall),
        .M_bubble_o(M_bubble),
        .M_stall_o(M_stall),
        .W_bubble_o(W_bubble),
        .W_stall_o(W_stall)   
    );

endmodule