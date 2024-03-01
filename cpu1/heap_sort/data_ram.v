module data_ram(
    input           clk_i,
    input [63:0]    mem_addr_i,
    input [63:0]    mem_wdata_i,
    input           mem_wen_i,
    output [63:0]   mem_rdata_o
);

    reg [7:0] data_mem[4999:0];

    initial begin
        // For data_data_memory:
        // 00000000000012e8 <elements>:
        data_mem[4808] = 'hff;
        data_mem[4809] = 'hff;
        data_mem[4810] = 'hff;
        data_mem[4811] = 'hff;
        data_mem[4812] = 'h32;
        data_mem[4813] = 'h00;
        data_mem[4814] = 'h00;
        data_mem[4815] = 'h00;
        data_mem[4816] = 'h0a;
        data_mem[4817] = 'h00;
        data_mem[4818] = 'h00;
        data_mem[4819] = 'h00;
        data_mem[4820] = 'h5a;
        data_mem[4821] = 'h00;
        data_mem[4822] = 'h00;
        data_mem[4823] = 'h00;
        data_mem[4824] = 'h1e;
        data_mem[4825] = 'h00;
        data_mem[4826] = 'h00;
        data_mem[4827] = 'h00;
        data_mem[4828] = 'hba;
        data_mem[4829] = 'hff;
        data_mem[4830] = 'hff;
        data_mem[4831] = 'hff;
        data_mem[4832] = 'h28;
        data_mem[4833] = 'h00;
        data_mem[4834] = 'h00;
        data_mem[4835] = 'h00;
        data_mem[4836] = 'h50;
        data_mem[4837] = 'h00;
        data_mem[4838] = 'h00;
        data_mem[4839] = 'h00;
        data_mem[4840] = 'h3c;
        data_mem[4841] = 'h00;
        data_mem[4842] = 'h00;
        data_mem[4843] = 'h00;
        data_mem[4844] = 'h14;
        data_mem[4845] = 'h00;
        data_mem[4846] = 'h00;
        data_mem[4847] = 'h00;
    end

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