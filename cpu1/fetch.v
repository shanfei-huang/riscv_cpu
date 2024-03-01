module fetch(
    input [63:0] f_pc_i,
    output [63:0] f_pc_o,
    output [31:0] f_instr_o
);
    inst_rom inst_rom_inst(
        .pc_i(f_pc_i),
        .instr_o(f_instr_o)
    );

    assign f_pc_o = f_pc_i;

endmodule