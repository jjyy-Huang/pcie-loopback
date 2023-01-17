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
// File       : xilinx_dma_pcie_ep.sv
// Version    : 4.1
//-----------------------------------------------------------------------------
`timescale 1ps / 1ps

module xilinx_dma_pcie_ep #
  (
   parameter PL_LINK_CAP_MAX_LINK_WIDTH          = 8,            // 1- X1; 2 - X2; 4 - X4; 8 - X8
   parameter PL_SIM_FAST_LINK_TRAINING           = "FALSE",      // Simulation Speedup
   parameter PL_LINK_CAP_MAX_LINK_SPEED          = 8,             // 1- GEN1; 2 - GEN2; 4 - GEN3
   parameter C_DATA_WIDTH                        = 512 ,
   parameter EXT_PIPE_SIM                        = "FALSE",  // This Parameter has effect on selecting Enable External PIPE Interface in GUI.
   parameter C_ROOT_PORT                         = "FALSE",      // PCIe block is in root port mode
   parameter C_DEVICE_NUMBER                     = 0,            // Device number for Root Port configurations only
   parameter AXIS_CCIX_RX_TDATA_WIDTH     = 256, 
   parameter AXIS_CCIX_TX_TDATA_WIDTH     = 256,
   parameter AXIS_CCIX_RX_TUSER_WIDTH     = 46,
   parameter AXIS_CCIX_TX_TUSER_WIDTH     = 46
   )
   (
    output [(PL_LINK_CAP_MAX_LINK_WIDTH - 1) : 0] pci_exp_txp,
    output [(PL_LINK_CAP_MAX_LINK_WIDTH - 1) : 0] pci_exp_txn,
    input [(PL_LINK_CAP_MAX_LINK_WIDTH - 1) : 0]  pci_exp_rxp,
    input [(PL_LINK_CAP_MAX_LINK_WIDTH - 1) : 0]  pci_exp_rxn,

//VU9P_TUL_EX_String= FALSE


    // synthesis translate_off
    input   [25:0]                               common_commands_in,
    input   [83:0]                               pipe_rx_0_sigs,
    input   [83:0]                               pipe_rx_1_sigs,
    input   [83:0]                               pipe_rx_2_sigs,
    input   [83:0]                               pipe_rx_3_sigs,
    input   [83:0]                               pipe_rx_4_sigs,
    input   [83:0]                               pipe_rx_5_sigs,
    input   [83:0]                               pipe_rx_6_sigs,
    input   [83:0]                               pipe_rx_7_sigs,
    input   [83:0]                               pipe_rx_8_sigs,
    input   [83:0]                               pipe_rx_9_sigs,
    input   [83:0]                               pipe_rx_10_sigs,
    input   [83:0]                               pipe_rx_11_sigs,
    input   [83:0]                               pipe_rx_12_sigs,
    input   [83:0]                               pipe_rx_13_sigs,
    input   [83:0]                               pipe_rx_14_sigs,
    input   [83:0]                               pipe_rx_15_sigs,
    output  [25:0]                               common_commands_out,
    output  [83:0]                               pipe_tx_0_sigs,
    output  [83:0]                               pipe_tx_1_sigs,
    output  [83:0]                               pipe_tx_2_sigs,
    output  [83:0]                               pipe_tx_3_sigs,
    output  [83:0]                               pipe_tx_4_sigs,
    output  [83:0]                               pipe_tx_5_sigs,
    output  [83:0]                               pipe_tx_6_sigs,
    output  [83:0]                               pipe_tx_7_sigs,
    output  [83:0]                               pipe_tx_8_sigs,
    output  [83:0]                               pipe_tx_9_sigs,
    output  [83:0]                               pipe_tx_10_sigs,
    output  [83:0]                               pipe_tx_11_sigs,
    output  [83:0]                               pipe_tx_12_sigs,
    output  [83:0]                               pipe_tx_13_sigs,
    output  [83:0]                               pipe_tx_14_sigs,
    output  [83:0]                               pipe_tx_15_sigs,
    // synthesis translate_on   


    input 					 sys_clk_p,
    input 					 sys_clk_n,
    input 					 sys_rst_n,
    
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
    input wire            async_fifo_rstn
 );

   //-----------------------------------------------------------------------------------------------------------------------

   
   // Local Parameters derived from user selection
   localparam integer 				   USER_CLK_FREQ         = ((PL_LINK_CAP_MAX_LINK_SPEED == 3'h4) ? 5 : 4);
   localparam TCQ = 1;
   localparam C_S_AXI_ID_WIDTH = 4; 
   localparam C_M_AXI_ID_WIDTH = 4; 
   localparam C_S_AXI_DATA_WIDTH = C_DATA_WIDTH;
   localparam C_M_AXI_DATA_WIDTH = C_DATA_WIDTH;
   localparam C_S_AXI_ADDR_WIDTH = 64;
   localparam C_M_AXI_ADDR_WIDTH = 64;

   localparam C_NUM_USR_IRQ	 = 1;

   
   localparam C_S_AXIS_DATA_WIDTH	     = C_DATA_WIDTH;
   localparam C_M_AXIS_DATA_WIDTH	     = C_DATA_WIDTH;
   localparam C_M_AXIS_RQ_USER_WIDTH	 = ((C_DATA_WIDTH == 512) ? 137 : 62);
   localparam C_S_AXIS_CQP_USER_WIDTH	 = ((C_DATA_WIDTH == 512) ? 183 : 88);
   localparam C_M_AXIS_RC_USER_WIDTH   = ((C_DATA_WIDTH == 512) ? 161 : 75);
   localparam C_S_AXIS_CC_USER_WIDTH	 = ((C_DATA_WIDTH == 512) ?  81 : 33);
   localparam C_S_KEEP_WIDTH		     = C_S_AXI_DATA_WIDTH / 32;
   localparam C_M_KEEP_WIDTH		     = C_M_AXI_DATA_WIDTH / 32;
   wire 					   user_lnk_up;
   
   //----------------------------------------------------------------------------------------------------------------//
   //  AXI Interface                                                                                                 //
   //----------------------------------------------------------------------------------------------------------------//
   
  wire axi_aclk;
  wire axi_aresetn;
  wire user_clk=axi_aclk;
  wire user_resetn=axi_aresetn;
   
  // Wires for Avery HOT/WARM and COLD RESET
   wire 					   avy_sys_rst_n_c;
   wire 					   avy_cfg_hot_reset_out;
   reg 						   avy_sys_rst_n_g;
   reg 						   avy_cfg_hot_reset_out_g;
   assign avy_sys_rst_n_c = avy_sys_rst_n_g;
   assign avy_cfg_hot_reset_out = avy_cfg_hot_reset_out_g;
   initial begin 
      avy_sys_rst_n_g = 1;
      avy_cfg_hot_reset_out_g =0;
   end
   


  //----------------------------------------------------------------------------------------------------------------//
  //    System(SYS) Interface                                                                                       //
  //----------------------------------------------------------------------------------------------------------------//

    wire                                    sys_clk;
    wire                                    sys_clk_gt;
    wire                                    sys_rst_n_c;

  // User Clock LED Heartbeat
     reg [25:0] 			     user_clk_heartbeat;
     reg [((2*C_NUM_USR_IRQ)-1):0]		usr_irq_function_number=0;
     reg [C_NUM_USR_IRQ-1:0] 		     usr_irq_req = 0;
     wire [C_NUM_USR_IRQ-1:0] 		     usr_irq_ack;

      //-- AXI Master Write Address Channel
     wire [C_M_AXI_ADDR_WIDTH-1:0] m_axi_awaddr;
     wire [C_M_AXI_ID_WIDTH-1:0] m_axi_awid;
     wire [2:0] 		 m_axi_awprot;
     wire [1:0] 		 m_axi_awburst;
     wire [2:0] 		 m_axi_awsize;
     wire [3:0] 		 m_axi_awcache;
     wire [7:0] 		 m_axi_awlen;
     wire 			 m_axi_awlock;
     wire 			 m_axi_awvalid;
     wire 			 m_axi_awready;

     //-- AXI Master Write Data Channel
     wire [C_M_AXI_DATA_WIDTH-1:0]     m_axi_wdata;
     wire [(C_M_AXI_DATA_WIDTH/8)-1:0] m_axi_wstrb;
     wire 			       m_axi_wlast;
     wire 			       m_axi_wvalid;
     wire 			       m_axi_wready;
     //-- AXI Master Write Response Channel
     wire 			       m_axi_bvalid;
     wire 			       m_axi_bready;
     wire [C_M_AXI_ID_WIDTH-1 : 0]     m_axi_bid ;
     wire [1:0]                        m_axi_bresp ;

     //-- AXI Master Read Address Channel
     wire [C_M_AXI_ID_WIDTH-1 : 0]     m_axi_arid;
     wire [C_M_AXI_ADDR_WIDTH-1:0]     m_axi_araddr;
     wire [7:0]                        m_axi_arlen;
     wire [2:0]                        m_axi_arsize;
     wire [1:0]                        m_axi_arburst;
     wire [2:0] 		       m_axi_arprot;
     wire 			       m_axi_arvalid;
     wire 			       m_axi_arready;
     wire 			       m_axi_arlock;
     wire [3:0] 		       m_axi_arcache;

     //-- AXI Master Read Data Channel
     wire [C_M_AXI_ID_WIDTH-1 : 0]   m_axi_rid;
     wire [C_M_AXI_DATA_WIDTH-1:0]   m_axi_rdata;
     wire [1:0] 		     m_axi_rresp;
     wire 			     m_axi_rvalid;
     wire 			     m_axi_rready;






    wire [2:0]    msi_vector_width;
    wire          msi_enable;

      // AXI streaming ports
    wire [C_DATA_WIDTH-1:0]	m_axis_h2c_tdata_0;
    wire 			m_axis_h2c_tlast_0;
    wire 			m_axis_h2c_tvalid_0;
    wire 			m_axis_h2c_tready_0;
    wire [C_DATA_WIDTH/8-1:0]	m_axis_h2c_tkeep_0;
    wire [C_DATA_WIDTH-1:0] s_axis_c2h_tdata_0; 
    wire s_axis_c2h_tlast_0;
    wire s_axis_c2h_tvalid_0;
    wire s_axis_c2h_tready_0;
    wire [C_DATA_WIDTH/8-1:0] s_axis_c2h_tkeep_0; 

    wire [3:0]                  leds;

 wire free_run_clock;
    
  wire [5:0]                          cfg_ltssm_state;

        wire          soft_reset_n;

  // Ref clock buffer
//  IBUFDS_GTE5 # (.REFCLK_HROW_CK_SEL(2'b00)) refclk_ibuf (.O(sys_clk_gt), .ODIV2(sys_clk), .I(sys_clk_p), .CEB(1'b0), .IB(sys_clk_n));
  // Reset buffer
  IBUF   sys_reset_n_ibuf (.O(sys_rst_n_c), .I(sys_rst_n));
     
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



 xdma_endpoint xdma_endpoint_i
  (
    .sys_reset (sys_rst_n_c),
    .pcie_refclk_clk_p(sys_clk_p),
    .pcie_refclk_clk_n(sys_clk_n),

    //---------------------------------------------------//
    //  PCI Express (pci_exp) Interface                  //
    //---------------------------------------------------//
    .pcie_mgt_gtx_n (pci_exp_txn),
    .pcie_mgt_gtx_p (pci_exp_txp),
    .pcie_mgt_grx_n (pci_exp_rxn),
    .pcie_mgt_grx_p (pci_exp_rxp),



    // AXI streaming ports
    .S_AXIS_C2H_0_tdata  (s_axis_c2h_tdata_0),
    .S_AXIS_C2H_0_tlast  (s_axis_c2h_tlast_0),
    .S_AXIS_C2H_0_tvalid (s_axis_c2h_tvalid_0),
    .S_AXIS_C2H_0_tready (s_axis_c2h_tready_0),
    .S_AXIS_C2H_0_tkeep  (s_axis_c2h_tkeep_0),
    .M_AXIS_H2C_0_tdata  (m_axis_h2c_tdata_0),
    .M_AXIS_H2C_0_tlast  (m_axis_h2c_tlast_0),
    .M_AXIS_H2C_0_tvalid (m_axis_h2c_tvalid_0),
    .M_AXIS_H2C_0_tready (m_axis_h2c_tready_0),
    .M_AXIS_H2C_0_tkeep  (m_axis_h2c_tkeep_0),



    .usr_irq_req  (usr_irq_req),
    .usr_irq_ack  (usr_irq_ack),
    .pipe_ep_commands_out (common_commands_in_i),
    .pipe_ep_tx_0 (pipe_rx_0_sigs_i),
    .pipe_ep_tx_1 (pipe_rx_1_sigs_i),
    .pipe_ep_tx_2 (pipe_rx_2_sigs_i),
    .pipe_ep_tx_3 (pipe_rx_3_sigs_i),
    .pipe_ep_tx_4 (pipe_rx_4_sigs_i),
    .pipe_ep_tx_5 (pipe_rx_5_sigs_i),
    .pipe_ep_tx_6 (pipe_rx_6_sigs_i),
    .pipe_ep_tx_7 (pipe_rx_7_sigs_i),
    .pipe_ep_tx_8 (pipe_rx_8_sigs_i),
    .pipe_ep_tx_9 (pipe_rx_9_sigs_i),
    .pipe_ep_tx_10(pipe_rx_10_sigs_i),
    .pipe_ep_tx_11(pipe_rx_11_sigs_i),
    .pipe_ep_tx_12(pipe_rx_12_sigs_i),
    .pipe_ep_tx_13(pipe_rx_13_sigs_i),
    .pipe_ep_tx_14(pipe_rx_14_sigs_i),
    .pipe_ep_tx_15(pipe_rx_15_sigs_i),

    .pipe_ep_commands_in(common_commands_out_i),
    .pipe_ep_rx_0  (pipe_tx_0_sigs_i),
    .pipe_ep_rx_1  (pipe_tx_1_sigs_i),
    .pipe_ep_rx_2  (pipe_tx_2_sigs_i),
    .pipe_ep_rx_3  (pipe_tx_3_sigs_i),
    .pipe_ep_rx_4  (pipe_tx_4_sigs_i),
    .pipe_ep_rx_5  (pipe_tx_5_sigs_i),
    .pipe_ep_rx_6  (pipe_tx_6_sigs_i),
    .pipe_ep_rx_7  (pipe_tx_7_sigs_i),
    .pipe_ep_rx_8  (pipe_tx_8_sigs_i),
    .pipe_ep_rx_9  (pipe_tx_9_sigs_i),
    .pipe_ep_rx_10 (pipe_tx_10_sigs_i),
    .pipe_ep_rx_11 (pipe_tx_11_sigs_i),
    .pipe_ep_rx_12 (pipe_tx_12_sigs_i),
    .pipe_ep_rx_13 (pipe_tx_13_sigs_i),
    .pipe_ep_rx_14 (pipe_tx_14_sigs_i),
    .pipe_ep_rx_15 (pipe_tx_15_sigs_i),
    //-- AXI Global
    .axi_aclk(axi_aclk),
    .phy_rdy_out (phy_rdy_out),
    .axi_aresetn (axi_aresetn),
//    .soft_reset_n(soft_reset_n),

    .user_lnk_up (user_lnk_up)
);

wire mrmac_clk;
clk_wizard_mrmac i_mrmac_clk_wiz (
  .clk_in1	(tx_clk),    
  .clk_out1	(mrmac_clk)   
);


// XDMA taget application
  xdma_app #(
    .C_M_AXI_ID_WIDTH(C_M_AXI_ID_WIDTH)
  ) xdma_app_i (


      // AXI streaming ports
      .s_axis_c2h_tdata_0(s_axis_c2h_tdata_0),  
      .s_axis_c2h_tlast_0(s_axis_c2h_tlast_0),
      .s_axis_c2h_tvalid_0(s_axis_c2h_tvalid_0), 
      .s_axis_c2h_tready_0(s_axis_c2h_tready_0),
      .s_axis_c2h_tkeep_0(s_axis_c2h_tkeep_0),
      .m_axis_h2c_tdata_0(m_axis_h2c_tdata_0),
      .m_axis_h2c_tlast_0(m_axis_h2c_tlast_0),
      .m_axis_h2c_tvalid_0(m_axis_h2c_tvalid_0),
      .m_axis_h2c_tready_0(m_axis_h2c_tready_0),
      .m_axis_h2c_tkeep_0(m_axis_h2c_tkeep_0),


      .user_clk(user_clk),
      .user_resetn(user_resetn),
      .sys_rst_n(sys_rst_n_c),

      .leds(),

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

      .tx_clk           		(mrmac_clk),
      // .tx_rstn            	(tx_rstn)
      .async_fifo_rstn      (async_fifo_rstn)
  );

endmodule
