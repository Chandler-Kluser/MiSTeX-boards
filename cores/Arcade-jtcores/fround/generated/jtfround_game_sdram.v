// jtfround_game_sdram.v is automatically generated by JTFRAME
// Do not modify it
// Do not add it to git

`ifndef JTFRAME_COLORW
`define JTFRAME_COLORW 4
`endif

`ifndef JTFRAME_BUTTONS
`define JTFRAME_BUTTONS 2
`endif

module jtfround_game_sdram(
    `include "jtframe_common_ports.inc"
    `include "jtframe_mem_ports.inc"
);

/* verilator lint_off WIDTH */
localparam [25:0] BA1_START  =`ifdef JTFRAME_BA1_START  `JTFRAME_BA1_START  `else 26'd0 `endif;
localparam [25:0] BA2_START  =`ifdef JTFRAME_BA2_START  `JTFRAME_BA2_START  `else 26'd0 `endif;
localparam [25:0] BA3_START  =`ifdef JTFRAME_BA3_START  `JTFRAME_BA3_START  `else 26'd0 `endif;
localparam [25:0] PROM_START =`ifdef JTFRAME_PROM_START `JTFRAME_PROM_START `else 26'd0 `endif;
localparam [25:0] HEADER_LEN =`ifdef JTFRAME_HEADER     `JTFRAME_HEADER     `else 26'd0 `endif;
/* verilator lint_on WIDTH */


parameter PCM_OFFSET = (`PCM_START-`JTFRAME_BA1_START) >> 1;
parameter UPD_OFFSET = (`UPD_START-`JTFRAME_BA1_START) >> 1;
parameter SCR_OFFSET = (`SCR_START-`JTFRAME_BA2_START) >> 1;
parameter RAM_OFFSET = 22'h100000;

`ifndef JTFRAME_IOCTL_RD
wire ioctl_ram = 0;
`endif
// Audio channels 
wire signed [15:0] fm_l, fm_r;
wire signed [11:0] pcm;
wire signed [ 8:0] upd;
wire mute;
// Additional ports
wire [11:1] fram_addr;
wire [1:0] vb_we;
wire [1:0] oram_we;
wire [7:0] pal_dout;
wire [12:1] vram_addr;
wire [15:0] mb_dout;
wire [1:0] obj_we;
wire [15:0] mo_dout;
wire [15:0] fram_dout;
wire [15:0] mf_dout;
wire [12:1] scra_addr;
wire [15:0] scra_dout;
wire [15:0] ma_dout;
wire [15:0] scrb_dout;
wire [13:1] oram_addr;
wire [11:0] pal_addr;
wire [1:0] fx_we;
wire [1:0] va_we;
wire [12:1] scrb_addr;
wire [15:0] oram_din;
wire [15:0] oram_dout;
wire  pal_we;
wire [7:0] mp_dout;

// BRAM buses










// SDRAM buses

wire [13:1] ram_addr;
wire [15:0] ram_data;
wire        ram_cs, ram_ok;
wire        ram_we;
wire [15:0] ram_din;
wire [ 1:0] ram_dsn;

wire [18:1] main_addr;
wire [15:0] main_data;
wire        main_cs, main_ok;
wire [14:0] snd_addr;
wire [ 7:0] snd_data;
wire        snd_cs, snd_ok;
wire [20:0] pcma_addr;
wire [ 7:0] pcma_data;
wire        pcma_cs, pcma_ok;
wire [20:0] pcmb_addr;
wire [ 7:0] pcmb_data;
wire        pcmb_cs, pcmb_ok;
wire [16:0] upd_addr;
wire [ 7:0] upd_data;
wire        upd_cs, upd_ok;
wire [13:2] lyrf_addr;
wire [31:0] lyrf_data;
wire        lyrf_cs, lyrf_ok;
wire [19:2] lyra_addr;
wire [31:0] lyra_data;
wire        lyra_cs, lyra_ok;
wire [19:2] lyrb_addr;
wire [31:0] lyrb_data;
wire        lyrb_cs, lyrb_ok;
wire [19:2] lyro_addr;
wire [31:0] lyro_data;
wire        lyro_cs, lyro_ok;
wire        prom_we, header;
wire [21:0] raw_addr, post_addr;
wire [25:0] pre_addr, dwnld_addr, ioctl_addr_noheader;
wire [ 7:0] post_data;
wire [15:0] raw_data;
wire        pass_io;
// Clock enable signals
wire cen_fm; 
wire cen_fm2; 
wire cen_640; 
wire cen_320; 
wire gfx8_en, gfx16_en, ioctl_dwn;

assign pass_io = header | ioctl_ram;
assign ioctl_addr_noheader = `ifdef JTFRAME_HEADER header ? ioctl_addr : ioctl_addr - HEADER_LEN `else ioctl_addr `endif ;

wire rst_h, rst24_h, rst48_h, hold_rst;
/* verilator tracing_off */
jtframe_rsthold u_hold(
    .rst    ( rst       ),
    .clk    ( clk       ),
    .hold   ( hold_rst  ),
    .rst_h  ( rst_h     )
`ifdef JTFRAME_CLK24 ,
    .rst24  ( rst24     ),
    .clk24  ( clk24     ),
    .rst24_h( rst24_h   )
`endif
`ifdef JTFRAME_CLK48 ,
    .rst48  ( rst48     ),
    .clk48  ( clk48     ),
    .rst48_h( rst48_h   )
`endif
);
/* verilator tracing_on */
jtfround_game u_game(
    .rst        ( rst_h     ),
    .clk        ( clk       ),
`ifdef JTFRAME_CLK24
    .rst24      ( rst24_h   ),
    .clk24      ( clk24     ),
`endif
`ifdef JTFRAME_CLK48
    .rst48      ( rst48_h   ),
    .clk48      ( clk48     ),
`endif
    // Audio channels
    .fm_l   ( fm_l    ),
    .fm_r   ( fm_r    ),.pcm     ( pcm      ),.upd     ( upd      ),
    
    .snd_en         ( snd_en        ),
    .cen_fm    ( cen_fm    ), 
    .cen_fm2    ( cen_fm2    ), 
    .cen_640    ( cen_640    ), 
    .cen_320    ( cen_320    ), 

    .pxl2_cen       ( pxl2_cen      ),
    .pxl_cen        ( pxl_cen       ),
    .red            ( red           ),
    .green          ( green         ),
    .blue           ( blue          ),
    .LHBL           ( LHBL          ),
    .LVBL           ( LVBL          ),
    .HS             ( HS            ),
    .VS             ( VS            ),
    // cabinet I/O
    .cab_1p   ( cab_1p  ),
    .coin     ( coin    ),
    .joystick1    ( joystick1        ), .joystick2    ( joystick2        ), `ifdef JTFRAME_4PLAYERS
    .joystick3    ( joystick3        ), .joystick4    ( joystick4        ), `endif `ifdef JTFRAME_MOUSE
    .mouse_1p     ( mouse_1p         ), .mouse_2p     ( mouse_2p         ), `endif `ifdef JTFRAME_SPINNER
    .spinner_1p   ( spinner_1p       ), .spinner_2p   ( spinner_2p       ), `endif `ifdef JTFRAME_ANALOG
    .joyana_l1    ( joyana_l1        ), .joyana_l2    ( joyana_l2        ), `ifdef JTFRAME_ANALOG_DUAL
    .joyana_r1    ( joyana_r1        ), .joyana_r2    ( joyana_r2        ), `endif `ifdef JTFRAME_4PLAYERS
    .joyana_l3    ( joyana_l3        ), .joyana_l4    ( joyana_l4        ), `ifdef JTFRAME_ANALOG_DUAL
    .joyana_r3    ( joyana_r3        ), .joyana_r4    ( joyana_r4        ), `endif `endif `endif `ifdef JTFRAME_DIAL
    .dial_x       ( dial_x           ), .dial_y       ( dial_y           ), `endif
    // DIP switches
    .status         ( status        ),
    .dipsw          ( dipsw         ),
    .service        ( service       ),
    .tilt           ( tilt          ),
    .dip_pause      ( dip_pause     ),
    .dip_flip       ( dip_flip      ),
    .dip_test       ( dip_test      ),
    .dip_fxlevel    ( dip_fxlevel   ),
    .enable_psg     ( enable_psg    ),
    .enable_fm      ( enable_fm     ),
    // Ports declared in mem.yaml
    .fram_addr   ( fram_addr ),
    .vb_we   ( vb_we ),
    .oram_we   ( oram_we ),
    .pal_dout   ( pal_dout ),
    .vram_addr   ( vram_addr ),
    .mb_dout   ( mb_dout ),
    .obj_we   ( obj_we ),
    .mo_dout   ( mo_dout ),
    .fram_dout   ( fram_dout ),
    .mf_dout   ( mf_dout ),
    .scra_addr   ( scra_addr ),
    .scra_dout   ( scra_dout ),
    .ma_dout   ( ma_dout ),
    .scrb_dout   ( scrb_dout ),
    .oram_addr   ( oram_addr ),
    .pal_addr   ( pal_addr ),
    .fx_we   ( fx_we ),
    .va_we   ( va_we ),
    .scrb_addr   ( scrb_addr ),
    .oram_din   ( oram_din ),
    .oram_dout   ( oram_dout ),
    .pal_we   ( pal_we ),
    .mp_dout   ( mp_dout ),
    // Memory interface - SDRAM
    .ram_addr ( ram_addr ),
    .ram_cs   ( ram_cs   ),
    .ram_ok   ( ram_ok   ),
    .ram_data ( ram_data ),
    .ram_we   ( ram_we   ),
    .ram_dsn  ( ram_dsn  ),
    .ram_din  ( ram_din  ),
    
    .main_addr ( main_addr ),
    .main_cs   ( main_cs   ),
    .main_ok   ( main_ok   ),
    .main_data ( main_data ),
    
    .snd_addr ( snd_addr ),
    .snd_cs   ( snd_cs   ),
    .snd_ok   ( snd_ok   ),
    .snd_data ( snd_data ),
    
    .pcma_addr ( pcma_addr ),
    .pcma_cs   ( pcma_cs   ),
    .pcma_ok   ( pcma_ok   ),
    .pcma_data ( pcma_data ),
    
    .pcmb_addr ( pcmb_addr ),
    .pcmb_cs   ( pcmb_cs   ),
    .pcmb_ok   ( pcmb_ok   ),
    .pcmb_data ( pcmb_data ),
    
    .upd_addr ( upd_addr ),
    .upd_cs   ( upd_cs   ),
    .upd_ok   ( upd_ok   ),
    .upd_data ( upd_data ),
    
    .lyrf_addr ( lyrf_addr ),
    .lyrf_cs   ( lyrf_cs   ),
    .lyrf_ok   ( lyrf_ok   ),
    .lyrf_data ( lyrf_data ),
    
    .lyra_addr ( lyra_addr ),
    .lyra_cs   ( lyra_cs   ),
    .lyra_ok   ( lyra_ok   ),
    .lyra_data ( lyra_data ),
    
    .lyrb_addr ( lyrb_addr ),
    .lyrb_cs   ( lyrb_cs   ),
    .lyrb_ok   ( lyrb_ok   ),
    .lyrb_data ( lyrb_data ),
    
    .lyro_addr ( lyro_addr ),
    .lyro_cs   ( lyro_cs   ),
    .lyro_ok   ( lyro_ok   ),
    .lyro_data ( lyro_data ),
    
    // Memory interface - BRAM

    
    
    
    
    
    
    
    
    
    
    
    // PROM writting
    .ioctl_addr   ( pass_io ? ioctl_addr       : ioctl_addr_noheader  ),
    .prog_addr    ( pass_io ? ioctl_addr[21:0] : raw_addr      ),
    .prog_data    ( pass_io ? ioctl_dout       : raw_data[7:0] ),
    .prog_we      ( pass_io ? ioctl_wr         : prog_we       ),
    .prog_ba      ( prog_ba        ), // prog_ba supplied in case it helps re-mapping addresses
`ifdef JTFRAME_PROM_START
    .prom_we      ( prom_we        ),
`endif
`ifdef JTFRAME_HEADER
    .header       ( header         ),
`endif
`ifdef JTFRAME_IOCTL_RD
    .ioctl_ram    ( ioctl_ram      ),
    .ioctl_din    ( ioctl_aux      ),
    .ioctl_dout   ( ioctl_dout     ),
    .ioctl_wr     ( ioctl_wr       ), `endif
    .ioctl_cart   ( ioctl_cart     ),
    // Debug
    .debug_bus    ( debug_bus      ),
    .debug_view   ( debug_view     ),
`ifdef JTFRAME_STATUS
    .st_addr      ( st_addr        ),
    .st_dout      ( st_dout        ),
`endif
`ifdef JTFRAME_LF_BUFFER
    .game_vrender( game_vrender  ),
    .game_hdump  ( game_hdump    ),
    .ln_addr     ( ln_addr       ),
    .ln_data     ( ln_data       ),
    .ln_done     ( ln_done       ),
    .ln_hs       ( ln_hs         ),
    .ln_pxl      ( ln_pxl        ),
    .ln_v        ( ln_v          ),
    .ln_we       ( ln_we         ),
`endif
    .gfx_en      ( gfx_en        )
);
/* verilator tracing_off */
assign dwnld_busy = ioctl_rom | prom_we; // prom_we is really just for sims
assign dwnld_addr = ioctl_addr;
assign prog_addr = raw_addr;
assign prog_data = raw_data;
assign gfx8_en   = 0;
assign gfx16_en  = 0;
assign ioctl_dwn = ioctl_rom | ioctl_cart;
`ifdef VERILATOR_KEEP_SDRAM /* verilator tracing_on */ `else /* verilator tracing_off */ `endif
jtframe_dwnld #(
`ifdef JTFRAME_HEADER
    .HEADER    ( `JTFRAME_HEADER   ),
`endif
`ifdef JTFRAME_BA1_START
    .BA1_START ( BA1_START ),
`endif
`ifdef JTFRAME_BA2_START
    .BA2_START ( BA2_START ),
`endif
`ifdef JTFRAME_BA3_START
    .BA3_START ( BA3_START ),
`endif
`ifdef JTFRAME_PROM_START
    .PROM_START( PROM_START ),
`endif
    .SWAB      ( 1),
    .GFX8B0    ( 0),
    .GFX16B0   ( 0)
) u_dwnld(
    .clk          ( clk            ),
    .ioctl_rom    ( ioctl_dwn      ),
    .ioctl_addr   ( dwnld_addr     ),
    .ioctl_dout   ( ioctl_dout     ),
    .ioctl_wr     ( ioctl_wr       ),
    .gfx8_en      ( gfx8_en        ),
    .gfx16_en     ( gfx16_en       ),
    .prog_addr    ( raw_addr       ),
    .prog_data    ( raw_data       ),
    .prog_mask    ( prog_mask      ), // active low
    .prog_we      ( prog_we        ),
    .prog_rd      ( prog_rd        ),
    .prog_ba      ( prog_ba        ),
    .prom_we      ( prom_we        ),
    .header       ( header         ),
    .sdram_ack    ( prog_ack       )
);
`ifdef VERILATOR_KEEP_SDRAM /* verilator tracing_on */ `else /* verilator tracing_off */ `endif



jtframe_ram1_2slots #(
    // ram
    .SLOT0_AW(13),
    .SLOT0_DW(16), 
    // main
    .SLOT1_AW(18),
    .SLOT1_DW(16)
`ifdef JTFRAME_BA2_LEN
    ,.SLOT1_DOUBLE(1)
`endif
) u_bank0(
    .rst         ( rst        ),
    .clk         ( clk        ),
    
    .slot0_addr  ( ram_addr  ),
    .hold_rst    ( hold_rst        ), 
    .slot0_wen   ( ram_we    ),
    .slot0_din   ( ram_din   ),
    .slot0_wrmask( ram_dsn   ),
    .slot0_offset( RAM_OFFSET[21:0] ),
    .slot0_dout  ( ram_data  ),
    .slot0_cs    ( ram_cs    ),
    .slot0_ok    ( ram_ok    ),
    
    .slot1_addr  ( main_addr  ),
    .slot1_clr   ( 1'b0       ), // only 1'b0 supported in mem.yaml
    .slot1_dout  ( main_data  ),
    .slot1_cs    ( main_cs    ),
    .slot1_ok    ( main_ok    ),
    
    // SDRAM controller interface
    .sdram_ack   ( ba_ack[0]  ),
    .sdram_rd    ( ba_rd[0]   ),
    .sdram_addr  ( ba0_addr   ),
    .sdram_wr    ( ba_wr[0]   ),
    .sdram_wrmask( ba0_dsn    ),
    .data_write  ( ba0_din    ),
    .data_dst    ( ba_dst[0]  ),
    .data_rdy    ( ba_rdy[0]  ),
    .data_read   ( data_read  )
);
jtframe_rom_4slots #(
    // snd
    .SLOT0_AW(15),
    .SLOT0_DW( 8), 
    // pcma
    .SLOT1_OFFSET(PCM_OFFSET[21:0]),
    .SLOT1_AW(21),
    .SLOT1_DW( 8), 
    // pcmb
    .SLOT2_OFFSET(PCM_OFFSET[21:0]),
    .SLOT2_AW(21),
    .SLOT2_DW( 8), 
    // upd
    .SLOT3_OFFSET(UPD_OFFSET[21:0]),
    .SLOT3_AW(17),
    .SLOT3_DW( 8)
`ifdef JTFRAME_BA2_LEN
    ,.SLOT0_DOUBLE(1)
    ,.SLOT1_DOUBLE(1)
    ,.SLOT2_DOUBLE(1)
    ,.SLOT3_DOUBLE(1)
`endif
) u_bank1(
    .rst         ( rst        ),
    .clk         ( clk        ),
    
    .slot0_addr  ( snd_addr  ),
    .slot0_dout  ( snd_data  ),
    .slot0_cs    ( snd_cs    ),
    .slot0_ok    ( snd_ok    ),
    
    .slot1_addr  ( pcma_addr  ),
    .slot1_dout  ( pcma_data  ),
    .slot1_cs    ( pcma_cs    ),
    .slot1_ok    ( pcma_ok    ),
    
    .slot2_addr  ( pcmb_addr  ),
    .slot2_dout  ( pcmb_data  ),
    .slot2_cs    ( pcmb_cs    ),
    .slot2_ok    ( pcmb_ok    ),
    
    .slot3_addr  ( upd_addr  ),
    .slot3_dout  ( upd_data  ),
    .slot3_cs    ( upd_cs    ),
    .slot3_ok    ( upd_ok    ),
    
    // SDRAM controller interface
    .sdram_ack   ( ba_ack[1]  ),
    .sdram_rd    ( ba_rd[1]   ),
    .sdram_addr  ( ba1_addr   ),
    .data_dst    ( ba_dst[1]  ),
    .data_rdy    ( ba_rdy[1]  ),
    .data_read   ( data_read  )
);
assign ba_wr[1] = 0;
assign ba1_din  = 0;
assign ba1_dsn  = 3;
jtframe_rom_3slots #(
    // lyrf
    .SLOT0_AW(13),
    .SLOT0_DW(32), 
    // lyra
    .SLOT1_OFFSET(SCR_OFFSET[21:0]),
    .SLOT1_AW(19),
    .SLOT1_DW(32), 
    // lyrb
    .SLOT2_OFFSET(SCR_OFFSET[21:0]),
    .SLOT2_AW(19),
    .SLOT2_DW(32)
`ifdef JTFRAME_BA2_LEN
    ,.SLOT0_DOUBLE(1)
    ,.SLOT1_DOUBLE(1)
    ,.SLOT2_DOUBLE(1)
`endif
) u_bank2(
    .rst         ( rst        ),
    .clk         ( clk        ),
    
    .slot0_addr  ( { lyrf_addr, 1'b0 } ),
    .slot0_dout  ( lyrf_data  ),
    .slot0_cs    ( lyrf_cs    ),
    .slot0_ok    ( lyrf_ok    ),
    
    .slot1_addr  ( { lyra_addr, 1'b0 } ),
    .slot1_dout  ( lyra_data  ),
    .slot1_cs    ( lyra_cs    ),
    .slot1_ok    ( lyra_ok    ),
    
    .slot2_addr  ( { lyrb_addr, 1'b0 } ),
    .slot2_dout  ( lyrb_data  ),
    .slot2_cs    ( lyrb_cs    ),
    .slot2_ok    ( lyrb_ok    ),
    
    // SDRAM controller interface
    .sdram_ack   ( ba_ack[2]  ),
    .sdram_rd    ( ba_rd[2]   ),
    .sdram_addr  ( ba2_addr   ),
    .data_dst    ( ba_dst[2]  ),
    .data_rdy    ( ba_rdy[2]  ),
    .data_read   ( data_read  )
);
assign ba_wr[2] = 0;
assign ba2_din  = 0;
assign ba2_dsn  = 3;
jtframe_rom_1slot #(
    // lyro
    .SLOT0_AW(19),
    .SLOT0_DW(32)
`ifdef JTFRAME_BA2_LEN
    ,.SLOT0_DOUBLE(1)
`endif
) u_bank3(
    .rst         ( rst        ),
    .clk         ( clk        ),
    
    .slot0_addr  ( { lyro_addr, 1'b0 } ),
    .slot0_dout  ( lyro_data  ),
    .slot0_cs    ( lyro_cs    ),
    .slot0_ok    ( lyro_ok    ),
    
    // SDRAM controller interface
    .sdram_ack   ( ba_ack[3]  ),
    .sdram_rd    ( ba_rd[3]   ),
    .sdram_addr  ( ba3_addr   ),
    .data_dst    ( ba_dst[3]  ),
    .data_rdy    ( ba_rdy[3]  ),
    .data_read   ( data_read  )
);
assign ba_wr[3] = 0;
assign ba3_din  = 0;
assign ba3_dsn  = 3;


// Dual port BRAM for fram and main
jtframe_dual_ram16 #(
    .AW(12-1),
    .SIMFILE_LO("fram_lo.bin"),
    .SIMFILE_HI("fram_hi.bin")
) u_bram_fram(
    // Port 0 - fram
    .clk0   ( clk ),
    .addr0  ( fram_amux ),
    .data0  ( 16'h0 ),
    .we0    ( 2'd0 ),
    .q0     ( fram_dout ),
    // Port 1 - main
    .clk1   ( clk ),
    .data1  ( ram_din ),
    .addr1  ( main_addr[11:1] ),
    .we1    ( fx_we  ), 
    .q1     ( mf_dout )
);
// Dual port BRAM for scra and vram
jtframe_dual_ram16 #(
    .AW(13-1),
    .SIMFILE_LO("scra_lo.bin"),
    .SIMFILE_HI("scra_hi.bin")
) u_bram_scra(
    // Port 0 - scra
    .clk0   ( clk ),
    .addr0  ( scra_amux ),
    .data0  ( 16'h0 ),
    .we0    ( 2'd0 ),
    .q0     ( scra_dout ),
    // Port 1 - vram
    .clk1   ( clk ),
    .data1  ( ram_din ),
    .addr1  ( vram_addr[12:1] ),
    .we1    ( va_we  ), 
    .q1     ( ma_dout )
);
// Dual port BRAM for scrb and vram
jtframe_dual_ram16 #(
    .AW(13-1),
    .SIMFILE_LO("scrb_lo.bin"),
    .SIMFILE_HI("scrb_hi.bin")
) u_bram_scrb(
    // Port 0 - scrb
    .clk0   ( clk ),
    .addr0  ( scrb_amux ),
    .data0  ( 16'h0 ),
    .we0    ( 2'd0 ),
    .q0     ( scrb_dout ),
    // Port 1 - vram
    .clk1   ( clk ),
    .data1  ( ram_din ),
    .addr1  ( vram_addr[12:1] ),
    .we1    ( vb_we  ), 
    .q1     ( mb_dout )
);
// Dual port BRAM for oram and main
jtframe_dual_ram16 #(
    .AW(14-1),
    .SIMFILE_LO("oram_lo.bin"),
    .SIMFILE_HI("oram_hi.bin")
) u_bram_oram(
    // Port 0 - oram
    .clk0   ( clk ),
    .addr0  ( oram_amux ),
    .data0  ( oram_din  ),
    .we0    (  oram_we ), 
    .q0     ( oram_dout ),
    // Port 1 - main
    .clk1   ( clk ),
    .data1  ( ram_din ),
    .addr1  ( main_addr[13:1] ),
    .we1    ( obj_we  ), 
    .q1     ( mo_dout )
);
// Dual port BRAM for pal and main
jtframe_dual_ram #(
    .AW(12),
    .SIMFILE("pal.bin")
) u_bram_pal(
    // Port 0 - pal
    .clk0   ( clk ),
    .addr0  ( pal_amux ),
    .data0  ( 8'h0 ),
    .we0    ( 1'd0 ),
    .q0     ( pal_dout ),
    // Port 1 - main
    .clk1   ( clk ),
    .data1  ( ram_din[7:0] ),
    .addr1  ( main_addr[12:1] ),
    .we1    ( pal_we  ), 
    .q1     ( mp_dout )
);
/* verilator tracing_off */
wire [7:0] ioctl_aux;
wire [16-1:0] fram_dimx;
wire [  1:0] fram_wemx;
wire [12-1:1] fram_amux;
wire [16-1:0] scra_dimx;
wire [  1:0] scra_wemx;
wire [13-1:1] scra_amux;
wire [16-1:0] scrb_dimx;
wire [  1:0] scrb_wemx;
wire [13-1:1] scrb_amux;
wire [16-1:0] oram_dimx;
wire [  1:0] oram_wemx;
wire [14-1:1] oram_amux;
wire [8-1:0] pal_dimx;
wire [  1:0] pal_wemx;
wire [12-1:0] pal_amux;

jtframe_ioctl_dump #(
    .DW0( 16 ), .AW0( 12 ),
    .DW1( 16 ), .AW1( 13 ),
    .DW2( 16 ), .AW2( 13 ),
    .DW3( 16 ), .AW3( 14 ),
    .DW4( 8 ), .AW4( 12 ),
    .DW5( 8 ), .AW5( 0 )
) u_dump (
    .clk       ( clk        ),
    // dump 0
    .dout0        ( fram_dout ),
    .addr0        ( fram_addr ),
    .addr0_mx     ( fram_amux ),
    // restore
    .din0         (  ),
    .din0_mx      ( fram_dimx ),
    .we0          ( 2'b0),
    .we0_mx       ( fram_wemx ),
    
    // dump 1
    .dout1        ( scra_dout ),
    .addr1        ( scra_addr ),
    .addr1_mx     ( scra_amux ),
    // restore
    .din1         (  ),
    .din1_mx      ( scra_dimx ),
    .we1          ( 2'b0),
    .we1_mx       ( scra_wemx ),
    
    // dump 2
    .dout2        ( scrb_dout ),
    .addr2        ( scrb_addr ),
    .addr2_mx     ( scrb_amux ),
    // restore
    .din2         (  ),
    .din2_mx      ( scrb_dimx ),
    .we2          ( 2'b0),
    .we2_mx       ( scrb_wemx ),
    
    // dump 3
    .dout3        ( oram_dout ),
    .addr3        ( oram_addr ),
    .addr3_mx     ( oram_amux ),
    // restore
    .din3         ( oram_din ),
    .din3_mx      ( oram_dimx ),
    .we3          ( 2'b0),
    .we3_mx       ( oram_wemx ),
    
    // dump 4
    .dout4        ( pal_dout ),
    .addr4        ( pal_addr ),
    .addr4_mx     ( pal_amux ),
    // restore
    .din4         (  ),
    .din4_mx      ( pal_dimx ),
    .we4          ( { 1'b0,1'b0 }),
    .we4_mx       ( pal_wemx ),
    
    // dump 5
    .dout5        ( 8'd0 ),
    .addr5        ( 1'b0 ),
    .addr5_mx     (  ),
    // restore
    .din5         (  ),
    .din5_mx      (  ),
    .we5          ( { 1'b0,1'b0 }),
    .we5_mx       (  ),
    
    .ioctl_addr ( ioctl_addr[23:0] ),
    .ioctl_ram  ( ioctl_ram ),
    .ioctl_aux  ( ioctl_aux ),
    .ioctl_wr   ( ioctl_wr  ),
    .ioctl_din  ( ioctl_din ),
    .ioctl_dout ( ioctl_dout)
);



// Clock enable generation
// 3579545 = 49153840*455/6248 Hz from clk
`ifdef VERILATOR_KEEP_CEN /* verilator tracing_on */ `else /* verilator tracing_off */ `endif
jtframe_gated_cen #(.W(2),.NUM(455),.DEN(6248),.MFREQ(49153)) u_cen0_clk(
    .rst    ( rst          ),
    .clk    ( clk ),
    .busy   ( 1'b0    ),
    .cen    ( { cen_fm2, cen_fm } ),
    .fave   (              ),
    .fworst (              )
); /* verilator tracing_off */

// 640000 = 49153840*487/37403 Hz from clk
`ifdef VERILATOR_KEEP_CEN /* verilator tracing_on */ `else /* verilator tracing_off */ `endif
jtframe_gated_cen #(.W(2),.NUM(487),.DEN(37403),.MFREQ(49153)) u_cen1_clk(
    .rst    ( rst          ),
    .clk    ( clk ),
    .busy   ( 1'b0    ),
    .cen    ( { cen_320, cen_640 } ),
    .fave   (              ),
    .fworst (              )
); /* verilator tracing_off */

`ifndef NOSOUND/* verilator tracing_on */
assign mute=0;
jtframe_rcmix #(
    .W0(16),
    .W1(12),
    .W2(9),
    .FIR2("fir_192k_4k.hex"),
    .STEREO0( 1),
    .STEREO1( 0),
    .STEREO2( 0),
    .STEREO3( 0),
    .STEREO4( 0),
    .STEREO5( 0),
    .DCRM0  ( 0),
    .DCRM1  ( 0),
    .DCRM2  ( 0),
    .DCRM3  ( 0),
    .DCRM4  ( 0),
    .DCRM5  ( 0),
    .STEREO ( 0),
    // Fractional cen for 192kHz
    .FRACW( 17), .FRACN(209), .FRACM(53506)
) u_rcmix(
    .rst    ( rst       ),
    .clk    ( clk       ),
    .mute   ( mute      ),
    .sample ( sample    ),
    .ch_en  ( snd_en    ),
    .gpole  ( 8'h86 ),  // 19894 Hz 
    .ch0    ( { fm_l,fm_r } ),
    .ch1    ( pcm ),
    .ch2    ( upd ),
    .ch3    ( 16'd0 ),
    .ch4    ( 16'd0 ),
    .ch5    ( 16'd0 ),
    .p0     ( 16'hCAB2), // 11130 Hz, 7242 Hz 
    .p1     ( 16'h00E9), // 2822 Hz, 0 Hz 
    .p2     ( 16'h00), // 0 Hz, 0 Hz 
    .p3     ( 16'h0), 
    .p4     ( 16'h0), 
    .p5     ( 16'h0), 
    .g0     ( 8'h20 ), // fm
    .g1     ( 8'h1E ), // pcm
    .g2     ( 8'h0B ), // upd
    .g3     ( 8'h00 ), 
    .g4     ( 8'h00 ), 
    .g5     ( 8'h00 ), 
    .mixed(snd),
    .peak ( game_led ),
    .vu   ( snd_vu   )
);
`else
assign snd=0;
assign snd_vu   = 0;
assign game_led = 0;
wire ncs;
jtframe_frac_cen #(.WC(17)) u_cen192(
    .clk    ( clk       ),
    .n      ( 209 ),
    .m      ( 53506 ),
    .cen    ( {  ncs,sample }  ), // sample is always 192 kHz
    .cenb   (                  )
);
`endif
endmodule