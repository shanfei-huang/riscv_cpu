module pipe_D_reg(
    input              clk_i,
    input              rst_n_i,
    input              D_bubble_i,
    input              D_stall_i,
    input      [63:0]  D_pc_i,
    output reg [63:0]  D_pc_o,
    input      [31:0]  D_instr_i,
    output reg [31:0]  D_instr_o
);
    wire [63:0] D_pc_next;
    wire [31:0] D_instr_next;

    assign D_pc_next = (D_stall_i) ? D_pc_o :
                       (D_bubble_i) ? D_pc_o :
                       D_pc_i;

    assign D_instr_next = (D_stall_i) ? D_instr_o :
                          (D_bubble_i) ? 32'h00000013 :
                          D_instr_i;

    always@(posedge clk_i or negedge rst_n_i)begin
        if(~rst_n_i)begin
            D_pc_o <= 64'b0;
            D_instr_o <= 32'h00000013;
        end
        else begin
            D_pc_o <= D_pc_next;
            D_instr_o <= D_instr_next;
        end
    end

endmodule