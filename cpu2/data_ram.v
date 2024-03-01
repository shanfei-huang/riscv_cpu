module data_ram(
    input           clk_i,
    input [63:0]    mem_addr_i,
    input [63:0]    mem_wdata_i,
    input           mem_wen_i,
    output [63:0]   mem_rdata_o
);

    reg [7:0] data_mem[1023:0];

    always@(posedge clk_i)begin
        if(mem_wen_i)begin
            data_mem[mem_addr_i + 4'd0] <= mem_wdata_i[7:0];
            data_mem[mem_addr_i + 4'd1] <= mem_wdata_i[15:8];
            data_mem[mem_addr_i + 4'd2] <= mem_wdata_i[23:16];
            data_mem[mem_addr_i + 4'd3] <= mem_wdata_i[31:24];
            data_mem[mem_addr_i + 4'd4] <= mem_wdata_i[39:32];
            data_mem[mem_addr_i + 4'd5] <= mem_wdata_i[47:40];
            data_mem[mem_addr_i + 4'd6] <= mem_wdata_i[55:48];
            data_mem[mem_addr_i + 4'd7] <= mem_wdata_i[63:56];
        end
    end

    assign mem_rdata_o = {
                          data_mem[mem_addr_i + 7],
                          data_mem[mem_addr_i + 6],
                          data_mem[mem_addr_i + 5],
                          data_mem[mem_addr_i + 4],
                          data_mem[mem_addr_i + 3],
                          data_mem[mem_addr_i + 2],
                          data_mem[mem_addr_i + 1],
                          data_mem[mem_addr_i + 0]
                         };

endmodule