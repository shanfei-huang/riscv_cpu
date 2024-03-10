`include "define.v"
module decode(
    input [31:0]    d_instr_i,
    input [63:0]    d_pc_i,
    output [63:0]   d_pc_o,
    // to regs
    output [4:0]    d_reg_raddr1_o,
    output [4:0]    d_reg_raddr2_o,
    output [4:0]    d_reg_waddr_o,
    // from regs
    input [63:0]    d_reg_rdata1_i,
    input [63:0]    d_reg_rdata2_i,
    // to exe
    output [63:0]   d_imm_o,
    output [63:0]   d_reg_rdata1_o,
    output [63:0]   d_reg_rdata2_o,
    // branch
    input  [63:0]   d_branch_opdata1_i,
    input  [63:0]   d_branch_opdata2_i,
    output          d_branch_o,
    output          d_branch_type_o,
    output          d_store_type_o,
    output [63:0]   d_pc_b_o, 
    input  [63:0]   d_jump_opdata1_i,
    output          d_jump_jal_o,
    output [63:0]   d_pc_jal_o,
    output          d_jump_jalr_o,
    output [63:0]   d_pc_jalr_o,
    // to pipe_control
    output          d_alu_data1_rs1_o,
    output          d_alu_data2_rs2_o,

    // control
    output [2:0]    d_l_mux_o,
    output [2:0]    d_s_mux_o,
    // d_reg_mux_o为高的时候,表明写入寄存器的数据来自存储器
    output          d_reg_mux_o,  
    // d_alu_op_o决定alu进行何种操作 
    output [4:0]    d_alu_op_o,
    // d_aludata1_mux_o,d_alu_data2_mux_o为alu提供操作数选择 
    output [1:0]    d_aludata1_mux_o,
    output [1:0]    d_aludata2_mux_o,
    // d_w_mem_o是否写存储器 
    output          d_mem_wen_o,
    input  [63:0]   d_mem_wdata_temp_i,
    output [63:0]   d_mem_wdata_temp_o,
    // d_w_reg_o是否写寄存器
    output          d_reg_wen_o
);

    assign d_mem_wdata_temp_o = d_mem_wdata_temp_i;

    wire [6:0] opcode;
    wire [4:0] rd;
    wire [2:0] fun3;
    wire [4:0] rs1;
    wire [4:0] zimm;
    wire [4:0] rs2;
    wire [6:0] fun7;
    wire [11:0] fun12;
    wire [11:0] csr;
    assign opcode = d_instr_i[6:0];
    assign rd = d_instr_i[11:7];
    assign fun3 = d_instr_i[14:12];
    assign rs1 = d_instr_i[19:15];
    assign zimm = d_instr_i[19:15];
    assign rs2 = d_instr_i[24:20];
    assign fun7 = d_instr_i[31:25];
    assign fun12 = d_instr_i[31:20];
    assign csr = d_instr_i[31:20];

    wire inst_lui;
    assign inst_lui = (opcode == `lui);
    wire inst_auipc;
    assign inst_auipc = (opcode == `auipc);
    wire inst_jal;
    assign inst_jal = (opcode == `jal);
    wire inst_jalr;
    assign inst_jalr = (opcode == `jalr);
    wire inst_beq;
    assign inst_beq = (opcode == `b_type) && (fun3 == `beq);
    wire inst_bne;
    assign inst_bne = (opcode == `b_type) && (fun3 == `bne);
    wire inst_blt;
    assign inst_blt = (opcode == `b_type) && (fun3 == `blt);
    wire inst_bge;
    assign inst_bge = (opcode == `b_type) && (fun3 == `bge);
    wire inst_bltu;
    assign inst_bltu = (opcode == `b_type) && (fun3 == `bltu);
    wire inst_bgeu;
    assign inst_bgeu = (opcode == `b_type) && (fun3 == `bgeu);
    wire inst_lb;
    assign inst_lb = (opcode == `l_type) && (fun3 == `lb);
    wire inst_lh;
    assign inst_lh = (opcode == `l_type) && (fun3 == `lh);
    wire inst_lw;
    assign inst_lw = (opcode == `l_type) && (fun3 == `lw);
    wire inst_ld;
    assign inst_ld = (opcode == `l_type) && (fun3 == `ld);
    wire inst_lbu;
    assign inst_lbu = (opcode == `l_type) && (fun3 == `lbu);
    wire inst_lhu;
    assign inst_lhu = (opcode == `l_type) && (fun3 == `lhu);
    wire inst_lwu;
    assign inst_lwu = (opcode == `l_type) && (fun3 == `lwu);
    wire inst_sb;
    assign inst_sb = (opcode == `s_type) && (fun3 == `sb);
    wire inst_sh;
    assign inst_sh = (opcode == `s_type) && (fun3 == `sh);
    wire inst_sw;
    assign inst_sw = (opcode == `s_type) && (fun3 == `sw);
    wire inst_sd;
    assign inst_sd = (opcode == `s_type) && (fun3 == `sd);
    wire inst_addi;
    assign inst_addi = (opcode == `reg_imm) && (fun3 == `add_sub);
    wire inst_slti;
    assign inst_slti = (opcode == `reg_imm) && (fun3 == `slt);
    wire inst_sltiu;
    assign inst_sltiu = (opcode == `reg_imm) && (fun3 == `sltu);
    wire inst_xori;
    assign inst_xori = (opcode == `reg_imm) && (fun3 == `xor);
    wire inst_ori;
    assign inst_ori = (opcode == `reg_imm) && (fun3 == `or);
    wire inst_andi;
    assign inst_andi = (opcode == `reg_imm) && (fun3 == `and);
    wire inst_slli;
    assign inst_slli = (opcode == `reg_imm) && (fun3 == `sl);
    wire inst_srli;
    assign inst_srli = (opcode == `reg_imm) && (fun3 == `sr) && (fun12[11:6] == 6'b00_0000);
    wire inst_srai;
    assign inst_srai = (opcode == `reg_imm) && (fun3 == `sr) && (fun12[11:6] == 6'b01_0000);
    wire inst_addiw;
    assign inst_addiw = (opcode == `w_reg_imm) && (fun3 == `add_sub);
    wire inst_slliw;
    assign inst_slliw = (opcode == `w_reg_imm) && (fun3 == `sl);
    wire inst_srliw;
    assign inst_srliw = (opcode == `w_reg_imm) && (fun3 == `sr) && (fun7 == `srl);
    wire inst_sraiw;
    assign inst_sraiw = (opcode == `w_reg_imm) && (fun3 == `sr) && (fun7 == `sra);
    wire inst_add;
    assign inst_add = (opcode == `reg_reg) && (fun3 == `add_sub) && (fun7 == `add);
    wire inst_sub;
    assign inst_sub = (opcode == `reg_reg) && (fun3 == `add_sub) && (fun7 == `sub);
    wire inst_sll;
    assign inst_sll = (opcode == `reg_reg) && (fun3 == `sl);
    wire inst_slt;
    assign inst_slt = (opcode == `reg_reg) && (fun3 == `slt);
    wire inst_sltu;
    assign inst_sltu = (opcode == `reg_reg) && (fun3 == `sltu);
    wire inst_xor;
    assign inst_xor = (opcode == `reg_reg) && (fun3 == `xor);
    wire inst_srl;
    assign inst_srl = (opcode == `reg_reg) && (fun3 == `sr) && (fun7 == `srl);
    wire inst_sra;
    assign inst_sra = (opcode == `reg_reg) && (fun3 == `sr) && (fun7 == `sra);
    wire inst_or;
    assign inst_or = (opcode == `reg_reg) && (fun3 == `or);
    wire inst_and;
    assign inst_and = (opcode == `reg_reg) && (fun3 == `and);
    wire inst_addw;
    assign inst_addw = (opcode == `w_reg_reg) && (fun3 == `add_sub) && (fun7 == `add);
    wire inst_subw;
    assign inst_subw = (opcode == `w_reg_reg) && (fun3 == `add_sub) && (fun7 == `sub);
    wire inst_sllw;
    assign inst_sllw = (opcode == `w_reg_reg) && (fun3 == `sl);
    wire inst_srlw;
    assign inst_srlw = (opcode == `w_reg_reg) && (fun3 == `sr) && (fun7 == `srl);
    wire inst_sraw;
    assign inst_sraw = (opcode == `w_reg_reg) && (fun3 == `sr) && (fun7 == `sra);
    wire inst_fence;
    assign inst_fence = (opcode == `fence_type) && (fun3 == `fence);
    wire inst_fence_i;
    assign inst_fence_i = (opcode == `fence_type) && (fun3 == `fence_i);
    wire inst_ecall;
    assign inst_ecall = (opcode == `e_type) && (fun3 == `ecall_ebreak) && (fun12 == `ecall);
    wire inst_ebreak;
    assign inst_ebreak = (opcode == `e_type) && (fun3 == `ecall_ebreak) && (fun12 == `ebreak);
    wire inst_csrrw;
    assign inst_csrrw = (opcode == `e_type) && (fun3 == `csrrw);
    wire inst_csrrs;
    assign inst_csrrs = (opcode == `e_type) && (fun3 == `csrrs);
    wire inst_csrrc;
    assign inst_csrrc = (opcode == `e_type) && (fun3 == `csrrc);
    wire inst_csrrwi;
    assign inst_csrrwi = (opcode == `e_type) && (fun3 == `csrrwi);
    wire inst_csrrsi;
    assign inst_csrrsi = (opcode == `e_type) && (fun3 == `csrrsi);
    wire inst_csrrci;
    assign inst_csrrci = (opcode == `e_type) && (fun3 == `csrrci);
    
    assign d_pc_o = d_pc_i;
    assign d_reg_raddr1_o = rs1;
    assign d_reg_raddr2_o = rs2;
    assign d_reg_waddr_o = rd;

    assign d_l_mux_o = fun3;
    assign d_s_mux_o = fun3;
    assign d_mem_wen_o = inst_sb | inst_sh | inst_sw | inst_sd;
    assign d_reg_wen_o = inst_lui | inst_auipc | inst_addi | inst_slti | inst_sltiu | inst_xori | inst_ori | inst_andi | inst_slli |
                          inst_srli | inst_srai | inst_add | inst_sub | inst_sll | inst_slt | inst_sltu | inst_xor | inst_srl | 
                          inst_sra | inst_or | inst_and | inst_lb | inst_lh | inst_lw | inst_ld | inst_lbu | inst_lhu | inst_lwu |
                          inst_jal | inst_jalr | inst_addiw | inst_slliw | inst_srliw | inst_sraiw | inst_addw | inst_subw | inst_sllw |
                          inst_srlw | inst_sraw;
    
    assign d_reg_mux_o = inst_lb | inst_lbu | inst_lh | inst_lhu | inst_lw | inst_lwu | inst_ld;

    wire alu_data1_x0;
    assign alu_data1_x0 = inst_lui;
    wire alu_data1_pc;
    assign alu_data1_pc = inst_auipc | inst_jal | inst_jalr;
    wire alu_data1_rs1;
    assign alu_data1_rs1 = (opcode == `l_type) || (opcode == `s_type) || (opcode == `reg_imm) || (opcode == `reg_reg) ||
                           (opcode == `w_reg_reg) || (opcode == `w_reg_imm);
    
    assign d_alu_data1_rs1_o = alu_data1_rs1;
    // 保留一下csr寄存器的接口
    wire alu_data1_csr;
    assign alu_data1_csr = inst_csrrc | inst_csrrci | inst_csrrs | inst_csrrsi | inst_csrrw | inst_csrrwi;
    assign d_aludata1_mux_o = alu_data1_x0 ? 2'b00 :
                              alu_data1_pc ? 2'b01 :
                              alu_data1_rs1 ? 2'b10 :
                              alu_data1_csr ? 2'b11 : 2'b00;

    wire alu_data2_rs2;
    assign alu_data2_rs2 = (opcode == `reg_reg) || (opcode == `w_reg_reg);

    assign d_alu_data2_rs2_o = alu_data2_rs2;
    
    wire alu_data2_imm;
    assign alu_data2_imm = inst_lui || inst_auipc || (opcode == `l_type) || (opcode == `s_type) || (opcode == `reg_imm) || 
                            (opcode == `w_reg_imm);
    wire alu_data2_4;
    assign alu_data2_4 = inst_jal | inst_jalr;
    wire alu_data2_x0;
    assign alu_data2_x0 = inst_csrrc | inst_csrrci | inst_csrrs | inst_csrrsi | inst_csrrw | inst_csrrwi;
    assign d_aludata2_mux_o = alu_data2_rs2 ? 2'b00 :
                              alu_data2_imm ? 2'b01 :
                              alu_data2_4 ? 2'b10   :
                              alu_data2_x0 ? 2'b11  :  2'b00;
    
    wire alu_add;
    wire alu_addw;
    wire alu_sub;
    wire alu_subw;
    wire alu_or;
    wire alu_xor;
    wire alu_and;
    wire alu_slt;
    wire alu_sltu;
    wire alu_sll;
    wire alu_sllw;
    wire alu_srl;
    wire alu_srlw;
    wire alu_sra;
    wire alu_sraw;

    assign alu_add = inst_lui | inst_auipc | inst_jal | inst_jalr | inst_lb | inst_lh | inst_lw | inst_ld | inst_lbu | inst_lhu |
                     inst_lwu | inst_sb | inst_sh | inst_sw | inst_sd | inst_addi | inst_add;
    assign alu_addw = inst_addiw | inst_addw;
    assign alu_sub = inst_sub ;
    assign alu_subw = inst_subw;
    assign alu_or = inst_ori | inst_or;
    assign alu_xor = inst_xori | inst_xor;
    assign alu_and = inst_andi | inst_and;
    assign alu_slt = inst_slti | inst_slt;
    assign alu_sltu = inst_sltiu | inst_sltu;
    assign alu_sll = inst_sll | inst_slli;
    assign alu_sllw = inst_sllw | inst_slliw;
    assign alu_srl = inst_srl | inst_srli;
    assign alu_srlw = inst_srlw | inst_srliw;
    assign alu_sra = inst_sra | inst_srai;
    assign alu_sraw = inst_sraw | inst_sraiw;

    wire [4:0] alu_op;
    assign alu_op = alu_add     ?   5'b0_0000 : 
                    alu_addw    ?   5'b0_0001 :
                    alu_sub     ?   5'b0_0010 :
                    alu_subw    ?   5'b0_0011 :
                    alu_or      ?   5'b0_0100 :
                    alu_xor     ?   5'b0_0101 :
                    alu_and     ?   5'b0_0110 :
                    alu_slt     ?   5'b0_0111 :
                    alu_sltu    ?   5'b0_1000 :
                    alu_sll     ?   5'b0_1001 :
                    alu_sllw    ?   5'b0_1010 :
                    alu_srl     ?   5'b0_1011 :
                    alu_srlw    ?   5'b0_1100 :
                    alu_sra     ?   5'b0_1101 :
                    alu_sraw    ?   5'b0_1110 : 5'b0_0000;
    
    assign d_alu_op_o = alu_op;
    
    wire inst_u;
    wire [63:0] imm_u;
    wire inst_b;
    wire [63:0] imm_b;
    wire inst_s;
    wire [63:0] imm_s;
    wire inst_l;
    wire [63:0] imm_l;
    wire [63:0] imm_jal;
    wire [63:0] imm_jalr;
    assign inst_u = inst_lui | inst_auipc;
    assign imm_u = {{32{d_instr_i[31]}},d_instr_i[31:12],12'b0};
    assign inst_b = (opcode == `b_type);
    assign imm_b = {{51{d_instr_i[31]}},d_instr_i[31],d_instr_i[7],d_instr_i[30:25],d_instr_i[11:8],1'b0};
    assign inst_s = (opcode == `s_type);
    assign imm_s = {{52{d_instr_i[31]}},d_instr_i[31:25],d_instr_i[11:7]};
    assign inst_l = (opcode == `l_type) || (opcode == `reg_imm) || (opcode == `w_reg_imm);
    assign imm_l = {{52{d_instr_i[31]}},d_instr_i[31:20]};
    assign imm_jal = {{43{d_instr_i[31]}},d_instr_i[31],d_instr_i[19:12],d_instr_i[20],d_instr_i[30:21],1'b0};
    assign imm_jalr = {{52{d_instr_i[31]}},d_instr_i[31:20]};
    assign d_imm_o = inst_u ? imm_u :
                     inst_b ? imm_b :
                     inst_s ? imm_s :
                     inst_l ? imm_l :
                     inst_jal ? imm_jal :
                     inst_jalr ? imm_jalr : 64'b0; 
 
    assign d_reg_rdata1_o = d_reg_rdata1_i;
    assign d_reg_rdata2_o = d_reg_rdata2_i;

    wire [63:0] pc_b;
    assign pc_b = d_pc_i + imm_b;
    wire [63:0] pc_jal;
    assign pc_jal = d_pc_i + imm_jal;
    wire [63:0] pc_jalr;
    assign pc_jalr = (d_jump_opdata1_i + imm_jalr) & 64'hffff_ffff_ffff_fffe;

    wire branch_beq;
    wire branch_bne;
    wire branch_blt;
    wire branch_bge;
    wire branch_bltu;
    wire branch_bgeu;
    wire [63:0] branch_op1;
    wire [63:0] branch_op2;
    assign branch_op1 = d_branch_opdata1_i;
    assign branch_op2 = (~d_branch_opdata2_i) + 1'b1;
    wire [63:0] branch_result;
    wire        branch_cin;
    wire        branch_zero;
    wire        branch_of;
    wire        branch_sf;
    assign {branch_cin,branch_result} = branch_op1 + branch_op2;
    assign branch_zero = (branch_result == 64'b0);
    assign branch_sf = branch_result[63];
    assign branch_of = (branch_op1[63] == branch_op2[63]) && (branch_op1[63] != branch_result[63]);
    assign branch_beq = inst_beq && branch_zero;
    assign branch_bne = inst_bne && (~branch_zero);
    assign branch_blt = inst_blt && (branch_of ^ branch_sf);
    assign branch_bge = inst_bge && (~(branch_of ^ branch_sf));
    assign branch_bltu = inst_bltu && (branch_cin == 1'b0);
    assign branch_bgeu = inst_bgeu && ((branch_cin == 1'b1) || branch_zero);
    assign branch = branch_beq | branch_bne | branch_blt | branch_bge | branch_bltu | branch_bgeu;
    assign d_branch_o = branch;
    wire   branch_type;
    assign branch_type = inst_beq | inst_bne | inst_blt | inst_bge | inst_bltu | inst_bgeu;
    assign d_branch_type_o = branch_type;
    assign d_pc_b_o = pc_b;
    assign d_jump_jal_o = inst_jal;
    assign d_pc_jal_o = pc_jal;
    assign d_jump_jalr_o = inst_jalr;
    assign d_pc_jalr_o = pc_jalr;    
    assign d_store_type_o = inst_sb | inst_sh | inst_sw | inst_sd;
    
endmodule