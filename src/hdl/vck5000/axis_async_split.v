`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/24/2022 11:21:44 AM
// Design Name: 
// Module Name: axis_async_split
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module axis_async_split(
	s_axis_aresetn,
	s_axis_aclk,
	s_axis_tvalid,
	s_axis_tready,
	s_axis_tdata,
	s_axis_tkeep,
	s_axis_tlast,
	m_axis_aclk,
	m_axis_tvalid,
	m_axis_tready,
	m_axis_tdata,
	m_axis_tkeep,
	m_axis_tlast
	);

	input wire 						s_axis_aresetn;
	input wire 						s_axis_aclk;
	input wire 						s_axis_tvalid;
	output wire 					s_axis_tready;
	input wire [511 : 0] 	s_axis_tdata;
	input wire [63 : 0] 	s_axis_tkeep;
	input wire 						s_axis_tlast;

	input wire 						m_axis_aclk;
	output wire 					m_axis_tvalid;
	input wire 						m_axis_tready;
	output wire [255 : 0] m_axis_tdata;
	output wire [31 : 0] 	m_axis_tkeep;
	output wire 					m_axis_tlast;

	wire 						s_axis_tvalid_fifo_0;
	wire						s_axis_tready_fifo_0;
	wire [255 : 0]	s_axis_tdata_fifo_0;
	wire [31 : 0]		s_axis_tkeep_fifo_0;
	wire 						s_axis_tlast_fifo_0;
	wire 						m_axis_tvalid_fifo_0;
	wire 						m_axis_tready_fifo_0;
	wire [255 : 0]	m_axis_tdata_fifo_0;
	wire [31 : 0]		m_axis_tkeep_fifo_0;
	wire 						m_axis_tlast_fifo_0;

	wire 						s_axis_tvalid_fifo_1;
	wire						s_axis_tready_fifo_1;
	wire [255 : 0]	s_axis_tdata_fifo_1;
	wire [31 : 0]		s_axis_tkeep_fifo_1;
	wire 						s_axis_tlast_fifo_1;
	wire 						m_axis_tvalid_fifo_1;
	wire 						m_axis_tready_fifo_1;
	wire [255 : 0]	m_axis_tdata_fifo_1;
	wire [31 : 0]		m_axis_tkeep_fifo_1;
	wire 						m_axis_tlast_fifo_1;

	assign s_axis_tready = s_axis_tready_fifo_0 & s_axis_tready_fifo_1;

	assign s_axis_tvalid_fifo_0 = s_axis_tvalid;
	assign s_axis_tdata_fifo_0 = s_axis_tdata[255 : 0];
	assign s_axis_tkeep_fifo_0 = s_axis_tkeep[31 : 0];
	assign s_axis_tlast_fifo_0 = s_axis_tlast ? !s_axis_tkeep[32] : 1'b0;

	assign s_axis_tvalid_fifo_1 = s_axis_tlast ? s_axis_tkeep[32] & s_axis_tvalid : s_axis_tvalid;
	assign s_axis_tdata_fifo_1 = s_axis_tdata[511 : 0];
	assign s_axis_tkeep_fifo_1 = s_axis_tkeep[63 : 32];
	assign s_axis_tlast_fifo_1 = s_axis_tlast ? s_axis_tkeep[32] : 1'b0;

	reg out_sel_reg;
	always @(posedge m_axis_aclk or negedge s_axis_aresetn) begin
		if ( !s_axis_aresetn ) begin
			out_sel_reg <= 1'b0;
		end else if ( m_axis_tvalid & m_axis_tready ) begin
			if ( m_axis_tlast ) begin
				out_sel_reg <= 1'b0;
			end else begin
				out_sel_reg <= ~out_sel_reg;
			end
		end else begin
			out_sel_reg <= out_sel_reg;
		end
	end

	assign m_axis_tdata = out_sel_reg ? m_axis_tdata_fifo_1 : m_axis_tdata_fifo_0;
	assign m_axis_tvalid = out_sel_reg ? m_axis_tvalid_fifo_1 : m_axis_tvalid_fifo_0;
	assign m_axis_tkeep = out_sel_reg ? m_axis_tkeep_fifo_1 : m_axis_tkeep_fifo_0;
	assign m_axis_tlast = out_sel_reg ? m_axis_tlast_fifo_1 : m_axis_tlast_fifo_0;
	assign m_axis_tready_fifo_0 = !out_sel_reg ? m_axis_tready : 1'b0;
	assign m_axis_tready_fifo_1 = out_sel_reg ? m_axis_tready : 1'b0;

  // pingpong fifo, write at the same time
	axis_data_fifo_256b_128 async_buffer_pingpong_0 (
  .s_axis_aresetn	(s_axis_aresetn),  // input wire s_axis_aresetn
  .s_axis_aclk		(s_axis_aclk),        // input wire s_axis_aclk
  .s_axis_tvalid	(s_axis_tvalid_fifo_0),    // input wire s_axis_tvalid
  .s_axis_tready	(s_axis_tready_fifo_0),    // output wire s_axis_tready
  .s_axis_tdata		(s_axis_tdata_fifo_0),      // input wire [255 : 0] s_axis_tdata
  .s_axis_tkeep		(s_axis_tkeep_fifo_0),      // input wire [31 : 0] s_axis_tkeep
  .s_axis_tlast		(s_axis_tlast_fifo_0),      // input wire s_axis_tlast
  .m_axis_aclk		(m_axis_aclk),        // input wire m_axis_aclk
  .m_axis_tvalid	(m_axis_tvalid_fifo_0),    // output wire m_axis_tvalid
  .m_axis_tready	(m_axis_tready_fifo_0),    // input wire m_axis_tready
  .m_axis_tdata		(m_axis_tdata_fifo_0),      // output wire [255 : 0] m_axis_tdata
  .m_axis_tkeep		(m_axis_tkeep_fifo_0),      // output wire [31 : 0] m_axis_tkeep
  .m_axis_tlast		(m_axis_tlast_fifo_0)      // output wire m_axis_tlast
	);

	axis_data_fifo_256b_128 async_buffer_pingpong_1 (
  .s_axis_aresetn	(s_axis_aresetn),  // input wire s_axis_aresetn
  .s_axis_aclk		(s_axis_aclk),        // input wire s_axis_aclk
  .s_axis_tvalid	(s_axis_tvalid_fifo_1),    // input wire s_axis_tvalid
  .s_axis_tready	(s_axis_tready_fifo_1),    // output wire s_axis_tready
  .s_axis_tdata		(s_axis_tdata_fifo_1),      // input wire [255 : 0] s_axis_tdata
  .s_axis_tkeep		(s_axis_tkeep_fifo_1),      // input wire [31 : 0] s_axis_tkeep
  .s_axis_tlast		(s_axis_tlast_fifo_1),      // input wire s_axis_tlast
  .m_axis_aclk		(m_axis_aclk),        // input wire m_axis_aclk
  .m_axis_tvalid	(m_axis_tvalid_fifo_1),    // output wire m_axis_tvalid
  .m_axis_tready	(m_axis_tready_fifo_1),    // input wire m_axis_tready
  .m_axis_tdata		(m_axis_tdata_fifo_1),      // output wire [255 : 0] m_axis_tdata
  .m_axis_tkeep		(m_axis_tkeep_fifo_1),      // output wire [31 : 0] m_axis_tkeep
  .m_axis_tlast		(m_axis_tlast_fifo_1)      // output wire m_axis_tlast
	);

endmodule
