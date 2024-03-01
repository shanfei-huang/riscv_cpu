// opcode
`define lui         7'b0110111
`define auipc       7'b0010111
`define jal         7'b1101111
`define jalr        7'b1100111
`define b_type      7'b1100011
`define l_type      7'b0000011
`define s_type      7'b0100011
`define reg_imm     7'b0010011
`define reg_reg     7'b0110011
`define w_reg_imm   7'b0011011
`define w_reg_reg   7'b0111011
`define fence_type  7'b0001111
`define e_type      7'b1110011

// op_type
`define add_sub     3'b000
`define sl          3'b001
`define slt         3'b010
`define sltu        3'b011
`define xor         3'b100
`define sr          3'b101
`define or          3'b110
`define and         3'b111

// add_sub
`define add         7'b0000000
`define sub         7'b0100000

// sr
`define srl         7'b0000000
`define sra         7'b0100000

// b_type
`define beq         3'b000
`define bne         3'b001
`define blt         3'b100
`define bge         3'b101
`define bltu        3'b110
`define bgeu        3'b111

// l_type
`define lb          3'b000
`define lh          3'b001
`define lw          3'b010
`define ld          3'b011
`define lbu         3'b100
`define lhu         3'b101
`define lwu         3'b110

// s_type
`define sb          3'b000
`define sh          3'b001
`define sw          3'b010
`define sd          3'b011 

// fence_type
`define fence       3'b000
`define fence_i     3'b001

// e_type
`define ecall_ebreak 3'b000
`define csrrw       3'b011
`define csrrs       3'b010
`define csrrc       3'b011
`define csrrwi      3'b101
`define csrrsi      3'b110
`define csrrci      3'b111

// ecall_ebreak
`define ecall       12'b000000000000
`define ebreak      12'b000000000001
 
 // alu_op
 `define alu_add    5'b0_0000
 `define alu_addw   5'b0_0001
 `define alu_sub    5'b0_0010  
 `define alu_subw   5'b0_0011
 `define alu_or     5'b0_0100
 `define alu_xor    5'b0_0101
 `define alu_and    5'b0_0110
 `define alu_slt    5'b0_0111
 `define alu_sltu   5'b0_1000
 `define alu_sll    5'b0_1001
 `define alu_sllw   5'b0_1010
 `define alu_srl    5'b0_1011
 `define alu_srlw   5'b0_1100
 `define alu_sra    5'b0_1101
 `define alu_sraw   5'b0_1110 