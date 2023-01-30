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
// File       : xdma_app.v
// Version    : 4.1
//-----------------------------------------------------------------------------

`timescale 1ps / 1ps
module xdma_app #(
  parameter TCQ                         = 1,
  parameter C_M_AXI_ID_WIDTH            = 4,
  parameter PL_LINK_CAP_MAX_LINK_WIDTH  = 16,
  parameter C_DATA_WIDTH                = 512,
  parameter C_M_AXI_DATA_WIDTH          = C_DATA_WIDTH,
  parameter C_S_AXI_DATA_WIDTH          = C_DATA_WIDTH,
  parameter C_S_AXIS_DATA_WIDTH         = C_DATA_WIDTH,
  parameter C_M_AXIS_DATA_WIDTH         = C_DATA_WIDTH,
  parameter C_M_AXIS_RQ_USER_WIDTH      = ((C_DATA_WIDTH == 512) ? 137 : 62),
  parameter C_S_AXIS_CQP_USER_WIDTH     = ((C_DATA_WIDTH == 512) ? 183 : 88),
  parameter C_M_AXIS_RC_USER_WIDTH      = ((C_DATA_WIDTH == 512) ? 161 : 75),
  parameter C_S_AXIS_CC_USER_WIDTH      = ((C_DATA_WIDTH == 512) ?  81 : 33),
  parameter C_S_KEEP_WIDTH              = C_S_AXI_DATA_WIDTH / 32,
  parameter C_M_KEEP_WIDTH              = (C_M_AXI_DATA_WIDTH / 32),
  parameter C_XDMA_NUM_CHNL             = 1
)
(


//VU9P_TUL_EX_String= FALSE
  // AXI streaming ports
  output wire [C_DATA_WIDTH-1:0] s_axis_c2h_tdata_0,  
  output wire s_axis_c2h_tlast_0,
  output wire s_axis_c2h_tvalid_0,
  input  wire s_axis_c2h_tready_0,
  output wire [C_DATA_WIDTH/8-1:0] s_axis_c2h_tkeep_0,
  input  wire [C_DATA_WIDTH-1:0] m_axis_h2c_tdata_0,
  input  wire m_axis_h2c_tlast_0,
  input  wire m_axis_h2c_tvalid_0,
  output wire m_axis_h2c_tready_0,
  input  wire [C_DATA_WIDTH/8-1:0] m_axis_h2c_tkeep_0,

  input  [3 :0]   gt_rxp_in,
  input  [3 :0]   gt_rxn_in,
  output [3 :0]   gt_txp_out,
  output [3 :0]   gt_txn_out,

  output wire     rx_gt_locked_led,
  output wire     rx_aligned_led,
  
  input  wire     gt_ref_clk_p,
  input  wire     gt_ref_clk_n,
  input  wire     init_clk,

  // System IO signals
  input  wire         user_resetn,
  input  wire         sys_rst_n,
 
  input  wire         user_clk,
  input  wire         user_lnk_up,
 
  output wire   [3:0] leds

);
  // wire/reg declarations
  wire            sys_reset = !sys_rst_n;
  reg  [25:0]     user_clk_heartbeat;


  // The sys_rst_n input is active low based on the core configuration
  assign sys_resetn = sys_rst_n;
  wire usr_reset = !user_resetn;

  // Create a Clock Heartbeat
  always @(posedge user_clk) begin
    if(!sys_resetn) begin
      user_clk_heartbeat <= #TCQ 26'd0;
    end else begin
      user_clk_heartbeat <= #TCQ user_clk_heartbeat + 1'b1;
    end
  end

  // LED 0 pysically resides in the reconfiguable area for Tandem with 
  // Field Updates designs so the OBUF must included in this hierarchy.
  OBUF led_0_obuf (.O(leds[0]), .I(sys_resetn));
  // LEDs 1-3 physically reside in the stage1 region for Tandem with Field 
  // Updates designs so the OBUF must be instantiated at the top-level.
  assign leds[1] = user_resetn;
  assign leds[2] = user_lnk_up;
  assign leds[3] = user_clk_heartbeat[25];
  
  wire                        mac_tx_clk;
  wire [C_DATA_WIDTH-1 : 0]   mac_tx_data;
  wire [C_DATA_WIDTH/8-1 : 0] mac_tx_keep;
  wire                        mac_tx_valid;
  wire                        mac_tx_last;
  wire                        mac_tx_ready;
  
  wire                        mac_rx_clk;
  wire [C_DATA_WIDTH-1 : 0]   mac_rx_data;
  wire [C_DATA_WIDTH/8-1 : 0] mac_rx_keep;
  wire                        mac_rx_valid;
  wire                        mac_rx_last;
  wire                        mac_rx_ready;

  wire s_axis_aclk = user_clk;
  wire s_axis_aresetn = user_resetn;
  wire m_axis_aclk = user_clk;

  wire                      udp_tx_tvalid;
  wire                      udp_tx_tready;
  wire [C_DATA_WIDTH-1:0]   udp_tx_tdata;
  wire [C_DATA_WIDTH/8-1:0] udp_tx_tkeep;
  wire                      udp_tx_tlast;

  wire                      udp_rx_tvalid;
  wire                      udp_rx_tready;
  wire [C_DATA_WIDTH-1:0]   udp_rx_tdata;
  wire [C_DATA_WIDTH/8-1:0] udp_rx_tkeep;
  wire                      udp_rx_tlast;
  
  axis_data_fifo_512b_128 async_tx_buffer (
    .s_axis_aresetn	(s_axis_aresetn),  // input wire s_axis_aresetn
    .s_axis_aclk		(s_axis_aclk),        // input wire s_axis_aclk
    .s_axis_tvalid	(m_axis_h2c_tvalid_0),    // input wire s_axis_tvalid
    .s_axis_tready	(m_axis_h2c_tready_0),    // output wire s_axis_tready
    .s_axis_tdata		(m_axis_h2c_tdata_0),      // input wire [511 : 0] s_axis_tdata
    .s_axis_tkeep		(m_axis_h2c_tkeep_0),      // input wire [63 : 0] s_axis_tkeep
    .s_axis_tlast		(m_axis_h2c_tlast_0),      // input wire s_axis_tlast
    .m_axis_aclk		(mac_tx_clk),        // input wire m_axis_aclk
    .m_axis_tvalid	(mac_tx_valid),    // output wire m_axis_tvalid
    .m_axis_tready	(mac_tx_ready),    // input wire m_axis_tready
    .m_axis_tdata		(mac_tx_data),      // output wire [511 : 0] m_axis_tdata
    .m_axis_tkeep		(mac_tx_keep),      // output wire [63 : 0] m_axis_tkeep
    .m_axis_tlast		(mac_tx_last)      // output wire m_axis_tlast
	);

  axis_data_fifo_512b_128 async_rx_buffer (
    .s_axis_aresetn	(s_axis_aresetn),  // input wire s_axis_aresetn
    .s_axis_aclk		(mac_rx_clk),        // input wire s_axis_aclk
    .s_axis_tvalid	(mac_rx_valid),    // input wire s_axis_tvalid
    .s_axis_tready	(mac_rx_ready),    // output wire s_axis_tready
    .s_axis_tdata		(mac_rx_data),      // input wire [511 : 0] s_axis_tdata
    .s_axis_tkeep		(mac_rx_keep),      // input wire [63 : 0] s_axis_tkeep
    .s_axis_tlast		(mac_rx_last),      // input wire s_axis_tlast
    .m_axis_aclk		(m_axis_aclk),        // input wire m_axis_aclk
    .m_axis_tvalid	(s_axis_c2h_tvalid_0),    // output wire m_axis_tvalid
    .m_axis_tready	(s_axis_c2h_tready_0),    // input wire m_axis_tready
    .m_axis_tdata		(s_axis_c2h_tdata_0),      // output wire [511 : 0] m_axis_tdata
    .m_axis_tkeep		(s_axis_c2h_tkeep_0),      // output wire [63 : 0] m_axis_tkeep
    .m_axis_tlast		(s_axis_c2h_tlast_0)      // output wire m_axis_tlast
	);

  
  cmac inst_cmac(
    .gt_rxp_in            (gt_rxp_in),
    .gt_rxn_in            (gt_rxn_in),
    .gt_txp_out           (gt_txp_out),
    .gt_txn_out           (gt_txn_out),

    .rx_gt_locked_led     (rx_gt_locked_led),
    .rx_aligned_led       (rx_aligned_led),

    .sys_reset            (sys_reset),

    .rx_clk_out           (mac_rx_clk),
    .tx_clk_out           (mac_tx_clk),

    .rx_reset             (usr_reset),
    .rx_axis_tvalid       (mac_rx_valid),
    .rx_axis_tdata        (mac_rx_data),
    .rx_axis_tkeep        (mac_rx_keep),
    .rx_axis_tlast        (mac_rx_last),
    .rx_axis_tuser        (),

    .tx_reset             (usr_reset),
    .tx_axis_tready       (mac_tx_ready),
    .tx_axis_tvalid       (mac_tx_valid),
    .tx_axis_tdata        (mac_tx_data),
    .tx_axis_tkeep        (mac_tx_keep),
    .tx_axis_tlast        (mac_tx_last),
    .tx_axis_tuser        (1'b0),

    .gt_ref_clk_p         (gt_ref_clk_p),
    .gt_ref_clk_n         (gt_ref_clk_n),
    .init_clk             (init_clk)
  );



endmodule
