module inst_rom(
    input [63:0] pc_i,
    output [31:0] instr_o
);

    reg[7:0] instr_mem[1023:0];

    initial begin
        // 0000000000000000 <_start>:
        // 0x0: addi	x2,x0,512
        instr_mem[3] = 'h20;
        instr_mem[2] = 'h00;
        instr_mem[1] = 'h01;
        instr_mem[0] = 'h13;
        // 0x4: addi	x2,x2,-16
        instr_mem[7] = 'hff;
        instr_mem[6] = 'h01;
        instr_mem[5] = 'h01;
        instr_mem[4] = 'h13;
        // 0x8: sd	x1,8(x2)
        instr_mem[11] = 'h00;
        instr_mem[10] = 'h11;
        instr_mem[9] = 'h34;
        instr_mem[8] = 'h23;
        // 0xc: sd	x8,0(x2)
        instr_mem[15] = 'h00;
        instr_mem[14] = 'h81;
        instr_mem[13] = 'h30;
        instr_mem[12] = 'h23;
        // 0x10: addi	x8,x2,16
        // 改变x8的值
        instr_mem[19] = 'h01;
        instr_mem[18] = 'h01;
        instr_mem[17] = 'h04;
        instr_mem[16] = 'h13;
        // 0x14: addi	x11,x0,9
        instr_mem[23] = 'h00;
        instr_mem[22] = 'h90;
        instr_mem[21] = 'h05;
        instr_mem[20] = 'h93;
        // 0x18: lui	x15,0x1
        instr_mem[27] = 'h00;
        instr_mem[26] = 'h00;
        instr_mem[25] = 'h17;
        instr_mem[24] = 'hb7;
        // 0x1c: addi	x10,x15,712 # 12c8 <elements>
        instr_mem[31] = 'h2c;
        instr_mem[30] = 'h87;
        instr_mem[29] = 'h85;
        instr_mem[28] = 'h13;
        // 0x20: jal	x1,1fc <heap_sort>
        instr_mem[35] = 'h1d;
        instr_mem[34] = 'hc0;
        instr_mem[33] = 'h00;
        instr_mem[32] = 'hef;
        // 0x24: addi	x15,x0,0
        instr_mem[39] = 'h00;
        instr_mem[38] = 'h00;
        instr_mem[37] = 'h07;
        instr_mem[36] = 'h93;
        // 0x28: addi	x10,x15,0
        instr_mem[43] = 'h00;
        instr_mem[42] = 'h07;
        instr_mem[41] = 'h85;
        instr_mem[40] = 'h13;
        // 0x2c: ld	x1,8(x2)
        instr_mem[47] = 'h00;
        instr_mem[46] = 'h81;
        instr_mem[45] = 'h30;
        instr_mem[44] = 'h83;
        // 0x30: ld	x8,0(x2)
        // 改变x8的值
        instr_mem[51] = 'h00;
        instr_mem[50] = 'h01;
        instr_mem[49] = 'h34;
        instr_mem[48] = 'h03;
        // 0x34: addi	x2,x2,16
        instr_mem[55] = 'h01;
        instr_mem[54] = 'h01;
        instr_mem[53] = 'h01;
        instr_mem[52] = 'h13;
        // 0x38: jalr	x0,0(x1)
        instr_mem[59] = 'h00;
        instr_mem[58] = 'h00;
        instr_mem[57] = 'h80;
        instr_mem[56] = 'h67;
        // 000000000000003c <swap>:
        // 0x3c: addi	x2,x2,-32
        instr_mem[63] = 'hfe;
        instr_mem[62] = 'h01;
        instr_mem[61] = 'h01;
        instr_mem[60] = 'h13;
        // 0x40: sd	x8,24(x2)
        instr_mem[67] = 'h00;
        instr_mem[66] = 'h81;
        instr_mem[65] = 'h3c;
        instr_mem[64] = 'h23;
        // 0x44: sd	x9,16(x2)
        instr_mem[71] = 'h00;
        instr_mem[70] = 'h91;
        instr_mem[69] = 'h38;
        instr_mem[68] = 'h23;
        // 0x48: addi	x8,x2,32
        // 改变x8的值
        instr_mem[75] = 'h02;
        instr_mem[74] = 'h01;
        instr_mem[73] = 'h04;
        instr_mem[72] = 'h13;
        // 0x4c: sd	x10,-24(x8)
        instr_mem[79] = 'hfe;
        instr_mem[78] = 'ha4;
        instr_mem[77] = 'h34;
        instr_mem[76] = 'h23;
        // 0x50: addi	x15,x11,0
        instr_mem[83] = 'h00;
        instr_mem[82] = 'h05;
        instr_mem[81] = 'h87;
        instr_mem[80] = 'h93;
        // 0x54: addi	x14,x12,0
        instr_mem[87] = 'h00;
        instr_mem[86] = 'h06;
        instr_mem[85] = 'h07;
        instr_mem[84] = 'h13;
        // 0x58: sw	x15,-28(x8)
        instr_mem[91] = 'hfe;
        instr_mem[90] = 'hf4;
        instr_mem[89] = 'h22;
        instr_mem[88] = 'h23;
        // 0x5c: addi	x15,x14,0
        instr_mem[95] = 'h00;
        instr_mem[94] = 'h07;
        instr_mem[93] = 'h07;
        instr_mem[92] = 'h93;
        // 0x60: sw	x15,-32(x8)
        instr_mem[99] = 'hfe;
        instr_mem[98] = 'hf4;
        instr_mem[97] = 'h20;
        instr_mem[96] = 'h23;
        // 0x64: lw	x15,-28(x8)
        instr_mem[103] = 'hfe;
        instr_mem[102] = 'h44;
        instr_mem[101] = 'h27;
        instr_mem[100] = 'h83;
        // 0x68: slli	x15,x15,0x2
        instr_mem[107] = 'h00;
        instr_mem[106] = 'h27;
        instr_mem[105] = 'h97;
        instr_mem[104] = 'h93;
        // 0x6c: ld	x14,-24(x8)
        instr_mem[111] = 'hfe;
        instr_mem[110] = 'h84;
        instr_mem[109] = 'h37;
        instr_mem[108] = 'h03;
        // 0x70: add	x15,x14,x15
        instr_mem[115] = 'h00;
        instr_mem[114] = 'hf7;
        instr_mem[113] = 'h07;
        instr_mem[112] = 'hb3;
        // 0x74: lw	x9,0(x15)
        instr_mem[119] = 'h00;
        instr_mem[118] = 'h07;
        instr_mem[117] = 'ha4;
        instr_mem[116] = 'h83;
        // 0x78: lw	x15,-32(x8)
        instr_mem[123] = 'hfe;
        instr_mem[122] = 'h04;
        instr_mem[121] = 'h27;
        instr_mem[120] = 'h83;
        // 0x7c: slli	x15,x15,0x2
        instr_mem[127] = 'h00;
        instr_mem[126] = 'h27;
        instr_mem[125] = 'h97;
        instr_mem[124] = 'h93;
        // 0x80: ld	x14,-24(x8)
        instr_mem[131] = 'hfe;
        instr_mem[130] = 'h84;
        instr_mem[129] = 'h37;
        instr_mem[128] = 'h03;
        // 0x84: add	x14,x14,x15
        instr_mem[135] = 'h00;
        instr_mem[134] = 'hf7;
        instr_mem[133] = 'h07;
        instr_mem[132] = 'h33;
        // 0x88: lw	x15,-28(x8)
        instr_mem[139] = 'hfe;
        instr_mem[138] = 'h44;
        instr_mem[137] = 'h27;
        instr_mem[136] = 'h83;
        // 0x8c: slli	x15,x15,0x2
        instr_mem[143] = 'h00;
        instr_mem[142] = 'h27;
        instr_mem[141] = 'h97;
        instr_mem[140] = 'h93;
        // 0x90: ld	x13,-24(x8)
        instr_mem[147] = 'hfe;
        instr_mem[146] = 'h84;
        instr_mem[145] = 'h36;
        instr_mem[144] = 'h83;
        // 0x94: add	x15,x13,x15
        instr_mem[151] = 'h00;
        instr_mem[150] = 'hf6;
        instr_mem[149] = 'h87;
        instr_mem[148] = 'hb3;
        // 0x98: lw	x14,0(x14)
        instr_mem[155] = 'h00;
        instr_mem[154] = 'h07;
        instr_mem[153] = 'h27;
        instr_mem[152] = 'h03;
        // 0x9c: sw	x14,0(x15)
        instr_mem[159] = 'h00;
        instr_mem[158] = 'he7;
        instr_mem[157] = 'ha0;
        instr_mem[156] = 'h23;
        // 0xa0: lw	x15,-32(x8)
        instr_mem[163] = 'hfe;
        instr_mem[162] = 'h04;
        instr_mem[161] = 'h27;
        instr_mem[160] = 'h83;
        // 0xa4: slli	x15,x15,0x2
        instr_mem[167] = 'h00;
        instr_mem[166] = 'h27;
        instr_mem[165] = 'h97;
        instr_mem[164] = 'h93;
        // 0xa8: ld	x14,-24(x8)
        instr_mem[171] = 'hfe;
        instr_mem[170] = 'h84;
        instr_mem[169] = 'h37;
        instr_mem[168] = 'h03;
        // 0xac: add	x15,x14,x15
        instr_mem[175] = 'h00;
        instr_mem[174] = 'hf7;
        instr_mem[173] = 'h07;
        instr_mem[172] = 'hb3;
        // 0xb0: sw	x9,0(x15)
        instr_mem[179] = 'h00;
        instr_mem[178] = 'h97;
        instr_mem[177] = 'ha0;
        instr_mem[176] = 'h23;
        // 0xb4: addi	x0,x0,0
        instr_mem[183] = 'h00;
        instr_mem[182] = 'h00;
        instr_mem[181] = 'h00;
        instr_mem[180] = 'h13;
        // 0xb8: ld	x8,24(x2)
        // 改变x8的值
        instr_mem[187] = 'h01;
        instr_mem[186] = 'h81;
        instr_mem[185] = 'h34;
        instr_mem[184] = 'h03;
        // 0xbc: ld	x9,16(x2)
        instr_mem[191] = 'h01;
        instr_mem[190] = 'h01;
        instr_mem[189] = 'h34;
        instr_mem[188] = 'h83;
        // 0xc0: addi	x2,x2,32
        instr_mem[195] = 'h02;
        instr_mem[194] = 'h01;
        instr_mem[193] = 'h01;
        instr_mem[192] = 'h13;
        // 0xc4: jalr	x0,0(x1)
        instr_mem[199] = 'h00;
        instr_mem[198] = 'h00;
        instr_mem[197] = 'h80;
        instr_mem[196] = 'h67;
        // 00000000000000c8 <adjust>:
        // 0xc8: addi	x2,x2,-48
        instr_mem[203] = 'hfd;
        instr_mem[202] = 'h01;
        instr_mem[201] = 'h01;
        instr_mem[200] = 'h13;
        // 0xcc: sd	x8,40(x2)
        instr_mem[207] = 'h02;
        instr_mem[206] = 'h81;
        instr_mem[205] = 'h34;
        instr_mem[204] = 'h23;
        // 0xd0: sd	x9,32(x2)
        instr_mem[211] = 'h02;
        instr_mem[210] = 'h91;
        instr_mem[209] = 'h30;
        instr_mem[208] = 'h23;
        // 0xd4: sd	x18,24(x2)
        instr_mem[215] = 'h01;
        instr_mem[214] = 'h21;
        instr_mem[213] = 'h3c;
        instr_mem[212] = 'h23;
        // 0xd8: addi	x8,x2,48
        // 改变x8的值
        instr_mem[219] = 'h03;
        instr_mem[218] = 'h01;
        instr_mem[217] = 'h04;
        instr_mem[216] = 'h13;
        // 0xdc: sd	x10,-40(x8)
        instr_mem[223] = 'hfc;
        instr_mem[222] = 'ha4;
        instr_mem[221] = 'h3c;
        instr_mem[220] = 'h23;
        // 0xe0: addi	x15,x11,0
        instr_mem[227] = 'h00;
        instr_mem[226] = 'h05;
        instr_mem[225] = 'h87;
        instr_mem[224] = 'h93;
        // 0xe4: addi	x14,x12,0
        instr_mem[231] = 'h00;
        instr_mem[230] = 'h06;
        instr_mem[229] = 'h07;
        instr_mem[228] = 'h13;
        // 0xe8: sw	x15,-44(x8)
        instr_mem[235] = 'hfc;
        instr_mem[234] = 'hf4;
        instr_mem[233] = 'h2a;
        instr_mem[232] = 'h23;
        // 0xec: addi	x15,x14,0
        instr_mem[239] = 'h00;
        instr_mem[238] = 'h07;
        instr_mem[237] = 'h07;
        instr_mem[236] = 'h93;
        // 0xf0: sw	x15,-48(x8)
        instr_mem[243] = 'hfc;
        instr_mem[242] = 'hf4;
        instr_mem[241] = 'h28;
        instr_mem[240] = 'h23;
        // 0xf4: lw	x15,-44(x8)
        instr_mem[247] = 'hfd;
        instr_mem[246] = 'h44;
        instr_mem[245] = 'h27;
        instr_mem[244] = 'h83;
        // 0xf8: slli	x15,x15,0x2
        instr_mem[251] = 'h00;
        instr_mem[250] = 'h27;
        instr_mem[249] = 'h97;
        instr_mem[248] = 'h93;
        // 0xfc: ld	x14,-40(x8)
        instr_mem[255] = 'hfd;
        instr_mem[254] = 'h84;
        instr_mem[253] = 'h37;
        instr_mem[252] = 'h03;
        // 0x100: add	x15,x14,x15
        instr_mem[259] = 'h00;
        instr_mem[258] = 'hf7;
        instr_mem[257] = 'h07;
        instr_mem[256] = 'hb3;
        // 0x104: lw	x18,0(x15)
        instr_mem[263] = 'h00;
        instr_mem[262] = 'h07;
        instr_mem[261] = 'ha9;
        instr_mem[260] = 'h03;
        // 0x108: lw	x15,-44(x8)
        instr_mem[267] = 'hfd;
        instr_mem[266] = 'h44;
        instr_mem[265] = 'h27;
        instr_mem[264] = 'h83;
        // 0x10c: slliw	x15,x15,0x1
        instr_mem[271] = 'h00;
        instr_mem[270] = 'h17;
        instr_mem[269] = 'h97;
        instr_mem[268] = 'h9b;
        // 0x110: addiw	x9,x15,0
        instr_mem[275] = 'h00;
        instr_mem[274] = 'h07;
        instr_mem[273] = 'h84;
        instr_mem[272] = 'h9b;
        // 0x114: jal	x0,1b4 <adjust+0xec>
        instr_mem[279] = 'h0a;
        instr_mem[278] = 'h00;
        instr_mem[277] = 'h00;
        instr_mem[276] = 'h6f;
        // 0x118: lw	x15,-48(x8)
        instr_mem[283] = 'hfd;
        instr_mem[282] = 'h04;
        instr_mem[281] = 'h27;
        instr_mem[280] = 'h83;
        // 0x11c: addiw	x15,x15,0
        instr_mem[287] = 'h00;
        instr_mem[286] = 'h07;
        instr_mem[285] = 'h87;
        instr_mem[284] = 'h9b;
        // 0x120: addi	x14,x9,0
        instr_mem[291] = 'h00;
        instr_mem[290] = 'h04;
        instr_mem[289] = 'h87;
        instr_mem[288] = 'h13;
        // 0x124: bge	x14,x15,164 <adjust+0x9c>
        instr_mem[295] = 'h04;
        instr_mem[294] = 'hf7;
        instr_mem[293] = 'h50;
        instr_mem[292] = 'h63;
        // 0x128: addi	x15,x9,0
        instr_mem[299] = 'h00;
        instr_mem[298] = 'h04;
        instr_mem[297] = 'h87;
        instr_mem[296] = 'h93;
        // 0x12c: slli	x15,x15,0x2
        instr_mem[303] = 'h00;
        instr_mem[302] = 'h27;
        instr_mem[301] = 'h97;
        instr_mem[300] = 'h93;
        // 0x130: ld	x14,-40(x8)
        instr_mem[307] = 'hfd;
        instr_mem[306] = 'h84;
        instr_mem[305] = 'h37;
        instr_mem[304] = 'h03;
        // 0x134: add	x15,x14,x15
        instr_mem[311] = 'h00;
        instr_mem[310] = 'hf7;
        instr_mem[309] = 'h07;
        instr_mem[308] = 'hb3;
        // 0x138: lw	x13,0(x15)
        instr_mem[315] = 'h00;
        instr_mem[314] = 'h07;
        instr_mem[313] = 'ha6;
        instr_mem[312] = 'h83;
        // 0x13c: addi	x15,x9,0
        instr_mem[319] = 'h00;
        instr_mem[318] = 'h04;
        instr_mem[317] = 'h87;
        instr_mem[316] = 'h93;
        // 0x140: addi	x15,x15,1
        instr_mem[323] = 'h00;
        instr_mem[322] = 'h17;
        instr_mem[321] = 'h87;
        instr_mem[320] = 'h93;
        // 0x144: slli	x15,x15,0x2
        instr_mem[327] = 'h00;
        instr_mem[326] = 'h27;
        instr_mem[325] = 'h97;
        instr_mem[324] = 'h93;
        // 0x148: ld	x14,-40(x8)
        instr_mem[331] = 'hfd;
        instr_mem[330] = 'h84;
        instr_mem[329] = 'h37;
        instr_mem[328] = 'h03;
        // 0x14c: add	x15,x14,x15
        instr_mem[335] = 'h00;
        instr_mem[334] = 'hf7;
        instr_mem[333] = 'h07;
        instr_mem[332] = 'hb3;
        // 0x150: lw	x15,0(x15)
        instr_mem[339] = 'h00;
        instr_mem[338] = 'h07;
        instr_mem[337] = 'ha7;
        instr_mem[336] = 'h83;
        // 0x154: addi	x14,x13,0
        instr_mem[343] = 'h00;
        instr_mem[342] = 'h06;
        instr_mem[341] = 'h87;
        instr_mem[340] = 'h13;
        // 0x158: bge	x14,x15,164 <adjust+0x9c>
        instr_mem[347] = 'h00;
        instr_mem[346] = 'hf7;
        instr_mem[345] = 'h56;
        instr_mem[344] = 'h63;
        // 0x15c: addiw	x15,x9,1
        instr_mem[351] = 'h00;
        instr_mem[350] = 'h14;
        instr_mem[349] = 'h87;
        instr_mem[348] = 'h9b;
        // 0x160: addiw	x9,x15,0
        instr_mem[355] = 'h00;
        instr_mem[354] = 'h07;
        instr_mem[353] = 'h84;
        instr_mem[352] = 'h9b;
        // 0x164: addi	x15,x9,0
        instr_mem[359] = 'h00;
        instr_mem[358] = 'h04;
        instr_mem[357] = 'h87;
        instr_mem[356] = 'h93;
        // 0x168: slli	x15,x15,0x2
        instr_mem[363] = 'h00;
        instr_mem[362] = 'h27;
        instr_mem[361] = 'h97;
        instr_mem[360] = 'h93;
        // 0x16c: ld	x14,-40(x8)
        instr_mem[367] = 'hfd;
        instr_mem[366] = 'h84;
        instr_mem[365] = 'h37;
        instr_mem[364] = 'h03;
        // 0x170: add	x15,x14,x15
        instr_mem[371] = 'h00;
        instr_mem[370] = 'hf7;
        instr_mem[369] = 'h07;
        instr_mem[368] = 'hb3;
        // 0x174: lw	x15,0(x15)
        instr_mem[375] = 'h00;
        instr_mem[374] = 'h07;
        instr_mem[373] = 'ha7;
        instr_mem[372] = 'h83;
        // 0x178: addi	x14,x18,0
        instr_mem[379] = 'h00;
        instr_mem[378] = 'h09;
        instr_mem[377] = 'h07;
        instr_mem[376] = 'h13;
        // 0x17c: blt	x15,x14,1c8 <adjust+0x100>
        instr_mem[383] = 'h04;
        instr_mem[382] = 'he7;
        instr_mem[381] = 'hc6;
        instr_mem[380] = 'h63;
        // 0x180: addi	x15,x9,0
        instr_mem[387] = 'h00;
        instr_mem[386] = 'h04;
        instr_mem[385] = 'h87;
        instr_mem[384] = 'h93;
        // 0x184: slli	x15,x15,0x2
        instr_mem[391] = 'h00;
        instr_mem[390] = 'h27;
        instr_mem[389] = 'h97;
        instr_mem[388] = 'h93;
        // 0x188: ld	x14,-40(x8)
        instr_mem[395] = 'hfd;
        instr_mem[394] = 'h84;
        instr_mem[393] = 'h37;
        instr_mem[392] = 'h03;
        // 0x18c: add	x14,x14,x15
        instr_mem[399] = 'h00;
        instr_mem[398] = 'hf7;
        instr_mem[397] = 'h07;
        instr_mem[396] = 'h33;
        // 0x190: sraiw	x15,x9,0x1
        instr_mem[403] = 'h40;
        instr_mem[402] = 'h14;
        instr_mem[401] = 'hd7;
        instr_mem[400] = 'h9b;
        // 0x194: addiw	x15,x15,0
        instr_mem[407] = 'h00;
        instr_mem[406] = 'h07;
        instr_mem[405] = 'h87;
        instr_mem[404] = 'h9b;
        // 0x198: slli	x15,x15,0x2
        instr_mem[411] = 'h00;
        instr_mem[410] = 'h27;
        instr_mem[409] = 'h97;
        instr_mem[408] = 'h93;
        // 0x19c: ld	x13,-40(x8)
        instr_mem[415] = 'hfd;
        instr_mem[414] = 'h84;
        instr_mem[413] = 'h36;
        instr_mem[412] = 'h83;
        // 0x1a0: add	x15,x13,x15
        instr_mem[419] = 'h00;
        instr_mem[418] = 'hf6;
        instr_mem[417] = 'h87;
        instr_mem[416] = 'hb3;
        // 0x1a4: lw	x14,0(x14)
        instr_mem[423] = 'h00;
        instr_mem[422] = 'h07;
        instr_mem[421] = 'h27;
        instr_mem[420] = 'h03;
        // 0x1a8: sw	x14,0(x15)
        instr_mem[427] = 'h00;
        instr_mem[426] = 'he7;
        instr_mem[425] = 'ha0;
        instr_mem[424] = 'h23;
        // 0x1ac: slliw	x15,x9,0x1
        instr_mem[431] = 'h00;
        instr_mem[430] = 'h14;
        instr_mem[429] = 'h97;
        instr_mem[428] = 'h9b;
        // 0x1b0: addiw	x9,x15,0
        instr_mem[435] = 'h00;
        instr_mem[434] = 'h07;
        instr_mem[433] = 'h84;
        instr_mem[432] = 'h9b;
        // 0x1b4: lw	x15,-48(x8)
        instr_mem[439] = 'hfd;
        instr_mem[438] = 'h04;
        instr_mem[437] = 'h27;
        instr_mem[436] = 'h83;
        // 0x1b8: addiw	x15,x15,0
        instr_mem[443] = 'h00;
        instr_mem[442] = 'h07;
        instr_mem[441] = 'h87;
        instr_mem[440] = 'h9b;
        // 0x1bc: addi	x14,x9,0
        instr_mem[447] = 'h00;
        instr_mem[446] = 'h04;
        instr_mem[445] = 'h87;
        instr_mem[444] = 'h13;
        // 0x1c0: bge	x15,x14,118 <adjust+0x50>
        instr_mem[451] = 'hf4;
        instr_mem[450] = 'he7;
        instr_mem[449] = 'hdc;
        instr_mem[448] = 'he3;
        // 0x1c4: jal	x0,1cc <adjust+0x104>
        instr_mem[455] = 'h00;
        instr_mem[454] = 'h80;
        instr_mem[453] = 'h00;
        instr_mem[452] = 'h6f;
        // 0x1c8: addi	x0,x0,0
        instr_mem[459] = 'h00;
        instr_mem[458] = 'h00;
        instr_mem[457] = 'h00;
        instr_mem[456] = 'h13;
        // 0x1cc: sraiw	x15,x9,0x1
        instr_mem[463] = 'h40;
        instr_mem[462] = 'h14;
        instr_mem[461] = 'hd7;
        instr_mem[460] = 'h9b;
        // 0x1d0: addiw	x15,x15,0
        instr_mem[467] = 'h00;
        instr_mem[466] = 'h07;
        instr_mem[465] = 'h87;
        instr_mem[464] = 'h9b;
        // 0x1d4: slli	x15,x15,0x2
        instr_mem[471] = 'h00;
        instr_mem[470] = 'h27;
        instr_mem[469] = 'h97;
        instr_mem[468] = 'h93;
        // 0x1d8: ld	x14,-40(x8)
        instr_mem[475] = 'hfd;
        instr_mem[474] = 'h84;
        instr_mem[473] = 'h37;
        instr_mem[472] = 'h03;
        // 0x1dc: add	x15,x14,x15
        instr_mem[479] = 'h00;
        instr_mem[478] = 'hf7;
        instr_mem[477] = 'h07;
        instr_mem[476] = 'hb3;
        // 0x1e0: sw	x18,0(x15)
        instr_mem[483] = 'h01;
        instr_mem[482] = 'h27;
        instr_mem[481] = 'ha0;
        instr_mem[480] = 'h23;
        // 0x1e4: addi	x0,x0,0
        instr_mem[487] = 'h00;
        instr_mem[486] = 'h00;
        instr_mem[485] = 'h00;
        instr_mem[484] = 'h13;
        // 0x1e8: ld	x8,40(x2)
        // 改变x8的值
        instr_mem[491] = 'h02;
        instr_mem[490] = 'h81;
        instr_mem[489] = 'h34;
        instr_mem[488] = 'h03;
        // 0x1ec: ld	x9,32(x2)
        instr_mem[495] = 'h02;
        instr_mem[494] = 'h01;
        instr_mem[493] = 'h34;
        instr_mem[492] = 'h83;
        // 0x1f0: ld	x18,24(x2)
        instr_mem[499] = 'h01;
        instr_mem[498] = 'h81;
        instr_mem[497] = 'h39;
        instr_mem[496] = 'h03;
        // 0x1f4: addi	x2,x2,48
        instr_mem[503] = 'h03;
        instr_mem[502] = 'h01;
        instr_mem[501] = 'h01;
        instr_mem[500] = 'h13;
        // 0x1f8: jalr	x0,0(x1)
        instr_mem[507] = 'h00;
        instr_mem[506] = 'h00;
        instr_mem[505] = 'h80;
        instr_mem[504] = 'h67;
        // 00000000000001fc <heap_sort>:
        // 0x1fc: addi	x2,x2,-48
        instr_mem[511] = 'hfd;
        instr_mem[510] = 'h01;
        instr_mem[509] = 'h01;
        instr_mem[508] = 'h13;
        // 0x200: sd	x1,40(x2)
        instr_mem[515] = 'h02;
        instr_mem[514] = 'h11;
        instr_mem[513] = 'h34;
        instr_mem[512] = 'h23;
        // 0x204: sd	x8,32(x2)
        instr_mem[519] = 'h02;
        instr_mem[518] = 'h81;
        instr_mem[517] = 'h30;
        instr_mem[516] = 'h23;
        // 0x208: addi	x8,x2,48
        // 改变x8的值
        instr_mem[523] = 'h03;
        instr_mem[522] = 'h01;
        instr_mem[521] = 'h04;
        instr_mem[520] = 'h13;
        // 0x20c: sd	x10,-40(x8)
        instr_mem[527] = 'hfc;
        instr_mem[526] = 'ha4;
        instr_mem[525] = 'h3c;
        instr_mem[524] = 'h23;
        // 0x210: addi	x15,x11,0
        instr_mem[531] = 'h00;
        instr_mem[530] = 'h05;
        instr_mem[529] = 'h87;
        instr_mem[528] = 'h93;
        // 0x214: sw	x15,-44(x8)
        instr_mem[535] = 'hfc;
        instr_mem[534] = 'hf4;
        instr_mem[533] = 'h2a;
        instr_mem[532] = 'h23;
        // 0x218: lw	x15,-44(x8)
        instr_mem[539] = 'hfd;
        instr_mem[538] = 'h44;
        instr_mem[537] = 'h27;
        instr_mem[536] = 'h83;
        // 0x21c: sraiw	x15,x15,0x1
        instr_mem[543] = 'h40;
        instr_mem[542] = 'h17;
        instr_mem[541] = 'hd7;
        instr_mem[540] = 'h9b;
        // 0x220: sw	x15,-20(x8)
        instr_mem[547] = 'hfe;
        instr_mem[546] = 'hf4;
        instr_mem[545] = 'h26;
        instr_mem[544] = 'h23;
        // 0x224: jal	x0,24c <heap_sort+0x50>
        instr_mem[551] = 'h02;
        instr_mem[550] = 'h80;
        instr_mem[549] = 'h00;
        instr_mem[548] = 'h6f;
        // 0x228: lw	x14,-44(x8)
        instr_mem[555] = 'hfd;
        instr_mem[554] = 'h44;
        instr_mem[553] = 'h27;
        instr_mem[552] = 'h03;
        // 0x22c: lw	x15,-20(x8)
        instr_mem[559] = 'hfe;
        instr_mem[558] = 'hc4;
        instr_mem[557] = 'h27;
        instr_mem[556] = 'h83;
        // 0x230: addi	x12,x14,0
        instr_mem[563] = 'h00;
        instr_mem[562] = 'h07;
        instr_mem[561] = 'h06;
        instr_mem[560] = 'h13;
        // 0x234: addi	x11,x15,0
        instr_mem[567] = 'h00;
        instr_mem[566] = 'h07;
        instr_mem[565] = 'h85;
        instr_mem[564] = 'h93;
        // 0x238: ld	x10,-40(x8)
        instr_mem[571] = 'hfd;
        instr_mem[570] = 'h84;
        instr_mem[569] = 'h35;
        instr_mem[568] = 'h03;
        // 0x23c: jal	x1,c8 <adjust>
        instr_mem[575] = 'he8;
        instr_mem[574] = 'hdf;
        instr_mem[573] = 'hf0;
        instr_mem[572] = 'hef;
        // 0x240: lw	x15,-20(x8)
        instr_mem[579] = 'hfe;
        instr_mem[578] = 'hc4;
        instr_mem[577] = 'h27;
        instr_mem[576] = 'h83;
        // 0x244: addiw	x15,x15,-1
        instr_mem[583] = 'hff;
        instr_mem[582] = 'hf7;
        instr_mem[581] = 'h87;
        instr_mem[580] = 'h9b;
        // 0x248: sw	x15,-20(x8)
        instr_mem[587] = 'hfe;
        instr_mem[586] = 'hf4;
        instr_mem[585] = 'h26;
        instr_mem[584] = 'h23;
        // 0x24c: lw	x15,-20(x8)
        instr_mem[591] = 'hfe;
        instr_mem[590] = 'hc4;
        instr_mem[589] = 'h27;
        instr_mem[588] = 'h83;
        // 0x250: addiw	x15,x15,0
        instr_mem[595] = 'h00;
        instr_mem[594] = 'h07;
        instr_mem[593] = 'h87;
        instr_mem[592] = 'h9b;
        // 0x254: blt	x0,x15,228 <heap_sort+0x2c>
        instr_mem[599] = 'hfc;
        instr_mem[598] = 'hf0;
        instr_mem[597] = 'h4a;
        instr_mem[596] = 'he3;
        // 0x258: lw	x15,-44(x8)
        instr_mem[603] = 'hfd;
        instr_mem[602] = 'h44;
        instr_mem[601] = 'h27;
        instr_mem[600] = 'h83;
        // 0x25c: sw	x15,-24(x8)
        instr_mem[607] = 'hfe;
        instr_mem[606] = 'hf4;
        instr_mem[605] = 'h24;
        instr_mem[604] = 'h23;
        // 0x260: jal	x0,2a0 <heap_sort+0xa4>
        instr_mem[611] = 'h04;
        instr_mem[610] = 'h00;
        instr_mem[609] = 'h00;
        instr_mem[608] = 'h6f;
        // 0x264: lw	x15,-24(x8)
        instr_mem[615] = 'hfe;
        instr_mem[614] = 'h84;
        instr_mem[613] = 'h27;
        instr_mem[612] = 'h83;
        // 0x268: addi	x12,x15,0
        instr_mem[619] = 'h00;
        instr_mem[618] = 'h07;
        instr_mem[617] = 'h86;
        instr_mem[616] = 'h13;
        // 0x26c: addi	x11,x0,1
        instr_mem[623] = 'h00;
        instr_mem[622] = 'h10;
        instr_mem[621] = 'h05;
        instr_mem[620] = 'h93;
        // 0x270: ld	x10,-40(x8)
        instr_mem[627] = 'hfd;
        instr_mem[626] = 'h84;
        instr_mem[625] = 'h35;
        instr_mem[624] = 'h03;
        // 0x274: jal	x1,3c <swap>
        instr_mem[631] = 'hdc;
        instr_mem[630] = 'h9f;
        instr_mem[629] = 'hf0;
        instr_mem[628] = 'hef;
        // 0x278: lw	x15,-24(x8)
        instr_mem[635] = 'hfe;
        instr_mem[634] = 'h84;
        instr_mem[633] = 'h27;
        instr_mem[632] = 'h83;
        // 0x27c: addiw	x15,x15,-1
        instr_mem[639] = 'hff;
        instr_mem[638] = 'hf7;
        instr_mem[637] = 'h87;
        instr_mem[636] = 'h9b;
        // 0x280: addiw	x15,x15,0
        instr_mem[643] = 'h00;
        instr_mem[642] = 'h07;
        instr_mem[641] = 'h87;
        instr_mem[640] = 'h9b;
        // 0x284: addi	x12,x15,0
        instr_mem[647] = 'h00;
        instr_mem[646] = 'h07;
        instr_mem[645] = 'h86;
        instr_mem[644] = 'h13;
        // 0x288: addi	x11,x0,1
        instr_mem[651] = 'h00;
        instr_mem[650] = 'h10;
        instr_mem[649] = 'h05;
        instr_mem[648] = 'h93;
        // 0x28c: ld	x10,-40(x8)
        instr_mem[655] = 'hfd;
        instr_mem[654] = 'h84;
        instr_mem[653] = 'h35;
        instr_mem[652] = 'h03;
        // 0x290: jal	x1,c8 <adjust>
        instr_mem[659] = 'he3;
        instr_mem[658] = 'h9f;
        instr_mem[657] = 'hf0;
        instr_mem[656] = 'hef;
        // 0x294: lw	x15,-24(x8)
        instr_mem[663] = 'hfe;
        instr_mem[662] = 'h84;
        instr_mem[661] = 'h27;
        instr_mem[660] = 'h83;
        // 0x298: addiw	x15,x15,-1
        instr_mem[667] = 'hff;
        instr_mem[666] = 'hf7;
        instr_mem[665] = 'h87;
        instr_mem[664] = 'h9b;
        // 0x29c: sw	x15,-24(x8)
        instr_mem[671] = 'hfe;
        instr_mem[670] = 'hf4;
        instr_mem[669] = 'h24;
        instr_mem[668] = 'h23;
        // 0x2a0: lw	x15,-24(x8)
        instr_mem[675] = 'hfe;
        instr_mem[674] = 'h84;
        instr_mem[673] = 'h27;
        instr_mem[672] = 'h83;
        // 0x2a4: addiw	x14,x15,0
        instr_mem[679] = 'h00;
        instr_mem[678] = 'h07;
        instr_mem[677] = 'h87;
        instr_mem[676] = 'h1b;
        // 0x2a8: addi	x15,x0,1
        instr_mem[683] = 'h00;
        instr_mem[682] = 'h10;
        instr_mem[681] = 'h07;
        instr_mem[680] = 'h93;
        // 0x2ac: blt	x15,x14,264 <heap_sort+0x68>
        instr_mem[687] = 'hfa;
        instr_mem[686] = 'he7;
        instr_mem[685] = 'hcc;
        instr_mem[684] = 'he3;
        // 0x2b0: addi	x0,x0,0
        instr_mem[691] = 'h00;
        instr_mem[690] = 'h00;
        instr_mem[689] = 'h00;
        instr_mem[688] = 'h13;
        // 0x2b4: addi	x0,x0,0
        instr_mem[695] = 'h00;
        instr_mem[694] = 'h00;
        instr_mem[693] = 'h00;
        instr_mem[692] = 'h13;
        // 0x2b8: ld	x1,40(x2)
        instr_mem[699] = 'h02;
        instr_mem[698] = 'h81;
        instr_mem[697] = 'h30;
        instr_mem[696] = 'h83;
        // 0x2bc: ld	x8,32(x2)
        // 改变x8的值
        instr_mem[703] = 'h02;
        instr_mem[702] = 'h01;
        instr_mem[701] = 'h34;
        instr_mem[700] = 'h03;
        // 0x2c0: addi	x2,x2,48
        instr_mem[707] = 'h03;
        instr_mem[706] = 'h01;
        instr_mem[705] = 'h01;
        instr_mem[704] = 'h13;
        // 0x2c4: jalr	x0,0(x1)
        instr_mem[711] = 'h00;
        instr_mem[710] = 'h00;
        instr_mem[709] = 'h80;
        instr_mem[708] = 'h67;
    end

    assign instr_o = {instr_mem[pc_i + 3],instr_mem[pc_i + 2],instr_mem[pc_i + 1],instr_mem[pc_i]};

endmodule