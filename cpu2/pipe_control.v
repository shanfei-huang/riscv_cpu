module pipe_control(
    // from d
    input   [4:0]   d_reg_raddr1_i,
    input   [4:0]   d_reg_raddr2_i,
    input           d_branch_i,
    input           d_jump_jal_i,
    input           d_jump_jalr_i,
    input           d_store_type_i,
    input           d_branch_type_i,
    input           d_alu_data1_rs1_i,
    input           d_alu_data2_rs2_i,
    // from E
    input   [4:0]   E_reg_waddr_i,
    input           E_reg_mux_i,
    input           E_reg_wen_i,
    // from M
    input   [4:0]   M_reg_waddr_i,
    input           M_reg_mux_i,
    output          pc_stall_o,
    output          D_bubble_o,
    output          D_stall_o,
    output          E_bubble_o,
    output          E_stall_o,
    output          M_bubble_o,
    output          M_stall_o,
    output          W_bubble_o,
    output          W_stall_o
);

    wire rs1_ld_use_conflict;
    wire rs2_ld_use_conflict;
    assign rs1_ld_use_conflict = (d_reg_raddr1_i == E_reg_waddr_i) && E_reg_mux_i && d_alu_data1_rs1_i;
    assign rs2_ld_use_conflict = (d_reg_raddr2_i == E_reg_waddr_i) && E_reg_mux_i && d_alu_data2_rs2_i;
    wire ld_use_conflict;
    assign ld_use_conflict = rs1_ld_use_conflict | rs2_ld_use_conflict;
    wire branch_conflict1;
    assign branch_conflict1 = ((d_reg_raddr1_i == E_reg_waddr_i) || (d_reg_raddr2_i == E_reg_waddr_i)) && d_branch_type_i && E_reg_wen_i;
    wire branch_conflict2;
    assign branch_conflict2 = ((d_reg_raddr1_i == M_reg_waddr_i) || (d_reg_raddr2_i == M_reg_waddr_i)) && d_branch_type_i && M_reg_mux_i;
    wire branch_conflict;
    assign branch_conflict = branch_conflict1 || branch_conflict2;
    wire jump_conflict1;
    assign jump_conflict1 = (d_reg_raddr1_i == E_reg_waddr_i) && d_jump_jalr_i && E_reg_wen_i;
    wire jump_conflict2;
    assign jump_conflict2 = (d_reg_raddr1_i == M_reg_waddr_i) && d_jump_jalr_i && M_reg_mux_i;
    wire jump_conflict;
    assign jump_conflict = jump_conflict1 || jump_conflict2;
    wire store_conflict1;
    assign store_conflict1 = (d_reg_raddr2_i == E_reg_waddr_i) && d_store_type_i && E_reg_wen_i;
    wire store_conflict2;
    assign store_conflict2 = (d_reg_raddr2_i == M_reg_waddr_i) && d_store_type_i && M_reg_mux_i;
    wire store_conflict;
    assign store_conflict = store_conflict1 || store_conflict2;

    assign pc_stall_o = ld_use_conflict || branch_conflict || jump_conflict || store_conflict;
    assign D_stall_o = ld_use_conflict || branch_conflict || jump_conflict || store_conflict;
    assign D_bubble_o = d_branch_i || d_jump_jal_i || d_jump_jalr_i;
    assign E_bubble_o = ld_use_conflict || branch_conflict || jump_conflict || store_conflict; 
    assign E_stall_o = 1'b0;
    assign M_bubble_o = 1'b0;
    assign M_stall_o = 1'b0;
    assign W_bubble_o = 1'b0;
    assign W_stall_o = 1'b0;
endmodule