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
  parameter PL_LINK_CAP_MAX_LINK_WIDTH  = 8,
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

  // System IO signals
  input  wire         user_resetn,
  input  wire         sys_rst_n,
  input  wire         user_clk,
  output wire   [3:0] leds,

  
	input  wire [7:0] 		gt_line_rate,
	input wire            s_axi_aclk,
	input wire            s_axi_aresetn,
	input wire [31 : 0]   s_axi_awaddr,
	input wire            s_axi_awvalid,
	output wire           s_axi_awready,
	input wire [31 : 0]   s_axi_wdata,
	input wire            s_axi_wvalid,
	output wire           s_axi_wready,
	output wire [1 : 0]   s_axi_bresp,
	output wire           s_axi_bvalid,
	input wire            s_axi_bready,
	input wire [31 : 0]   s_axi_araddr,
	input wire            s_axi_arvalid,
	output wire           s_axi_arready,
	output wire [31 : 0]  s_axi_rdata,
	output wire [1 : 0]   s_axi_rresp,
	output wire           s_axi_rvalid,
	input wire            s_axi_rready,	

  output wire [3:0] 		stat_mst_reset_done,
	
  input  wire [3:0] 		gt_rxn_in,
  input  wire [3:0] 		gt_rxp_in,
  output wire [3:0] 		gt_txn_out,
  output wire [3:0] 		gt_txp_out,
	
  input  wire  [3:0]		gt_reset_all_in,
  input  wire [2:0] 		gt_loopback,
  input  wire       		gt_ref_clk_p,
  input  wire       		gt_ref_clk_n,

	input wire						tx_clk,
	input wire  					async_fifo_rstn

);
  // wire/reg declarations
  wire            sys_reset;
  reg  [25:0]     user_clk_heartbeat;

  wire dma_clk = user_clk;
  // wire rx_clk = tx_clk;
  wire mactx_axis_clk;
  wire macrx_axis_clk;


  // The sys_rst_n input is active low based on the core configuration
  assign sys_resetn = sys_rst_n;

  // Create a Clock Heartbeat
  always @(posedge user_clk) begin
    if(!sys_resetn) begin
      user_clk_heartbeat <= #TCQ 26'd0;
    end else begin
      user_clk_heartbeat <= #TCQ user_clk_heartbeat + 1'b1;
    end
  end

  // LEDs for observation
  assign leds[0] = sys_resetn;
  assign leds[1] = user_resetn;
  assign leds[3] = user_clk_heartbeat[25];

      // // AXI streaming ports
      // assign s_axis_c2h_tdata_0 =  m_axis_h2c_tdata_0;   
      // assign s_axis_c2h_tlast_0 =  m_axis_h2c_tlast_0;   
      // assign s_axis_c2h_tvalid_0 =  m_axis_h2c_tvalid_0;   
      // assign s_axis_c2h_tkeep_0 =  m_axis_h2c_tkeep_0;  
      // assign m_axis_h2c_tready_0 = s_axis_c2h_tready_0;

  
  wire 					  tx_axis_tready0;
  wire [63:0] 		tx_axis_tdata0;
  wire [63:0] 		tx_axis_tdata1;
  wire [63:0] 		tx_axis_tdata2;
  wire [63:0] 		tx_axis_tdata3;
  wire [7:0] 		  tx_axis_tkeep_user0;
  wire [7:0] 		  tx_axis_tkeep_user1;
  wire [7:0] 		  tx_axis_tkeep_user2;
  wire [7:0] 		  tx_axis_tkeep_user3;
  wire 						tx_axis_tlast0;
  wire 						tx_axis_tvalid0;

  wire            rx_axis_tready0;
  wire [63:0] 		rx_axis_tdata0;
  wire [63:0] 		rx_axis_tdata1;
  wire [63:0] 		rx_axis_tdata2;
  wire [63:0] 		rx_axis_tdata3;
  wire [10:0] 	  rx_axis_tkeep_user0;
  wire [10:0] 	  rx_axis_tkeep_user1;
  wire [10:0] 	  rx_axis_tkeep_user2;
  wire [10:0] 	  rx_axis_tkeep_user3;
  wire 			 		  rx_axis_tlast0;
  wire 			 		  rx_axis_tvalid0;

  // assign rx_axis_tdata0 = tx_axis_tdata0;
  // assign rx_axis_tdata1 = tx_axis_tdata1;
  // assign rx_axis_tdata2 = tx_axis_tdata2;
  // assign rx_axis_tdata3 = tx_axis_tdata3;

  // assign rx_axis_tkeep_user0 = {3'b0, tx_axis_tkeep_user0};
  // assign rx_axis_tkeep_user1 = {3'b0, tx_axis_tkeep_user1};
  // assign rx_axis_tkeep_user2 = {3'b0, tx_axis_tkeep_user2};
  // assign rx_axis_tkeep_user3 = {3'b0, tx_axis_tkeep_user3};
  
  // assign rx_axis_tvalid0 = tx_axis_tvalid0;
  // assign rx_axis_tlast0 = tx_axis_tlast0;
  // assign tx_axis_tready0 = rx_axis_tready0;

  axis_async_split inst_axis_async_split(
	.s_axis_aresetn     (sys_resetn),
	.s_axis_aclk        (dma_clk),
	.s_axis_tvalid      (m_axis_h2c_tvalid_0),
	.s_axis_tready      (m_axis_h2c_tready_0),
	.s_axis_tdata       (m_axis_h2c_tdata_0),
	.s_axis_tkeep       (m_axis_h2c_tkeep_0),
	.s_axis_tlast       (m_axis_h2c_tlast_0),

	.m_axis_aclk        (mactx_axis_clk),
	.m_axis_tvalid      (tx_axis_tvalid0),
	.m_axis_tready      (tx_axis_tready0),
	.m_axis_tdata       ({tx_axis_tdata3, tx_axis_tdata2, tx_axis_tdata1, tx_axis_tdata0}),
	.m_axis_tkeep       ({tx_axis_tkeep_user3, tx_axis_tkeep_user2, tx_axis_tkeep_user1, tx_axis_tkeep_user0}),
	.m_axis_tlast       (tx_axis_tlast0)
  );

  axis_async_conmbine inst_axis_async_conmbine(
	.s_axis_aresetn     (sys_resetn),
	.s_axis_aclk        (macrx_axis_clk),
	.s_axis_tvalid      (rx_axis_tvalid0),
	.s_axis_tready      (),
	.s_axis_tdata       ({rx_axis_tdata3, rx_axis_tdata2, rx_axis_tdata1, rx_axis_tdata0}),
	.s_axis_tkeep       ({rx_axis_tkeep_user3[7:0], rx_axis_tkeep_user2[7:0], rx_axis_tkeep_user1[7:0], rx_axis_tkeep_user0[7:0]}),
	.s_axis_tlast       (rx_axis_tlast0),

	.m_axis_aclk        (dma_clk),
	.m_axis_tvalid      (s_axis_c2h_tvalid_0),
	.m_axis_tready      (s_axis_c2h_tready_0),
	.m_axis_tdata       (s_axis_c2h_tdata_0),
	.m_axis_tkeep       (s_axis_c2h_tkeep_0),
	.m_axis_tlast       (s_axis_c2h_tlast_0)
  );

  mrmac inst_mrmac(

	.gt_line_rate         (gt_line_rate),
	.s_axi_aclk           (s_axi_aclk),
	.s_axi_aresetn        (s_axi_aresetn),
	.s_axi_awaddr         (s_axi_awaddr),
	.s_axi_awvalid        (s_axi_awvalid),
	.s_axi_awready        (s_axi_awready),
	.s_axi_wdata          (s_axi_wdata),
	.s_axi_wvalid         (s_axi_wvalid),
	.s_axi_wready         (s_axi_wready),
	.s_axi_bresp          (s_axi_bresp),
	.s_axi_bvalid         (s_axi_bvalid),
	.s_axi_bready         (s_axi_bready),
	.s_axi_araddr         (s_axi_araddr),
	.s_axi_arvalid        (s_axi_arvalid),
	.s_axi_arready        (s_axi_arready),
	.s_axi_rdata          (s_axi_rdata),
	.s_axi_rresp          (s_axi_rresp),
	.s_axi_rvalid         (s_axi_rvalid),
	.s_axi_rready         (s_axi_rready),	

  .stat_mst_reset_done  (stat_mst_reset_done),

  .gt_rxn_in            (gt_rxn_in),
  .gt_rxp_in            (gt_rxp_in),
  .gt_txn_out           (gt_txn_out),
  .gt_txp_out           (gt_txp_out),

  .gt_reset_all_in      (gt_reset_all_in),
  .gt_loopback          (gt_loopback),
  .gt_ref_clk_p         (gt_ref_clk_p),
  .gt_ref_clk_n         (gt_ref_clk_n),

	.tx_clk               (tx_clk),
	// .tx_rstn              (tx_rstn),
  
	.sys_rstn             (tx_rstn),
  .tx_user_clk          (mactx_axis_clk),
  .rx_user_clk          (macrx_axis_clk),

  .tx_axis_tready_0     (tx_axis_tready0),
  .tx_axis_tready_1     (),
  .tx_axis_tready_2     (),
  .tx_axis_tready_3     (),
  .tx_axis_tdata0       (tx_axis_tdata0),
  .tx_axis_tdata1       (tx_axis_tdata1),
  .tx_axis_tdata2       (tx_axis_tdata2),
  .tx_axis_tdata3       (tx_axis_tdata3),
  .tx_axis_tkeep_user0  ({3'b0, tx_axis_tkeep_user0}),
  .tx_axis_tkeep_user1  ({3'b0, tx_axis_tkeep_user1}),
  .tx_axis_tkeep_user2  ({3'b0, tx_axis_tkeep_user2}),
  .tx_axis_tkeep_user3  ({3'b0, tx_axis_tkeep_user3}),
  .tx_axis_tlast_0      (tx_axis_tlast0),
  .tx_axis_tlast_1      (),
  .tx_axis_tlast_2      (),
  .tx_axis_tlast_3      (),
  .tx_axis_tvalid_0     (tx_axis_tvalid0),
  .tx_axis_tvalid_1     (),
  .tx_axis_tvalid_2     (),
  .tx_axis_tvalid_3     (),

  .rx_axis_tdata0       (rx_axis_tdata0),
  .rx_axis_tdata1       (rx_axis_tdata1),
  .rx_axis_tdata2       (rx_axis_tdata2),
  .rx_axis_tdata3       (rx_axis_tdata3),
  .rx_axis_tkeep_user0  (rx_axis_tkeep_user0),
  .rx_axis_tkeep_user1  (rx_axis_tkeep_user1),
  .rx_axis_tkeep_user2  (rx_axis_tkeep_user2),
  .rx_axis_tkeep_user3  (rx_axis_tkeep_user3),
  .rx_axis_tlast_0      (rx_axis_tlast0),
  .rx_axis_tlast_1      (),
  .rx_axis_tlast_2      (),
  .rx_axis_tlast_3      (),
  .rx_axis_tvalid_0     (rx_axis_tvalid0),
  .rx_axis_tvalid_1     (),
  .rx_axis_tvalid_2     (),
  .rx_axis_tvalid_3     ()
  );



  wire    [1:0]  cfg_link_power_state;
  wire   [11:0]  cfg_function_power_state;
  wire           cfg_ext_read_received;
  wire           cfg_ext_write_received;
  wire [9:0]     cfg_ext_register_number;
  wire [7:0]     cfg_ext_function_number;
  wire [31:0]    cfg_ext_write_data;
  wire [3:0]     cfg_ext_write_byte_enable;
  wire [31:0]    cfg_ext_read_data;
  wire           cfg_ext_read_data_valid;
  wire   [3:0]   cfg_rcb_status;
  wire    [1:0]  cfg_obff_enable;
  wire    [7:0]  cfg_fc_ph;
  wire   [11:0]  cfg_fc_pd;
//  wire    [7:0]  cfg_fc_nph;
  wire   [11:0]  cfg_fc_npd;
  wire    [7:0]  cfg_fc_cplh;
  wire   [11:0]  cfg_fc_cpld;
  wire           cfg_power_state_change_ack;
  wire           cfg_power_state_change_interrupt;
  wire   [11:0]  cfg_interrupt_msi_mmenable;
  //wire [5:0]     pcie_cq_np_req_count;

//assign cfg_dbe_int = cfg_dbe | cfg_err_uncor_in;

//assign cfg_msg_transmit = 1'b0;
//assign cfg_msg_transmit_type = 3'b0;
//assign cfg_msg_transmit_data = 32'h0;

// assign cfg_fc_sel = 3'h5;

endmodule
