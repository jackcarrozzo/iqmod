module sincos (
	sin,  //out
	cos,  //out
	sval, //in
	cval  //in
);

output [7:0] sin;
output [7:0] cos;

input [7:0] sval;
input [7:0] cval;

reg [7:0] sin_lut [0:255];
reg [7:0] cos_lut [0:255];
reg [7:0] sin;
reg [7:0] cos;

// generated with lut_gen.pl
// TODO: need to regen this as ints
initial begin
	sin_lut[000] = 8'h7F;
	cos_lut[000] = 8'hFF;
	sin_lut[001] = 8'h82;
	cos_lut[001] = 8'hFE;
	sin_lut[002] = 8'h85;
	cos_lut[002] = 8'hFE;
	sin_lut[003] = 8'h88;
	cos_lut[003] = 8'hFE;
	sin_lut[004] = 8'h8C;
	cos_lut[004] = 8'hFE;
	sin_lut[005] = 8'h8F;
	cos_lut[005] = 8'hFE;
	sin_lut[006] = 8'h92;
	cos_lut[006] = 8'hFD;
	sin_lut[007] = 8'h95;
	cos_lut[007] = 8'hFD;
	sin_lut[008] = 8'h98;
	cos_lut[008] = 8'hFC;
	sin_lut[009] = 8'h9B;
	cos_lut[009] = 8'hFB;
	sin_lut[010] = 8'h9E;
	cos_lut[010] = 8'hFB;
	sin_lut[011] = 8'hA1;
	cos_lut[011] = 8'hFA;
	sin_lut[012] = 8'hA4;
	cos_lut[012] = 8'hF9;
	sin_lut[013] = 8'hA7;
	cos_lut[013] = 8'hF8;
	sin_lut[014] = 8'hAA;
	cos_lut[014] = 8'hF7;
	sin_lut[015] = 8'hAD;
	cos_lut[015] = 8'hF6;
	sin_lut[016] = 8'hB0;
	cos_lut[016] = 8'hF5;
	sin_lut[017] = 8'hB3;
	cos_lut[017] = 8'hF3;
	sin_lut[018] = 8'hB6;
	cos_lut[018] = 8'hF2;
	sin_lut[019] = 8'hB9;
	cos_lut[019] = 8'hF1;
	sin_lut[020] = 8'hBB;
	cos_lut[020] = 8'hEF;
	sin_lut[021] = 8'hBE;
	cos_lut[021] = 8'hEE;
	sin_lut[022] = 8'hC1;
	cos_lut[022] = 8'hEC;
	sin_lut[023] = 8'hC3;
	cos_lut[023] = 8'hEB;
	sin_lut[024] = 8'hC6;
	cos_lut[024] = 8'hE9;
	sin_lut[025] = 8'hC9;
	cos_lut[025] = 8'hE7;
	sin_lut[026] = 8'hCB;
	cos_lut[026] = 8'hE5;
	sin_lut[027] = 8'hCE;
	cos_lut[027] = 8'hE3;
	sin_lut[028] = 8'hD0;
	cos_lut[028] = 8'hE1;
	sin_lut[029] = 8'hD3;
	cos_lut[029] = 8'hDF;
	sin_lut[030] = 8'hD5;
	cos_lut[030] = 8'hDD;
	sin_lut[031] = 8'hD7;
	cos_lut[031] = 8'hDB;
	sin_lut[032] = 8'hD9;
	cos_lut[032] = 8'hD9;
	sin_lut[033] = 8'hDC;
	cos_lut[033] = 8'hD7;
	sin_lut[034] = 8'hDE;
	cos_lut[034] = 8'hD4;
	sin_lut[035] = 8'hE0;
	cos_lut[035] = 8'hD2;
	sin_lut[036] = 8'hE2;
	cos_lut[036] = 8'hD0;
	sin_lut[037] = 8'hE4;
	cos_lut[037] = 8'hCD;
	sin_lut[038] = 8'hE6;
	cos_lut[038] = 8'hCB;
	sin_lut[039] = 8'hE8;
	cos_lut[039] = 8'hC8;
	sin_lut[040] = 8'hE9;
	cos_lut[040] = 8'hC5;
	sin_lut[041] = 8'hEB;
	cos_lut[041] = 8'hC3;
	sin_lut[042] = 8'hED;
	cos_lut[042] = 8'hC0;
	sin_lut[043] = 8'hEE;
	cos_lut[043] = 8'hBD;
	sin_lut[044] = 8'hF0;
	cos_lut[044] = 8'hBB;
	sin_lut[045] = 8'hF1;
	cos_lut[045] = 8'hB8;
	sin_lut[046] = 8'hF2;
	cos_lut[046] = 8'hB5;
	sin_lut[047] = 8'hF4;
	cos_lut[047] = 8'hB2;
	sin_lut[048] = 8'hF5;
	cos_lut[048] = 8'hAF;
	sin_lut[049] = 8'hF6;
	cos_lut[049] = 8'hAC;
	sin_lut[050] = 8'hF7;
	cos_lut[050] = 8'hA9;
	sin_lut[051] = 8'hF8;
	cos_lut[051] = 8'hA6;
	sin_lut[052] = 8'hF9;
	cos_lut[052] = 8'hA3;
	sin_lut[053] = 8'hFA;
	cos_lut[053] = 8'hA0;
	sin_lut[054] = 8'hFB;
	cos_lut[054] = 8'h9D;
	sin_lut[055] = 8'hFC;
	cos_lut[055] = 8'h9A;
	sin_lut[056] = 8'hFC;
	cos_lut[056] = 8'h97;
	sin_lut[057] = 8'hFD;
	cos_lut[057] = 8'h94;
	sin_lut[058] = 8'hFD;
	cos_lut[058] = 8'h91;
	sin_lut[059] = 8'hFE;
	cos_lut[059] = 8'h8E;
	sin_lut[060] = 8'hFE;
	cos_lut[060] = 8'h8B;
	sin_lut[061] = 8'hFE;
	cos_lut[061] = 8'h88;
	sin_lut[062] = 8'hFE;
	cos_lut[062] = 8'h84;
	sin_lut[063] = 8'hFE;
	cos_lut[063] = 8'h81;
	sin_lut[064] = 8'hFE;
	cos_lut[064] = 8'h7E;
	sin_lut[065] = 8'hFE;
	cos_lut[065] = 8'h7B;
	sin_lut[066] = 8'hFE;
	cos_lut[066] = 8'h78;
	sin_lut[067] = 8'hFE;
	cos_lut[067] = 8'h75;
	sin_lut[068] = 8'hFE;
	cos_lut[068] = 8'h72;
	sin_lut[069] = 8'hFD;
	cos_lut[069] = 8'h6F;
	sin_lut[070] = 8'hFD;
	cos_lut[070] = 8'h6B;
	sin_lut[071] = 8'hFC;
	cos_lut[071] = 8'h68;
	sin_lut[072] = 8'hFC;
	cos_lut[072] = 8'h65;
	sin_lut[073] = 8'hFB;
	cos_lut[073] = 8'h62;
	sin_lut[074] = 8'hFA;
	cos_lut[074] = 8'h5F;
	sin_lut[075] = 8'hFA;
	cos_lut[075] = 8'h5C;
	sin_lut[076] = 8'hF9;
	cos_lut[076] = 8'h59;
	sin_lut[077] = 8'hF8;
	cos_lut[077] = 8'h56;
	sin_lut[078] = 8'hF7;
	cos_lut[078] = 8'h53;
	sin_lut[079] = 8'hF6;
	cos_lut[079] = 8'h50;
	sin_lut[080] = 8'hF4;
	cos_lut[080] = 8'h4D;
	sin_lut[081] = 8'hF3;
	cos_lut[081] = 8'h4A;
	sin_lut[082] = 8'hF2;
	cos_lut[082] = 8'h48;
	sin_lut[083] = 8'hF0;
	cos_lut[083] = 8'h45;
	sin_lut[084] = 8'hEF;
	cos_lut[084] = 8'h42;
	sin_lut[085] = 8'hED;
	cos_lut[085] = 8'h3F;
	sin_lut[086] = 8'hEC;
	cos_lut[086] = 8'h3D;
	sin_lut[087] = 8'hEA;
	cos_lut[087] = 8'h3A;
	sin_lut[088] = 8'hE8;
	cos_lut[088] = 8'h37;
	sin_lut[089] = 8'hE7;
	cos_lut[089] = 8'h35;
	sin_lut[090] = 8'hE5;
	cos_lut[090] = 8'h32;
	sin_lut[091] = 8'hE3;
	cos_lut[091] = 8'h30;
	sin_lut[092] = 8'hE1;
	cos_lut[092] = 8'h2D;
	sin_lut[093] = 8'hDF;
	cos_lut[093] = 8'h2B;
	sin_lut[094] = 8'hDD;
	cos_lut[094] = 8'h29;
	sin_lut[095] = 8'hDB;
	cos_lut[095] = 8'h26;
	sin_lut[096] = 8'hD8;
	cos_lut[096] = 8'h24;
	sin_lut[097] = 8'hD6;
	cos_lut[097] = 8'h22;
	sin_lut[098] = 8'hD4;
	cos_lut[098] = 8'h20;
	sin_lut[099] = 8'hD1;
	cos_lut[099] = 8'h1E;
	sin_lut[100] = 8'hCF;
	cos_lut[100] = 8'h1C;
	sin_lut[101] = 8'hCC;
	cos_lut[101] = 8'h1A;
	sin_lut[102] = 8'hCA;
	cos_lut[102] = 8'h18;
	sin_lut[103] = 8'hC7;
	cos_lut[103] = 8'h16;
	sin_lut[104] = 8'hC5;
	cos_lut[104] = 8'h14;
	sin_lut[105] = 8'hC2;
	cos_lut[105] = 8'h13;
	sin_lut[106] = 8'hBF;
	cos_lut[106] = 8'h11;
	sin_lut[107] = 8'hBD;
	cos_lut[107] = 8'h0F;
	sin_lut[108] = 8'hBA;
	cos_lut[108] = 8'h0E;
	sin_lut[109] = 8'hB7;
	cos_lut[109] = 8'h0D;
	sin_lut[110] = 8'hB4;
	cos_lut[110] = 8'h0B;
	sin_lut[111] = 8'hB1;
	cos_lut[111] = 8'h0A;
	sin_lut[112] = 8'hAF;
	cos_lut[112] = 8'h09;
	sin_lut[113] = 8'hAC;
	cos_lut[113] = 8'h08;
	sin_lut[114] = 8'hA9;
	cos_lut[114] = 8'h06;
	sin_lut[115] = 8'hA6;
	cos_lut[115] = 8'h05;
	sin_lut[116] = 8'hA3;
	cos_lut[116] = 8'h05;
	sin_lut[117] = 8'hA0;
	cos_lut[117] = 8'h04;
	sin_lut[118] = 8'h9D;
	cos_lut[118] = 8'h03;
	sin_lut[119] = 8'h9A;
	cos_lut[119] = 8'h02;
	sin_lut[120] = 8'h96;
	cos_lut[120] = 8'h02;
	sin_lut[121] = 8'h93;
	cos_lut[121] = 8'h01;
	sin_lut[122] = 8'h90;
	cos_lut[122] = 8'h01;
	sin_lut[123] = 8'h8D;
	cos_lut[123] = 8'h00;
	sin_lut[124] = 8'h8A;
	cos_lut[124] = 8'h00;
	sin_lut[125] = 8'h87;
	cos_lut[125] = 8'h00;
	sin_lut[126] = 8'h84;
	cos_lut[126] = 8'h00;
	sin_lut[127] = 8'h81;
	cos_lut[127] = 8'h00;
	sin_lut[128] = 8'h7D;
	cos_lut[128] = 8'h00;
	sin_lut[129] = 8'h7A;
	cos_lut[129] = 8'h00;
	sin_lut[130] = 8'h77;
	cos_lut[130] = 8'h00;
	sin_lut[131] = 8'h74;
	cos_lut[131] = 8'h00;
	sin_lut[132] = 8'h71;
	cos_lut[132] = 8'h00;
	sin_lut[133] = 8'h6E;
	cos_lut[133] = 8'h01;
	sin_lut[134] = 8'h6B;
	cos_lut[134] = 8'h01;
	sin_lut[135] = 8'h68;
	cos_lut[135] = 8'h02;
	sin_lut[136] = 8'h64;
	cos_lut[136] = 8'h02;
	sin_lut[137] = 8'h61;
	cos_lut[137] = 8'h03;
	sin_lut[138] = 8'h5E;
	cos_lut[138] = 8'h04;
	sin_lut[139] = 8'h5B;
	cos_lut[139] = 8'h05;
	sin_lut[140] = 8'h58;
	cos_lut[140] = 8'h05;
	sin_lut[141] = 8'h55;
	cos_lut[141] = 8'h06;
	sin_lut[142] = 8'h52;
	cos_lut[142] = 8'h08;
	sin_lut[143] = 8'h4F;
	cos_lut[143] = 8'h09;
	sin_lut[144] = 8'h4D;
	cos_lut[144] = 8'h0A;
	sin_lut[145] = 8'h4A;
	cos_lut[145] = 8'h0B;
	sin_lut[146] = 8'h47;
	cos_lut[146] = 8'h0D;
	sin_lut[147] = 8'h44;
	cos_lut[147] = 8'h0E;
	sin_lut[148] = 8'h41;
	cos_lut[148] = 8'h0F;
	sin_lut[149] = 8'h3F;
	cos_lut[149] = 8'h11;
	sin_lut[150] = 8'h3C;
	cos_lut[150] = 8'h13;
	sin_lut[151] = 8'h39;
	cos_lut[151] = 8'h14;
	sin_lut[152] = 8'h37;
	cos_lut[152] = 8'h16;
	sin_lut[153] = 8'h34;
	cos_lut[153] = 8'h18;
	sin_lut[154] = 8'h32;
	cos_lut[154] = 8'h1A;
	sin_lut[155] = 8'h2F;
	cos_lut[155] = 8'h1C;
	sin_lut[156] = 8'h2D;
	cos_lut[156] = 8'h1E;
	sin_lut[157] = 8'h2A;
	cos_lut[157] = 8'h20;
	sin_lut[158] = 8'h28;
	cos_lut[158] = 8'h22;
	sin_lut[159] = 8'h26;
	cos_lut[159] = 8'h24;
	sin_lut[160] = 8'h23;
	cos_lut[160] = 8'h26;
	sin_lut[161] = 8'h21;
	cos_lut[161] = 8'h29;
	sin_lut[162] = 8'h1F;
	cos_lut[162] = 8'h2B;
	sin_lut[163] = 8'h1D;
	cos_lut[163] = 8'h2D;
	sin_lut[164] = 8'h1B;
	cos_lut[164] = 8'h30;
	sin_lut[165] = 8'h19;
	cos_lut[165] = 8'h32;
	sin_lut[166] = 8'h17;
	cos_lut[166] = 8'h35;
	sin_lut[167] = 8'h16;
	cos_lut[167] = 8'h37;
	sin_lut[168] = 8'h14;
	cos_lut[168] = 8'h3A;
	sin_lut[169] = 8'h12;
	cos_lut[169] = 8'h3D;
	sin_lut[170] = 8'h11;
	cos_lut[170] = 8'h3F;
	sin_lut[171] = 8'h0F;
	cos_lut[171] = 8'h42;
	sin_lut[172] = 8'h0E;
	cos_lut[172] = 8'h45;
	sin_lut[173] = 8'h0C;
	cos_lut[173] = 8'h48;
	sin_lut[174] = 8'h0B;
	cos_lut[174] = 8'h4A;
	sin_lut[175] = 8'h0A;
	cos_lut[175] = 8'h4D;
	sin_lut[176] = 8'h08;
	cos_lut[176] = 8'h50;
	sin_lut[177] = 8'h07;
	cos_lut[177] = 8'h53;
	sin_lut[178] = 8'h06;
	cos_lut[178] = 8'h56;
	sin_lut[179] = 8'h05;
	cos_lut[179] = 8'h59;
	sin_lut[180] = 8'h04;
	cos_lut[180] = 8'h5C;
	sin_lut[181] = 8'h04;
	cos_lut[181] = 8'h5F;
	sin_lut[182] = 8'h03;
	cos_lut[182] = 8'h62;
	sin_lut[183] = 8'h02;
	cos_lut[183] = 8'h65;
	sin_lut[184] = 8'h02;
	cos_lut[184] = 8'h68;
	sin_lut[185] = 8'h01;
	cos_lut[185] = 8'h6B;
	sin_lut[186] = 8'h01;
	cos_lut[186] = 8'h6F;
	sin_lut[187] = 8'h00;
	cos_lut[187] = 8'h72;
	sin_lut[188] = 8'h00;
	cos_lut[188] = 8'h75;
	sin_lut[189] = 8'h00;
	cos_lut[189] = 8'h78;
	sin_lut[190] = 8'h00;
	cos_lut[190] = 8'h7B;
	sin_lut[191] = 8'h00;
	cos_lut[191] = 8'h7E;
	sin_lut[192] = 8'h00;
	cos_lut[192] = 8'h81;
	sin_lut[193] = 8'h00;
	cos_lut[193] = 8'h84;
	sin_lut[194] = 8'h00;
	cos_lut[194] = 8'h88;
	sin_lut[195] = 8'h00;
	cos_lut[195] = 8'h8B;
	sin_lut[196] = 8'h00;
	cos_lut[196] = 8'h8E;
	sin_lut[197] = 8'h01;
	cos_lut[197] = 8'h91;
	sin_lut[198] = 8'h01;
	cos_lut[198] = 8'h94;
	sin_lut[199] = 8'h02;
	cos_lut[199] = 8'h97;
	sin_lut[200] = 8'h02;
	cos_lut[200] = 8'h9A;
	sin_lut[201] = 8'h03;
	cos_lut[201] = 8'h9D;
	sin_lut[202] = 8'h04;
	cos_lut[202] = 8'hA0;
	sin_lut[203] = 8'h05;
	cos_lut[203] = 8'hA3;
	sin_lut[204] = 8'h06;
	cos_lut[204] = 8'hA6;
	sin_lut[205] = 8'h07;
	cos_lut[205] = 8'hA9;
	sin_lut[206] = 8'h08;
	cos_lut[206] = 8'hAC;
	sin_lut[207] = 8'h09;
	cos_lut[207] = 8'hAF;
	sin_lut[208] = 8'h0A;
	cos_lut[208] = 8'hB2;
	sin_lut[209] = 8'h0C;
	cos_lut[209] = 8'hB5;
	sin_lut[210] = 8'h0D;
	cos_lut[210] = 8'hB8;
	sin_lut[211] = 8'h0E;
	cos_lut[211] = 8'hBB;
	sin_lut[212] = 8'h10;
	cos_lut[212] = 8'hBD;
	sin_lut[213] = 8'h11;
	cos_lut[213] = 8'hC0;
	sin_lut[214] = 8'h13;
	cos_lut[214] = 8'hC3;
	sin_lut[215] = 8'h15;
	cos_lut[215] = 8'hC5;
	sin_lut[216] = 8'h16;
	cos_lut[216] = 8'hC8;
	sin_lut[217] = 8'h18;
	cos_lut[217] = 8'hCB;
	sin_lut[218] = 8'h1A;
	cos_lut[218] = 8'hCD;
	sin_lut[219] = 8'h1C;
	cos_lut[219] = 8'hD0;
	sin_lut[220] = 8'h1E;
	cos_lut[220] = 8'hD2;
	sin_lut[221] = 8'h20;
	cos_lut[221] = 8'hD4;
	sin_lut[222] = 8'h22;
	cos_lut[222] = 8'hD7;
	sin_lut[223] = 8'h25;
	cos_lut[223] = 8'hD9;
	sin_lut[224] = 8'h27;
	cos_lut[224] = 8'hDB;
	sin_lut[225] = 8'h29;
	cos_lut[225] = 8'hDD;
	sin_lut[226] = 8'h2B;
	cos_lut[226] = 8'hDF;
	sin_lut[227] = 8'h2E;
	cos_lut[227] = 8'hE1;
	sin_lut[228] = 8'h30;
	cos_lut[228] = 8'hE3;
	sin_lut[229] = 8'h33;
	cos_lut[229] = 8'hE5;
	sin_lut[230] = 8'h35;
	cos_lut[230] = 8'hE7;
	sin_lut[231] = 8'h38;
	cos_lut[231] = 8'hE9;
	sin_lut[232] = 8'h3B;
	cos_lut[232] = 8'hEB;
	sin_lut[233] = 8'h3D;
	cos_lut[233] = 8'hEC;
	sin_lut[234] = 8'h40;
	cos_lut[234] = 8'hEE;
	sin_lut[235] = 8'h43;
	cos_lut[235] = 8'hEF;
	sin_lut[236] = 8'h45;
	cos_lut[236] = 8'hF1;
	sin_lut[237] = 8'h48;
	cos_lut[237] = 8'hF2;
	sin_lut[238] = 8'h4B;
	cos_lut[238] = 8'hF3;
	sin_lut[239] = 8'h4E;
	cos_lut[239] = 8'hF5;
	sin_lut[240] = 8'h51;
	cos_lut[240] = 8'hF6;
	sin_lut[241] = 8'h54;
	cos_lut[241] = 8'hF7;
	sin_lut[242] = 8'h57;
	cos_lut[242] = 8'hF8;
	sin_lut[243] = 8'h5A;
	cos_lut[243] = 8'hF9;
	sin_lut[244] = 8'h5D;
	cos_lut[244] = 8'hFA;
	sin_lut[245] = 8'h60;
	cos_lut[245] = 8'hFB;
	sin_lut[246] = 8'h63;
	cos_lut[246] = 8'hFB;
	sin_lut[247] = 8'h66;
	cos_lut[247] = 8'hFC;
	sin_lut[248] = 8'h69;
	cos_lut[248] = 8'hFD;
	sin_lut[249] = 8'h6C;
	cos_lut[249] = 8'hFD;
	sin_lut[250] = 8'h6F;
	cos_lut[250] = 8'hFE;
	sin_lut[251] = 8'h72;
	cos_lut[251] = 8'hFE;
	sin_lut[252] = 8'h76;
	cos_lut[252] = 8'hFE;
	sin_lut[253] = 8'h79;
	cos_lut[253] = 8'hFE;
	sin_lut[254] = 8'h7C;
	cos_lut[254] = 8'hFE;
	sin_lut[255] = 8'h7F;
	cos_lut[255] = 8'hFE;
end 

always @(sval,cval)
    begin
        sin<=sin_lut[sval];
        cos<=cos_lut[cval];
    end
endmodule
