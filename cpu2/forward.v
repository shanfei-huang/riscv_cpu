module forward(
   // from regs
   input    [4:0]   fwd_d_reg_raddr1_i,
   input    [4:0]   fwd_d_reg_raddr2_i,
   // from mem_access
   input            fwd_m_reg_wen_i,
   input    [4:0]   fwd_m_reg_waddr_i,
   input    [63:0]  fwd_m_alu_result_i,
   // from E_output
   input    [4:0]   fwd_E_reg_raddr1_i,
   input    [4:0]   fwd_E_reg_raddr2_i,
   input    [63:0]  fwd_E_reg_rdata1_i,
   input    [63:0]  fwd_E_reg_rdata2_i, 
   // from regs
   input    [63:0]  fwd_d_reg_rdata1_i,
   input    [63:0]  fwd_d_reg_rdata2_i,
   // from M_output
   input            fwd_M_reg_wen_i, 
   input    [4:0]   fwd_M_reg_waddr_i,
   input    [63:0]  fwd_M_reg_wdata_i,
   // from W_output
   input            fwd_W_reg_wen_i,
   input    [4:0]   fwd_W_reg_waddr_i,
   input    [63:0]  fwd_W_reg_wdata_i,
   // to alu
   output   [63:0]  fwd_alu_opdata1_o,
   output   [63:0]  fwd_alu_opdata2_o,
   // to branch
   output   [63:0]  fwd_branch_opdata1_o,
   output   [63:0]  fwd_branch_opdata2_o,
   // to jump
   output   [63:0]  fwd_jump_opdata1_o,
   // to mem_wdata
   output   [63:0]  fwd_mem_wdata_temp_o
);

    assign fwd_alu_opdata1_o = ((fwd_E_reg_raddr1_i == fwd_M_reg_waddr_i) && (fwd_E_reg_raddr1_i != 5'b0) && fwd_M_reg_wen_i) ? fwd_M_reg_wdata_i :
                               ((fwd_E_reg_raddr1_i == fwd_W_reg_waddr_i) && (fwd_E_reg_raddr1_i != 5'b0) && fwd_W_reg_wen_i) ? fwd_W_reg_wdata_i :
                               fwd_E_reg_rdata1_i;

    assign fwd_alu_opdata2_o = ((fwd_E_reg_raddr2_i == fwd_M_reg_waddr_i) && (fwd_E_reg_raddr2_i != 5'b0) && fwd_M_reg_wen_i) ? fwd_M_reg_wdata_i :
                               ((fwd_E_reg_raddr2_i == fwd_W_reg_waddr_i) && (fwd_E_reg_raddr2_i != 5'b0) && fwd_W_reg_wen_i) ? fwd_W_reg_wdata_i :
                               fwd_E_reg_rdata2_i; 

    assign fwd_branch_opdata1_o = ((fwd_d_reg_raddr1_i == fwd_m_reg_waddr_i) && (fwd_d_reg_raddr1_i != 5'b0) && fwd_m_reg_wen_i) ? fwd_m_alu_result_i :
                                  fwd_d_reg_rdata1_i;
    
    assign fwd_branch_opdata2_o = ((fwd_d_reg_raddr2_i == fwd_m_reg_waddr_i) && (fwd_d_reg_raddr2_i != 5'b0) && fwd_m_reg_wen_i) ? fwd_m_alu_result_i :
                                  fwd_d_reg_rdata2_i;

    assign fwd_jump_opdata1_o = ((fwd_d_reg_raddr1_i == fwd_m_reg_waddr_i) && (fwd_d_reg_raddr1_i != 5'b0) && fwd_m_reg_wen_i) ? fwd_m_alu_result_i :
                                 fwd_d_reg_rdata1_i;

    assign fwd_mem_wdata_temp_o = ((fwd_d_reg_raddr2_i == fwd_m_reg_waddr_i) && (fwd_d_reg_raddr2_i != 5'b0) && fwd_m_reg_wen_i) ? fwd_m_alu_result_i :
                                  fwd_d_reg_rdata2_i;
endmodule