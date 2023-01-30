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
// File       : qdma_lpbk.sv
// Version    : 5.0
//-----------------------------------------------------------------------------


`timescale 1ps/1ps
//`include "qdma_axi4mm_axi_bridge_exdes.vh"
//`include "pciedmacoredefines_exdes.vh"
//`include "qdma_defines_exdes.vh"
//`include "mdma_defines_exdes.svh"
`include "qdma_stm_defines.svh"

module   qdma_lpbk #(
    parameter MAX_DATA_WIDTH    = 512,
    parameter TDEST_BITS        = 16,
    parameter TCQ               = 0
) (
    // Clock and Reset
    input                                           clk,
    input                                           rst_n,
    input                                           sys_rst_n,

    //Input from QDMA
    input  [MAX_DATA_WIDTH-1:0]                     in_axis_tdata,
    input  mdma_h2c_axis_tuser_exdes_t              in_axis_tuser,
    input                                           in_axis_tlast,
    input                                           in_axis_tvalid,
    output logic                                    in_axis_tready,

    //HDR output to QDMA
    output c2h_stub_std_cmp_t                       out_axis_cmp_data,
    output c2h_stub_std_cmp_ctrl_t                  out_axis_cmp_ctrl,
    output logic                                    out_axis_cmp_tlast,
    output logic                                    out_axis_cmp_tvalid,
    input                                           out_axis_cmp_tready,

    input  [3 :0]                                   gt_rxp_in,
    input  [3 :0]                                   gt_rxn_in,
    output [3 :0]                                   gt_txp_out,
    output [3 :0]                                   gt_txn_out,

    output wire                                     rx_gt_locked_led,
    output wire                                     rx_aligned_led,
    
    input  wire                                     gt_ref_clk_p,
    input  wire                                     gt_ref_clk_n,
    input  wire                                     init_clk,

    //PLD output to QDMA
    output mdma_c2h_axis_data_exdes_t               out_axis_pld_data,
    output mdma_c2h_axis_ctrl_exdes_t               out_axis_pld_ctrl,
    output logic [$clog2(MAX_DATA_WIDTH/8)-1:0]     out_axis_pld_mty,
    output logic                                    out_axis_pld_tlast,
    output logic                                    out_axis_pld_tvalid,
    input                                           out_axis_pld_tready
);



    //----------------------------------------------------------------
    //declarations
    //----------------------------------------------------------------
    //H2C stub
    //in
    logic [MAX_DATA_WIDTH-1:0]              h2c_stub_in_axis_tdata;
    mdma_h2c_axis_tuser_exdes_t             h2c_stub_in_axis_tuser;
    logic                                   h2c_stub_in_axis_tlast;
    logic                                   h2c_stub_in_axis_tvalid;
    logic                                   h2c_stub_in_axis_tready;
    //out
    logic [MAX_DATA_WIDTH-1:0]              h2c_stub_out_axis_tdata;
    logic                                   h2c_stub_out_axis_tvalid;
    logic [TDEST_BITS-1:0]                  h2c_stub_out_axis_tdest;
    logic                                   h2c_stub_out_axis_tuser;
    logic                                   h2c_stub_out_axis_tlast;
    logic                                   h2c_stub_out_axis_tready;

    //LPBK
    //in
    logic [MAX_DATA_WIDTH-1:0]              lpbk_in_axis_tdata;
    logic                                   lpbk_in_axis_tvalid;
    logic [TDEST_BITS-1:0]                  lpbk_in_axis_tdest;
    logic                                   lpbk_in_axis_tuser;
    logic                                   lpbk_in_axis_tlast;
    logic                                   lpbk_in_axis_tready;
    //out
    logic [MAX_DATA_WIDTH-1:0]              lpbk_out_axis_tdata;
    logic                                   lpbk_out_axis_tuser;
    logic                                   lpbk_out_axis_tlast;
    logic                                   lpbk_out_axis_tvalid;
    logic                                   lpbk_out_axis_tready;

    //C2H stub
    //in
    logic [MAX_DATA_WIDTH-1:0]              c2h_stub_in_axis_tdata;
    logic                                   c2h_stub_in_axis_tuser;
    logic                                   c2h_stub_in_axis_tlast;
    logic                                   c2h_stub_in_axis_tvalid;
    logic                                   c2h_stub_in_axis_tready;
    //cmp out
    c2h_stub_std_cmp_t                      c2h_stub_out_axis_cmp_data;
    c2h_stub_std_cmp_ctrl_t                 c2h_stub_out_axis_cmp_ctrl;
    logic                                   c2h_stub_out_axis_cmp_tlast;
    logic                                   c2h_stub_out_axis_cmp_tvalid;
    logic                                   c2h_stub_out_axis_cmp_tready;
    //pld out
    mdma_c2h_axis_data_exdes_t              c2h_stub_out_axis_pld_data;
    mdma_c2h_axis_ctrl_exdes_t              c2h_stub_out_axis_pld_ctrl;
    logic [$clog2(MAX_DATA_WIDTH/8)-1:0]    c2h_stub_out_axis_pld_mty;
    logic                                   c2h_stub_out_axis_pld_tlast;
    logic                                   c2h_stub_out_axis_pld_tvalid;
    logic                                   c2h_stub_out_axis_pld_tready;
    //----------------------------------------------------------------

    wire                        mac_tx_clk;
    wire [512-1 : 0]            mac_tx_data;
    wire [512/8-1 : 0]          mac_tx_keep;
    wire                        mac_tx_valid;
    wire                        mac_tx_last;
    wire                        mac_tx_ready;
    
    wire                        mac_rx_clk;
    wire [512-1 : 0]            mac_rx_data;
    wire [512/8-1 : 0]          mac_rx_keep;
    wire                        mac_rx_valid;
    wire                        mac_rx_last;
    wire                        mac_rx_ready;

    wire s_axis_aclk = clk;
    wire s_axis_aresetn = rst_n;
    wire m_axis_aclk = clk;

    wire usr_reset = !rst_n;
    wire sys_reset = !sys_rst_n;

    wire                        udp_tx_tvalid;
    wire                        udp_tx_tready;
    wire [512-1:0]              udp_tx_tdata;
    wire [512/8-1:0]            udp_tx_tkeep;
    wire                        udp_tx_tlast;

    wire                        udp_rx_tvalid;
    wire                        udp_rx_tready;
    wire [512-1:0]              udp_rx_tdata;
    wire [512/8-1:0]            udp_rx_tkeep;
    wire                        udp_rx_tlast;


    //----------------------------------------------------------------
    // local connections
    //----------------------------------------------------------------
    always_comb begin
        h2c_stub_in_axis_tdata          = in_axis_tdata;
        h2c_stub_in_axis_tuser          = in_axis_tuser;
        h2c_stub_in_axis_tlast          = in_axis_tlast;
        h2c_stub_in_axis_tvalid         = in_axis_tvalid;
        in_axis_tready                  = h2c_stub_in_axis_tready;

        lpbk_in_axis_tdata              = h2c_stub_out_axis_tdata;
        lpbk_in_axis_tvalid             = h2c_stub_out_axis_tvalid;
        lpbk_in_axis_tdest              = h2c_stub_out_axis_tdest;
        lpbk_in_axis_tuser              = h2c_stub_out_axis_tuser;
        lpbk_in_axis_tlast              = h2c_stub_out_axis_tlast;
        h2c_stub_out_axis_tready        = lpbk_in_axis_tready;

        out_axis_cmp_data               = c2h_stub_out_axis_cmp_data;
        out_axis_cmp_ctrl               = c2h_stub_out_axis_cmp_ctrl;
        out_axis_cmp_tlast              = c2h_stub_out_axis_cmp_tlast;
        out_axis_cmp_tvalid             = c2h_stub_out_axis_cmp_tvalid;
        c2h_stub_out_axis_cmp_tready    = out_axis_cmp_tready;

        out_axis_pld_data               = c2h_stub_out_axis_pld_data;
        out_axis_pld_ctrl               = c2h_stub_out_axis_pld_ctrl;
        out_axis_pld_mty                = c2h_stub_out_axis_pld_mty;
        out_axis_pld_tlast              = c2h_stub_out_axis_pld_tlast;
        out_axis_pld_tvalid             = c2h_stub_out_axis_pld_tvalid;
        c2h_stub_out_axis_pld_tready    = out_axis_pld_tready;
    end
    //----------------------------------------------------------------



    qdma_stm_h2c_stub #(
        .MAX_DATA_WIDTH         (MAX_DATA_WIDTH),
        .TDEST_BITS             (TDEST_BITS),
        .TCQ                    (TCQ)
    ) stm_h2c_stub (
        .clk                        (clk),
        .rst_n                      (rst_n),

        .in_axis_tdata              (h2c_stub_in_axis_tdata ),
        .in_axis_tuser              (h2c_stub_in_axis_tuser ),
        .in_axis_tlast              (h2c_stub_in_axis_tlast ),
        .in_axis_tvalid             (h2c_stub_in_axis_tvalid),
        .in_axis_tready             (h2c_stub_in_axis_tready),

        .out_axis_tdata             (h2c_stub_out_axis_tdata ),
        .out_axis_tvalid            (h2c_stub_out_axis_tvalid),
        .out_axis_tdest             (h2c_stub_out_axis_tdest ),
        .out_axis_tuser             (h2c_stub_out_axis_tuser ),
        .out_axis_tlast             (h2c_stub_out_axis_tlast ),
        .out_axis_tready            (h2c_stub_out_axis_tready)
    );

    qdma_stm_lpbk #(
        .MAX_DATA_WIDTH         (MAX_DATA_WIDTH),
        .TDEST_BITS             (TDEST_BITS),
        .TCQ                    (TCQ)
    ) qdma_stm_lpbk_inst (
        .clk                        (clk),
        .rst_n                      (rst_n),

        .in_axis_tdata              (lpbk_in_axis_tdata ),
        .in_axis_tvalid             (lpbk_in_axis_tvalid),
        .in_axis_tdest              (lpbk_in_axis_tdest ),
        .in_axis_tuser              (lpbk_in_axis_tuser ),
        .in_axis_tlast              (lpbk_in_axis_tlast ),
        .in_axis_tready             (lpbk_in_axis_tready),

        .out_axis_tdata             (lpbk_out_axis_tdata ),
        .out_axis_tuser             (lpbk_out_axis_tuser ),
        .out_axis_tlast             (lpbk_out_axis_tlast ),
        .out_axis_tvalid            (lpbk_out_axis_tvalid),
        .out_axis_tready            (lpbk_out_axis_tready)
    );

    assign c2h_stub_in_axis_tuser = 1'b0;

    axis_data_fifo_512b_128 async_tx_buffer (
        .s_axis_aresetn	(s_axis_aresetn),  // input wire s_axis_aresetn
        .s_axis_aclk	(s_axis_aclk),        // input wire s_axis_aclk
        .s_axis_tvalid	(lpbk_out_axis_tvalid),    // input wire s_axis_tvalid
        .s_axis_tready	(lpbk_out_axis_tready),    // output wire s_axis_tready
        .s_axis_tdata	(lpbk_out_axis_tdata),      // input wire [511 : 0] s_axis_tdata
        .s_axis_tkeep	(64'hffff_ffff_ffff_ffff),      // input wire [63 : 0] s_axis_tkeep
        .s_axis_tlast	(lpbk_out_axis_tlast),      // input wire s_axis_tlast
        .m_axis_aclk	(mac_tx_clk),        // input wire m_axis_aclk
        .m_axis_tvalid	(mac_tx_valid),    // output wire m_axis_tvalid
        .m_axis_tready	(mac_tx_ready),    // input wire m_axis_tready
        .m_axis_tdata	(mac_tx_data),      // output wire [511 : 0] m_axis_tdata
        .m_axis_tkeep	(mac_tx_keep),      // output wire [63 : 0] m_axis_tkeep
        .m_axis_tlast	(mac_tx_last)      // output wire m_axis_tlast
        );

    axis_data_fifo_512b_128 async_rx_buffer (
        .s_axis_aresetn	(s_axis_aresetn),  // input wire s_axis_aresetn
        .s_axis_aclk	(mac_rx_clk),        // input wire s_axis_aclk
        .s_axis_tvalid	(mac_rx_valid),    // input wire s_axis_tvalid
        .s_axis_tready	(mac_rx_ready),    // output wire s_axis_tready
        .s_axis_tdata	(mac_rx_data),      // input wire [511 : 0] s_axis_tdata
        .s_axis_tkeep	(mac_rx_keep),      // input wire [63 : 0] s_axis_tkeep
        .s_axis_tlast	(mac_rx_last),      // input wire s_axis_tlast
        .m_axis_aclk	(m_axis_aclk),        // input wire m_axis_aclk
        .m_axis_tvalid	(c2h_stub_in_axis_tvalid),    // output wire m_axis_tvalid
        .m_axis_tready	(c2h_stub_in_axis_tready),    // input wire m_axis_tready
        .m_axis_tdata	(c2h_stub_in_axis_tdata),      // output wire [511 : 0] m_axis_tdata
        .m_axis_tkeep	(),      // output wire [63 : 0] m_axis_tkeep
        .m_axis_tlast	(c2h_stub_in_axis_tlast)      // output wire m_axis_tlast
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




    qdma_stm_c2h_stub #(
        .MAX_DATA_WIDTH         (MAX_DATA_WIDTH),
        .TDEST_BITS             (TDEST_BITS),
        .TCQ                    (TCQ)
    ) stm_c2h_stub (
        .clk                        (clk),
        .rst_n                      (rst_n),

        .in_axis_tdata              (c2h_stub_in_axis_tdata ),
        .in_axis_tuser              (c2h_stub_in_axis_tuser ),
        .in_axis_tlast              (c2h_stub_in_axis_tlast ),
        .in_axis_tvalid             (c2h_stub_in_axis_tvalid),
        .in_axis_tready             (c2h_stub_in_axis_tready),

        .out_axis_cmp_data          (c2h_stub_out_axis_cmp_data  ),
        .out_axis_cmp_ctrl          (c2h_stub_out_axis_cmp_ctrl  ),
        .out_axis_cmp_tlast         (c2h_stub_out_axis_cmp_tlast ),
        .out_axis_cmp_tvalid        (c2h_stub_out_axis_cmp_tvalid),
        .out_axis_cmp_tready        (c2h_stub_out_axis_cmp_tready),

        .out_axis_pld_data          (c2h_stub_out_axis_pld_data  ),
        .out_axis_pld_ctrl          (c2h_stub_out_axis_pld_ctrl  ),
        .out_axis_pld_mty           (c2h_stub_out_axis_pld_mty   ),
        .out_axis_pld_tlast         (c2h_stub_out_axis_pld_tlast ),
        .out_axis_pld_tvalid        (c2h_stub_out_axis_pld_tvalid),
        .out_axis_pld_tready        (c2h_stub_out_axis_pld_tready)
    );
endmodule


