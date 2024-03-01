> 暂时就先用5bit数来编码alu_op

|   编码    |   操作   |
| :-------: | :------: |
| 5'b0_0000 | alu_add  |
| 5'b0_0001 | alu_addw |
| 5'b0_0010 | alu_sub  |
| 5'b0_0011 | alu_subw |
| 5'b0_0100 |  alu_or  |
| 5'b0_0101 | alu_xor  |
| 5'b0_0110 | alu_and  |
| 5'b0_0111 | alu_slt  |
| 5'b0_1000 | alu_sltu |
| 5'b0_1001 | alu_sll  |
| 5'b0_1010 | alu_sllw |
| 5'b0_1011 | alu_srl  |
| 5'b0_1100 | alu_srlw |
| 5'b0_1101 | alu_sra  |
| 5'b0_1110 | alu_sraw |

>用2bit数来编码aludata1_mux

| 编码  |            操作数来源            |
| :---: | :------------------------------: |
| 2'b00 |     x0(加0操作:比如lui指令)      |
| 2'b01 | pc(主要用于auipc，jal，jalr指令) |
| 2'b10 |               rs1                |
| 2'b11 |      csr寄存器中读出的数据       |

> 用2bit数来编码aludata2_mux

| 编码  |           操作数来源           |
| :---: | :----------------------------: |
| 2'b00 |              rs2               |
| 2'b01 |              imm               |
| 2'b10 |    4(主要用于jal，jalr指令)    |
| 2'b11 | x0(加0操作，主要和csr指令配合) |
