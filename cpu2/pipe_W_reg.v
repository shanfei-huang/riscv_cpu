module pipe_W_reg(
    input               clk_i,
    input               rst_n_i,
    input               W_bubble_i,
    input               W_stall_i,
    input      [63:0]   W_pc_i,         
    output reg [63:0]   W_pc_o,
    input      [63:0]   W_alu_result_i,
    output reg [63:0]   W_alu_result_o,
    input      [63:0]   W_mem_rdata_i,
    output reg [63:0]   W_mem_rdata_o,
    input               W_reg_wen_i,
    output reg          W_reg_wen_o,
    input               W_reg_mux_i,
    output reg          W_reg_mux_o,
    input      [4:0]    W_reg_waddr_i,
    output reg [4:0]    W_reg_waddr_o 
);

    wire [63:0] W_pc_next;
    wire [63:0] W_alu_result_next;
    wire [63:0] W_mem_rdata_next;
    wire        W_reg_wen_next;
    wire        W_reg_mux_next;
    wire [4:0]  W_reg_waddr_next;    

    assign W_pc_next = (W_stall_i) ? W_pc_o :
                       (W_bubble_i) ? W_pc_o :
                       W_pc_i;
    
    assign W_alu_result_next = (W_stall_i) ? W_alu_result_o :
                               (W_bubble_i) ? 64'b0 :
                               W_alu_result_i;
    
    assign W_mem_rdata_next = (W_stall_i) ? W_mem_rdata_o :
                              (W_bubble_i) ? 64'b0 :
                               W_mem_rdata_i;
    
    assign W_reg_wen_next = (W_stall_i) ? W_reg_wen_o :
                            (W_bubble_i) ? 1'b0 :
                            W_reg_wen_i;
    
    assign W_reg_mux_next = (W_stall_i) ? W_reg_mux_o :
                            (W_bubble_i) ? 1'b0 :
                            W_reg_mux_i;
    
    assign W_reg_waddr_next = (W_stall_i) ? W_reg_waddr_o :
                              (W_bubble_i) ? 5'b0 :
                              W_reg_waddr_i;

    always@(posedge clk_i or negedge rst_n_i)begin
        if(~rst_n_i)begin
            W_pc_o <= 64'b0;
            W_alu_result_o <= 64'b0;
            W_mem_rdata_o <= 64'b0;
            W_reg_wen_o <= 1'b0;
            W_reg_mux_o <= 1'b0;
            W_reg_waddr_o <= 5'b0;            
        end
        else begin
            W_pc_o <= W_pc_next;
            W_alu_result_o <= W_alu_result_next;
            W_mem_rdata_o <= W_mem_rdata_next;
            W_reg_wen_o <= W_reg_wen_next;
            W_reg_mux_o <= W_reg_mux_next;
            W_reg_waddr_o <= W_reg_waddr_next;
        end
    end
endmodule