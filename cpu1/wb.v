module wb(
    input [63:0]    w_pc_i,
    output [63:0]   w_pc_o,

    input [63:0]    w_alu_result_i,
    input [63:0]    w_mem_rdata_i,
    input           w_reg_wen_i,
    input           w_reg_mux_i,
    input [4:0]     w_reg_waddr_i,
    output          w_reg_wen_o,
    output [4:0]    w_reg_waddr_o,
    output [63:0]   w_reg_wdata_o
);

    assign w_pc_o = w_pc_i;
    assign w_reg_wen_o = w_reg_wen_i;
    assign w_reg_waddr_o = w_reg_waddr_i;
    assign w_reg_wdata_o = w_reg_mux_i ? w_mem_rdata_i : w_alu_result_i;

endmodule