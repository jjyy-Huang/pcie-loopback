`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/24/2022 11:21:44 AM
// Design Name: 
// Module Name: axis_async_conmbine
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


module axis_async_conmbine(
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
	input wire [255 : 0] 	s_axis_tdata;
	input wire [31 : 0] 	s_axis_tkeep;
	input wire 						s_axis_tlast;

	input wire 						m_axis_aclk;
	output wire 					m_axis_tvalid;
	input wire 						m_axis_tready;
	output wire [511 : 0] m_axis_tdata;
	output wire [63 : 0] 	m_axis_tkeep;
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

	reg in_sel_reg;
	always @(posedge s_axis_aclk or negedge s_axis_aresetn) begin
		if ( !s_axis_aresetn ) begin
			in_sel_reg <= 1'b0;
		end else if ( s_axis_tvalid & s_axis_tready ) begin
			if ( s_axis_tlast ) begin
				in_sel_reg <= 1'b0;
			end else begin
				in_sel_reg <= ~in_sel_reg;
			end
		end else begin
			in_sel_reg <= in_sel_reg;
		end
	end

	assign s_axis_tready = in_sel_reg ? s_axis_tready_fifo_1 : s_axis_tready_fifo_0;

	assign s_axis_tvalid_fifo_0 = !in_sel_reg ? s_axis_tvalid : 1'b0;
	assign s_axis_tdata_fifo_0 = s_axis_tdata;
	assign s_axis_tkeep_fifo_0 = s_axis_tkeep;
	assign s_axis_tlast_fifo_0 = s_axis_tlast;

	assign s_axis_tvalid_fifo_1 = in_sel_reg ? s_axis_tvalid : 1'b0;
	assign s_axis_tdata_fifo_1 = s_axis_tdata;
	assign s_axis_tkeep_fifo_1 = s_axis_tkeep;
	assign s_axis_tlast_fifo_1 = s_axis_tlast;

	wire invalid_fifo1 = m_axis_tlast_fifo_0;

	wire fifo_data_loaded = m_axis_tvalid_fifo_0 & m_axis_tvalid_fifo_1;

	assign m_axis_tvalid = invalid_fifo1 ? m_axis_tvalid_fifo_0 : fifo_data_loaded;
	assign m_axis_tdata = {invalid_fifo1 ? 256'b0 : m_axis_tdata_fifo_1, m_axis_tdata_fifo_0};
	assign m_axis_tkeep = {invalid_fifo1 ? 32'b0 : m_axis_tkeep_fifo_1, m_axis_tkeep_fifo_0};
	assign m_axis_tlast = m_axis_tlast_fifo_0 | m_axis_tlast_fifo_1;
	assign m_axis_tready_fifo_0 = invalid_fifo1 ? m_axis_tready : fifo_data_loaded ? m_axis_tready : 1'b0;
	assign m_axis_tready_fifo_1 = invalid_fifo1 ? 1'b0 : m_axis_tready;

  // pingpong fifo, write once per cycle, read twice at the same time
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
