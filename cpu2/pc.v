module pc(
    input   clk_i,
    input   rst_n_i,
    input   pc_stall_i, 
    input   [63:0] next_pc_i,
    output  [63:0] pc_o 
);
    reg [63:0] pc;
    wire [63:0] next_pc;
    assign next_pc = pc_stall_i ? pc_o : next_pc_i;

    always@(posedge clk_i,negedge rst_n_i)begin
        if(~rst_n_i)
            pc <= 64'b0;
        else
            pc <= next_pc;
    end

    assign pc_o = pc;
endmodule