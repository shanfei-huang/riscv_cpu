module regs(
    input clk_i,
    input [4:0] reg_raddr1_i,
    input [4:0] reg_raddr2_i,
    input       reg_wen_i,
    input [4:0] reg_waddr_i,
    input [63:0] reg_wdata_i,
    output [63:0] reg_rdata1_o,
    output [63:0] reg_rdata2_o
);

    reg [63:0] regs[31:0];

    assign reg_rdata1_o = (reg_raddr1_i == 5'b0) ? 64'b0 : regs[reg_raddr1_i];
    assign reg_rdata2_o = (reg_raddr2_i == 5'b0) ? 64'b0 : regs[reg_raddr2_i];

    always@(posedge clk_i)begin
        if(reg_wen_i && (reg_waddr_i != 5'b0))
            regs[reg_waddr_i] <= reg_wdata_i;
    end

endmodule