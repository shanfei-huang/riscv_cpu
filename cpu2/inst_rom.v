module inst_rom(
    input [63:0] pc_i,
    output [31:0] instr_o
);

    reg[7:0] instr_mem[1023:0];

    initial begin
        // addi t0,zero,1
        instr_mem[0] = 8'h93;
        instr_mem[1] = 8'h02;
        instr_mem[2] = 8'h10;
        instr_mem[3] = 8'h00;
        // addi t1,zero,111
        instr_mem[4] = 8'h13;
        instr_mem[5] = 8'h03;
        instr_mem[6] = 8'hf0;
        instr_mem[7] = 8'h06;
        // add t2,t0,t1
        instr_mem[8] = 8'hb3;
        instr_mem[9] = 8'h83;
        instr_mem[10] = 8'h62;
        instr_mem[11] = 8'h00;
        
        // li t3,4097
        // lui x28,1
        instr_mem[12] = 8'h37;
        instr_mem[13] = 8'h1e;
        instr_mem[14] = 8'h00;
        instr_mem[15] = 8'h00;
        // addi x28,x28,1
        instr_mem[16] = 8'h13;
        instr_mem[17] = 8'h0e;
        instr_mem[18] = 8'h1e;
        instr_mem[19] = 8'h00;
        // li t4,1234567891
        // lui x29,301408
        instr_mem[20] = 8'hb7;
        instr_mem[21] = 8'h0e;
        instr_mem[22] = 8'h96;
        instr_mem[23] = 8'h49;
        // addi x29 x29 723
        instr_mem[24] = 8'h93;
        instr_mem[25] = 8'h8e;
        instr_mem[26] = 8'h3e;
        instr_mem[27] = 8'h2d;
        // add t5,t4,t3
        instr_mem[28] = 8'h33;
        instr_mem[29] = 8'h8f;
        instr_mem[30] = 8'hce;
        instr_mem[31] = 8'h01;
        // auipc t6,1
        
        // 汇编器所完成的功能是把汇编代码翻译成对应的机器码,
        // 所以在这条指令所完成的功能是pc + 4096
        
        instr_mem[32] = 8'h97;
        instr_mem[33] = 8'h1f;
        instr_mem[34] = 8'h00;
        instr_mem[35] = 8'h00;
        // beq t0,t1,8
        instr_mem[36] = 8'h63;
        instr_mem[37] = 8'h84;
        instr_mem[38] = 8'h62;
        instr_mem[39] = 8'h00;
        // bne t0,t1,8
        instr_mem[40] = 8'h63;
        instr_mem[41] = 8'h94;
        instr_mem[42] = 8'h62;
        instr_mem[43] = 8'h00;
        // nop 
        instr_mem[44] = 8'h13;
        instr_mem[45] = 8'h00;
        instr_mem[46] = 8'h00;
        instr_mem[47] = 8'h00;
        // addi x1,x0,-1
        instr_mem[48] = 8'h93;
        instr_mem[49] = 8'h00;
        instr_mem[50] = 8'hf0;
        instr_mem[51] = 8'hff;
        // addi x2,x0,1
        instr_mem[52] = 8'h13;
        instr_mem[53] = 8'h01;
        instr_mem[54] = 8'h10;
        instr_mem[55] = 8'h00;
        // bge x1,x2,8
        instr_mem[56] = 8'h63;
        instr_mem[57] = 8'hd4;
        instr_mem[58] = 8'h20;
        instr_mem[59] = 8'h00;
        // blt x1,x2,8
        instr_mem[60] = 8'h63;
        instr_mem[61] = 8'hc4;
        instr_mem[62] = 8'h20;
        instr_mem[63] = 8'h00;
        // nop
        instr_mem[64] = 8'h13;
        instr_mem[65] = 8'h00;
        instr_mem[66] = 8'h00;
        instr_mem[67] = 8'h00;
        // addi x3 x0 20
        instr_mem[68] = 8'h93;
        instr_mem[69] = 8'h01;
        instr_mem[70] = 8'h40;
        instr_mem[71] = 8'h01;
        // addi x4 x0 19
        instr_mem[72] = 8'h13;
        instr_mem[73] = 8'h02;
        instr_mem[74] = 8'h30;
        instr_mem[75] = 8'h01;
        // bltu x3 x4 8
        instr_mem[76] = 8'h63;
        instr_mem[77] = 8'he4;
        instr_mem[78] = 8'h41;
        instr_mem[79] = 8'h00;
        // bgeu x3 x4 8
        instr_mem[80] = 8'h63;
        instr_mem[81] = 8'hf4;
        instr_mem[82] = 8'h41;
        instr_mem[83] = 8'h00;
        // nop
        instr_mem[84] = 8'h13;
        instr_mem[85] = 8'h00;
        instr_mem[86] = 8'h00;
        instr_mem[87] = 8'h00;
        // li x5 4042322160
        // lui x5 986895
        instr_mem[88] = 8'hb7;
        instr_mem[89] = 8'hf2;
        instr_mem[90] = 8'hf0;
        instr_mem[91] = 8'hf0;
        // addi x5 x5 240
        instr_mem[92] = 8'h93;
        instr_mem[93] = 8'h82;
        instr_mem[94] = 8'h02;
        instr_mem[95] = 8'h0f;
        // sd x5 8(x0)
        instr_mem[96] = 8'h23;
        instr_mem[97] = 8'h34;
        instr_mem[98] = 8'h50;
        instr_mem[99] = 8'h00;
        // lb x6 8(x0)
        instr_mem[100] = 8'h03;
        instr_mem[101] = 8'h03;
        instr_mem[102] = 8'h80;
        instr_mem[103] = 8'h00;
        // lbu x7 8(x0)
        instr_mem[104] = 8'h83;
        instr_mem[105] = 8'h43;
        instr_mem[106] = 8'h80;
        instr_mem[107] = 8'h00;
        // lh x8 8(x0)
        instr_mem[108] = 8'h03;
        instr_mem[109] = 8'h14;
        instr_mem[110] = 8'h80;
        instr_mem[111] = 8'h00;
        // lhu x9 8(x0)
        instr_mem[112] = 8'h83;
        instr_mem[113] = 8'h54;
        instr_mem[114] = 8'h80;
        instr_mem[115] = 8'h00;
        // lw x10 8(x0)
        instr_mem[116] = 8'h03;
        instr_mem[117] = 8'h25;
        instr_mem[118] = 8'h80;
        instr_mem[119] = 8'h00;
        // lwu x11 8(x0)
        instr_mem[120] = 8'h83;
        instr_mem[121] = 8'h65;
        instr_mem[122] = 8'h80;
        instr_mem[123] = 8'h00;
        // ld x12 8(x0)
        instr_mem[124] = 8'h03;
        instr_mem[125] = 8'h36;
        instr_mem[126] = 8'h80;
        instr_mem[127] = 8'h00;
        // addi x13 x0 160
        instr_mem[128] = 8'h93;
        instr_mem[129] = 8'h06;
        instr_mem[130] = 8'h00;
        instr_mem[131] = 8'h0A;
        // sb x13 8(x0)
        instr_mem[132] = 8'h23;
        instr_mem[133] = 8'h04;
        instr_mem[134] = 8'hd0;
        instr_mem[135] = 8'h00;
        // lui x14 10
        instr_mem[136] = 8'h37;
        instr_mem[137] = 8'hA7;
        instr_mem[138] = 8'h00;
        instr_mem[139] = 8'h00;
        // addi x14 x14 176
        instr_mem[140] = 8'h13;
        instr_mem[141] = 8'h07;
        instr_mem[142] = 8'h07;
        instr_mem[143] = 8'h0B;
        // sh x14 8(x0)
        instr_mem[144] = 8'h23;
        instr_mem[145] = 8'h14;
        instr_mem[146] = 8'he0;
        instr_mem[147] = 8'h00;
        // lui x15 658118
        instr_mem[148] = 8'hb7;
        instr_mem[149] = 8'hc7;
        instr_mem[150] = 8'hb0;
        instr_mem[151] = 8'ha0;
        // addi x15 x15 208
        instr_mem[152] = 8'h93;
        instr_mem[153] = 8'h87;
        instr_mem[154] = 8'h07;
        instr_mem[155] = 8'h0d;
        // sw x15 8(x0)
        instr_mem[156] = 8'h23;
        instr_mem[157] = 8'h24;
        instr_mem[158] = 8'hf0;
        instr_mem[159] = 8'h00;

        // lui t0,0xff0f1
        instr_mem[160] = 8'hb7;
        instr_mem[161] = 8'h12;
        instr_mem[162] = 8'h0f;
        instr_mem[163] = 8'hff;

        // addiw t0,t0,-241
        instr_mem[164] = 8'h9b;
        instr_mem[165] = 8'h82;
        instr_mem[166] = 8'hf2;
        instr_mem[167] = 8'hf0;

        // slli t0,t0,0xc
        instr_mem[168] = 8'h93;
        instr_mem[169] = 8'h92;
        instr_mem[170] = 8'hc2;
        instr_mem[171] = 8'h00;

        // addi t0,t0,241
        instr_mem[172] = 8'h93;
        instr_mem[173] = 8'h82;
        instr_mem[174] = 8'h12;
        instr_mem[175] = 8'h0f;

        // slli t0,t0,0xc
        instr_mem[176] = 8'h93;
        instr_mem[177] = 8'h92;
        instr_mem[178] = 8'hc2;
        instr_mem[179] = 8'h00;

        // addi t0,t0,-241
        instr_mem[180] = 8'h93;
        instr_mem[181] = 8'h82;
        instr_mem[182] = 8'hf2;
        instr_mem[183] = 8'hf0;

        // slli t0,t0,0xc
        instr_mem[184] = 8'h93;
        instr_mem[185] = 8'h92;
        instr_mem[186] = 8'hc2;
        instr_mem[187] = 8'h00;
        
        // addi t0,t0,240
        instr_mem[188] = 8'h93;
        instr_mem[189] = 8'h82;
        instr_mem[190] = 8'h02;
        instr_mem[191] = 8'h0f;

        // lui t1,0xfff0f
        instr_mem[192] = 8'h37;
        instr_mem[193] = 8'hf3;
        instr_mem[194] = 8'hf0;
        instr_mem[195] = 8'hff;

        // addiw t1,t1,241
        instr_mem[196] = 8'h1b;
        instr_mem[197] = 8'h03;
        instr_mem[198] = 8'h13;
        instr_mem[199] = 8'h0f;

        // slli t1,t1,0xc
        instr_mem[200] = 8'h13;
        instr_mem[201] = 8'h13;
        instr_mem[202] = 8'hc3;
        instr_mem[203] = 8'h00;

        // addi t1,t1,-241
        instr_mem[204] = 8'h13;
        instr_mem[205] = 8'h03;
        instr_mem[206] = 8'hf3;
        instr_mem[207] = 8'hf0;

        // slli t1,t1,0xc
        instr_mem[208] = 8'h13;
        instr_mem[209] = 8'h13;
        instr_mem[210] = 8'hc3;
        instr_mem[211] = 8'h00;

        // addi t1,t1,241
        instr_mem[212] = 8'h13;
        instr_mem[213] = 8'h03;
        instr_mem[214] = 8'h13;
        instr_mem[215] = 8'h0f;

        // slli t1,t1,0xc
        instr_mem[216] = 8'h13;
        instr_mem[217] = 8'h13;
        instr_mem[218] = 8'hc3;
        instr_mem[219] = 8'h00;
        
        // addi t1,t1,-1
        instr_mem[220] = 8'h13;
        instr_mem[221] = 8'h03;
        instr_mem[222] = 8'hf3;
        instr_mem[223] = 8'hff;

        // slti t2,t1,520
        instr_mem[224] = 8'h93;
        instr_mem[225] = 8'h23;
        instr_mem[226] = 8'h83;
        instr_mem[227] = 8'h20;

        // sltiu t3,t1,520
        instr_mem[228] = 8'h13;
        instr_mem[229] = 8'h3e;
        instr_mem[230] = 8'h83;
        instr_mem[231] = 8'h20;
        
        // addi a1,zero,5
        instr_mem[232] = 8'h93;
        instr_mem[233] = 8'h05;
        instr_mem[234] = 8'h50;
        instr_mem[235] = 8'h00;

        // sltiu t5,a1,6
        instr_mem[236] = 8'h13;
        instr_mem[237] = 8'hbf;
        instr_mem[238] = 8'h65;
        instr_mem[239] = 8'h00;

        // xori t6,t0,-1
        instr_mem[240] = 8'h93;
        instr_mem[241] = 8'hcf;
        instr_mem[242] = 8'hf2;
        instr_mem[243] = 8'hff;

        // ori a6,t0,-1
        instr_mem[244] = 8'h13;
        instr_mem[245] = 8'he8;
        instr_mem[246] = 8'hf2;
        instr_mem[247] = 8'hff;

        // andi t0,a7,0
        instr_mem[248] = 8'h93;
        instr_mem[249] = 8'hf8;
        instr_mem[250] = 8'h02;
        instr_mem[251] = 8'h00;

        // slli s2,t0,0x20
        instr_mem[252] = 8'h13;
        instr_mem[253] = 8'h99;
        instr_mem[254] = 8'h02;
        instr_mem[255] = 8'h02;

        // slli s3,t1,0x3f
        instr_mem[256] = 8'h93;
        instr_mem[257] = 8'h19;
        instr_mem[258] = 8'hf3;
        instr_mem[259] = 8'h03;

        // srli s4,t0,0x20
        instr_mem[260] = 8'h13;
        instr_mem[261] = 8'hda;
        instr_mem[262] = 8'h02;
        instr_mem[263] = 8'h02;

        // srli s5,t0,0x3f
        instr_mem[264] = 8'h93;
        instr_mem[265] = 8'hda;
        instr_mem[266] = 8'hf2;
        instr_mem[267] = 8'h03;

        // srai s6,t0,0x20
        instr_mem[268] = 8'h13;
        instr_mem[269] = 8'hdb;
        instr_mem[270] = 8'h02;
        instr_mem[271] = 8'h42;

        // srai s7,t0,0x3f
        instr_mem[272] = 8'h93;
        instr_mem[273] = 8'hdb;
        instr_mem[274] = 8'hf2;
        instr_mem[275] = 8'h43;

        // add s8,t0,t1
        instr_mem[276] = 8'h33;
        instr_mem[277] = 8'h8c;
        instr_mem[278] = 8'h62;
        instr_mem[279] = 8'h00;

        // sub s9,t0,t1
        instr_mem[280] = 8'hb3;
        instr_mem[281] = 8'h8c;
        instr_mem[282] = 8'h62;
        instr_mem[283] = 8'h40;

        // addi ra,zero,20
        instr_mem[284] = 8'h93;
        instr_mem[285] = 8'h00;
        instr_mem[286] = 8'h00;
        instr_mem[287] = 8'h02;

        // sll s10,t0,ra
        instr_mem[288] = 8'h33;
        instr_mem[289] = 8'h9d;
        instr_mem[290] = 8'h12;
        instr_mem[291] = 8'h00;

        // addi ra,zero,63
        instr_mem[292] = 8'h93;
        instr_mem[293] = 8'h00;
        instr_mem[294] = 8'hf0;
        instr_mem[295] = 8'h03;

        // sll s11,t0,ra
        instr_mem[296] = 8'hb3;
        instr_mem[297] = 8'h1d;
        instr_mem[298] = 8'h13;
        instr_mem[299] = 8'h00;

        // slt a0,t0,t1
        instr_mem[300] = 8'h33;
        instr_mem[301] = 8'ha5;
        instr_mem[302] = 8'h62;
        instr_mem[303] = 8'h00;

        // addi a1,zero,5
        instr_mem[304] = 8'h93;
        instr_mem[305] = 8'h05;
        instr_mem[306] = 8'h50;
        instr_mem[307] = 8'h00;

        // addi a2,zero,4
        instr_mem[308] = 8'h13;
        instr_mem[309] = 8'h06;
        instr_mem[310] = 8'h40;
        instr_mem[311] = 8'h00;

        // slt a3,a1,a2
        instr_mem[312] = 8'hb3;
        instr_mem[313] = 8'ha6;
        instr_mem[314] = 8'hc5;
        instr_mem[315] = 8'h00;

        // sltu a4,t0,t1
        instr_mem[316] = 8'h33;
        instr_mem[317] = 8'hb7;
        instr_mem[318] = 8'h62;
        instr_mem[319] = 8'h00;

        // addi a5,zero,6
        instr_mem[320] = 8'h93;
        instr_mem[321] = 8'h07;
        instr_mem[322] = 8'h60;
        instr_mem[323] = 8'h00;
        // addi a6,zero,5
        instr_mem[324] = 8'h13;
        instr_mem[325] = 8'h08;
        instr_mem[326] = 8'h50;
        instr_mem[327] = 8'h00;
        // sltu a7,a5,a6
        instr_mem[328] = 8'hb3;
        instr_mem[329] = 8'hb8;
        instr_mem[330] = 8'h07;
        instr_mem[331] = 8'h01;

        // addi t2,zero,-1
        instr_mem[332] = 8'h93;
        instr_mem[333] = 8'h03;
        instr_mem[334] = 8'hf0;
        instr_mem[335] = 8'hff;

        // xor t3,t2,t0
        instr_mem[336] = 8'h33;
        instr_mem[337] = 8'hce;
        instr_mem[338] = 8'h53;
        instr_mem[339] = 8'h00;
        // xor t4,t1,t0
        instr_mem[340] = 8'hb3;
        instr_mem[341] = 8'hce;
        instr_mem[342] = 8'h63;
        instr_mem[343] = 8'h00;

        // addi a0,zero,32
        instr_mem[344] = 8'h13;
        instr_mem[345] = 8'h05;
        instr_mem[346] = 8'h00;
        instr_mem[347] = 8'h02;
        // addi a1,zero,63
        instr_mem[348] = 8'h93;
        instr_mem[349] = 8'h05;
        instr_mem[350] = 8'hf0;
        instr_mem[351] = 8'h03;
        // srl a2,t0,a0
        instr_mem[352] = 8'h33;
        instr_mem[353] = 8'hd6;
        instr_mem[354] = 8'ha2;
        instr_mem[355] = 8'h00;
        // srl a3,t1,a1
        instr_mem[356] = 8'hb3;
        instr_mem[357] = 8'h56;
        instr_mem[358] = 8'hb3;
        instr_mem[359] = 8'h00;
        
        // sra a5,t0,a0
        instr_mem[360] = 8'hb3;
        instr_mem[361] = 8'hd7;
        instr_mem[362] = 8'ha2;
        instr_mem[363] = 8'h40;
        // sra a6,t0,a1
        instr_mem[364] = 8'h33;
        instr_mem[365] = 8'hd8;
        instr_mem[366] = 8'hb2;
        instr_mem[367] = 8'h40;

        // addi a0,zero,0
        instr_mem[368] = 8'h13;
        instr_mem[369] = 8'h05;
        instr_mem[370] = 8'h00;
        instr_mem[371] = 8'h00;
        // addi a1,zero,-1
        instr_mem[372] = 8'h93;
        instr_mem[373] = 8'h05;
        instr_mem[374] = 8'hf0;
        instr_mem[375] = 8'hff;
        // or a2,t0,a1
        instr_mem[376] = 8'h33;
        instr_mem[377] = 8'he6;
        instr_mem[378] = 8'hb2;
        instr_mem[379] = 8'h00;
        // and a3,t0,a0
        instr_mem[380] = 8'hb3;
        instr_mem[381] = 8'hf6;
        instr_mem[382] = 8'ha2;
        instr_mem[383] = 8'h00;
        
        // jal ra,0x4
        instr_mem[384] = 8'hef;
        instr_mem[385] = 8'h00;
        instr_mem[386] = 8'h40;
        instr_mem[387] = 8'h00;

        // li a2,392
        instr_mem[388] = 8'h13;
        instr_mem[389] = 8'h06;
        instr_mem[390] = 8'h80;
        instr_mem[391] = 8'h18;

        // jalr ra,a2,4
        instr_mem[392] = 8'he7;
        instr_mem[393] = 8'h00;
        instr_mem[394] = 8'h46;
        instr_mem[395] = 8'h00;
        
        // addiw a4,t0,t1
        instr_mem[396] = 8'h3b;
        instr_mem[397] = 8'h87;
        instr_mem[398] = 8'h62;
        instr_mem[399] = 8'h00;
        
        // subw a5,t0,t1
        instr_mem[400] = 8'hbb;
        instr_mem[401] = 8'h87;
        instr_mem[402] = 8'h62;
        instr_mem[403] = 8'h40;

        // addi a0,zero,63
        instr_mem[404] = 8'h13;
        instr_mem[405] = 8'h05;
        instr_mem[406] = 8'hf0;
        instr_mem[407] = 8'h03;
        // sllw a1,t0,a0
        instr_mem[408] = 8'hbb;
        instr_mem[409] = 8'h95;
        instr_mem[410] = 8'ha2;
        instr_mem[411] = 8'h00;

        // sllw a2,t1,a0
        instr_mem[412] = 8'h3b;
        instr_mem[413] = 8'h16;
        instr_mem[414] = 8'ha3;
        instr_mem[415] = 8'h00;

        // srlw a3,t0,a0
        instr_mem[416] = 8'hbb;
        instr_mem[417] = 8'hd6;
        instr_mem[418] = 8'ha2;
        instr_mem[419] = 8'h00;

        // sraw a4,t0,a0
        instr_mem[420] = 8'h3b;
        instr_mem[421] = 8'hd7;
        instr_mem[422] = 8'ha2;
        instr_mem[423] = 8'h40;

        // addiw a5,t0,123
        instr_mem[424] = 8'h9b;
        instr_mem[425] = 8'h87;
        instr_mem[426] = 8'hb2;
        instr_mem[427] = 8'h07;

        // slliw a6,t1,0x1f
        instr_mem[428] = 8'h1b;
        instr_mem[429] = 8'h18;
        instr_mem[430] = 8'hf3;
        instr_mem[431] = 8'h01;

        // srliw a7,t0,0x1f
        instr_mem[432] = 8'h9b;
        instr_mem[433] = 8'hd8;
        instr_mem[434] = 8'hf2;
        instr_mem[435] = 8'h01;

        // sraiw s2,t0,0x1f
        instr_mem[436] = 8'h1b;
        instr_mem[437] = 8'hd9;
        instr_mem[438] = 8'hf2;
        instr_mem[439] = 8'h41;

        // sd t0,0(zero)
        instr_mem[440] = 8'h23;
        instr_mem[441] = 8'h30;
        instr_mem[442] = 8'h50;
        instr_mem[443] = 8'h00;

        // lwu s3,0(zero)
        instr_mem[444] = 8'h83;
        instr_mem[445] = 8'h69;
        instr_mem[446] = 8'h00;
        instr_mem[447] = 8'h00;

        // lw s4,0(zero)
        instr_mem[448] = 8'h03;
        instr_mem[449] = 8'h2a;
        instr_mem[450] = 8'h00;
        instr_mem[451] = 8'h00;

        // ld s5,0(zero)
        instr_mem[452] = 8'h83;
        instr_mem[453] = 8'h3a;
        instr_mem[454] = 8'h00;
        instr_mem[455] = 8'h00;

    end

    assign instr_o = {instr_mem[pc_i + 3],instr_mem[pc_i + 2],instr_mem[pc_i + 1],instr_mem[pc_i]};

endmodule