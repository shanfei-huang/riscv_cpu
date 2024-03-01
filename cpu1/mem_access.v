`include "define.v"
module mem_access(
    input           clk_i,
    input [63:0]    m_pc_i,
    output [63:0]   m_pc_o, 

    input [63:0]    m_alu_result_i,
    output [63:0]   m_alu_result_o,
    
    // mem
    input [2:0]     m_l_mux_i,
    input [2:0]     m_s_mux_i,
    input           m_mem_wen_i,
    input [63:0]    m_mem_wdata_temp_i,
    input [63:0]    m_mem_addr_i, 
    output [63:0]   m_mem_rdata_o,

    // reg
    input           m_reg_wen_i,
    input           m_reg_mux_i,
    input [4:0]     m_reg_waddr_i,
    output          m_reg_wen_o,
    output          m_reg_mux_o,
    output [4:0]    m_reg_waddr_o

);
    // 为了数据存储器接口的简单设计,读写都直接以8个字节为单位

    wire [63:0]     mem_rdata_temp;
    wire [63:0]     mem_wdata;

    assign mem_wdata = (m_s_mux_i == `sb) ? {mem_rdata_temp[63:8],m_mem_wdata_temp_i[7:0]} :
                       (m_s_mux_i == `sh) ? {mem_rdata_temp[63:16],m_mem_wdata_temp_i[15:0]} :
                       (m_s_mux_i == `sw) ? {mem_rdata_temp[63:32],m_mem_wdata_temp_i[31:0]} :
                       (m_s_mux_i == `sd) ? m_mem_wdata_temp_i : 64'b0;

    data_ram data_ram_inst(
        .clk_i(clk_i),
        .mem_addr_i(m_mem_addr_i),
        .mem_wdata_i(mem_wdata),
        .mem_wen_i(m_mem_wen_i),
        .mem_rdata_o(mem_rdata_temp)
    );

    assign m_mem_rdata_o = (m_l_mux_i == `lb) ? {{56{mem_rdata_temp[7]}},mem_rdata_temp[7:0]} :
                            (m_l_mux_i == `lh) ? {{48{mem_rdata_temp[15]}},mem_rdata_temp[15:0]} :
                            (m_l_mux_i == `lw) ? {{32{mem_rdata_temp[31]}},mem_rdata_temp[31:0]} :
                            (m_l_mux_i == `ld) ? mem_rdata_temp :
                            (m_l_mux_i == `lbu) ? {56'b0,mem_rdata_temp[7:0]} :
                            (m_l_mux_i == `lhu) ? {48'b0,mem_rdata_temp[15:0]} :
                            (m_l_mux_i == `lwu) ? {32'b0,mem_rdata_temp[31:0]} : 64'b0;

    assign m_pc_o = m_pc_i;
    assign m_alu_result_o = m_alu_result_i;
    assign m_reg_wen_o = m_reg_wen_i;
    assign m_reg_mux_o = m_reg_mux_i;
    assign m_reg_waddr_o = m_reg_waddr_i;

endmodule