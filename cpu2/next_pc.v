module next_pc(
    input [63:0]    pc_i,
    input           branch_i,
    input [63:0]    pc_b_i,
    input           jump_jal_i,
    input [63:0]    pc_jal_i,
    input           jump_jalr_i,
    input [63:0]    pc_jalr_i,
    output [63:0]   next_pc_o
);

    assign next_pc_o = branch_i ? pc_b_i :
                       jump_jal_i ? pc_jal_i :
                       jump_jalr_i ? pc_jalr_i : (pc_i + 4);
endmodule