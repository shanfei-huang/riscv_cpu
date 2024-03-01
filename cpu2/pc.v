module pc(
    input   clk_i,
    input   rst_n_i,
    input   [63:0] next_pc_i,
    output  [63:0] pc_o 
);
    reg [63:0] pc;
    always@(posedge clk_i,negedge rst_n_i)begin
        if(~rst_n_i)
            pc <= 64'b0;
        else
            pc <= next_pc_i;
    end

    assign pc_o = pc;
endmodule