module pipe_M_reg(
    input               clk_i,
    input               rst_n_i,
    input               M_stall_i,
    input               M_bubble_i,
    input      [63:0]   M_pc_i, 
    output reg [63:0]   M_pc_o,
    input      [63:0]   M_alu_result_i,
    output reg [63:0]   M_alu_result_o,
    input               M_reg_wen_i,
    output reg          M_reg_wen_o,
    input               M_reg_mux_i,
    output reg          M_reg_mux_o,
    input      [4:0]    M_reg_waddr_i,
    output reg [4:0]    M_reg_waddr_o, 
    input               M_mem_wen_i,
    output reg          M_mem_wen_o,
    input      [63:0]   M_mem_wdata_temp_i,
    output reg [63:0]   M_mem_wdata_temp_o,
    input      [63:0]   M_mem_addr_i,
    output reg [63:0]   M_mem_addr_o,
    input      [2:0]    M_l_mux_i,
    output reg [2:0]    M_l_mux_o,
    input      [2:0]    M_s_mux_i,
    output reg [2:0]    M_s_mux_o
);

    wire [63:0] M_pc_next;
    wire [63:0] M_alu_result_next;
    wire        M_reg_wen_next;
    wire        M_reg_mux_next;
    wire [4:0]  M_reg_waddr_next;
    wire        M_mem_wen_next;
    wire [63:0] M_mem_wdata_temp_next;
    wire [63:0] M_mem_addr_next;
    wire [2:0]  M_l_mux_next;
    wire [2:0]  M_s_mux_next;         

    assign M_pc_next = (M_stall_i) ? M_pc_o :
                       (M_bubble_i) ? M_pc_o :
                        M_pc_i;
    
    assign M_alu_result_next = (M_stall_i) ? M_alu_result_o :
                               (M_bubble_i) ? 64'b0 :
                               M_alu_result_i;
    
    assign M_reg_wen_next = (M_stall_i) ? M_reg_wen_o :
                            (M_bubble_i) ? 1'b0 :
                            M_reg_wen_i;
    
    assign M_reg_mux_next = (M_stall_i) ? M_reg_mux_o :
                            (M_bubble_i) ? 1'b0 :
                            M_reg_mux_i;
    
    assign M_reg_waddr_next = (M_stall_i) ? M_reg_waddr_o :
                              (M_bubble_i) ? 5'b0 :
                              M_reg_waddr_i;
    
    assign M_mem_wen_next = (M_stall_i) ? M_mem_wen_o :
                            (M_bubble_i) ? 1'b0 :
                            M_mem_wen_i;
    
    assign M_mem_wdata_temp_next = (M_stall_i) ? M_mem_wdata_temp_o :
                                   (M_bubble_i) ? 64'b0 :
                                   M_mem_wdata_temp_i;
    
    assign M_mem_addr_next = (M_stall_i) ? M_mem_addr_o :
                             (M_bubble_i) ? 64'b0 :
                             M_mem_addr_i;
    
    assign M_l_mux_next = (M_stall_i) ? M_l_mux_o :
                          (M_bubble_i) ? 3'b0 :
                          M_l_mux_i;
    
    assign M_s_mux_next = (M_stall_i) ? M_s_mux_o :
                          (M_bubble_i) ? 3'b0 :
                          M_s_mux_i;

    always@(posedge clk_i or negedge rst_n_i)begin
        if(~rst_n_i)begin
            M_pc_o <= 64'b0;             
            M_alu_result_o <= 64'b0;
            M_reg_wen_o <= 1'b0;
            M_reg_mux_o <= 1'b0;
            M_reg_waddr_o <= 5'b0;
            M_mem_wen_o <= 1'b0;
            M_mem_wdata_temp_o <= 64'b0;
            M_mem_addr_o <= 64'b0;
            M_l_mux_o <= 3'b0;
            M_s_mux_o <= 3'b0;         
        end
        else begin
            M_pc_o <= M_pc_next;             
            M_alu_result_o <= M_alu_result_next;
            M_reg_wen_o <= M_reg_wen_next;
            M_reg_mux_o <= M_reg_mux_next;
            M_reg_waddr_o <= M_reg_waddr_next;
            M_mem_wen_o <= M_mem_wen_next;
            M_mem_wdata_temp_o <= M_mem_wdata_temp_next;
            M_mem_addr_o <= M_mem_addr_next;
            M_l_mux_o <= M_l_mux_next;
            M_s_mux_o <= M_s_mux_next;         
        end
    end

endmodule