//-----------------------------------------------------------------------------
//
// (c) Copyright 2012-2012 Xilinx, Inc. All rights reserved.
//
// This file contains confidential and proprietary information
// of Xilinx, Inc. and is protected under U.S. and
// international copyright and other intellectual property
// laws.
//
// DISCLAIMER
// This disclaimer is not a license and does not grant any
// rights to the materials distributed herewith. Except as
// otherwise provided in a valid license issued to you by
// Xilinx, and to the maximum extent permitted by applicable
// law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
// WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
// AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
// BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
// INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
// (2) Xilinx shall not be liable (whether in contract or tort,
// including negligence, or under any other theory of
// liability) for any loss or damage of any kind or nature
// related to, arising under or in connection with these
// materials, including for any direct, or any indirect,
// special, incidental, or consequential loss or damage
// (including loss of data, profits, goodwill, or any type of
// loss or damage suffered as a result of any action brought
// by a third party) even if such damage or loss was
// reasonably foreseeable or Xilinx had been advised of the
// possibility of the same.
//
// CRITICAL APPLICATIONS
// Xilinx products are not designed or intended to be fail-
// safe, or for use in any application requiring fail-safe
// performance, such as life-support or safety devices or
// systems, Class III medical devices, nuclear facilities,
// applications related to the deployment of airbags, or any
// other applications that could lead to death, personal
// injury, or severe property or environmental damage
// (individually and collectively, "Critical
// Applications"). Customer assumes the sole risk and
// liability of any use of Xilinx products in Critical
// Applications, subject only to applicable laws and
// regulations governing limitations on product liability.
//
// THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
// PART OF THIS FILE AT ALL TIMES.
//
//-----------------------------------------------------------------------------
//
// Project    : The Xilinx PCI Express DMA 
// File       : board.v
// Version    : 4.1
//-----------------------------------------------------------------------------
//-----------------------------------------------------------------------------
//
// Project    : Ultrascale FPGA Gen3 Integrated Block for PCI Express
// File       : board.v
// Version    : 4.0 
//-----------------------------------------------------------------------------
//-----------------------------------------------------------------------------
//
// Description: Top level testbench
//
//------------------------------------------------------------------------------

`timescale 1ps/1ps

`include "board_common.vh"

`define SIMULATION

module board;

  parameter          REF_CLK_FREQ       = 0 ;      // 0 - 100 MHz, 1 - 125 MHz,  2 - 250 MHz

  parameter C_DATA_WIDTH                        = 512 ;
  parameter          DRP_CLK_FREQ       = 0; // 0 - 100 MHz, 1 - 125 MHz, 3 - 300 MHz
//
  localparam         DRP_CLK_HALF_CYCLE = (DRP_CLK_FREQ == 0) ? 5000 :
                                          (DRP_CLK_FREQ == 1) ? 4000 :
                                          (DRP_CLK_FREQ == 2) ? 2000 : 
                                          (DRP_CLK_FREQ == 3) ? 1666 : 0;



  localparam         REF_CLK_HALF_CYCLE = (REF_CLK_FREQ == 0) ? 5000 :
                                          (REF_CLK_FREQ == 1) ? 4000 :
                                          (REF_CLK_FREQ == 2) ? 2000 : 0;

  localparam					TX_CLK_HALF_CYCLE = 5000;
	localparam					GT_REF_HALF_CYCLE = 3103.030;
  localparam 					pclk_cycle = 10000;

  localparam   [2:0] PF0_DEV_CAP_MAX_PAYLOAD_SIZE = 3'b011;
  `ifdef LINKWIDTH
  localparam   [4:0] LINK_WIDTH = 5'd`LINKWIDTH;
  `else
  localparam   [4:0] LINK_WIDTH = 5'd8;
  `endif
  `ifdef LINKSPEED
  localparam   [2:0] LINK_SPEED = 3'h`LINKSPEED;
  `else
  localparam   [2:0] LINK_SPEED = 3'h8;
  `endif

    //////////// axi_reg_map address
    parameter  ADDR_CORE_VERSION_REG                    =  32'h00000000;
    ///// For PORT-0
    parameter  ADDR_RESET_REG_0                         =  32'h00000004;
    parameter  ADDR_MODE_REG_0                          =  32'h00000008;
    parameter  ADDR_CONFIG_TX_REG1_0                    =  32'h0000000C;
    parameter  ADDR_CONFIG_RX_REG1_0                    =  32'h00000010;
    parameter  ADDR_TICK_REG_0                          =  32'h0000002C;
    parameter  ADDR_FEC_CONFIGURATION_REG1_0            =  32'h000000D0;
	parameter  ADDR_STAT_RX_STATUS_REG1_0               =  32'h00000744;
	parameter  ADDR_STAT_RX_RT_STATUS_REG1_0            =  32'h0000074C;	
    parameter  ADDR_STAT_TX_TOTAL_PACKETS_LSB_0         =  32'h00000818;
    parameter  ADDR_STAT_TX_TOTAL_PACKETS_MSB_0         =  32'h0000081C;
    parameter  ADDR_STAT_TX_TOTAL_GOOD_PACKETS_LSB_0    =  32'h00000820;
    parameter  ADDR_STAT_TX_TOTAL_GOOD_PACKETS_MSB_0    =  32'h00000824;
    parameter  ADDR_STAT_TX_TOTAL_BYTES_LSB_0           =  32'h00000828;
    parameter  ADDR_STAT_TX_TOTAL_BYTES_MSB_0           =  32'h0000082C;
    parameter  ADDR_STAT_TX_TOTAL_GOOD_BYTES_LSB_0      =  32'h00000830;
    parameter  ADDR_STAT_TX_TOTAL_GOOD_BYTES_MSB_0      =  32'h00000834;
    parameter  ADDR_STAT_RX_TOTAL_PACKETS_LSB_0         =  32'h00000E30;
    parameter  ADDR_STAT_RX_TOTAL_PACKETS_MSB_0         =  32'h00000E34;
    parameter  ADDR_STAT_RX_TOTAL_GOOD_PACKETS_LSB_0    =  32'h00000E38;
    parameter  ADDR_STAT_RX_TOTAL_GOOD_PACKETS_MSB_0    =  32'h00000E3C;
    parameter  ADDR_STAT_RX_TOTAL_BYTES_LSB_0           =  32'h00000E40;
    parameter  ADDR_STAT_RX_TOTAL_BYTES_MSB_0           =  32'h00000E44;
    parameter  ADDR_STAT_RX_TOTAL_GOOD_BYTES_LSB_0      =  32'h00000E48;
    parameter  ADDR_STAT_RX_TOTAL_GOOD_BYTES_MSB_0      =  32'h00000E4C;
    ///// For PORT-1
    parameter  ADDR_RESET_REG_1                         =  32'h00001004;
    parameter  ADDR_MODE_REG_1                          =  32'h00001008;
    parameter  ADDR_CONFIG_TX_REG1_1                    =  32'h0000100C;
    parameter  ADDR_CONFIG_RX_REG1_1                    =  32'h00001010;
    parameter  ADDR_TICK_REG_1                          =  32'h0000102C;
    parameter  ADDR_FEC_CONFIGURATION_REG1_1            =  32'h000010D0;
	parameter  ADDR_STAT_RX_STATUS_REG1_1               =  32'h00001744;
	parameter  ADDR_STAT_RX_RT_STATUS_REG1_1            =  32'h0000174C;	
    parameter  ADDR_STAT_TX_TOTAL_PACKETS_LSB_1         =  32'h00001818;
    parameter  ADDR_STAT_TX_TOTAL_PACKETS_MSB_1         =  32'h0000181C;
    parameter  ADDR_STAT_TX_TOTAL_GOOD_PACKETS_LSB_1    =  32'h00001820;
    parameter  ADDR_STAT_TX_TOTAL_GOOD_PACKETS_MSB_1    =  32'h00001824;
    parameter  ADDR_STAT_TX_TOTAL_BYTES_LSB_1           =  32'h00001828;
    parameter  ADDR_STAT_TX_TOTAL_BYTES_MSB_1           =  32'h0000182C;
    parameter  ADDR_STAT_TX_TOTAL_GOOD_BYTES_LSB_1      =  32'h00001830;
    parameter  ADDR_STAT_TX_TOTAL_GOOD_BYTES_MSB_1      =  32'h00001834;
    parameter  ADDR_STAT_RX_TOTAL_PACKETS_LSB_1         =  32'h00001E30;
    parameter  ADDR_STAT_RX_TOTAL_PACKETS_MSB_1         =  32'h00001E34;
    parameter  ADDR_STAT_RX_TOTAL_GOOD_PACKETS_LSB_1    =  32'h00001E38;
    parameter  ADDR_STAT_RX_TOTAL_GOOD_PACKETS_MSB_1    =  32'h00001E3C;
    parameter  ADDR_STAT_RX_TOTAL_BYTES_LSB_1           =  32'h00001E40;
    parameter  ADDR_STAT_RX_TOTAL_BYTES_MSB_1           =  32'h00001E44;
    parameter  ADDR_STAT_RX_TOTAL_GOOD_BYTES_LSB_1      =  32'h00001E48;
    parameter  ADDR_STAT_RX_TOTAL_GOOD_BYTES_MSB_1      =  32'h00001E4C;
    
    ///// For PORT-2
    parameter  ADDR_RESET_REG_2                         =  32'h00002004;
    parameter  ADDR_MODE_REG_2                          =  32'h00002008;
    parameter  ADDR_CONFIG_TX_REG1_2                    =  32'h0000200C;
    parameter  ADDR_CONFIG_RX_REG1_2                    =  32'h00002010;
    parameter  ADDR_TICK_REG_2                          =  32'h0000202C;
    parameter  ADDR_FEC_CONFIGURATION_REG1_2            =  32'h000020D0;
	parameter  ADDR_STAT_RX_STATUS_REG1_2               =  32'h00002744;
	parameter  ADDR_STAT_RX_RT_STATUS_REG1_2            =  32'h0000274C;	
    parameter  ADDR_STAT_TX_TOTAL_PACKETS_LSB_2         =  32'h00002818;
    parameter  ADDR_STAT_TX_TOTAL_PACKETS_MSB_2         =  32'h0000281C;
    parameter  ADDR_STAT_TX_TOTAL_GOOD_PACKETS_LSB_2    =  32'h00002820;
    parameter  ADDR_STAT_TX_TOTAL_GOOD_PACKETS_MSB_2    =  32'h00002824;
    parameter  ADDR_STAT_TX_TOTAL_BYTES_LSB_2           =  32'h00002828;
    parameter  ADDR_STAT_TX_TOTAL_BYTES_MSB_2           =  32'h0000282C;
    parameter  ADDR_STAT_TX_TOTAL_GOOD_BYTES_LSB_2      =  32'h00002830;
    parameter  ADDR_STAT_TX_TOTAL_GOOD_BYTES_MSB_2      =  32'h00002834;
    parameter  ADDR_STAT_RX_TOTAL_PACKETS_LSB_2         =  32'h00002E30;
    parameter  ADDR_STAT_RX_TOTAL_PACKETS_MSB_2         =  32'h00002E34;
    parameter  ADDR_STAT_RX_TOTAL_GOOD_PACKETS_LSB_2    =  32'h00002E38;
    parameter  ADDR_STAT_RX_TOTAL_GOOD_PACKETS_MSB_2    =  32'h00002E3C;
    parameter  ADDR_STAT_RX_TOTAL_BYTES_LSB_2           =  32'h00002E40;
    parameter  ADDR_STAT_RX_TOTAL_BYTES_MSB_2           =  32'h00002E44;
    parameter  ADDR_STAT_RX_TOTAL_GOOD_BYTES_LSB_2      =  32'h00002E48;
    parameter  ADDR_STAT_RX_TOTAL_GOOD_BYTES_MSB_2      =  32'h00002E4C;
    
    ///// For PORT-3
    parameter  ADDR_RESET_REG_3                         =  32'h00003004;
    parameter  ADDR_MODE_REG_3                          =  32'h00003008;
    parameter  ADDR_CONFIG_TX_REG1_3                    =  32'h0000300C;
    parameter  ADDR_CONFIG_RX_REG1_3                    =  32'h00003010;
    parameter  ADDR_TICK_REG_3                          =  32'h0000302C;
    parameter  ADDR_FEC_CONFIGURATION_REG1_3            =  32'h000030D0;
		parameter  ADDR_STAT_RX_STATUS_REG1_3               =  32'h00003744;
		parameter  ADDR_STAT_RX_RT_STATUS_REG1_3            =  32'h0000374C;	
    parameter  ADDR_STAT_TX_TOTAL_PACKETS_LSB_3         =  32'h00003818;
    parameter  ADDR_STAT_TX_TOTAL_PACKETS_MSB_3         =  32'h0000381C;
    parameter  ADDR_STAT_TX_TOTAL_GOOD_PACKETS_LSB_3    =  32'h00003820;
    parameter  ADDR_STAT_TX_TOTAL_GOOD_PACKETS_MSB_3    =  32'h00003824;
    parameter  ADDR_STAT_TX_TOTAL_BYTES_LSB_3           =  32'h00003828;
    parameter  ADDR_STAT_TX_TOTAL_BYTES_MSB_3           =  32'h0000382C;
    parameter  ADDR_STAT_TX_TOTAL_GOOD_BYTES_LSB_3      =  32'h00003830;
    parameter  ADDR_STAT_TX_TOTAL_GOOD_BYTES_MSB_3      =  32'h00003834;
    parameter  ADDR_STAT_RX_TOTAL_PACKETS_LSB_3         =  32'h00003E30;
    parameter  ADDR_STAT_RX_TOTAL_PACKETS_MSB_3         =  32'h00003E34;
    parameter  ADDR_STAT_RX_TOTAL_GOOD_PACKETS_LSB_3    =  32'h00003E38;
    parameter  ADDR_STAT_RX_TOTAL_GOOD_PACKETS_MSB_3    =  32'h00003E3C;
    parameter  ADDR_STAT_RX_TOTAL_BYTES_LSB_3           =  32'h00003E40;
    parameter  ADDR_STAT_RX_TOTAL_BYTES_MSB_3           =  32'h00003E44;
    parameter  ADDR_STAT_RX_TOTAL_GOOD_BYTES_LSB_3      =  32'h00003E48;
    parameter  ADDR_STAT_RX_TOTAL_GOOD_BYTES_MSB_3      =  32'h00003E4C;  



    wire 			s_axi_arready;
    reg [31:0] 		s_axi_araddr;
    reg 			s_axi_arvalid; 
    wire 			s_axi_awready;
    reg [31:0] 		s_axi_awaddr;
    reg 			s_axi_awvalid;  
    reg 			s_axi_bready;
    wire [1:0] 		s_axi_bresp;
    wire 			s_axi_bvalid;
    reg 			s_axi_rready;
    wire [31:0] 	s_axi_rdata;
    wire [1:0] 		s_axi_rresp;
    wire 			s_axi_rvalid;
    wire 			s_axi_wready;
    reg [31:0] 		s_axi_wdata;
    reg 			s_axi_wvalid;
		wire [3:0]      gt_loopback_p; 
    wire [3:0]      gt_loopback_n; 
		wire [3:0]      stat_mst_reset_done;    
		
		reg  [7:0]    gt_line_rate;
		reg  [3:0]    gt_reset_all_in;






  integer            i;

  // System-level clock and reset
  reg                sys_rst_n;
	reg 							async_fifo_rstn;

  wire               ep_sys_clk;
  wire               rp_sys_clk;
  wire               ep_sys_clk_p;
  wire               ep_sys_clk_n;
  wire               rp_sys_clk_p;
  wire               rp_sys_clk_n;
	wire							 tx_clk_p;
	wire							 tx_clk_n;
	wire             	 gt_ref_clk_p;
	wire             	 gt_ref_clk_n;



  //
  // PCI-Express Serial Interconnect
  //

  // Xilinx Pipe Interface
  wire  [25:0]  common_commands_out;
  wire  [83:0]  xil_tx0_sigs_ep;
  wire  [83:0]  xil_tx1_sigs_ep;
  wire  [83:0]  xil_tx2_sigs_ep;
  wire  [83:0]  xil_tx3_sigs_ep;
  wire  [83:0]  xil_tx4_sigs_ep;
  wire  [83:0]  xil_tx5_sigs_ep;
  wire  [83:0]  xil_tx6_sigs_ep;
  wire  [83:0]  xil_tx7_sigs_ep;
  wire  [83:0]  xil_tx8_sigs_ep;
  wire  [83:0]  xil_tx9_sigs_ep;
  wire  [83:0]  xil_tx10_sigs_ep;
  wire  [83:0]  xil_tx11_sigs_ep;
  wire  [83:0]  xil_tx12_sigs_ep;
  wire  [83:0]  xil_tx13_sigs_ep;
  wire  [83:0]  xil_tx14_sigs_ep;
  wire  [83:0]  xil_tx15_sigs_ep;

  wire  [83:0]  xil_rx0_sigs_ep;
  wire  [83:0]  xil_rx1_sigs_ep;
  wire  [83:0]  xil_rx2_sigs_ep;
  wire  [83:0]  xil_rx3_sigs_ep;
  wire  [83:0]  xil_rx4_sigs_ep;
  wire  [83:0]  xil_rx5_sigs_ep;
  wire  [83:0]  xil_rx6_sigs_ep;
  wire  [83:0]  xil_rx7_sigs_ep;
  wire  [83:0]  xil_rx8_sigs_ep;
  wire  [83:0]  xil_rx9_sigs_ep;
  wire  [83:0]  xil_rx10_sigs_ep;
  wire  [83:0]  xil_rx11_sigs_ep;
  wire  [83:0]  xil_rx12_sigs_ep;
  wire  [83:0]  xil_rx13_sigs_ep;
  wire  [83:0]  xil_rx14_sigs_ep;
  wire  [83:0]  xil_rx15_sigs_ep;

  wire  [83:0]  xil_tx0_sigs_rp;
  wire  [83:0]  xil_tx1_sigs_rp;
  wire  [83:0]  xil_tx2_sigs_rp;
  wire  [83:0]  xil_tx3_sigs_rp;
  wire  [83:0]  xil_tx4_sigs_rp;
  wire  [83:0]  xil_tx5_sigs_rp;
  wire  [83:0]  xil_tx6_sigs_rp;
  wire  [83:0]  xil_tx7_sigs_rp;
  wire  [83:0]  xil_tx8_sigs_rp;
  wire  [83:0]  xil_tx9_sigs_rp;
  wire  [83:0]  xil_tx10_sigs_rp;
  wire  [83:0]  xil_tx11_sigs_rp;
  wire  [83:0]  xil_tx12_sigs_rp;
  wire  [83:0]  xil_tx13_sigs_rp;
  wire  [83:0]  xil_tx14_sigs_rp;
  wire  [83:0]  xil_tx15_sigs_rp;


  //------------------------------------------------------------------------------//
  // Generate system clock
  //------------------------------------------------------------------------------//
  sys_clk_gen_ds # (
    .halfcycle(REF_CLK_HALF_CYCLE), 
    .offset(0)
  )
  CLK_GEN_RP (
    .sys_clk_p(rp_sys_clk_p),
    .sys_clk_n(rp_sys_clk_n)
  );

  sys_clk_gen_ds # (
    .halfcycle(REF_CLK_HALF_CYCLE),
    .offset(0)
  )
  CLK_GEN_EP (
    .sys_clk_p(ep_sys_clk_p),
    .sys_clk_n(ep_sys_clk_n)
  );

	sys_clk_gen_ds # (
    .halfcycle(TX_CLK_HALF_CYCLE),
    .offset(0)
  )
  CLK_GEN_TXDX (
    .sys_clk_p(tx_clk_p),
    .sys_clk_n(tx_clk_n)
  );

	sys_clk_gen_ds # (
    .halfcycle(TX_CLK_HALF_CYCLE),
    .offset(0)
  )
  CLK_GEN_GT (
    .sys_clk_p(gt_ref_clk_p),
    .sys_clk_n(gt_ref_clk_n)
  );


  //------------------------------------------------------------------------------//
  // Generate system-level reset
  //------------------------------------------------------------------------------//
  parameter ON=3, OFF=4, UNIQUE=32, UNIQUE0=64, PRIORITY=128;

  initial begin
    `ifndef XILINX_SIMULATOR
    // Disable UNIQUE, UNIQUE0, and PRIORITY analysis during reset because signal can be at unknown value during reset
    $assertcontrol( OFF , UNIQUE | UNIQUE0 | PRIORITY);
    `endif

    $display("[%t] : System Reset Is Asserted...", $realtime);
    sys_rst_n = 1'b0;
    repeat (500) @(posedge rp_sys_clk_p);
    $display("[%t] : System Reset Is De-asserted...", $realtime);
    sys_rst_n = 1'b1;

    `ifndef XILINX_SIMULATOR
    // Re-enable UNIQUE, UNIQUE0, and PRIORITY analysis
    $assertcontrol( ON , UNIQUE | UNIQUE0 | PRIORITY);
    `endif
  end
  //------------------------------------------------------------------------------//

  //------------------------------------------------------------------------------//
  // EndPoint DUT with PIO Slave
  //------------------------------------------------------------------------------//
  //
  // PCI-Express Endpoint Instance
  //

  localparam EXT_PIPE_SIM = "TRUE";
// //
// //
    defparam board.EP.xdma_endpoint_i.xdma_2_support.pcie.inst.PL_SIM_FAST_LINK_TRAINING=2'h3;
    defparam board.EP.xdma_endpoint_i.xdma_2_support.pcie.inst.EXT_PIPE_SIM = "TRUE";
    defparam  board.RP.xdma_rootcomplex_i.pcie_versal_0.inst.EXT_PIPE_SIM = "TRUE";
    defparam  board.RP.EXT_PIPE_SIM = "TRUE";
    defparam  board.EP.EXT_PIPE_SIM = "TRUE";

  xilinx_dma_pcie_ep
	#(
    .EXT_PIPE_SIM (EXT_PIPE_SIM)
	)
  EP (
    // SYS Inteface
    .sys_clk_p(ep_sys_clk_p),
    .sys_clk_n(ep_sys_clk_n),
    .sys_rst_n(sys_rst_n),

    // Xilinx Pipe Interface
    .common_commands_in (26'b0),
    .pipe_rx_0_sigs  ({45'b0,xil_tx0_sigs_rp[38:0]}),
    .pipe_rx_1_sigs  ({45'b0,xil_tx1_sigs_rp[38:0]}),
    .pipe_rx_2_sigs  ({45'b0,xil_tx2_sigs_rp[38:0]}),
    .pipe_rx_3_sigs  ({45'b0,xil_tx3_sigs_rp[38:0]}),
    .pipe_rx_4_sigs  ({45'b0,xil_tx4_sigs_rp[38:0]}),
    .pipe_rx_5_sigs  ({45'b0,xil_tx5_sigs_rp[38:0]}),
    .pipe_rx_6_sigs  ({45'b0,xil_tx6_sigs_rp[38:0]}),
    .pipe_rx_7_sigs  ({45'b0,xil_tx7_sigs_rp[38:0]}),
    .pipe_rx_8_sigs  ({45'b0,xil_tx8_sigs_rp[38:0]}),
    .pipe_rx_9_sigs  ({45'b0,xil_tx9_sigs_rp[38:0]}),
    .pipe_rx_10_sigs ({45'b0,xil_tx10_sigs_rp[38:0]}),
    .pipe_rx_11_sigs ({45'b0,xil_tx11_sigs_rp[38:0]}),
    .pipe_rx_12_sigs ({45'b0,xil_tx12_sigs_rp[38:0]}),
    .pipe_rx_13_sigs ({45'b0,xil_tx13_sigs_rp[38:0]}),
    .pipe_rx_14_sigs ({45'b0,xil_tx14_sigs_rp[38:0]}),
    .pipe_rx_15_sigs ({45'b0,xil_tx15_sigs_rp[38:0]}),

    .common_commands_out(common_commands_out), //[0] - pipe_clk out
    .pipe_tx_0_sigs  (xil_tx0_sigs_ep),
    .pipe_tx_1_sigs  (xil_tx1_sigs_ep),
    .pipe_tx_2_sigs  (xil_tx2_sigs_ep),
    .pipe_tx_3_sigs  (xil_tx3_sigs_ep),
    .pipe_tx_4_sigs  (xil_tx4_sigs_ep),
    .pipe_tx_5_sigs  (xil_tx5_sigs_ep),
    .pipe_tx_6_sigs  (xil_tx6_sigs_ep),
    .pipe_tx_7_sigs  (xil_tx7_sigs_ep),
    .pipe_tx_8_sigs  (xil_tx8_sigs_ep),
    .pipe_tx_9_sigs  (xil_tx9_sigs_ep),
    .pipe_tx_10_sigs (xil_tx10_sigs_ep),
    .pipe_tx_11_sigs (xil_tx11_sigs_ep),
    .pipe_tx_12_sigs (xil_tx12_sigs_ep),
    .pipe_tx_13_sigs (xil_tx13_sigs_ep),
    .pipe_tx_14_sigs (xil_tx14_sigs_ep),
    .pipe_tx_15_sigs (xil_tx15_sigs_ep),

		
		.s_axi_aclk							(ep_sys_clk_p),
		.s_axi_aresetn					(sys_rst_n),
		.s_axi_awaddr						(s_axi_awaddr),
		.s_axi_awvalid					(s_axi_awvalid),
		.s_axi_awready					(s_axi_awready),
		.s_axi_wdata						(s_axi_wdata),
		.s_axi_wvalid						(s_axi_wvalid),
		.s_axi_wready						(s_axi_wready),
		.s_axi_bresp						(s_axi_bresp),
		.s_axi_bvalid						(s_axi_bvalid),
		.s_axi_bready						(s_axi_bready),
		.s_axi_araddr						(s_axi_araddr),
		.s_axi_arvalid					(s_axi_arvalid),
		.s_axi_arready					(s_axi_arready),
		.s_axi_rdata						(s_axi_rdata),
		.s_axi_rresp						(s_axi_rresp),
		.s_axi_rvalid						(s_axi_rvalid),
		.s_axi_rready						(s_axi_rready),	
    
		.stat_mst_reset_done		(stat_mst_reset_done),
		.gt_line_rate						(gt_line_rate),
		.gt_reset_all_in				(gt_reset_all_in),
		.gt_rxn_in							(gt_loopback_n),
		.gt_rxp_in							(gt_loopback_p),
		.gt_txn_out							(gt_loopback_n),
		.gt_txp_out							(gt_loopback_p),
		.gt_ref_clk_p						(gt_ref_clk_p),
		.gt_ref_clk_n						(gt_ref_clk_n),
		.tx_clk									(tx_clk_p),
    .async_fifo_rstn        (async_fifo_rstn)

);




  //------------------------------------------------------------------------------//
  // Simulation Root Port Model
  // (Comment out this module to interface EndPoint with BFM)
  //------------------------------------------------------------------------------//
  //
  // PCI-Express Model Root Port Instance
  //

 //------------------------------------------------------------------------------//
  // Simulation Root Port Model
  // (Comment out this module to interface EndPoint with BFM)
  //------------------------------------------------------------------------------//
  //
  // PCI-Express Model Root Port Instance
  //


  xilinx_pcie_versal_rp
  #(
     .PF0_DEV_CAP_MAX_PAYLOAD_SIZE(PF0_DEV_CAP_MAX_PAYLOAD_SIZE),
     .EXT_PIPE_SIM (EXT_PIPE_SIM),
     .REF_CLK_FREQ (REF_CLK_FREQ)
  ) RP (
    // SYS Inteface
    .sys_clk_p(rp_sys_clk_p),
    .sys_clk_n(rp_sys_clk_n),
    .sys_rst_n (sys_rst_n),
    // Xilinx Pipe Interface
    .common_commands_in ({25'b0,common_commands_out[0]}), // pipe_clk from EP
    .pipe_rx_0_sigs  ({45'b0,xil_tx0_sigs_ep[38:0]}),
    .pipe_rx_1_sigs  ({45'b0,xil_tx1_sigs_ep[38:0]}),
    .pipe_rx_2_sigs  ({45'b0,xil_tx2_sigs_ep[38:0]}),
    .pipe_rx_3_sigs  ({45'b0,xil_tx3_sigs_ep[38:0]}),
    .pipe_rx_4_sigs  ({45'b0,xil_tx4_sigs_ep[38:0]}),
    .pipe_rx_5_sigs  ({45'b0,xil_tx5_sigs_ep[38:0]}),
    .pipe_rx_6_sigs  ({45'b0,xil_tx6_sigs_ep[38:0]}),
    .pipe_rx_7_sigs  ({45'b0,xil_tx7_sigs_ep[38:0]}),
    .pipe_rx_8_sigs  ({45'b0,xil_tx8_sigs_ep[38:0]}),
    .pipe_rx_9_sigs  ({45'b0,xil_tx9_sigs_ep[38:0]}),
    .pipe_rx_10_sigs ({45'b0,xil_tx10_sigs_ep[38:0]}),
    .pipe_rx_11_sigs ({45'b0,xil_tx11_sigs_ep[38:0]}),
    .pipe_rx_12_sigs ({45'b0,xil_tx12_sigs_ep[38:0]}),
    .pipe_rx_13_sigs ({45'b0,xil_tx13_sigs_ep[38:0]}),
    .pipe_rx_14_sigs ({45'b0,xil_tx14_sigs_ep[38:0]}),
    .pipe_rx_15_sigs ({45'b0,xil_tx15_sigs_ep[38:0]}),

    .common_commands_out(),
    .pipe_tx_0_sigs  (xil_tx0_sigs_rp),
    .pipe_tx_1_sigs  (xil_tx1_sigs_rp),
    .pipe_tx_2_sigs  (xil_tx2_sigs_rp),
    .pipe_tx_3_sigs  (xil_tx3_sigs_rp),
    .pipe_tx_4_sigs  (xil_tx4_sigs_rp),
    .pipe_tx_5_sigs  (xil_tx5_sigs_rp),
    .pipe_tx_6_sigs  (xil_tx6_sigs_rp),
    .pipe_tx_7_sigs  (xil_tx7_sigs_rp),
    .pipe_tx_8_sigs  (xil_tx8_sigs_rp),
    .pipe_tx_9_sigs  (xil_tx9_sigs_rp),
    .pipe_tx_10_sigs (xil_tx10_sigs_rp),
    .pipe_tx_11_sigs (xil_tx11_sigs_rp),
    .pipe_tx_12_sigs (xil_tx12_sigs_rp),
    .pipe_tx_13_sigs (xil_tx13_sigs_rp),
    .pipe_tx_14_sigs (xil_tx14_sigs_rp),
    .pipe_tx_15_sigs (xil_tx15_sigs_rp)
);
  initial begin

    if ($test$plusargs ("dump_all")) begin

  `ifdef NCV // Cadence TRN dump

      $recordsetup("design=board",
                   "compress",
                   "wrapsize=100M",
                   "version=1",
                   "run=1");
      $recordvars();

  `elsif VCS //Synopsys VPD dump

      $vcdplusfile("board.vpd");
      $vcdpluson;
      $vcdplusglitchon;
      $vcdplusflush;

  `else

      // Verilog VC dump
      $dumpfile("board.vcd");
      $dumpvars(0, board);

  `endif

    end

  end

     assign xil_rx0_sigs_ep  = {45'b0,xil_tx0_sigs_rp[38:0]};
     assign xil_rx1_sigs_ep  = {45'b0,xil_tx1_sigs_rp[38:0]};
     assign xil_rx2_sigs_ep  = {45'b0,xil_tx2_sigs_rp[38:0]};
     assign xil_rx3_sigs_ep  = {45'b0,xil_tx3_sigs_rp[38:0]};
     assign xil_rx4_sigs_ep  = {45'b0,xil_tx4_sigs_rp[38:0]};
     assign xil_rx5_sigs_ep  = {45'b0,xil_tx5_sigs_rp[38:0]};
     assign xil_rx6_sigs_ep  = {45'b0,xil_tx6_sigs_rp[38:0]};
     assign xil_rx7_sigs_ep  = {45'b0,xil_tx7_sigs_rp[38:0]};

     assign xil_rx8_sigs_ep   = {45'b0,xil_tx8_sigs_rp[38:0]};
     assign xil_rx9_sigs_ep   = {45'b0,xil_tx9_sigs_rp[38:0]};
     assign xil_rx10_sigs_ep  = {45'b0,xil_tx10_sigs_rp[38:0]};
     assign xil_rx11_sigs_ep  = {45'b0,xil_tx11_sigs_rp[38:0]};
     assign xil_rx12_sigs_ep  = {45'b0,xil_tx12_sigs_rp[38:0]};
     assign xil_rx13_sigs_ep  = {45'b0,xil_tx13_sigs_rp[38:0]};
     assign xil_rx14_sigs_ep  = {45'b0,xil_tx14_sigs_rp[38:0]};
     assign xil_rx15_sigs_ep  = {45'b0,xil_tx15_sigs_rp[38:0]};
  //------------------------------------------------------------------------------//
  // Simulation with BFM
  //------------------------------------------------------------------------------//
  //
  // PCI-Express use case with BFM Instance
  //
  //-----------------------------------------------------------------------------
  //-- Description:  Pipe Mode Interface
  //-- 16bit data for Gen1 rate @ Pipe Clk 125
  //-- 16bit data for Gen2 rate @ Pipe Clk 250
  //-- 32bit data for Gen3 rate @ Pipe Clk 250
  //-- For Gen1/Gen2 use case, tie-off rx*_start_block, rx*_data_valid, rx*_syncheader & rx*_data[31:16]
  //-- Pipe Clk is provided as output of this module - All pipe signals need to be aligned to provided Pipe Clk
  //-- pipe_tx_rate (00 - Gen1, 01 -Gen2 & 10- Gen3)
  //-- Rcvr Detect is handled internally by the core (Rcvr Detect Bypassed)
  //-- RX Status and PHY Status are handled internally (speed change & rcvr detect )
  //-- Phase2/3 needs to be disabled
  //-- LF & FS values are 40 & 12 decimal
  //-- RP should provide TX preset hint of 5 (in EQ TS2's before changing rate to Gen3)
  //-----------------------------------------------------------------------------
//------------------------------------------------------------------------------//
  // Simulation with BFM
  //------------------------------------------------------------------------------//
  //
  // PCI-Express use case with BFM Instance
  //
  //-----------------------------------------------------------------------------
  //-- Description:  Pipe Mode Interface
  //-- 16bit data for Gen1 rate @ Pipe Clk 125
  //-- 16bit data for Gen2 rate @ Pipe Clk 250
  //-- 32bit data for Gen3 rate @ Pipe Clk 250
  //-- For Gen1/Gen2 use case, tie-off rx*_start_block, rx*_data_valid, rx*_syncheader & rx*_data[31:16]
  //-- Pipe Clk is provided as output of this module - All pipe signals need to be aligned to provided Pipe Clk
  //-- pipe_tx_rate (00 - Gen1, 01 -Gen2 & 10- Gen3)
  //-- Rcvr Detect is handled internally by the core (Rcvr Detect Bypassed)
  //-- RX Status and PHY Status are handled internally (speed change & rcvr detect )
  //-- Phase2/3 needs to be disabled
  //-- LF & FS values are 40 & 12 decimal
  //-- RP should provide TX preset hint of 5 (in EQ TS2's before changing rate to Gen3)
  //-----------------------------------------------------------------------------
  /*
   xil_sig2pipe xil_dut_pipe (
     .xil_rx0_sigs(xil_rx0_sigs_ep),
     .xil_rx1_sigs(xil_rx1_sigs_ep),
     .xil_rx2_sigs(xil_rx2_sigs_ep),
     .xil_rx3_sigs(xil_rx3_sigs_ep),
     .xil_rx4_sigs(xil_rx4_sigs_ep),
     .xil_rx5_sigs(xil_rx5_sigs_ep),
     .xil_rx6_sigs(xil_rx6_sigs_ep),
     .xil_rx7_sigs(xil_rx7_sigs_ep),
     .xil_rx8_sigs(xil_rx8_sigs_ep),
     .xil_rx9_sigs(xil_rx9_sigs_ep),
     .xil_rx10_sigs(xil_rx10_sigs_ep),
     .xil_rx11_sigs(xil_rx11_sigs_ep),
     .xil_rx12_sigs(xil_rx12_sigs_ep),
     .xil_rx13_sigs(xil_rx13_sigs_ep),
     .xil_rx14_sigs(xil_rx14_sigs_ep),
     .xil_rx15_sigs(xil_rx15_sigs_ep),
     .xil_tx0_sigs(xil_tx0_sigs_ep),
     .xil_tx1_sigs(xil_tx1_sigs_ep),
     .xil_tx2_sigs(xil_tx2_sigs_ep),
     .xil_tx3_sigs(xil_tx3_sigs_ep),
     .xil_tx4_sigs(xil_tx4_sigs_ep),
     .xil_tx5_sigs(xil_tx5_sigs_ep),
     .xil_tx6_sigs(xil_tx6_sigs_ep),
     .xil_tx7_sigs(xil_tx7_sigs_ep),

     .xil_common_commands(common_commands_out),
      ///////////// do not modify above this line //////////
      //////////Connect the following pipe ports to BFM///////////////
     .pipe_clk(),               // input to BFM  (pipe clock output)
     .pipe_tx_rate(),           // input to BFM  (rate)
     .pipe_tx_detect_rx(),      // input to BFM  (Receiver Detect)
     .pipe_tx_powerdown(),      // input to BFM  (Powerdown)
      // Pipe TX Interface
     .pipe_tx0_data(),          // input to BFM
     .pipe_tx1_data(),          // input to BFM
     .pipe_tx2_data(),          // input to BFM
     .pipe_tx3_data(),          // input to BFM
     .pipe_tx4_data(),          // input to BFM
     .pipe_tx5_data(),          // input to BFM
     .pipe_tx6_data(),          // input to BFM
     .pipe_tx7_data(),          // input to BFM
     .pipe_tx0_char_is_k(),     // input to BFM
     .pipe_tx1_char_is_k(),     // input to BFM
     .pipe_tx2_char_is_k(),     // input to BFM
     .pipe_tx3_char_is_k(),     // input to BFM
     .pipe_tx4_char_is_k(),     // input to BFM
     .pipe_tx5_char_is_k(),     // input to BFM
     .pipe_tx6_char_is_k(),     // input to BFM
     .pipe_tx7_char_is_k(),     // input to BFM
     .pipe_tx0_elec_idle(),     // input to BFM
     .pipe_tx1_elec_idle(),     // input to BFM
     .pipe_tx2_elec_idle(),     // input to BFM
     .pipe_tx3_elec_idle(),     // input to BFM
     .pipe_tx4_elec_idle(),     // input to BFM
     .pipe_tx5_elec_idle(),     // input to BFM
     .pipe_tx6_elec_idle(),     // input to BFM
     .pipe_tx7_elec_idle(),     // input to BFM
     .pipe_tx0_start_block(),   // input to BFM
     .pipe_tx1_start_block(),   // input to BFM
     .pipe_tx2_start_block(),   // input to BFM
     .pipe_tx3_start_block(),   // input to BFM
     .pipe_tx4_start_block(),   // input to BFM
     .pipe_tx5_start_block(),   // input to BFM
     .pipe_tx6_start_block(),   // input to BFM
     .pipe_tx7_start_block(),   // input to BFM
     .pipe_tx0_syncheader(),    // input to BFM
     .pipe_tx1_syncheader(),    // input to BFM
     .pipe_tx2_syncheader(),    // input to BFM
     .pipe_tx3_syncheader(),    // input to BFM
     .pipe_tx4_syncheader(),    // input to BFM
     .pipe_tx5_syncheader(),    // input to BFM
     .pipe_tx6_syncheader(),    // input to BFM
     .pipe_tx7_syncheader(),    // input to BFM
     .pipe_tx0_data_valid(),    // input to BFM
     .pipe_tx1_data_valid(),    // input to BFM
     .pipe_tx2_data_valid(),    // input to BFM
     .pipe_tx3_data_valid(),    // input to BFM
     .pipe_tx4_data_valid(),    // input to BFM
     .pipe_tx5_data_valid(),    // input to BFM
     .pipe_tx6_data_valid(),    // input to BFM
     .pipe_tx7_data_valid(),    // input to BFM
     // Pipe RX Interface
     .pipe_rx0_data(),          // output of BFM
     .pipe_rx1_data(),          // output of BFM
     .pipe_rx2_data(),          // output of BFM
     .pipe_rx3_data(),          // output of BFM
     .pipe_rx4_data(),          // output of BFM
     .pipe_rx5_data(),          // output of BFM
     .pipe_rx6_data(),          // output of BFM
     .pipe_rx7_data(),          // output of BFM
     .pipe_rx0_char_is_k(),     // output of BFM
     .pipe_rx1_char_is_k(),     // output of BFM
     .pipe_rx2_char_is_k(),     // output of BFM
     .pipe_rx3_char_is_k(),     // output of BFM
     .pipe_rx4_char_is_k(),     // output of BFM
     .pipe_rx5_char_is_k(),     // output of BFM
     .pipe_rx6_char_is_k(),     // output of BFM
     .pipe_rx7_char_is_k(),     // output of BFM
     .pipe_rx0_elec_idle(),     // output of BFM
     .pipe_rx1_elec_idle(),     // output of BFM
     .pipe_rx2_elec_idle(),     // output of BFM
     .pipe_rx3_elec_idle(),     // output of BFM
     .pipe_rx4_elec_idle(),     // output of BFM
     .pipe_rx5_elec_idle(),     // output of BFM
     .pipe_rx6_elec_idle(),     // output of BFM
     .pipe_rx7_elec_idle(),     // output of BFM
     .pipe_rx0_start_block(),   // output of BFM
     .pipe_rx1_start_block(),   // output of BFM
     .pipe_rx2_start_block(),   // output of BFM
     .pipe_rx3_start_block(),   // output of BFM
     .pipe_rx4_start_block(),   // output of BFM
     .pipe_rx5_start_block(),   // output of BFM
     .pipe_rx6_start_block(),   // output of BFM
     .pipe_rx7_start_block(),   // output of BFM
     .pipe_rx0_syncheader(),    // output of BFM
     .pipe_rx1_syncheader(),    // output of BFM
     .pipe_rx2_syncheader(),    // output of BFM
     .pipe_rx3_syncheader(),    // output of BFM
     .pipe_rx4_syncheader(),    // output of BFM
     .pipe_rx5_syncheader(),    // output of BFM
     .pipe_rx6_syncheader(),    // output of BFM
     .pipe_rx7_syncheader(),    // output of BFM
     .pipe_rx0_data_valid(),    // output of BFM
     .pipe_rx1_data_valid(),    // output of BFM
     .pipe_rx2_data_valid(),    // output of BFM
     .pipe_rx3_data_valid(),    // output of BFM
     .pipe_rx4_data_valid(),    // output of BFM
     .pipe_rx5_data_valid(),    // output of BFM
     .pipe_rx6_data_valid(),    // output of BFM
     .pipe_rx7_data_valid()     // output of BFM
);

*/


	reg  [31:0]     axi_read_data;
	reg  [63:0]    tx_total_pkt_0, tx_total_bytes_0, tx_total_good_pkts_0, tx_total_good_bytes_0; // use only lsb 48 bits
	reg  [63:0]    rx_total_pkt_0, rx_total_bytes_0, rx_total_good_pkts_0, rx_total_good_bytes_0; // use only lsb 48 bits
	reg  [63:0]    tx_total_pkt_1, tx_total_bytes_1, tx_total_good_pkts_1, tx_total_good_bytes_1; // use only lsb 48 bits
	reg  [63:0]    rx_total_pkt_1, rx_total_bytes_1, rx_total_good_pkts_1, rx_total_good_bytes_1; // use only lsb 48 bits 
	reg  [63:0]    tx_total_pkt_2, tx_total_bytes_2, tx_total_good_pkts_2, tx_total_good_bytes_2; // use only lsb 48 bits
	reg  [63:0]    rx_total_pkt_2, rx_total_bytes_2, rx_total_good_pkts_2, rx_total_good_bytes_2; // use only lsb 48 bits   
	reg  [63:0]    tx_total_pkt_3, tx_total_bytes_3, tx_total_good_pkts_3, tx_total_good_bytes_3; // use only lsb 48 bits
	reg  [63:0]    rx_total_pkt_3, rx_total_bytes_3, rx_total_good_pkts_3, rx_total_good_bytes_3; // use only lsb 48 bits  
	
  reg mrmac_init_success;

  initial
  begin
	
	
     $display("################################################################- MRMAC Example Design Simulation Started - ##################################################################");
    
    `ifdef SIM_SPEED_UP
    `else
      $display("****************");
      $display("INFO : Simulation time may be longer. For faster simulation, please use SIM_SPEED_UP option. For more information refer product guide.");
      $display("****************");
    `endif

    gt_reset_all_in =4'h0;	
    gt_line_rate=8'h00;
		async_fifo_rstn = 1'b1;
    mrmac_init_success = 1'b0;
 	  
	    s_axi_awaddr = 0;
			s_axi_awvalid = 0;
			s_axi_wdata = 0;
			s_axi_wvalid = 0;
			s_axi_bready = 0;
			s_axi_araddr = 0;
			s_axi_arvalid = 0;
			s_axi_rready = 0;
      $display("****************");
      $display("INFO :Init Axi4-lite Periphe.");
      $display("****************");

		repeat (520) @(posedge tx_clk_p);
 		
		repeat (10) @(posedge tx_clk_p);
 		
        gt_reset_all_in =4'h0;		
		repeat (10) @(posedge tx_clk_p);
        gt_reset_all_in =4'hF;
		repeat (10) @(posedge tx_clk_p);	
        gt_reset_all_in =4'h0;
				
		@(posedge stat_mst_reset_done[0]);
		repeat (400) @(posedge tx_clk_p);
		
		// 1x100GE Test Start
		$display("############ 1x100G TEST STARTED");
		$display("INFO : SET GT RATE PORT");
 
		gt_line_rate=8'h02;
		@(posedge stat_mst_reset_done[0]);

		repeat (400) @(posedge tx_clk_p);
		$display("INFO : SYS_RESET APPLIED TO ASYNC FIFO");
		async_fifo_rstn=1'b0;
		repeat (400) @(posedge tx_clk_p);
		$display("INFO : SYS_RESET RELEASED TO ASYNC FIFO");
		async_fifo_rstn=1'b1;
		repeat (400) @(posedge tx_clk_p);
		$display("INFO : SYS_RESET APPLIED TO GT and MRMAC IP(AXI4-LIte)");
		gt_reset_all_in =4'hF;
		repeat (400) @(posedge tx_clk_p);
		$display("INFO : SYS_RESET RELEASED TO GT and MRMAC IP(AXI4-LIte)");
		gt_reset_all_in =4'h0;
		$display("INFO : WAITING FOR MST RESET DONE FROM GT..........");
		@(posedge stat_mst_reset_done[0]);

		$display("INFO : GT LOCKED..........");		
	    repeat (400) @(posedge tx_clk_p);
 
	     
		$display("INFO : READ MRMAC CORE VERSION ..........");
		axi_read(ADDR_CORE_VERSION_REG, axi_read_data);  
		$display( " Core_Version  =  %0d",  axi_read_data); 
		
		$display("INFO : START MRMAC CONFIGURATION ..........");	
        axi_write(ADDR_RESET_REG_0, 32'h00000FFF);
		$display("INFO : SET CORE SPEED 1x100GE ..........");
	    axi_write(ADDR_MODE_REG_0, 32'h40000A64); 
 
        axi_write(ADDR_CONFIG_RX_REG1_0, 32'h00000033);   
		axi_write(ADDR_CONFIG_TX_REG1_0, 32'h00000C03);

		axi_write(ADDR_FEC_CONFIGURATION_REG1_0, 32'h00000000); 
		axi_write(ADDR_FEC_CONFIGURATION_REG1_1, 32'h00000000); 
		axi_write(ADDR_FEC_CONFIGURATION_REG1_2, 32'h00000000); 
		axi_write(ADDR_FEC_CONFIGURATION_REG1_3, 32'h00000000); 
	
		axi_write(ADDR_RESET_REG_0,32'h00000000);
		axi_write(ADDR_TICK_REG_0, 32'h00000001);
		
		$display("INFO : WAITING FOR RX ALIGNED ..........");		
    /*		
	    //////// Wait for Fixed Delay , But in actual Software need to poll for RX status bit
		`ifdef SIM_SPEED_UP
			repeat (12500) @(posedge tx_clk_p);
		`else
			repeat (200000) @(posedge tx_clk_p);
		`endif

		axi_write(ADDR_STAT_RX_STATUS_REG1_0, 32'hFFFFFFFF); 
    axi_read(ADDR_STAT_RX_STATUS_REG1_0, axi_read_data); 
    if (axi_read_data[0] ==  1'b0)begin
      $display("ERROR : RX ALIGN FAILED");
      $display("INFO  : Test FAILED");
      $finish;
    end		

    */

    @(posedge board.EP.xdma_app_i.inst_mrmac.stat_rx_aligned_0);

    $display("INFO : RX ALIGNED ..........");
		
    repeat(50)@(posedge tx_clk_p);
    mrmac_init_success = 1'b1;

		repeat (500) @(posedge tx_clk_p);
		/// Data Traffic complete		
		/// PM tick
		axi_write(ADDR_TICK_REG_0, 32'h00000001);		
		repeat (100) @(posedge tx_clk_p);
		axi_read(ADDR_STAT_TX_TOTAL_PACKETS_LSB_0, tx_total_pkt_0[31:0]);
		axi_read(ADDR_STAT_TX_TOTAL_PACKETS_MSB_0, tx_total_pkt_0[63:32]);
		axi_read(ADDR_STAT_TX_TOTAL_GOOD_PACKETS_LSB_0, tx_total_good_pkts_0[31:0]);
		axi_read(ADDR_STAT_TX_TOTAL_GOOD_PACKETS_MSB_0, tx_total_good_pkts_0[63:32]);
		axi_read(ADDR_STAT_TX_TOTAL_BYTES_LSB_0, tx_total_bytes_0[31:0]);
		axi_read(ADDR_STAT_TX_TOTAL_BYTES_MSB_0, tx_total_bytes_0[63:32]);		
		axi_read(ADDR_STAT_TX_TOTAL_GOOD_BYTES_LSB_0, tx_total_good_bytes_0[31:0]);
		axi_read(ADDR_STAT_TX_TOTAL_GOOD_BYTES_MSB_0, tx_total_good_bytes_0[63:32]);
		
		axi_read(ADDR_STAT_RX_TOTAL_PACKETS_LSB_0, rx_total_pkt_0[31:0]);
		axi_read(ADDR_STAT_RX_TOTAL_PACKETS_MSB_0, rx_total_pkt_0[63:32]);
		axi_read(ADDR_STAT_RX_TOTAL_GOOD_PACKETS_LSB_0, rx_total_good_pkts_0[31:0]);
		axi_read(ADDR_STAT_RX_TOTAL_GOOD_PACKETS_MSB_0, rx_total_good_pkts_0[63:32]);
		axi_read(ADDR_STAT_RX_TOTAL_BYTES_LSB_0, rx_total_bytes_0[31:0]);
		axi_read(ADDR_STAT_RX_TOTAL_BYTES_MSB_0, rx_total_bytes_0[63:32]);		
		axi_read(ADDR_STAT_RX_TOTAL_GOOD_BYTES_LSB_0, rx_total_good_bytes_0[31:0]);
		axi_read(ADDR_STAT_RX_TOTAL_GOOD_BYTES_MSB_0, rx_total_good_bytes_0[63:32]);	

        $display( "  " );
        $display( "          PORT - 0 Statistics           " );
        $display( "               STAT_TX_TOTAL_PACKETS           = %d,     STAT_RX_TOTAL_PACKETS           = %d", tx_total_pkt_0, rx_total_pkt_0 );
        $display( "               STAT_TX_TOTAL_GOOD_PACKETS      = %d,     STAT_RX_TOTAL_GOOD_PACKETS      = %d", tx_total_good_pkts_0, rx_total_good_pkts_0 );
        $display( "               STAT_TX_TOTAL_BYTES             = %d,     STAT_RX_TOTAL_BYTES             = %d", tx_total_bytes_0, rx_total_bytes_0 );
        $display( "               STAT_TX_TOTAL_GOOD_BYTES        = %d,     STAT_RX_TOTAL_GOOD_BYTES        = %d", tx_total_good_bytes_0, rx_total_good_bytes_0 );
        $display( "  " );
		if ((tx_total_pkt_0[47:0] == rx_total_pkt_0[47:0]) && (tx_total_good_pkts_0[47:0]  == rx_total_good_pkts_0[47:0] ) && (tx_total_bytes_0[47:0]  == rx_total_bytes_0[47:0] ) && (tx_total_good_bytes_0[47:0]  == rx_total_good_bytes_0[47:0] ))
		 begin
				$display("INFO : Counters matched in Loopback Mode");
				$display("INFO  : Test PASS");
		 end
		 else
		 begin
				$display("ERROR : Counters not matched in Loopback Mode");
				$display("INFO  : Test FAILED");
				$finish;
		 end		
	    repeat (100) @(posedge tx_clk_p);
		$display("############ 1x100G TEST COMPLETE...");
		$display("INFO : Test Completed Successfully");
		$display("################################################################- MRMAC Example Design Simulation Finished- ##################################################################");     
		// $finish;
	end
  
  

	task axi_write;
        input [31:0] awaddr;
        input [31:0] wdata; 
        begin
            // *** Write address ***
            s_axi_awaddr = awaddr;
			s_axi_wdata = wdata;
            s_axi_awvalid = 1;
			s_axi_wvalid = 1;
			@(posedge s_axi_wready); 
            #pclk_cycle;
			#pclk_cycle;
			s_axi_awvalid = 0;
            s_axi_wvalid = 0;
            s_axi_awaddr = 0;
			s_axi_wdata = 0;			
			@(posedge s_axi_bvalid);
            if (s_axi_bresp !=2'b00)
			begin
				$display("############ AXI4 write error ...");
	
				$finish;
		    end 
			#pclk_cycle;
            s_axi_bready = 1'b1;
			#pclk_cycle;
			s_axi_bready = 1'b0;
			#pclk_cycle;
        end
    endtask
    
    task axi_read;
        input [31:0] araddr;
		output [31:0] read_data;
        begin
            // *** Write address ***
            s_axi_araddr = araddr;
            s_axi_arvalid = 1;
			@(posedge s_axi_arready);
		    #pclk_cycle;
			#pclk_cycle;
            s_axi_arvalid = 0;
			
			@(posedge s_axi_rvalid);	
            if (s_axi_rresp !=2'b00)
			begin
				$display("############ AXI4 read error ...");
	
		   	  $finish;
		    end			
            read_data =  s_axi_rdata; 	
			#pclk_cycle;
            s_axi_rready = 1'b1;
			#pclk_cycle;
			s_axi_rready = 1'b0;	
			#pclk_cycle;
        end
    endtask


endmodule // BOARD
