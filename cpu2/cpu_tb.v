module cpu_tb();
    reg         clk;
    reg         rst_n;
    wire [63:0] pc_o;

    initial begin
        clk = 0;
        forever begin
            #(10/2.0) clk = ~clk;
        end
    end

    initial begin
        rst_n = 1'b1;
        #2
        rst_n = 1'b0;
        #1
        rst_n = 1'b1;
        #30000
        $finish();
    end

    cpu cpu_inst(
        .clk_i(clk),
        .rst_n_i(rst_n),
        .pc_o(pc_o)
    );
endmodule