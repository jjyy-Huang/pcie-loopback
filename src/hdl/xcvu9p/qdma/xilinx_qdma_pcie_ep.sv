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
// File       : xilinx_qdma_pcie_ep.sv
// Version    : 5.0
//-----------------------------------------------------------------------------
`timescale 1ps / 1ps

`include "qdma_stm_defines.svh"
module xilinx_qdma_pcie_ep #
  (
    parameter PL_LINK_CAP_MAX_LINK_WIDTH  = 16,            // 1- X1; 2 - X2; 4 - X4; 8 - X8
    parameter PL_SIM_FAST_LINK_TRAINING   = "FALSE",  // Simulation Speedup
    parameter PL_LINK_CAP_MAX_LINK_SPEED  = 4,             // 1- GEN1; 2 - GEN2; 4 - GEN3
    parameter C_DATA_WIDTH                = 512 ,
    parameter EXT_PIPE_SIM                = "FALSE",  // This Parameter has effect on selecting Enable External PIPE Interface in GUI.
    parameter C_ROOT_PORT                 = "FALSE",  // PCIe block is in root port mode
    parameter C_DEVICE_NUMBER             = 0,        // Device number for Root Port configurations only
    parameter AXIS_CCIX_RX_TDATA_WIDTH    = 256,
    parameter AXIS_CCIX_TX_TDATA_WIDTH    = 256,
    parameter AXIS_CCIX_RX_TUSER_WIDTH    = 46,
    parameter AXIS_CCIX_TX_TUSER_WIDTH    = 46
  )
  (
    output [(PL_LINK_CAP_MAX_LINK_WIDTH - 1) : 0]   pci_exp_txp,
    output [(PL_LINK_CAP_MAX_LINK_WIDTH - 1) : 0]   pci_exp_txn,
    input  [(PL_LINK_CAP_MAX_LINK_WIDTH - 1) : 0]   pci_exp_rxp,
    input  [(PL_LINK_CAP_MAX_LINK_WIDTH - 1) : 0]   pci_exp_rxn,


    // synthesis translate_off
    input [25:0]  common_commands_in,
    input [83:0]  pipe_rx_0_sigs,
    input [83:0]  pipe_rx_1_sigs,
    input [83:0]  pipe_rx_2_sigs,
    input [83:0]  pipe_rx_3_sigs,
    input [83:0]  pipe_rx_4_sigs,
    input [83:0]  pipe_rx_5_sigs,
    input [83:0]  pipe_rx_6_sigs,
    input [83:0]  pipe_rx_7_sigs,
    input [83:0]  pipe_rx_8_sigs,
    input [83:0]  pipe_rx_9_sigs,
    input [83:0]  pipe_rx_10_sigs,
    input [83:0]  pipe_rx_11_sigs,
    input [83:0]  pipe_rx_12_sigs,
    input [83:0]  pipe_rx_13_sigs,
    input [83:0]  pipe_rx_14_sigs,
    input [83:0]  pipe_rx_15_sigs,
    output [25:0]  common_commands_out,
    output [83:0]  pipe_tx_0_sigs,
    output [83:0]  pipe_tx_1_sigs,
    output [83:0]  pipe_tx_2_sigs,
    output [83:0]  pipe_tx_3_sigs,
    output [83:0]  pipe_tx_4_sigs,
    output [83:0]  pipe_tx_5_sigs,
    output [83:0]  pipe_tx_6_sigs,
    output [83:0]  pipe_tx_7_sigs,
    output [83:0]  pipe_tx_8_sigs,
    output [83:0]  pipe_tx_9_sigs,
    output [83:0]  pipe_tx_10_sigs,
    output [83:0]  pipe_tx_11_sigs,
    output [83:0]  pipe_tx_12_sigs,
    output [83:0]  pipe_tx_13_sigs,
    output [83:0]  pipe_tx_14_sigs,
    output [83:0]  pipe_tx_15_sigs,
    // synthesis translate_on

    input  [3 :0]   gt_rxp_in,
    input  [3 :0]   gt_rxn_in,
    output [3 :0]   gt_txp_out,
    output [3 :0]   gt_txn_out,

    output wire     rx_gt_locked_led,
    output wire     rx_aligned_led,
    
    input  wire     gt_ref_clk_p,
    input  wire     gt_ref_clk_n,
    input  wire     init_clk,

    output  led_0,
    output  led_1,
    output  led_2,
    output  led_3,
    input   sys_clk_p,
    input   sys_clk_n,
    input   sys_rst_n
 );

   //-----------------------------------------------------------------------------------------------------------------------


   // Local Parameters derived from user selection
   localparam integer USER_CLK_FREQ = ((PL_LINK_CAP_MAX_LINK_SPEED == 3'h4) ? 5 : 4);
   localparam TCQ = 1;
   localparam C_S_AXI_ID_WIDTH   = 4;
   localparam C_M_AXI_ID_WIDTH   = 4;
   localparam C_S_AXI_DATA_WIDTH = C_DATA_WIDTH;
   localparam C_M_AXI_DATA_WIDTH = C_DATA_WIDTH;
   localparam C_S_AXI_ADDR_WIDTH = 64;
   localparam C_M_AXI_ADDR_WIDTH = 64;
   localparam C_NUM_USR_IRQ  = 16;
   localparam CRC_WIDTH          = 32;
   localparam MULTQ_EN = 1;
   localparam C_DSC_MAGIC_EN	= 1;
   localparam C_H2C_NUM_RIDS	= 64;
   localparam C_H2C_NUM_CHNL	= MULTQ_EN ? 4 : 4;
   localparam C_C2H_NUM_CHNL	= MULTQ_EN ? 4 : 4;
   localparam C_C2H_NUM_RIDS	= 32;
   localparam C_NUM_PCIE_TAGS	= 256;
   localparam C_S_AXI_NUM_READ 	= 32;
   localparam C_S_AXI_NUM_WRITE	= 8;
   localparam C_H2C_TUSER_WIDTH	= 55;
   localparam C_C2H_TUSER_WIDTH	= 64;
   localparam C_MDMA_DSC_IN_NUM_CHNL = 3;   // only 2 interface are userd. 0 is for MM and 2 is for ST. 1 is not used
   localparam C_MAX_NUM_QUEUE    = 128;
   localparam TM_DSC_BITS = 16;
  wire user_lnk_up;

  //----------------------------------------------------------------------------------------------------------------//
  //  AXI Interface                                                                                                 //
  //----------------------------------------------------------------------------------------------------------------//
  wire user_clk;
  wire axi_aclk;
  wire axi_aresetn;

  wire user_clk_dma_in;
  wire user_reset_dma_in;
  wire user_reset_dma_out;
  // Wires for Avery HOT/WARM and COLD RESET
  wire avy_sys_rst_n_c;
  wire avy_cfg_hot_reset_out;
  reg  avy_sys_rst_n_g;
  reg  avy_cfg_hot_reset_out_g;

  assign  avy_sys_rst_n_c = avy_sys_rst_n_g;
  assign  avy_cfg_hot_reset_out = avy_cfg_hot_reset_out_g;

  initial begin
    avy_sys_rst_n_g = 1;
    avy_cfg_hot_reset_out_g =0;
  end

  assign user_clk = axi_aclk;






  //----------------------------------------------------------------------------------------------------------------//
  //    System(SYS) Interface                                                                                       //
  //----------------------------------------------------------------------------------------------------------------//

  wire  sys_clk;
  wire  sys_rst_n_c;


  // User Clock LED Heartbeat
  reg [25:0] user_clk_heartbeat;

  //-- AXI Master Write Address Channel
  wire [C_M_AXI_ADDR_WIDTH-1:0]  m_axi_awaddr;
  wire [C_M_AXI_ID_WIDTH-1:0]    m_axi_awid;
  wire [2:0]                     m_axi_awprot;
  wire [1:0]                     m_axi_awburst;
  wire [2:0]                     m_axi_awsize;
  wire [3:0]                     m_axi_awcache;
  wire [7:0]                     m_axi_awlen;
  wire                           m_axi_awlock;
  wire                           m_axi_awvalid;
  wire                           m_axi_awready;

  //-- AXI Master Write Data Channel
  wire [C_M_AXI_DATA_WIDTH-1:0]      m_axi_wdata;
  wire [(C_M_AXI_DATA_WIDTH/8)-1:0]  m_axi_wstrb;
  wire                               m_axi_wlast;
  wire                               m_axi_wvalid;
  wire                               m_axi_wready;

  //-- AXI Master Write Response Channel
  wire                           m_axi_bvalid;
  wire                           m_axi_bready;
  wire [C_M_AXI_ID_WIDTH-1 : 0]  m_axi_bid ;
  wire [1:0]                     m_axi_bresp ;

  //-- AXI Master Read Address Channel
  wire [C_M_AXI_ID_WIDTH-1 : 0]  m_axi_arid;
  wire [C_M_AXI_ADDR_WIDTH-1:0]  m_axi_araddr;
  wire [7:0]                     m_axi_arlen;
  wire [2:0]                     m_axi_arsize;
  wire [1:0]                     m_axi_arburst;
  wire [2:0]                     m_axi_arprot;
  wire                           m_axi_arvalid;
  wire                           m_axi_arready;
  wire                           m_axi_arlock;
  wire [3:0]                     m_axi_arcache;

  //-- AXI Master Read Data Channel
  wire [C_M_AXI_ID_WIDTH-1 : 0]  m_axi_rid;
  wire [C_M_AXI_DATA_WIDTH-1:0]  m_axi_rdata;
  wire [1:0]                     m_axi_rresp;
  wire                           m_axi_rvalid;
  wire                           m_axi_rready;
  wire                           m_axi_rlast;


  //////////////////////////////////////////////////  LITE
  //-- AXI Master Write Address Channel
  wire [31:0] m_axil_awaddr;
  wire [2:0]  m_axil_awprot;
  wire        m_axil_awvalid;
  wire        m_axil_awready;

  //-- AXI Master Write Data Channel
  wire [31:0] m_axil_wdata;
  wire [3:0]  m_axil_wstrb;
  wire        m_axil_wvalid;
  wire        m_axil_wready;

  //-- AXI Master Write Response Channel
  wire        m_axil_bvalid;
  wire        m_axil_bready;

  //-- AXI Master Read Address Channel
  wire [31:0] m_axil_araddr;
  wire [2:0]  m_axil_arprot;
  wire        m_axil_arvalid;
  wire        m_axil_arready;

  //-- AXI Master Read Data Channel
  wire [31:0] m_axil_rdata;
  wire [1:0]  m_axil_rresp;
  wire        m_axil_rvalid;
  wire        m_axil_rready;
  wire [1:0]  m_axil_bresp;

  wire [2:0]  msi_vector_width;
  wire        msi_enable;

  wire [3:0]  leds;

  wire   free_run_clock;

  wire [5:0]  cfg_ltssm_state;

  wire [7:0]		c2h_sts_0;
  wire [7:0]		h2c_sts_0;
  wire [7:0]		c2h_sts_1;
  wire [7:0]		h2c_sts_1;
  wire [7:0]		c2h_sts_2;
  wire [7:0]		h2c_sts_2;
  wire [7:0]		c2h_sts_3;
  wire [7:0]		h2c_sts_3;

  // MDMA signals
  wire   [C_DATA_WIDTH-1:0]   m_axis_h2c_tdata;
  wire   [CRC_WIDTH-1:0]      m_axis_h2c_tcrc;
  wire   [10:0]               m_axis_h2c_tuser_qid;
  wire   [2:0]                m_axis_h2c_tuser_port_id;
  wire                        m_axis_h2c_tuser_err;
  wire   [31:0]               m_axis_h2c_tuser_mdata;
  wire   [5:0]                m_axis_h2c_tuser_mty;
  wire                        m_axis_h2c_tuser_zero_byte;
  wire                        m_axis_h2c_tvalid;
  wire                        m_axis_h2c_tready;
  wire                        m_axis_h2c_tlast;

  wire                        m_axis_h2c_tready_lpbk;
  wire                        m_axis_h2c_tready_int;

  // AXIS C2H packet wire
  wire [C_DATA_WIDTH-1:0]     s_axis_c2h_tdata;
  wire [CRC_WIDTH-1:0]        s_axis_c2h_tcrc;
  wire                        s_axis_c2h_ctrl_marker;
  wire [6:0]                  s_axis_c2h_ctrl_ecc;
  wire [15:0]                 s_axis_c2h_ctrl_len;
  wire [2:0]                  s_axis_c2h_ctrl_port_id;
  wire [10:0]                 s_axis_c2h_ctrl_qid ;
  wire                        s_axis_c2h_ctrl_has_cmpt ;
  wire [C_DATA_WIDTH-1:0]     s_axis_c2h_tdata_int;
  wire                        s_axis_c2h_ctrl_marker_int;
  wire [15:0]                 s_axis_c2h_ctrl_len_int;
  wire [10:0]                 s_axis_c2h_ctrl_qid_int ;
  wire                        s_axis_c2h_ctrl_has_cmpt_int ;
  wire                        s_axis_c2h_tvalid;
  wire                        s_axis_c2h_tready;
  wire                        s_axis_c2h_tlast;
  wire  [5:0]                 s_axis_c2h_mty;
  wire                        s_axis_c2h_tvalid_lpbk;
  wire                        s_axis_c2h_tlast_lpbk;
  wire  [5:0]                 s_axis_c2h_mty_lpbk;
  wire                        s_axis_c2h_tvalid_int;
  wire                        s_axis_c2h_tlast_int;
  wire  [5:0]                 s_axis_c2h_mty_int;

  // AXIS C2H tuser wire
  wire  [511:0] s_axis_c2h_cmpt_tdata;
  wire  [1:0]   s_axis_c2h_cmpt_size;
  wire  [15:0]  s_axis_c2h_cmpt_dpar;
  wire          s_axis_c2h_cmpt_tvalid;
  wire          s_axis_c2h_cmpt_tvalid_int;
  wire  [511:0] s_axis_c2h_cmpt_tdata_int;
  wire  [1:0]   s_axis_c2h_cmpt_size_int;
  wire  [15:0]  s_axis_c2h_cmpt_dpar_int;
  wire          s_axis_c2h_cmpt_tready_int;
  wire          s_axis_c2h_cmpt_tready;
	wire [10:0]		s_axis_c2h_cmpt_ctrl_qid;
	wire [1:0]		s_axis_c2h_cmpt_ctrl_cmpt_type;
	wire [15:0]		s_axis_c2h_cmpt_ctrl_wait_pld_pkt_id;
	wire 				  s_axis_c2h_cmpt_ctrl_marker;
	wire 				  s_axis_c2h_cmpt_ctrl_user_trig;
	wire [2:0]		s_axis_c2h_cmpt_ctrl_col_idx;
	wire [2:0]		s_axis_c2h_cmpt_ctrl_err_idx;

  // Descriptor Bypass Out for qdma
  wire  [255:0] h2c_byp_out_dsc;
  wire  [3:0]   h2c_byp_out_fmt;
  wire          h2c_byp_out_st_mm;
  wire  [10:0]  h2c_byp_out_qid;
  wire  [1:0]   h2c_byp_out_dsc_sz;
  wire          h2c_byp_out_error;
  wire  [7:0]   h2c_byp_out_func;
  wire  [15:0]  h2c_byp_out_cidx;
  wire  [2:0]   h2c_byp_out_port_id;
  wire          h2c_byp_out_vld;
  wire          h2c_byp_out_rdy;

  wire  [255:0] c2h_byp_out_dsc;
  wire  [3:0]   c2h_byp_out_fmt;
  wire          c2h_byp_out_st_mm;
  wire  [1:0]   c2h_byp_out_dsc_sz;
  wire  [10:0]  c2h_byp_out_qid;
  wire          c2h_byp_out_error;
  wire  [7:0]   c2h_byp_out_func;
  wire  [15:0]  c2h_byp_out_cidx;
  wire  [2:0]   c2h_byp_out_port_id;
  wire  [6:0]   c2h_byp_out_pfch_tag;
  wire          c2h_byp_out_vld;
  wire          c2h_byp_out_rdy;

  // Descriptor Bypass In for qdma MM
  wire  [63:0]  h2c_byp_in_mm_radr;
  wire  [63:0]  h2c_byp_in_mm_wadr;
  wire  [15:0]  h2c_byp_in_mm_len;
  wire          h2c_byp_in_mm_mrkr_req;
  wire          h2c_byp_in_mm_sdi;
  wire  [10:0]  h2c_byp_in_mm_qid;
  wire          h2c_byp_in_mm_error;
  wire  [7:0]   h2c_byp_in_mm_func;
  wire  [15:0]  h2c_byp_in_mm_cidx;
  wire  [2:0]   h2c_byp_in_mm_port_id;
  wire  [1:0]   h2c_byp_in_mm_at;
  wire          h2c_byp_in_mm_no_dma;
  wire          h2c_byp_in_mm_vld;
  wire          h2c_byp_in_mm_rdy;

  wire  [63:0]  c2h_byp_in_mm_radr;
  wire  [63:0]  c2h_byp_in_mm_wadr;
  wire  [15:0]  c2h_byp_in_mm_len;
  wire          c2h_byp_in_mm_mrkr_req;
  wire          c2h_byp_in_mm_sdi;
  wire  [10:0]  c2h_byp_in_mm_qid;
  wire          c2h_byp_in_mm_error;
  wire  [7:0]   c2h_byp_in_mm_func;
  wire  [15:0]  c2h_byp_in_mm_cidx;
  wire  [2:0]   c2h_byp_in_mm_port_id;
  wire  [1:0]   c2h_byp_in_mm_at;
  wire          c2h_byp_in_mm_no_dma;
  wire          c2h_byp_in_mm_vld;
  wire          c2h_byp_in_mm_rdy;

  // Descriptor Bypass In for qdma ST
  wire [63:0]   h2c_byp_in_st_addr;
  wire [15:0]   h2c_byp_in_st_len;
  wire          h2c_byp_in_st_eop;
  wire          h2c_byp_in_st_sop;
  wire          h2c_byp_in_st_mrkr_req;
  wire          h2c_byp_in_st_sdi;
  wire  [10:0]  h2c_byp_in_st_qid;
  wire          h2c_byp_in_st_error;
  wire  [7:0]   h2c_byp_in_st_func;
  wire  [15:0]  h2c_byp_in_st_cidx;
  wire  [2:0]   h2c_byp_in_st_port_id;
  wire  [1:0]   h2c_byp_in_st_at;
  wire          h2c_byp_in_st_no_dma;
  wire          h2c_byp_in_st_vld;
  wire          h2c_byp_in_st_rdy;

  wire  [63:0]  c2h_byp_in_st_csh_addr;
  wire  [10:0]  c2h_byp_in_st_csh_qid;
  wire          c2h_byp_in_st_csh_error;
  wire  [7:0]   c2h_byp_in_st_csh_func;
  wire  [2:0]   c2h_byp_in_st_csh_port_id;
  wire  [6:0]   c2h_byp_in_st_csh_pfch_tag;
  wire  [1:0]   c2h_byp_in_st_csh_at;
  wire          c2h_byp_in_st_csh_vld;
  wire          c2h_byp_in_st_csh_rdy;

  wire          usr_irq_in_vld;
  wire [10 : 0] usr_irq_in_vec;
  wire [7 : 0]  usr_irq_in_fnc;
  wire          usr_irq_out_ack;
  wire          usr_irq_out_fail;

  wire          st_rx_msg_rdy;
  wire          st_rx_msg_valid;
  wire          st_rx_msg_last;
  wire [31:0]   st_rx_msg_data;

  wire          tm_dsc_sts_vld;
  wire          tm_dsc_sts_qen;
  wire          tm_dsc_sts_byp;
  wire          tm_dsc_sts_dir;
  wire          tm_dsc_sts_mm;
  wire          tm_dsc_sts_error;
  wire  [10:0]  tm_dsc_sts_qid;
  wire  [15:0]  tm_dsc_sts_avl;
  wire          tm_dsc_sts_qinv;
  wire          tm_dsc_sts_irq_arm;
  wire          tm_dsc_sts_rdy;

  // Descriptor credit In
  wire          dsc_crdt_in_vld;
  wire          dsc_crdt_in_rdy;
  wire          dsc_crdt_in_dir;
  wire          dsc_crdt_in_fence;
  wire [10:0]   dsc_crdt_in_qid;
  wire [15:0]   dsc_crdt_in_crdt;

  // Report the DROP case
  wire          axis_c2h_status_drop;
  wire          axis_c2h_status_last;
  wire          axis_c2h_status_valid;
  wire          axis_c2h_status_imm_or_marker;
  wire          axis_c2h_status_cmp;
  wire [10:0]   axis_c2h_status_qid;
  wire [7:0]    qsts_out_op;
  wire [63:0]   qsts_out_data;
  wire [2:0]    qsts_out_port_id;
  wire [12:0]   qsts_out_qid;
  wire          qsts_out_vld;
  wire          qsts_out_rdy;

  wire [3:0]		cfg_tph_requester_enable;
  wire [251:0]	cfg_vf_tph_requester_enable;
	wire          soft_reset_n;
	wire					st_loopback;

  wire [10:0]   c2h_num_pkt;
  wire [10:0]   c2h_st_qid;
  wire [15:0]   c2h_st_len;
  wire [31:0]   h2c_count;
  wire          h2c_match;
  wire          clr_h2c_match;
  wire 	        c2h_end;
  wire [31:0]   c2h_control;
  wire [10:0]   h2c_qid;
  wire [31:0]   cmpt_size;
  wire [255:0]  wb_dat;

  wire [TM_DSC_BITS-1:0] credit_out;
  wire [TM_DSC_BITS-1:0] credit_needed;
  wire [TM_DSC_BITS-1:0] credit_perpkt_in;
  wire                   credit_updt;

  wire [15:0] buf_count;
  wire        sys_clk_gt;


  // Ref clock buffer

  IBUFDS_GTE4 # (.REFCLK_HROW_CK_SEL(2'b00)) refclk_ibuf (.O(sys_clk_gt), .ODIV2(sys_clk), .I(sys_clk_p), .CEB(1'b0), .IB(sys_clk_n));
  // Reset buffer
  IBUF   sys_reset_n_ibuf (.O(sys_rst_n_c), .I(sys_rst_n));
  // LED 0 pysically resides in the reconfiguable area for Tandem with
  // Field Updates designs so the OBUF must included in the app hierarchy.
  assign led_0 = leds[0];
  // LEDs 1-3 physically reside in the stage1 region for Tandem with Field
  // Updates designs so the OBUF must be instantiated at the top-level and
  // added to the stage1 region
  OBUF led_1_obuf (.O(led_1), .I(leds[1]));
  OBUF led_2_obuf (.O(led_2), .I(leds[2]));
  OBUF led_3_obuf (.O(led_3), .I(leds[3]));


  wire  [25:0]  common_commands_in_i;
  wire  [83:0]  pipe_rx_0_sigs_i;
  wire  [83:0]  pipe_rx_1_sigs_i;
  wire  [83:0]  pipe_rx_2_sigs_i;
  wire  [83:0]  pipe_rx_3_sigs_i;
  wire  [83:0]  pipe_rx_4_sigs_i;
  wire  [83:0]  pipe_rx_5_sigs_i;
  wire  [83:0]  pipe_rx_6_sigs_i;
  wire  [83:0]  pipe_rx_7_sigs_i;
  wire  [83:0]  pipe_rx_8_sigs_i;
  wire  [83:0]  pipe_rx_9_sigs_i;
  wire  [83:0]  pipe_rx_10_sigs_i;
  wire  [83:0]  pipe_rx_11_sigs_i;
  wire  [83:0]  pipe_rx_12_sigs_i;
  wire  [83:0]  pipe_rx_13_sigs_i;
  wire  [83:0]  pipe_rx_14_sigs_i;
  wire  [83:0]  pipe_rx_15_sigs_i;
  wire  [25:0]  common_commands_out_i;
  wire  [83:0]  pipe_tx_0_sigs_i;
  wire  [83:0]  pipe_tx_1_sigs_i;
  wire  [83:0]  pipe_tx_2_sigs_i;
  wire  [83:0]  pipe_tx_3_sigs_i;
  wire  [83:0]  pipe_tx_4_sigs_i;
  wire  [83:0]  pipe_tx_5_sigs_i;
  wire  [83:0]  pipe_tx_6_sigs_i;
  wire  [83:0]  pipe_tx_7_sigs_i;
  wire  [83:0]  pipe_tx_8_sigs_i;
  wire  [83:0]  pipe_tx_9_sigs_i;
  wire  [83:0]  pipe_tx_10_sigs_i;
  wire  [83:0]  pipe_tx_11_sigs_i;
  wire  [83:0]  pipe_tx_12_sigs_i;
  wire  [83:0]  pipe_tx_13_sigs_i;
  wire  [83:0]  pipe_tx_14_sigs_i;
  wire  [83:0]  pipe_tx_15_sigs_i;


// synthesis translate_off
generate if (EXT_PIPE_SIM == "TRUE")
begin
  assign common_commands_in_i = common_commands_in;
  assign pipe_rx_0_sigs_i     = pipe_rx_0_sigs;
  assign pipe_rx_1_sigs_i     = pipe_rx_1_sigs;
  assign pipe_rx_2_sigs_i     = pipe_rx_2_sigs;
  assign pipe_rx_3_sigs_i     = pipe_rx_3_sigs;
  assign pipe_rx_4_sigs_i     = pipe_rx_4_sigs;
  assign pipe_rx_5_sigs_i     = pipe_rx_5_sigs;
  assign pipe_rx_6_sigs_i     = pipe_rx_6_sigs;
  assign pipe_rx_7_sigs_i     = pipe_rx_7_sigs;
  assign pipe_rx_8_sigs_i     = pipe_rx_8_sigs;
  assign pipe_rx_9_sigs_i     = pipe_rx_9_sigs;
  assign pipe_rx_10_sigs_i    = pipe_rx_10_sigs;
  assign pipe_rx_11_sigs_i    = pipe_rx_11_sigs;
  assign pipe_rx_12_sigs_i    = pipe_rx_12_sigs;
  assign pipe_rx_13_sigs_i    = pipe_rx_13_sigs;
  assign pipe_rx_14_sigs_i    = pipe_rx_14_sigs;
  assign pipe_rx_15_sigs_i    = pipe_rx_15_sigs;
  assign common_commands_out  = common_commands_out_i;
  assign pipe_tx_0_sigs       = pipe_tx_0_sigs_i;
  assign pipe_tx_1_sigs       = pipe_tx_1_sigs_i;
  assign pipe_tx_2_sigs       = pipe_tx_2_sigs_i;
  assign pipe_tx_3_sigs       = pipe_tx_3_sigs_i;
  assign pipe_tx_4_sigs       = pipe_tx_4_sigs_i;
  assign pipe_tx_5_sigs       = pipe_tx_5_sigs_i;
  assign pipe_tx_6_sigs       = pipe_tx_6_sigs_i;
  assign pipe_tx_7_sigs       = pipe_tx_7_sigs_i;
  assign pipe_tx_8_sigs       = pipe_tx_8_sigs_i;
  assign pipe_tx_9_sigs       = pipe_tx_9_sigs_i;
  assign pipe_tx_10_sigs      = pipe_tx_10_sigs_i;
  assign pipe_tx_11_sigs      = pipe_tx_11_sigs_i;
  assign pipe_tx_12_sigs      = pipe_tx_12_sigs_i;
  assign pipe_tx_13_sigs      = pipe_tx_13_sigs_i;
  assign pipe_tx_14_sigs      = pipe_tx_14_sigs_i;
  assign pipe_tx_15_sigs      = pipe_tx_15_sigs_i;
 end
endgenerate
// synthesis translate_on

generate if (EXT_PIPE_SIM == "FALSE")
begin
  assign common_commands_in_i = 26'h0;
  assign pipe_rx_0_sigs_i     = 84'h0;
  assign pipe_rx_1_sigs_i     = 84'h0;
  assign pipe_rx_2_sigs_i     = 84'h0;
  assign pipe_rx_3_sigs_i     = 84'h0;
  assign pipe_rx_4_sigs_i     = 84'h0;
  assign pipe_rx_5_sigs_i     = 84'h0;
  assign pipe_rx_6_sigs_i     = 84'h0;
  assign pipe_rx_7_sigs_i     = 84'h0;
  assign pipe_rx_8_sigs_i     = 84'h0;
  assign pipe_rx_9_sigs_i     = 84'h0;
  assign pipe_rx_10_sigs_i    = 84'h0;
  assign pipe_rx_11_sigs_i    = 84'h0;
  assign pipe_rx_12_sigs_i    = 84'h0;
  assign pipe_rx_13_sigs_i    = 84'h0;
  assign pipe_rx_14_sigs_i    = 84'h0;
  assign pipe_rx_15_sigs_i    = 84'h0;
 end
endgenerate




//
//



  // Core Top Level Wrapper
  qdma qdma_i
     (
      .sys_rst_n       ( sys_rst_n_c ),

      .sys_clk         ( sys_clk ),
      .sys_clk_gt      ( sys_clk_gt),
      //---------------------------------------------------------------------------------------//
      //  PCI Express (pci_exp) Interface                                                      //
      //---------------------------------------------------------------------------------------//
      // Tx
      .pci_exp_txn     ( pci_exp_txn ),
      .pci_exp_txp     ( pci_exp_txp ),

      // Rx
      .pci_exp_rxn     ( pci_exp_rxn ),
      .pci_exp_rxp     ( pci_exp_rxp ),
      // LITE interface
      //-- AXI Master Write Address Channel
      .m_axil_awaddr    (m_axil_awaddr),
      .m_axil_awprot    (m_axil_awprot),
      .m_axil_awvalid   (m_axil_awvalid),
      .m_axil_awready   (m_axil_awready),
      //-- AXI Master Write Data Channel
      .m_axil_wdata     (m_axil_wdata),
      .m_axil_wstrb     (m_axil_wstrb),
      .m_axil_wvalid    (m_axil_wvalid),
      .m_axil_wready    (m_axil_wready),
      //-- AXI Master Write Response Channel
      .m_axil_bvalid    (m_axil_bvalid),
      .m_axil_bresp     (m_axil_bresp),
      .m_axil_bready    (m_axil_bready),
      //-- AXI Master Read Address Channel
      .m_axil_araddr    (m_axil_araddr),
      .m_axil_arprot    (m_axil_arprot),
      .m_axil_arvalid   (m_axil_arvalid),
      .m_axil_arready   (m_axil_arready),
      .m_axil_rdata     (m_axil_rdata),
      //-- AXI Master Read Data Channel
      .m_axil_rresp     (m_axil_rresp),
      .m_axil_rvalid    (m_axil_rvalid),
      .m_axil_rready    (m_axil_rready),


      .common_commands_in (common_commands_in_i ),
      .pipe_rx_0_sigs     (pipe_rx_0_sigs_i),
      .pipe_rx_1_sigs     (pipe_rx_1_sigs_i),
      .pipe_rx_2_sigs     (pipe_rx_2_sigs_i),
      .pipe_rx_3_sigs     (pipe_rx_3_sigs_i),
      .pipe_rx_4_sigs     (pipe_rx_4_sigs_i),
      .pipe_rx_5_sigs     (pipe_rx_5_sigs_i),
      .pipe_rx_6_sigs     (pipe_rx_6_sigs_i),
      .pipe_rx_7_sigs     (pipe_rx_7_sigs_i),
      .pipe_rx_8_sigs     (pipe_rx_8_sigs_i),
      .pipe_rx_9_sigs     (pipe_rx_9_sigs_i),
      .pipe_rx_10_sigs    (pipe_rx_10_sigs_i),
      .pipe_rx_11_sigs    (pipe_rx_11_sigs_i),
      .pipe_rx_12_sigs    (pipe_rx_12_sigs_i),
      .pipe_rx_13_sigs    (pipe_rx_13_sigs_i),
      .pipe_rx_14_sigs    (pipe_rx_14_sigs_i),
      .pipe_rx_15_sigs    (pipe_rx_15_sigs_i),
      .common_commands_out(common_commands_out_i),
      .pipe_tx_0_sigs     (pipe_tx_0_sigs_i),
      .pipe_tx_1_sigs     (pipe_tx_1_sigs_i),
      .pipe_tx_2_sigs     (pipe_tx_2_sigs_i),
      .pipe_tx_3_sigs     (pipe_tx_3_sigs_i),
      .pipe_tx_4_sigs     (pipe_tx_4_sigs_i),
      .pipe_tx_5_sigs     (pipe_tx_5_sigs_i),
      .pipe_tx_6_sigs     (pipe_tx_6_sigs_i),
      .pipe_tx_7_sigs     (pipe_tx_7_sigs_i),
      .pipe_tx_8_sigs      (pipe_tx_8_sigs_i ),
      .pipe_tx_9_sigs      (pipe_tx_9_sigs_i ),
      .pipe_tx_10_sigs     (pipe_tx_10_sigs_i),
      .pipe_tx_11_sigs     (pipe_tx_11_sigs_i),
      .pipe_tx_12_sigs     (pipe_tx_12_sigs_i),
      .pipe_tx_13_sigs     (pipe_tx_13_sigs_i),
      .pipe_tx_14_sigs     (pipe_tx_14_sigs_i),
      .pipe_tx_15_sigs     (pipe_tx_15_sigs_i),
      //-- AXI Global
      .axi_aclk        (axi_aclk),
      .axi_aresetn     (axi_aresetn ),
      .soft_reset_n    (soft_reset_n ),
      .phy_ready       (phy_ready),

      .s_axis_c2h_tdata          (s_axis_c2h_tdata ),
      .s_axis_c2h_tcrc           (s_axis_c2h_tcrc ),
      .s_axis_c2h_ctrl_marker    (s_axis_c2h_ctrl_marker),
      .s_axis_c2h_ctrl_len       (s_axis_c2h_ctrl_len), // c2h_st_len),
      .s_axis_c2h_ctrl_port_id   (s_axis_c2h_ctrl_port_id),
      .s_axis_c2h_ctrl_ecc       (s_axis_c2h_ctrl_ecc),
      .s_axis_c2h_ctrl_qid       (s_axis_c2h_ctrl_qid ), // st_qid),
      .s_axis_c2h_ctrl_has_cmpt  (s_axis_c2h_ctrl_has_cmpt),   //write back is valid
      .s_axis_c2h_tvalid         (s_axis_c2h_tvalid),
      .s_axis_c2h_tready         (s_axis_c2h_tready),
      .s_axis_c2h_tlast          (s_axis_c2h_tlast),
      .s_axis_c2h_mty            (s_axis_c2h_mty),                   // no empthy bytes at EOP

      .m_axis_h2c_tready         (m_axis_h2c_tready),
      .m_axis_h2c_tvalid         (m_axis_h2c_tvalid),
      .m_axis_h2c_tlast          (m_axis_h2c_tlast),
      .m_axis_h2c_tuser_qid      (m_axis_h2c_tuser_qid),
      .m_axis_h2c_tuser_port_id  (m_axis_h2c_tuser_port_id),
      .m_axis_h2c_tuser_err      (m_axis_h2c_tuser_err),
      .m_axis_h2c_tuser_mdata    (m_axis_h2c_tuser_mdata),
      .m_axis_h2c_tuser_mty      (m_axis_h2c_tuser_mty),
      .m_axis_h2c_tuser_zero_byte(m_axis_h2c_tuser_zero_byte),
      .m_axis_h2c_tdata          (m_axis_h2c_tdata),
      .m_axis_h2c_tcrc           (m_axis_h2c_tcrc),

      .axis_c2h_status_error         (axis_c2h_status_error),
      .axis_c2h_status_drop          (axis_c2h_status_drop),
      .axis_c2h_status_last          (axis_c2h_status_last),
      .axis_c2h_status_cmp           (axis_c2h_status_cmp),
      .axis_c2h_status_valid         (axis_c2h_status_valid),
      .axis_c2h_status_qid           (axis_c2h_status_qid),
      //.axis_c2h_status_imm_or_marker (axis_c2h_status_imm_or_marker),
      .s_axis_c2h_cmpt_tdata               (s_axis_c2h_cmpt_tdata),
      .s_axis_c2h_cmpt_size                (s_axis_c2h_cmpt_size ),
      .s_axis_c2h_cmpt_dpar                (s_axis_c2h_cmpt_dpar),
      .s_axis_c2h_cmpt_tvalid              (s_axis_c2h_cmpt_tvalid),
      .s_axis_c2h_cmpt_tready              (s_axis_c2h_cmpt_tready),
      .s_axis_c2h_cmpt_ctrl_qid            (s_axis_c2h_cmpt_ctrl_qid     ),
      .s_axis_c2h_cmpt_ctrl_cmpt_type      (s_axis_c2h_cmpt_ctrl_cmpt_type       ),
      .s_axis_c2h_cmpt_ctrl_wait_pld_pkt_id(s_axis_c2h_cmpt_ctrl_wait_pld_pkt_id ),
      .s_axis_c2h_cmpt_ctrl_port_id        (3'b000),
      .s_axis_c2h_cmpt_ctrl_marker         (s_axis_c2h_cmpt_ctrl_marker),
      .s_axis_c2h_cmpt_ctrl_no_wrb_marker  (1'b0),
      .s_axis_c2h_cmpt_ctrl_user_trig      (s_axis_c2h_cmpt_ctrl_user_trig),
      .s_axis_c2h_cmpt_ctrl_col_idx        (s_axis_c2h_cmpt_ctrl_col_idx),
      .s_axis_c2h_cmpt_ctrl_err_idx        (s_axis_c2h_cmpt_ctrl_err_idx),
      //  Descriptor Bypass Out for mdma
      .h2c_byp_out_dsc       (h2c_byp_out_dsc),
      .h2c_byp_out_fmt       (h2c_byp_out_fmt),
      .h2c_byp_out_st_mm     (h2c_byp_out_st_mm),
      .h2c_byp_out_qid       (h2c_byp_out_qid),
      .h2c_byp_out_dsc_sz    (h2c_byp_out_dsc_sz),
      .h2c_byp_out_error     (h2c_byp_out_error),
      .h2c_byp_out_func      (h2c_byp_out_func),
      .h2c_byp_out_cidx      (h2c_byp_out_cidx),
      .h2c_byp_out_port_id   (h2c_byp_out_port_id),
      .h2c_byp_out_vld       (h2c_byp_out_vld),
      .h2c_byp_out_rdy       (h2c_byp_out_rdy),
      .c2h_byp_out_dsc       (c2h_byp_out_dsc),
      .c2h_byp_out_fmt       (c2h_byp_out_fmt),
      .c2h_byp_out_st_mm     (c2h_byp_out_st_mm),
      .c2h_byp_out_dsc_sz    (c2h_byp_out_dsc_sz),
      .c2h_byp_out_qid       (c2h_byp_out_qid),
      .c2h_byp_out_error     (c2h_byp_out_error),
      .c2h_byp_out_func      (c2h_byp_out_func),
      .c2h_byp_out_cidx      (c2h_byp_out_cidx),
      .c2h_byp_out_port_id   (c2h_byp_out_port_id),
      .c2h_byp_out_pfch_tag  (c2h_byp_out_pfch_tag),
      .c2h_byp_out_vld       (c2h_byp_out_vld),
      .c2h_byp_out_rdy       (c2h_byp_out_rdy),
      .h2c_byp_in_st_addr      (h2c_byp_in_st_addr),
      .h2c_byp_in_st_len       (h2c_byp_in_st_len),
      .h2c_byp_in_st_eop       (h2c_byp_in_st_eop),
      .h2c_byp_in_st_sop       (h2c_byp_in_st_sop),
      .h2c_byp_in_st_mrkr_req  (h2c_byp_in_st_mrkr_req),
      .h2c_byp_in_st_sdi       (h2c_byp_in_st_sdi),
      .h2c_byp_in_st_qid       (h2c_byp_in_st_qid),
      .h2c_byp_in_st_error     (h2c_byp_in_st_error),
      .h2c_byp_in_st_func      (h2c_byp_in_st_func),
      .h2c_byp_in_st_cidx      (h2c_byp_in_st_cidx),
      .h2c_byp_in_st_port_id   (h2c_byp_in_st_port_id),
      .h2c_byp_in_st_no_dma    (h2c_byp_in_st_no_dma),
      .h2c_byp_in_st_vld       (h2c_byp_in_st_vld),
      .h2c_byp_in_st_rdy       (h2c_byp_in_st_rdy),
      .c2h_byp_in_st_csh_addr      (c2h_byp_in_st_csh_addr),
      .c2h_byp_in_st_csh_qid       (c2h_byp_in_st_csh_qid),
      .c2h_byp_in_st_csh_error     (c2h_byp_in_st_csh_error),
      .c2h_byp_in_st_csh_func      (c2h_byp_in_st_csh_func),
      .c2h_byp_in_st_csh_port_id   (c2h_byp_in_st_csh_port_id),
      .c2h_byp_in_st_csh_pfch_tag  (c2h_byp_in_st_csh_pfch_tag),
      .c2h_byp_in_st_csh_vld       (c2h_byp_in_st_csh_vld),
      .c2h_byp_in_st_csh_rdy       (c2h_byp_in_st_csh_rdy),

      .tm_dsc_sts_vld       (tm_dsc_sts_vld   ),
      .tm_dsc_sts_qen       (tm_dsc_sts_qen   ),
      .tm_dsc_sts_byp       (tm_dsc_sts_byp   ),
      .tm_dsc_sts_dir       (tm_dsc_sts_dir   ),
      .tm_dsc_sts_mm        (tm_dsc_sts_mm    ),
      .tm_dsc_sts_error     (tm_dsc_sts_error ),
      .tm_dsc_sts_qid       (tm_dsc_sts_qid   ),
      .tm_dsc_sts_avl       (tm_dsc_sts_avl   ),
      .tm_dsc_sts_qinv      (tm_dsc_sts_qinv  ),
      .tm_dsc_sts_irq_arm   (tm_dsc_sts_irq_arm),
      .tm_dsc_sts_rdy       (tm_dsc_sts_rdy),

      .dsc_crdt_in_vld      (dsc_crdt_in_vld),
      .dsc_crdt_in_rdy      (dsc_crdt_in_rdy),
      .dsc_crdt_in_dir      (dsc_crdt_in_dir),
      .dsc_crdt_in_fence    (dsc_crdt_in_fence),
      .dsc_crdt_in_qid      (dsc_crdt_in_qid),
      .dsc_crdt_in_crdt     (dsc_crdt_in_crdt),

      .qsts_out_op      (qsts_out_op),
      .qsts_out_data    (qsts_out_data),
      .qsts_out_port_id (qsts_out_port_id),
      .qsts_out_qid     (qsts_out_qid),
      .qsts_out_vld     (qsts_out_vld),
      .qsts_out_rdy     (qsts_out_rdy),

      .usr_irq_in_vld   (usr_irq_in_vld),
      .usr_irq_in_vec   (usr_irq_in_vec),
      .usr_irq_in_fnc   (usr_irq_in_fnc),
      .usr_irq_out_ack  (usr_irq_out_ack),
      .usr_irq_out_fail (usr_irq_out_fail),
      .user_lnk_up     ( user_lnk_up )
    );




  // QDMA target application
  qdma_app #(
    .C_M_AXI_ID_WIDTH(C_M_AXI_ID_WIDTH),
    .MAX_DATA_WIDTH(C_DATA_WIDTH),
    .TDEST_BITS(16),
    .TCQ(TCQ)
  ) qdma_app_i (
    .clk(axi_aclk),
    .rst_n(axi_aresetn),
    .soft_reset_n(soft_reset_n),

    // AXI Lite Master Interface connections
    .s_axil_awaddr  (m_axil_awaddr[31:0]),
    .s_axil_awvalid (m_axil_awvalid),
    .s_axil_awready (m_axil_awready),
    .s_axil_wdata   (m_axil_wdata[31:0]),    // block fifo for AXI lite only 31 bits.
    .s_axil_wstrb   (m_axil_wstrb[3:0]),
    .s_axil_wvalid  (m_axil_wvalid),
    .s_axil_wready  (m_axil_wready),
    .s_axil_bresp   (m_axil_bresp),
    .s_axil_bvalid  (m_axil_bvalid),
    .s_axil_bready  (m_axil_bready),
    .s_axil_araddr  (m_axil_araddr[31:0]),
    .s_axil_arvalid (m_axil_arvalid),
    .s_axil_arready (m_axil_arready),
    .s_axil_rdata   (m_axil_rdata),   // block ram for AXI Lite is only 31 bits
    .s_axil_rresp   (m_axil_rresp),
    .s_axil_rvalid  (m_axil_rvalid),
    .s_axil_rready  (m_axil_rready),



    .c2h_byp_out_dsc      (c2h_byp_out_dsc),
    .c2h_byp_out_fmt      (c2h_byp_out_fmt),
    .c2h_byp_out_st_mm    (c2h_byp_out_st_mm),
    .c2h_byp_out_dsc_sz   (c2h_byp_out_dsc_sz),
    .c2h_byp_out_qid      (c2h_byp_out_qid),
    .c2h_byp_out_error    (c2h_byp_out_error),
    .c2h_byp_out_func     (c2h_byp_out_func),
    .c2h_byp_out_cidx     (c2h_byp_out_cidx),
    .c2h_byp_out_port_id  (c2h_byp_out_port_id),
    .c2h_byp_out_pfch_tag (c2h_byp_out_pfch_tag),
    .c2h_byp_out_vld      (c2h_byp_out_vld),
    .c2h_byp_out_rdy      (c2h_byp_out_rdy),

    .c2h_byp_in_mm_radr     (c2h_byp_in_mm_radr),
    .c2h_byp_in_mm_wadr     (c2h_byp_in_mm_wadr),
    .c2h_byp_in_mm_len      (c2h_byp_in_mm_len),
    .c2h_byp_in_mm_mrkr_req (c2h_byp_in_mm_mrkr_req),
    .c2h_byp_in_mm_sdi      (c2h_byp_in_mm_sdi),
    .c2h_byp_in_mm_qid      (c2h_byp_in_mm_qid),
    .c2h_byp_in_mm_error    (c2h_byp_in_mm_error),
    .c2h_byp_in_mm_func     (c2h_byp_in_mm_func),
    .c2h_byp_in_mm_cidx     (c2h_byp_in_mm_cidx),
    .c2h_byp_in_mm_port_id  (c2h_byp_in_mm_port_id),
    .c2h_byp_in_mm_at       (c2h_byp_in_mm_at),
    .c2h_byp_in_mm_no_dma   (c2h_byp_in_mm_no_dma),
    .c2h_byp_in_mm_vld      (c2h_byp_in_mm_vld),
    .c2h_byp_in_mm_rdy      (c2h_byp_in_mm_rdy),

    .c2h_byp_in_st_csh_addr    (c2h_byp_in_st_csh_addr),
    .c2h_byp_in_st_csh_qid     (c2h_byp_in_st_csh_qid),
    .c2h_byp_in_st_csh_error   (c2h_byp_in_st_csh_error),
    .c2h_byp_in_st_csh_func    (c2h_byp_in_st_csh_func),
    .c2h_byp_in_st_csh_port_id (c2h_byp_in_st_csh_port_id),
    .c2h_byp_in_st_csh_pfch_tag(c2h_byp_in_st_csh_pfch_tag),
    .c2h_byp_in_st_csh_at      (c2h_byp_in_st_csh_at),
    .c2h_byp_in_st_csh_vld     (c2h_byp_in_st_csh_vld),
    .c2h_byp_in_st_csh_rdy     (c2h_byp_in_st_csh_rdy),

    .h2c_byp_out_dsc      (h2c_byp_out_dsc),
    .h2c_byp_out_fmt      (h2c_byp_out_fmt),
    .h2c_byp_out_st_mm    (h2c_byp_out_st_mm),
    .h2c_byp_out_dsc_sz   (h2c_byp_out_dsc_sz),
    .h2c_byp_out_qid      (h2c_byp_out_qid),
    .h2c_byp_out_error    (h2c_byp_out_error),
    .h2c_byp_out_func     (h2c_byp_out_func),
    .h2c_byp_out_cidx     (h2c_byp_out_cidx),
    .h2c_byp_out_port_id  (h2c_byp_out_port_id),
    .h2c_byp_out_vld      (h2c_byp_out_vld),
    .h2c_byp_out_rdy      (h2c_byp_out_rdy),

    .h2c_byp_in_mm_radr     (h2c_byp_in_mm_radr),
    .h2c_byp_in_mm_wadr     (h2c_byp_in_mm_wadr),
    .h2c_byp_in_mm_len      (h2c_byp_in_mm_len),
    .h2c_byp_in_mm_mrkr_req (h2c_byp_in_mm_mrkr_req),
    .h2c_byp_in_mm_sdi      (h2c_byp_in_mm_sdi),
    .h2c_byp_in_mm_qid      (h2c_byp_in_mm_qid),
    .h2c_byp_in_mm_error    (h2c_byp_in_mm_error),
    .h2c_byp_in_mm_func     (h2c_byp_in_mm_func),
    .h2c_byp_in_mm_cidx     (h2c_byp_in_mm_cidx),
    .h2c_byp_in_mm_port_id  (h2c_byp_in_mm_port_id),
    .h2c_byp_in_mm_at       (h2c_byp_in_mm_at),
    .h2c_byp_in_mm_no_dma   (h2c_byp_in_mm_no_dma),
    .h2c_byp_in_mm_vld      (h2c_byp_in_mm_vld),
    .h2c_byp_in_mm_rdy      (h2c_byp_in_mm_rdy),

    .h2c_byp_in_st_addr     (h2c_byp_in_st_addr),
    .h2c_byp_in_st_len      (h2c_byp_in_st_len),
    .h2c_byp_in_st_eop      (h2c_byp_in_st_eop),
    .h2c_byp_in_st_sop      (h2c_byp_in_st_sop),
    .h2c_byp_in_st_mrkr_req (h2c_byp_in_st_mrkr_req),
    .h2c_byp_in_st_sdi      (h2c_byp_in_st_sdi),
    .h2c_byp_in_st_qid      (h2c_byp_in_st_qid),
    .h2c_byp_in_st_error    (h2c_byp_in_st_error),
    .h2c_byp_in_st_func     (h2c_byp_in_st_func),
    .h2c_byp_in_st_cidx     (h2c_byp_in_st_cidx),
    .h2c_byp_in_st_port_id  (h2c_byp_in_st_port_id),
    .h2c_byp_in_st_at       (h2c_byp_in_st_at),
    .h2c_byp_in_st_no_dma   (h2c_byp_in_st_no_dma),
    .h2c_byp_in_st_vld      (h2c_byp_in_st_vld),
    .h2c_byp_in_st_rdy      (h2c_byp_in_st_rdy),

    .user_clk(axi_aclk),
    .user_resetn(axi_aresetn),
    .user_lnk_up(user_lnk_up),



    .sys_rst_n(sys_rst_n_c),

    .m_axis_h2c_tvalid         (m_axis_h2c_tvalid),
    .m_axis_h2c_tready         (m_axis_h2c_tready),
    .m_axis_h2c_tdata          (m_axis_h2c_tdata),
    .m_axis_h2c_tcrc           (m_axis_h2c_tcrc),
    .m_axis_h2c_tlast          (m_axis_h2c_tlast),
    .m_axis_h2c_tuser_qid      (m_axis_h2c_tuser_qid),
    .m_axis_h2c_tuser_port_id  (m_axis_h2c_tuser_port_id),
    .m_axis_h2c_tuser_err      (m_axis_h2c_tuser_err),
    .m_axis_h2c_tuser_mdata    (m_axis_h2c_tuser_mdata),
    .m_axis_h2c_tuser_mty      (m_axis_h2c_tuser_mty),
    .m_axis_h2c_tuser_zero_byte(m_axis_h2c_tuser_zero_byte),

    .s_axis_c2h_tdata          (s_axis_c2h_tdata ),
    .s_axis_c2h_tcrc           (s_axis_c2h_tcrc  ),
    .s_axis_c2h_ctrl_marker    (s_axis_c2h_ctrl_marker),
    .s_axis_c2h_ctrl_len       (s_axis_c2h_ctrl_len), // c2h_st_len,
    .s_axis_c2h_ctrl_port_id   (s_axis_c2h_ctrl_port_id),
    .s_axis_c2h_ctrl_ecc       (s_axis_c2h_ctrl_ecc),
    .s_axis_c2h_ctrl_qid       (s_axis_c2h_ctrl_qid ), // st_qid,
    .s_axis_c2h_ctrl_has_cmpt  (s_axis_c2h_ctrl_has_cmpt),   // write back is valid
    .s_axis_c2h_tvalid         (s_axis_c2h_tvalid),
    .s_axis_c2h_tready         (s_axis_c2h_tready),
    .s_axis_c2h_tlast          (s_axis_c2h_tlast ),
    .s_axis_c2h_mty            (s_axis_c2h_mty ),  // no empthy bytes at EOP

    .s_axis_c2h_cmpt_tdata               (s_axis_c2h_cmpt_tdata),
    .s_axis_c2h_cmpt_size                (s_axis_c2h_cmpt_size),
    .s_axis_c2h_cmpt_dpar                (s_axis_c2h_cmpt_dpar),
    .s_axis_c2h_cmpt_tvalid              (s_axis_c2h_cmpt_tvalid),
    .s_axis_c2h_cmpt_tready              (s_axis_c2h_cmpt_tready),
    .s_axis_c2h_cmpt_ctrl_qid            (s_axis_c2h_cmpt_ctrl_qid),
    .s_axis_c2h_cmpt_ctrl_cmpt_type      (s_axis_c2h_cmpt_ctrl_cmpt_type),
    .s_axis_c2h_cmpt_ctrl_wait_pld_pkt_id(s_axis_c2h_cmpt_ctrl_wait_pld_pkt_id ),
    .s_axis_c2h_cmpt_ctrl_marker         (s_axis_c2h_cmpt_ctrl_marker),
    .s_axis_c2h_cmpt_ctrl_user_trig      (s_axis_c2h_cmpt_ctrl_user_trig),
    .s_axis_c2h_cmpt_ctrl_col_idx        (s_axis_c2h_cmpt_ctrl_col_idx),
    .s_axis_c2h_cmpt_ctrl_err_idx        (s_axis_c2h_cmpt_ctrl_err_idx),

    .qsts_out_op      (qsts_out_op),
    .qsts_out_data    (qsts_out_data),
    .qsts_out_port_id (qsts_out_port_id),
    .qsts_out_qid     (qsts_out_qid),
    .qsts_out_vld     (qsts_out_vld),
    .qsts_out_rdy     (qsts_out_rdy),

    .usr_irq_in_vld   (usr_irq_in_vld),
    .usr_irq_in_vec   (usr_irq_in_vec),
    .usr_irq_in_fnc   (usr_irq_in_fnc),
    .usr_irq_out_ack  (usr_irq_out_ack),
    .usr_irq_out_fail (usr_irq_out_fail),


    .tm_dsc_sts_vld     (tm_dsc_sts_vld   ),
    .tm_dsc_sts_qen     (tm_dsc_sts_qen   ),
    .tm_dsc_sts_byp     (tm_dsc_sts_byp   ),
    .tm_dsc_sts_dir     (tm_dsc_sts_dir   ),
    .tm_dsc_sts_mm      (tm_dsc_sts_mm    ),
    .tm_dsc_sts_error   (tm_dsc_sts_error ),
    .tm_dsc_sts_qid     (tm_dsc_sts_qid   ),
    .tm_dsc_sts_avl     (tm_dsc_sts_avl   ),
    .tm_dsc_sts_qinv    (tm_dsc_sts_qinv  ),
    .tm_dsc_sts_irq_arm (tm_dsc_sts_irq_arm),
    .tm_dsc_sts_rdy     (tm_dsc_sts_rdy),

    .dsc_crdt_in_vld        (dsc_crdt_in_vld),
    .dsc_crdt_in_rdy        (dsc_crdt_in_rdy),
    .dsc_crdt_in_dir        (dsc_crdt_in_dir),
    .dsc_crdt_in_fence      (dsc_crdt_in_fence),
    .dsc_crdt_in_qid        (dsc_crdt_in_qid),
    .dsc_crdt_in_crdt       (dsc_crdt_in_crdt),

    .gt_rxp_in          (gt_rxp_in),
    .gt_rxn_in          (gt_rxn_in),
    .gt_txp_out         (gt_txp_out),
    .gt_txn_out         (gt_txn_out),

    .rx_gt_locked_led   (rx_gt_locked_led),
    .rx_aligned_led     (rx_aligned_led),
    
    .gt_ref_clk_p       (gt_ref_clk_p),
    .gt_ref_clk_n       (gt_ref_clk_n),
    .init_clk           (init_clk),

    .leds(leds)

  );

endmodule

