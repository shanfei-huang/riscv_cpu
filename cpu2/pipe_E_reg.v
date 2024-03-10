module pipe_E_reg(
    input               clk_i,
    input               rst_n_i,
    input               E_stall_i,
    input               E_bubble_i,
    input      [63:0]   E_pc_i,
    output reg [63:0]   E_pc_o,
    input      [63:0]   E_imm_i,
    output reg [63:0]   E_imm_o,
    input      [63:0]   E_reg_rdata1_i,
    output reg [63:0]   E_reg_rdata1_o,
    input      [63:0]   E_reg_rdata2_i,
    output reg [63:0]   E_reg_rdata2_o,
    input      [4:0]    E_reg_raddr1_i,
    output reg [4:0]    E_reg_raddr1_o,
    input      [4:0]    E_reg_raddr2_i,
    output reg [4:0]    E_reg_raddr2_o,
    input      [4:0]    E_reg_waddr_i,
    output reg [4:0]    E_reg_waddr_o,
    input               E_reg_mux_i,
    output reg          E_reg_mux_o,
    input               E_reg_wen_i,
    output reg          E_reg_wen_o,
    input      [2:0]    E_l_mux_i,
    output reg [2:0]    E_l_mux_o,
    input      [2:0]    E_s_mux_i,
    output reg [2:0]    E_s_mux_o,
    input      [4:0]    E_alu_op_i,
    output reg [4:0]    E_alu_op_o,             
    input      [1:0]    E_aludata1_mux_i,
    output reg [1:0]    E_aludata1_mux_o,
    input      [1:0]    E_aludata2_mux_i,
    output reg [1:0]    E_aludata2_mux_o,
    input               E_mem_wen_i,
    output reg          E_mem_wen_o,
    input      [63:0]   E_mem_wdata_temp_i,
    output reg [63:0]   E_mem_wdata_temp_o
);
    
    wire [63:0] E_pc_next;
    wire [63:0] E_imm_next;
    wire [63:0] E_reg_rdata1_next;
    wire [63:0] E_reg_rdata2_next;
    wire [4:0]  E_reg_waddr_next;
    wire [4:0]  E_reg_raddr1_next;
    wire [4:0]  E_reg_raddr2_next;
    wire        E_reg_mux_next; 
    wire        E_reg_wen_next; 
    wire [2:0]  E_l_mux_next; 
    wire [2:0]  E_s_mux_next;
    wire [4:0]  E_alu_op_next;
    wire [1:0]  E_aludata1_mux_next;
    wire [1:0]  E_aludata2_mux_next;
    wire        E_mem_wen_next;
    wire [63:0] E_mem_wdata_temp_next;

    assign E_pc_next = (E_stall_i) ? E_pc_o :
                       (E_bubble_i) ? E_pc_o :
                       E_pc_i;

    assign E_imm_next = (E_stall_i) ? E_imm_o :
                        (E_bubble_i) ? 64'b0 :
                        E_imm_i;
    
    assign E_reg_rdata1_next = (E_stall_i) ? E_reg_rdata1_o :
                               (E_bubble_i) ? 64'b0 :
                               E_reg_rdata1_i;
    
    assign E_reg_rdata2_next = (E_stall_i) ? E_reg_rdata2_o :
                               (E_bubble_i) ? 64'b0 :
                               E_reg_rdata2_i;
    
    assign E_reg_raddr1_next = (E_stall_i) ? E_reg_raddr1_o :
                               (E_bubble_i) ? 5'b0 :
                               E_reg_raddr1_i;
    
    assign E_reg_raddr2_next = (E_stall_i) ? E_reg_raddr2_o :
                               (E_bubble_i) ? 5'b0 :
                               E_reg_raddr2_i;

    assign E_reg_waddr_next = (E_stall_i) ? E_reg_waddr_o :
                              (E_bubble_i) ? 5'b0 :
                              E_reg_waddr_i;
    
    assign E_reg_mux_next = (E_stall_i) ? E_reg_mux_o :
                            (E_bubble_i) ? 1'b0 :
                            E_reg_mux_i;
    
    assign E_reg_wen_next = (E_stall_i) ? E_reg_wen_o :
                            (E_bubble_i) ? 1'b0 :
                            E_reg_wen_i;
    
    assign E_l_mux_next = (E_stall_i) ? E_l_mux_o :
                          (E_bubble_i) ? 3'b0 :
                          E_l_mux_i;

    assign E_s_mux_next = (E_stall_i) ? E_s_mux_o :
                          (E_bubble_i) ? 3'b0 :
                          E_s_mux_i;
    
    assign E_alu_op_next = (E_stall_i) ? E_alu_op_o :
                           (E_bubble_i) ? 5'b0 : 
                           E_alu_op_i;
    
    assign E_aludata1_mux_next = (E_stall_i) ? E_aludata1_mux_o :
                                 (E_bubble_i) ? 2'b00 :
                                 E_aludata1_mux_i;
    
    assign E_aludata2_mux_next = (E_stall_i) ? E_aludata2_mux_o :
                                 (E_bubble_i) ? 2'b01 :
                                 E_aludata2_mux_i;
    
    assign E_mem_wen_next = (E_stall_i) ? E_mem_wen_o :
                            (E_bubble_i) ? 1'b0 :
                            E_mem_wen_i;

    assign E_mem_wdata_temp_next = (E_stall_i) ? E_mem_wdata_temp_o :
                                   (E_bubble_i) ? 64'b0 :
                                   E_mem_wdata_temp_i;
    
    always@(posedge clk_i or negedge rst_n_i)begin
        if(~rst_n_i)begin
            E_pc_o <= 64'b0;
            E_imm_o <= 64'b0;
            E_reg_rdata1_o <= 64'b0;
            E_reg_rdata2_o <= 64'b0;
            E_reg_raddr1_o <= 5'b0;
            E_reg_raddr2_o <= 5'b0;
            E_reg_waddr_o <= 5'b0;
            E_reg_mux_o <= 1'b0;
            E_reg_wen_o <= 1'b0;
            E_l_mux_o <= 3'b0;
            E_s_mux_o <= 3'b0;
            E_alu_op_o <= 5'b0;
            E_aludata1_mux_o <= 2'b00;
            E_aludata2_mux_o <= 2'b01;
            E_mem_wen_o <= 1'b0;
            E_mem_wdata_temp_o <= 64'b0;
        end
        else begin
            E_pc_o <= E_pc_next;
            E_imm_o <= E_imm_next;
            E_reg_rdata1_o <= E_reg_rdata1_next;
            E_reg_rdata2_o <= E_reg_rdata2_next;
            E_reg_raddr1_o <= E_reg_raddr1_next;
            E_reg_raddr2_o <= E_reg_raddr2_next;
            E_reg_waddr_o <= E_reg_waddr_next;
            E_reg_mux_o <= E_reg_mux_next;
            E_reg_wen_o <= E_reg_wen_next;
            E_l_mux_o <= E_l_mux_next;
            E_s_mux_o <= E_s_mux_next;
            E_alu_op_o <= E_alu_op_next;
            E_aludata1_mux_o <= E_aludata1_mux_next;
            E_aludata2_mux_o <= E_aludata2_mux_next;
            E_mem_wen_o <= E_mem_wen_next;
            E_mem_wdata_temp_o <= E_mem_wdata_temp_next;
        end
    end

endmodule