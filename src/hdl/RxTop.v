// Generator : SpinalHDL v1.7.1    git head : 0444bb76ab1d6e19f0ec46bc03c4769776deb7d5
// Component : RxTop
// Git hash  : ad1b4551b969650a2c4cc6464eab127a247ff4cf
// 
// @Author : Jinyuan Huang (Jerry) jjyy.huang@gmail.com
// @Create : Thu Jan 26 19:44:51 UTC 2023

`timescale 1ns/1ps

module RxTop (
  input               io_dataAxisIn_valid,
  output              io_dataAxisIn_ready,
  input      [255:0]  io_dataAxisIn_payload_data,
  input      [31:0]   io_dataAxisIn_payload_keep,
  input               io_dataAxisIn_payload_last,
  input      [31:0]   io_dataAxisIn_payload_user,
  output              io_metaOut_valid,
  input               io_metaOut_ready,
  output     [11:0]   io_metaOut_payload_dataLen,
  output     [47:0]   io_metaOut_payload_dstMacAddr,
  output     [31:0]   io_metaOut_payload_dstIpAddr,
  output     [47:0]   io_metaOut_payload_srcMacAddr,
  output     [31:0]   io_metaOut_payload_srcIpAddr,
  output     [15:0]   io_metaOut_payload_dstPort,
  output     [15:0]   io_metaOut_payload_srcPort,
  output              io_dataAxisOut_valid,
  input               io_dataAxisOut_ready,
  output     [255:0]  io_dataAxisOut_payload_data,
  output     [31:0]   io_dataAxisOut_payload_keep,
  output              io_dataAxisOut_payload_last,
  output reg [31:0]   io_dataAxisOut_payload_user,
  input               clk,
  input               reset
);

  reg        [31:0]   io_dataAxisIn_fifo_io_push_payload_user;
  reg        [31:0]   headerRecognizer_1_io_dataAxisIn_payload_user;
  wire                headerRecognizer_1_io_metaOut_ready;
  wire                headerRecognizer_1_io_dataAxisOut_ready;
  wire                io_dataAxisIn_fifo_io_push_ready;
  wire                io_dataAxisIn_fifo_io_pop_valid;
  wire       [255:0]  io_dataAxisIn_fifo_io_pop_payload_data;
  wire       [31:0]   io_dataAxisIn_fifo_io_pop_payload_keep;
  wire                io_dataAxisIn_fifo_io_pop_payload_last;
  wire       [31:0]   io_dataAxisIn_fifo_io_pop_payload_user;
  wire       [8:0]    io_dataAxisIn_fifo_io_occupancy;
  wire       [8:0]    io_dataAxisIn_fifo_io_availability;
  wire                headerRecognizer_1_io_dataAxisIn_ready;
  wire                headerRecognizer_1_io_metaOut_valid;
  wire       [11:0]   headerRecognizer_1_io_metaOut_payload_dataLen;
  wire       [47:0]   headerRecognizer_1_io_metaOut_payload_dstMacAddr;
  wire       [31:0]   headerRecognizer_1_io_metaOut_payload_dstIpAddr;
  wire       [47:0]   headerRecognizer_1_io_metaOut_payload_srcMacAddr;
  wire       [31:0]   headerRecognizer_1_io_metaOut_payload_srcIpAddr;
  wire       [15:0]   headerRecognizer_1_io_metaOut_payload_dstPort;
  wire       [15:0]   headerRecognizer_1_io_metaOut_payload_srcPort;
  wire                headerRecognizer_1_io_dataAxisOut_valid;
  wire       [255:0]  headerRecognizer_1_io_dataAxisOut_payload_data;
  wire       [31:0]   headerRecognizer_1_io_dataAxisOut_payload_keep;
  wire                headerRecognizer_1_io_dataAxisOut_payload_last;
  wire       [31:0]   headerRecognizer_1_io_dataAxisOut_payload_user;
  wire                headerRecognizer_1_io_dataAxisOut_s2mPipe_valid;
  reg                 headerRecognizer_1_io_dataAxisOut_s2mPipe_ready;
  wire       [255:0]  headerRecognizer_1_io_dataAxisOut_s2mPipe_payload_data;
  wire       [31:0]   headerRecognizer_1_io_dataAxisOut_s2mPipe_payload_keep;
  wire                headerRecognizer_1_io_dataAxisOut_s2mPipe_payload_last;
  reg        [31:0]   headerRecognizer_1_io_dataAxisOut_s2mPipe_payload_user;
  reg                 headerRecognizer_1_io_dataAxisOut_rValid;
  reg        [255:0]  headerRecognizer_1_io_dataAxisOut_rData_data;
  reg        [31:0]   headerRecognizer_1_io_dataAxisOut_rData_keep;
  reg                 headerRecognizer_1_io_dataAxisOut_rData_last;
  reg        [31:0]   headerRecognizer_1_io_dataAxisOut_rData_user;
  wire       [31:0]   _zz_headerRecognizer_io_dataAxisOut_s2mPipe_payload_user;
  wire                headerRecognizer_1_io_dataAxisOut_s2mPipe_m2sPipe_valid;
  wire                headerRecognizer_1_io_dataAxisOut_s2mPipe_m2sPipe_ready;
  wire       [255:0]  headerRecognizer_1_io_dataAxisOut_s2mPipe_m2sPipe_payload_data;
  wire       [31:0]   headerRecognizer_1_io_dataAxisOut_s2mPipe_m2sPipe_payload_keep;
  wire                headerRecognizer_1_io_dataAxisOut_s2mPipe_m2sPipe_payload_last;
  reg        [31:0]   headerRecognizer_1_io_dataAxisOut_s2mPipe_m2sPipe_payload_user;
  reg                 headerRecognizer_1_io_dataAxisOut_s2mPipe_rValid;
  reg        [255:0]  headerRecognizer_1_io_dataAxisOut_s2mPipe_rData_data;
  reg        [31:0]   headerRecognizer_1_io_dataAxisOut_s2mPipe_rData_keep;
  reg                 headerRecognizer_1_io_dataAxisOut_s2mPipe_rData_last;
  reg        [31:0]   headerRecognizer_1_io_dataAxisOut_s2mPipe_rData_user;
  wire                when_Stream_l368;
  wire                headerRecognizer_1_io_metaOut_s2mPipe_valid;
  reg                 headerRecognizer_1_io_metaOut_s2mPipe_ready;
  wire       [11:0]   headerRecognizer_1_io_metaOut_s2mPipe_payload_dataLen;
  wire       [47:0]   headerRecognizer_1_io_metaOut_s2mPipe_payload_dstMacAddr;
  wire       [31:0]   headerRecognizer_1_io_metaOut_s2mPipe_payload_dstIpAddr;
  wire       [47:0]   headerRecognizer_1_io_metaOut_s2mPipe_payload_srcMacAddr;
  wire       [31:0]   headerRecognizer_1_io_metaOut_s2mPipe_payload_srcIpAddr;
  wire       [15:0]   headerRecognizer_1_io_metaOut_s2mPipe_payload_dstPort;
  wire       [15:0]   headerRecognizer_1_io_metaOut_s2mPipe_payload_srcPort;
  reg                 headerRecognizer_1_io_metaOut_rValid;
  reg        [11:0]   headerRecognizer_1_io_metaOut_rData_dataLen;
  reg        [47:0]   headerRecognizer_1_io_metaOut_rData_dstMacAddr;
  reg        [31:0]   headerRecognizer_1_io_metaOut_rData_dstIpAddr;
  reg        [47:0]   headerRecognizer_1_io_metaOut_rData_srcMacAddr;
  reg        [31:0]   headerRecognizer_1_io_metaOut_rData_srcIpAddr;
  reg        [15:0]   headerRecognizer_1_io_metaOut_rData_dstPort;
  reg        [15:0]   headerRecognizer_1_io_metaOut_rData_srcPort;
  wire                headerRecognizer_1_io_metaOut_s2mPipe_m2sPipe_valid;
  wire                headerRecognizer_1_io_metaOut_s2mPipe_m2sPipe_ready;
  wire       [11:0]   headerRecognizer_1_io_metaOut_s2mPipe_m2sPipe_payload_dataLen;
  wire       [47:0]   headerRecognizer_1_io_metaOut_s2mPipe_m2sPipe_payload_dstMacAddr;
  wire       [31:0]   headerRecognizer_1_io_metaOut_s2mPipe_m2sPipe_payload_dstIpAddr;
  wire       [47:0]   headerRecognizer_1_io_metaOut_s2mPipe_m2sPipe_payload_srcMacAddr;
  wire       [31:0]   headerRecognizer_1_io_metaOut_s2mPipe_m2sPipe_payload_srcIpAddr;
  wire       [15:0]   headerRecognizer_1_io_metaOut_s2mPipe_m2sPipe_payload_dstPort;
  wire       [15:0]   headerRecognizer_1_io_metaOut_s2mPipe_m2sPipe_payload_srcPort;
  reg                 headerRecognizer_1_io_metaOut_s2mPipe_rValid;
  reg        [11:0]   headerRecognizer_1_io_metaOut_s2mPipe_rData_dataLen;
  reg        [47:0]   headerRecognizer_1_io_metaOut_s2mPipe_rData_dstMacAddr;
  reg        [31:0]   headerRecognizer_1_io_metaOut_s2mPipe_rData_dstIpAddr;
  reg        [47:0]   headerRecognizer_1_io_metaOut_s2mPipe_rData_srcMacAddr;
  reg        [31:0]   headerRecognizer_1_io_metaOut_s2mPipe_rData_srcIpAddr;
  reg        [15:0]   headerRecognizer_1_io_metaOut_s2mPipe_rData_dstPort;
  reg        [15:0]   headerRecognizer_1_io_metaOut_s2mPipe_rData_srcPort;
  wire                when_Stream_l368_1;

  StreamFifo io_dataAxisIn_fifo (
    .io_push_valid        (io_dataAxisIn_valid                          ), //i
    .io_push_ready        (io_dataAxisIn_fifo_io_push_ready             ), //o
    .io_push_payload_data (io_dataAxisIn_payload_data[255:0]            ), //i
    .io_push_payload_keep (io_dataAxisIn_payload_keep[31:0]             ), //i
    .io_push_payload_last (io_dataAxisIn_payload_last                   ), //i
    .io_push_payload_user (io_dataAxisIn_fifo_io_push_payload_user[31:0]), //i
    .io_pop_valid         (io_dataAxisIn_fifo_io_pop_valid              ), //o
    .io_pop_ready         (headerRecognizer_1_io_dataAxisIn_ready       ), //i
    .io_pop_payload_data  (io_dataAxisIn_fifo_io_pop_payload_data[255:0]), //o
    .io_pop_payload_keep  (io_dataAxisIn_fifo_io_pop_payload_keep[31:0] ), //o
    .io_pop_payload_last  (io_dataAxisIn_fifo_io_pop_payload_last       ), //o
    .io_pop_payload_user  (io_dataAxisIn_fifo_io_pop_payload_user[31:0] ), //o
    .io_flush             (1'b0                                         ), //i
    .io_occupancy         (io_dataAxisIn_fifo_io_occupancy[8:0]         ), //o
    .io_availability      (io_dataAxisIn_fifo_io_availability[8:0]      ), //o
    .clk                  (clk                                          ), //i
    .reset                (reset                                        )  //i
  );
  HeaderRecognizer headerRecognizer_1 (
    .io_dataAxisIn_valid           (io_dataAxisIn_fifo_io_pop_valid                       ), //i
    .io_dataAxisIn_ready           (headerRecognizer_1_io_dataAxisIn_ready                ), //o
    .io_dataAxisIn_payload_data    (io_dataAxisIn_fifo_io_pop_payload_data[255:0]         ), //i
    .io_dataAxisIn_payload_keep    (io_dataAxisIn_fifo_io_pop_payload_keep[31:0]          ), //i
    .io_dataAxisIn_payload_last    (io_dataAxisIn_fifo_io_pop_payload_last                ), //i
    .io_dataAxisIn_payload_user    (headerRecognizer_1_io_dataAxisIn_payload_user[31:0]   ), //i
    .io_metaOut_valid              (headerRecognizer_1_io_metaOut_valid                   ), //o
    .io_metaOut_ready              (headerRecognizer_1_io_metaOut_ready                   ), //i
    .io_metaOut_payload_dataLen    (headerRecognizer_1_io_metaOut_payload_dataLen[11:0]   ), //o
    .io_metaOut_payload_dstMacAddr (headerRecognizer_1_io_metaOut_payload_dstMacAddr[47:0]), //o
    .io_metaOut_payload_dstIpAddr  (headerRecognizer_1_io_metaOut_payload_dstIpAddr[31:0] ), //o
    .io_metaOut_payload_srcMacAddr (headerRecognizer_1_io_metaOut_payload_srcMacAddr[47:0]), //o
    .io_metaOut_payload_srcIpAddr  (headerRecognizer_1_io_metaOut_payload_srcIpAddr[31:0] ), //o
    .io_metaOut_payload_dstPort    (headerRecognizer_1_io_metaOut_payload_dstPort[15:0]   ), //o
    .io_metaOut_payload_srcPort    (headerRecognizer_1_io_metaOut_payload_srcPort[15:0]   ), //o
    .io_dataAxisOut_valid          (headerRecognizer_1_io_dataAxisOut_valid               ), //o
    .io_dataAxisOut_ready          (headerRecognizer_1_io_dataAxisOut_ready               ), //i
    .io_dataAxisOut_payload_data   (headerRecognizer_1_io_dataAxisOut_payload_data[255:0] ), //o
    .io_dataAxisOut_payload_keep   (headerRecognizer_1_io_dataAxisOut_payload_keep[31:0]  ), //o
    .io_dataAxisOut_payload_last   (headerRecognizer_1_io_dataAxisOut_payload_last        ), //o
    .io_dataAxisOut_payload_user   (headerRecognizer_1_io_dataAxisOut_payload_user[31:0]  ), //o
    .clk                           (clk                                                   ), //i
    .reset                         (reset                                                 )  //i
  );
  assign io_dataAxisIn_ready = io_dataAxisIn_fifo_io_push_ready;
  always @(*) begin
    io_dataAxisIn_fifo_io_push_payload_user[0 : 0] = io_dataAxisIn_payload_user[0 : 0];
    io_dataAxisIn_fifo_io_push_payload_user[1 : 1] = io_dataAxisIn_payload_user[1 : 1];
    io_dataAxisIn_fifo_io_push_payload_user[2 : 2] = io_dataAxisIn_payload_user[2 : 2];
    io_dataAxisIn_fifo_io_push_payload_user[3 : 3] = io_dataAxisIn_payload_user[3 : 3];
    io_dataAxisIn_fifo_io_push_payload_user[4 : 4] = io_dataAxisIn_payload_user[4 : 4];
    io_dataAxisIn_fifo_io_push_payload_user[5 : 5] = io_dataAxisIn_payload_user[5 : 5];
    io_dataAxisIn_fifo_io_push_payload_user[6 : 6] = io_dataAxisIn_payload_user[6 : 6];
    io_dataAxisIn_fifo_io_push_payload_user[7 : 7] = io_dataAxisIn_payload_user[7 : 7];
    io_dataAxisIn_fifo_io_push_payload_user[8 : 8] = io_dataAxisIn_payload_user[8 : 8];
    io_dataAxisIn_fifo_io_push_payload_user[9 : 9] = io_dataAxisIn_payload_user[9 : 9];
    io_dataAxisIn_fifo_io_push_payload_user[10 : 10] = io_dataAxisIn_payload_user[10 : 10];
    io_dataAxisIn_fifo_io_push_payload_user[11 : 11] = io_dataAxisIn_payload_user[11 : 11];
    io_dataAxisIn_fifo_io_push_payload_user[12 : 12] = io_dataAxisIn_payload_user[12 : 12];
    io_dataAxisIn_fifo_io_push_payload_user[13 : 13] = io_dataAxisIn_payload_user[13 : 13];
    io_dataAxisIn_fifo_io_push_payload_user[14 : 14] = io_dataAxisIn_payload_user[14 : 14];
    io_dataAxisIn_fifo_io_push_payload_user[15 : 15] = io_dataAxisIn_payload_user[15 : 15];
    io_dataAxisIn_fifo_io_push_payload_user[16 : 16] = io_dataAxisIn_payload_user[16 : 16];
    io_dataAxisIn_fifo_io_push_payload_user[17 : 17] = io_dataAxisIn_payload_user[17 : 17];
    io_dataAxisIn_fifo_io_push_payload_user[18 : 18] = io_dataAxisIn_payload_user[18 : 18];
    io_dataAxisIn_fifo_io_push_payload_user[19 : 19] = io_dataAxisIn_payload_user[19 : 19];
    io_dataAxisIn_fifo_io_push_payload_user[20 : 20] = io_dataAxisIn_payload_user[20 : 20];
    io_dataAxisIn_fifo_io_push_payload_user[21 : 21] = io_dataAxisIn_payload_user[21 : 21];
    io_dataAxisIn_fifo_io_push_payload_user[22 : 22] = io_dataAxisIn_payload_user[22 : 22];
    io_dataAxisIn_fifo_io_push_payload_user[23 : 23] = io_dataAxisIn_payload_user[23 : 23];
    io_dataAxisIn_fifo_io_push_payload_user[24 : 24] = io_dataAxisIn_payload_user[24 : 24];
    io_dataAxisIn_fifo_io_push_payload_user[25 : 25] = io_dataAxisIn_payload_user[25 : 25];
    io_dataAxisIn_fifo_io_push_payload_user[26 : 26] = io_dataAxisIn_payload_user[26 : 26];
    io_dataAxisIn_fifo_io_push_payload_user[27 : 27] = io_dataAxisIn_payload_user[27 : 27];
    io_dataAxisIn_fifo_io_push_payload_user[28 : 28] = io_dataAxisIn_payload_user[28 : 28];
    io_dataAxisIn_fifo_io_push_payload_user[29 : 29] = io_dataAxisIn_payload_user[29 : 29];
    io_dataAxisIn_fifo_io_push_payload_user[30 : 30] = io_dataAxisIn_payload_user[30 : 30];
    io_dataAxisIn_fifo_io_push_payload_user[31 : 31] = io_dataAxisIn_payload_user[31 : 31];
  end

  always @(*) begin
    headerRecognizer_1_io_dataAxisIn_payload_user[0 : 0] = io_dataAxisIn_fifo_io_pop_payload_user[0 : 0];
    headerRecognizer_1_io_dataAxisIn_payload_user[1 : 1] = io_dataAxisIn_fifo_io_pop_payload_user[1 : 1];
    headerRecognizer_1_io_dataAxisIn_payload_user[2 : 2] = io_dataAxisIn_fifo_io_pop_payload_user[2 : 2];
    headerRecognizer_1_io_dataAxisIn_payload_user[3 : 3] = io_dataAxisIn_fifo_io_pop_payload_user[3 : 3];
    headerRecognizer_1_io_dataAxisIn_payload_user[4 : 4] = io_dataAxisIn_fifo_io_pop_payload_user[4 : 4];
    headerRecognizer_1_io_dataAxisIn_payload_user[5 : 5] = io_dataAxisIn_fifo_io_pop_payload_user[5 : 5];
    headerRecognizer_1_io_dataAxisIn_payload_user[6 : 6] = io_dataAxisIn_fifo_io_pop_payload_user[6 : 6];
    headerRecognizer_1_io_dataAxisIn_payload_user[7 : 7] = io_dataAxisIn_fifo_io_pop_payload_user[7 : 7];
    headerRecognizer_1_io_dataAxisIn_payload_user[8 : 8] = io_dataAxisIn_fifo_io_pop_payload_user[8 : 8];
    headerRecognizer_1_io_dataAxisIn_payload_user[9 : 9] = io_dataAxisIn_fifo_io_pop_payload_user[9 : 9];
    headerRecognizer_1_io_dataAxisIn_payload_user[10 : 10] = io_dataAxisIn_fifo_io_pop_payload_user[10 : 10];
    headerRecognizer_1_io_dataAxisIn_payload_user[11 : 11] = io_dataAxisIn_fifo_io_pop_payload_user[11 : 11];
    headerRecognizer_1_io_dataAxisIn_payload_user[12 : 12] = io_dataAxisIn_fifo_io_pop_payload_user[12 : 12];
    headerRecognizer_1_io_dataAxisIn_payload_user[13 : 13] = io_dataAxisIn_fifo_io_pop_payload_user[13 : 13];
    headerRecognizer_1_io_dataAxisIn_payload_user[14 : 14] = io_dataAxisIn_fifo_io_pop_payload_user[14 : 14];
    headerRecognizer_1_io_dataAxisIn_payload_user[15 : 15] = io_dataAxisIn_fifo_io_pop_payload_user[15 : 15];
    headerRecognizer_1_io_dataAxisIn_payload_user[16 : 16] = io_dataAxisIn_fifo_io_pop_payload_user[16 : 16];
    headerRecognizer_1_io_dataAxisIn_payload_user[17 : 17] = io_dataAxisIn_fifo_io_pop_payload_user[17 : 17];
    headerRecognizer_1_io_dataAxisIn_payload_user[18 : 18] = io_dataAxisIn_fifo_io_pop_payload_user[18 : 18];
    headerRecognizer_1_io_dataAxisIn_payload_user[19 : 19] = io_dataAxisIn_fifo_io_pop_payload_user[19 : 19];
    headerRecognizer_1_io_dataAxisIn_payload_user[20 : 20] = io_dataAxisIn_fifo_io_pop_payload_user[20 : 20];
    headerRecognizer_1_io_dataAxisIn_payload_user[21 : 21] = io_dataAxisIn_fifo_io_pop_payload_user[21 : 21];
    headerRecognizer_1_io_dataAxisIn_payload_user[22 : 22] = io_dataAxisIn_fifo_io_pop_payload_user[22 : 22];
    headerRecognizer_1_io_dataAxisIn_payload_user[23 : 23] = io_dataAxisIn_fifo_io_pop_payload_user[23 : 23];
    headerRecognizer_1_io_dataAxisIn_payload_user[24 : 24] = io_dataAxisIn_fifo_io_pop_payload_user[24 : 24];
    headerRecognizer_1_io_dataAxisIn_payload_user[25 : 25] = io_dataAxisIn_fifo_io_pop_payload_user[25 : 25];
    headerRecognizer_1_io_dataAxisIn_payload_user[26 : 26] = io_dataAxisIn_fifo_io_pop_payload_user[26 : 26];
    headerRecognizer_1_io_dataAxisIn_payload_user[27 : 27] = io_dataAxisIn_fifo_io_pop_payload_user[27 : 27];
    headerRecognizer_1_io_dataAxisIn_payload_user[28 : 28] = io_dataAxisIn_fifo_io_pop_payload_user[28 : 28];
    headerRecognizer_1_io_dataAxisIn_payload_user[29 : 29] = io_dataAxisIn_fifo_io_pop_payload_user[29 : 29];
    headerRecognizer_1_io_dataAxisIn_payload_user[30 : 30] = io_dataAxisIn_fifo_io_pop_payload_user[30 : 30];
    headerRecognizer_1_io_dataAxisIn_payload_user[31 : 31] = io_dataAxisIn_fifo_io_pop_payload_user[31 : 31];
  end

  assign headerRecognizer_1_io_dataAxisOut_ready = (! headerRecognizer_1_io_dataAxisOut_rValid);
  assign headerRecognizer_1_io_dataAxisOut_s2mPipe_valid = (headerRecognizer_1_io_dataAxisOut_valid || headerRecognizer_1_io_dataAxisOut_rValid);
  assign _zz_headerRecognizer_io_dataAxisOut_s2mPipe_payload_user = (headerRecognizer_1_io_dataAxisOut_rValid ? headerRecognizer_1_io_dataAxisOut_rData_user : headerRecognizer_1_io_dataAxisOut_payload_user);
  assign headerRecognizer_1_io_dataAxisOut_s2mPipe_payload_data = (headerRecognizer_1_io_dataAxisOut_rValid ? headerRecognizer_1_io_dataAxisOut_rData_data : headerRecognizer_1_io_dataAxisOut_payload_data);
  assign headerRecognizer_1_io_dataAxisOut_s2mPipe_payload_keep = (headerRecognizer_1_io_dataAxisOut_rValid ? headerRecognizer_1_io_dataAxisOut_rData_keep : headerRecognizer_1_io_dataAxisOut_payload_keep);
  assign headerRecognizer_1_io_dataAxisOut_s2mPipe_payload_last = (headerRecognizer_1_io_dataAxisOut_rValid ? headerRecognizer_1_io_dataAxisOut_rData_last : headerRecognizer_1_io_dataAxisOut_payload_last);
  always @(*) begin
    headerRecognizer_1_io_dataAxisOut_s2mPipe_payload_user[0 : 0] = _zz_headerRecognizer_io_dataAxisOut_s2mPipe_payload_user[0 : 0];
    headerRecognizer_1_io_dataAxisOut_s2mPipe_payload_user[1 : 1] = _zz_headerRecognizer_io_dataAxisOut_s2mPipe_payload_user[1 : 1];
    headerRecognizer_1_io_dataAxisOut_s2mPipe_payload_user[2 : 2] = _zz_headerRecognizer_io_dataAxisOut_s2mPipe_payload_user[2 : 2];
    headerRecognizer_1_io_dataAxisOut_s2mPipe_payload_user[3 : 3] = _zz_headerRecognizer_io_dataAxisOut_s2mPipe_payload_user[3 : 3];
    headerRecognizer_1_io_dataAxisOut_s2mPipe_payload_user[4 : 4] = _zz_headerRecognizer_io_dataAxisOut_s2mPipe_payload_user[4 : 4];
    headerRecognizer_1_io_dataAxisOut_s2mPipe_payload_user[5 : 5] = _zz_headerRecognizer_io_dataAxisOut_s2mPipe_payload_user[5 : 5];
    headerRecognizer_1_io_dataAxisOut_s2mPipe_payload_user[6 : 6] = _zz_headerRecognizer_io_dataAxisOut_s2mPipe_payload_user[6 : 6];
    headerRecognizer_1_io_dataAxisOut_s2mPipe_payload_user[7 : 7] = _zz_headerRecognizer_io_dataAxisOut_s2mPipe_payload_user[7 : 7];
    headerRecognizer_1_io_dataAxisOut_s2mPipe_payload_user[8 : 8] = _zz_headerRecognizer_io_dataAxisOut_s2mPipe_payload_user[8 : 8];
    headerRecognizer_1_io_dataAxisOut_s2mPipe_payload_user[9 : 9] = _zz_headerRecognizer_io_dataAxisOut_s2mPipe_payload_user[9 : 9];
    headerRecognizer_1_io_dataAxisOut_s2mPipe_payload_user[10 : 10] = _zz_headerRecognizer_io_dataAxisOut_s2mPipe_payload_user[10 : 10];
    headerRecognizer_1_io_dataAxisOut_s2mPipe_payload_user[11 : 11] = _zz_headerRecognizer_io_dataAxisOut_s2mPipe_payload_user[11 : 11];
    headerRecognizer_1_io_dataAxisOut_s2mPipe_payload_user[12 : 12] = _zz_headerRecognizer_io_dataAxisOut_s2mPipe_payload_user[12 : 12];
    headerRecognizer_1_io_dataAxisOut_s2mPipe_payload_user[13 : 13] = _zz_headerRecognizer_io_dataAxisOut_s2mPipe_payload_user[13 : 13];
    headerRecognizer_1_io_dataAxisOut_s2mPipe_payload_user[14 : 14] = _zz_headerRecognizer_io_dataAxisOut_s2mPipe_payload_user[14 : 14];
    headerRecognizer_1_io_dataAxisOut_s2mPipe_payload_user[15 : 15] = _zz_headerRecognizer_io_dataAxisOut_s2mPipe_payload_user[15 : 15];
    headerRecognizer_1_io_dataAxisOut_s2mPipe_payload_user[16 : 16] = _zz_headerRecognizer_io_dataAxisOut_s2mPipe_payload_user[16 : 16];
    headerRecognizer_1_io_dataAxisOut_s2mPipe_payload_user[17 : 17] = _zz_headerRecognizer_io_dataAxisOut_s2mPipe_payload_user[17 : 17];
    headerRecognizer_1_io_dataAxisOut_s2mPipe_payload_user[18 : 18] = _zz_headerRecognizer_io_dataAxisOut_s2mPipe_payload_user[18 : 18];
    headerRecognizer_1_io_dataAxisOut_s2mPipe_payload_user[19 : 19] = _zz_headerRecognizer_io_dataAxisOut_s2mPipe_payload_user[19 : 19];
    headerRecognizer_1_io_dataAxisOut_s2mPipe_payload_user[20 : 20] = _zz_headerRecognizer_io_dataAxisOut_s2mPipe_payload_user[20 : 20];
    headerRecognizer_1_io_dataAxisOut_s2mPipe_payload_user[21 : 21] = _zz_headerRecognizer_io_dataAxisOut_s2mPipe_payload_user[21 : 21];
    headerRecognizer_1_io_dataAxisOut_s2mPipe_payload_user[22 : 22] = _zz_headerRecognizer_io_dataAxisOut_s2mPipe_payload_user[22 : 22];
    headerRecognizer_1_io_dataAxisOut_s2mPipe_payload_user[23 : 23] = _zz_headerRecognizer_io_dataAxisOut_s2mPipe_payload_user[23 : 23];
    headerRecognizer_1_io_dataAxisOut_s2mPipe_payload_user[24 : 24] = _zz_headerRecognizer_io_dataAxisOut_s2mPipe_payload_user[24 : 24];
    headerRecognizer_1_io_dataAxisOut_s2mPipe_payload_user[25 : 25] = _zz_headerRecognizer_io_dataAxisOut_s2mPipe_payload_user[25 : 25];
    headerRecognizer_1_io_dataAxisOut_s2mPipe_payload_user[26 : 26] = _zz_headerRecognizer_io_dataAxisOut_s2mPipe_payload_user[26 : 26];
    headerRecognizer_1_io_dataAxisOut_s2mPipe_payload_user[27 : 27] = _zz_headerRecognizer_io_dataAxisOut_s2mPipe_payload_user[27 : 27];
    headerRecognizer_1_io_dataAxisOut_s2mPipe_payload_user[28 : 28] = _zz_headerRecognizer_io_dataAxisOut_s2mPipe_payload_user[28 : 28];
    headerRecognizer_1_io_dataAxisOut_s2mPipe_payload_user[29 : 29] = _zz_headerRecognizer_io_dataAxisOut_s2mPipe_payload_user[29 : 29];
    headerRecognizer_1_io_dataAxisOut_s2mPipe_payload_user[30 : 30] = _zz_headerRecognizer_io_dataAxisOut_s2mPipe_payload_user[30 : 30];
    headerRecognizer_1_io_dataAxisOut_s2mPipe_payload_user[31 : 31] = _zz_headerRecognizer_io_dataAxisOut_s2mPipe_payload_user[31 : 31];
  end

  always @(*) begin
    headerRecognizer_1_io_dataAxisOut_s2mPipe_ready = headerRecognizer_1_io_dataAxisOut_s2mPipe_m2sPipe_ready;
    if(when_Stream_l368) begin
      headerRecognizer_1_io_dataAxisOut_s2mPipe_ready = 1'b1;
    end
  end

  assign when_Stream_l368 = (! headerRecognizer_1_io_dataAxisOut_s2mPipe_m2sPipe_valid);
  assign headerRecognizer_1_io_dataAxisOut_s2mPipe_m2sPipe_valid = headerRecognizer_1_io_dataAxisOut_s2mPipe_rValid;
  assign headerRecognizer_1_io_dataAxisOut_s2mPipe_m2sPipe_payload_data = headerRecognizer_1_io_dataAxisOut_s2mPipe_rData_data;
  assign headerRecognizer_1_io_dataAxisOut_s2mPipe_m2sPipe_payload_keep = headerRecognizer_1_io_dataAxisOut_s2mPipe_rData_keep;
  assign headerRecognizer_1_io_dataAxisOut_s2mPipe_m2sPipe_payload_last = headerRecognizer_1_io_dataAxisOut_s2mPipe_rData_last;
  always @(*) begin
    headerRecognizer_1_io_dataAxisOut_s2mPipe_m2sPipe_payload_user[0 : 0] = headerRecognizer_1_io_dataAxisOut_s2mPipe_rData_user[0 : 0];
    headerRecognizer_1_io_dataAxisOut_s2mPipe_m2sPipe_payload_user[1 : 1] = headerRecognizer_1_io_dataAxisOut_s2mPipe_rData_user[1 : 1];
    headerRecognizer_1_io_dataAxisOut_s2mPipe_m2sPipe_payload_user[2 : 2] = headerRecognizer_1_io_dataAxisOut_s2mPipe_rData_user[2 : 2];
    headerRecognizer_1_io_dataAxisOut_s2mPipe_m2sPipe_payload_user[3 : 3] = headerRecognizer_1_io_dataAxisOut_s2mPipe_rData_user[3 : 3];
    headerRecognizer_1_io_dataAxisOut_s2mPipe_m2sPipe_payload_user[4 : 4] = headerRecognizer_1_io_dataAxisOut_s2mPipe_rData_user[4 : 4];
    headerRecognizer_1_io_dataAxisOut_s2mPipe_m2sPipe_payload_user[5 : 5] = headerRecognizer_1_io_dataAxisOut_s2mPipe_rData_user[5 : 5];
    headerRecognizer_1_io_dataAxisOut_s2mPipe_m2sPipe_payload_user[6 : 6] = headerRecognizer_1_io_dataAxisOut_s2mPipe_rData_user[6 : 6];
    headerRecognizer_1_io_dataAxisOut_s2mPipe_m2sPipe_payload_user[7 : 7] = headerRecognizer_1_io_dataAxisOut_s2mPipe_rData_user[7 : 7];
    headerRecognizer_1_io_dataAxisOut_s2mPipe_m2sPipe_payload_user[8 : 8] = headerRecognizer_1_io_dataAxisOut_s2mPipe_rData_user[8 : 8];
    headerRecognizer_1_io_dataAxisOut_s2mPipe_m2sPipe_payload_user[9 : 9] = headerRecognizer_1_io_dataAxisOut_s2mPipe_rData_user[9 : 9];
    headerRecognizer_1_io_dataAxisOut_s2mPipe_m2sPipe_payload_user[10 : 10] = headerRecognizer_1_io_dataAxisOut_s2mPipe_rData_user[10 : 10];
    headerRecognizer_1_io_dataAxisOut_s2mPipe_m2sPipe_payload_user[11 : 11] = headerRecognizer_1_io_dataAxisOut_s2mPipe_rData_user[11 : 11];
    headerRecognizer_1_io_dataAxisOut_s2mPipe_m2sPipe_payload_user[12 : 12] = headerRecognizer_1_io_dataAxisOut_s2mPipe_rData_user[12 : 12];
    headerRecognizer_1_io_dataAxisOut_s2mPipe_m2sPipe_payload_user[13 : 13] = headerRecognizer_1_io_dataAxisOut_s2mPipe_rData_user[13 : 13];
    headerRecognizer_1_io_dataAxisOut_s2mPipe_m2sPipe_payload_user[14 : 14] = headerRecognizer_1_io_dataAxisOut_s2mPipe_rData_user[14 : 14];
    headerRecognizer_1_io_dataAxisOut_s2mPipe_m2sPipe_payload_user[15 : 15] = headerRecognizer_1_io_dataAxisOut_s2mPipe_rData_user[15 : 15];
    headerRecognizer_1_io_dataAxisOut_s2mPipe_m2sPipe_payload_user[16 : 16] = headerRecognizer_1_io_dataAxisOut_s2mPipe_rData_user[16 : 16];
    headerRecognizer_1_io_dataAxisOut_s2mPipe_m2sPipe_payload_user[17 : 17] = headerRecognizer_1_io_dataAxisOut_s2mPipe_rData_user[17 : 17];
    headerRecognizer_1_io_dataAxisOut_s2mPipe_m2sPipe_payload_user[18 : 18] = headerRecognizer_1_io_dataAxisOut_s2mPipe_rData_user[18 : 18];
    headerRecognizer_1_io_dataAxisOut_s2mPipe_m2sPipe_payload_user[19 : 19] = headerRecognizer_1_io_dataAxisOut_s2mPipe_rData_user[19 : 19];
    headerRecognizer_1_io_dataAxisOut_s2mPipe_m2sPipe_payload_user[20 : 20] = headerRecognizer_1_io_dataAxisOut_s2mPipe_rData_user[20 : 20];
    headerRecognizer_1_io_dataAxisOut_s2mPipe_m2sPipe_payload_user[21 : 21] = headerRecognizer_1_io_dataAxisOut_s2mPipe_rData_user[21 : 21];
    headerRecognizer_1_io_dataAxisOut_s2mPipe_m2sPipe_payload_user[22 : 22] = headerRecognizer_1_io_dataAxisOut_s2mPipe_rData_user[22 : 22];
    headerRecognizer_1_io_dataAxisOut_s2mPipe_m2sPipe_payload_user[23 : 23] = headerRecognizer_1_io_dataAxisOut_s2mPipe_rData_user[23 : 23];
    headerRecognizer_1_io_dataAxisOut_s2mPipe_m2sPipe_payload_user[24 : 24] = headerRecognizer_1_io_dataAxisOut_s2mPipe_rData_user[24 : 24];
    headerRecognizer_1_io_dataAxisOut_s2mPipe_m2sPipe_payload_user[25 : 25] = headerRecognizer_1_io_dataAxisOut_s2mPipe_rData_user[25 : 25];
    headerRecognizer_1_io_dataAxisOut_s2mPipe_m2sPipe_payload_user[26 : 26] = headerRecognizer_1_io_dataAxisOut_s2mPipe_rData_user[26 : 26];
    headerRecognizer_1_io_dataAxisOut_s2mPipe_m2sPipe_payload_user[27 : 27] = headerRecognizer_1_io_dataAxisOut_s2mPipe_rData_user[27 : 27];
    headerRecognizer_1_io_dataAxisOut_s2mPipe_m2sPipe_payload_user[28 : 28] = headerRecognizer_1_io_dataAxisOut_s2mPipe_rData_user[28 : 28];
    headerRecognizer_1_io_dataAxisOut_s2mPipe_m2sPipe_payload_user[29 : 29] = headerRecognizer_1_io_dataAxisOut_s2mPipe_rData_user[29 : 29];
    headerRecognizer_1_io_dataAxisOut_s2mPipe_m2sPipe_payload_user[30 : 30] = headerRecognizer_1_io_dataAxisOut_s2mPipe_rData_user[30 : 30];
    headerRecognizer_1_io_dataAxisOut_s2mPipe_m2sPipe_payload_user[31 : 31] = headerRecognizer_1_io_dataAxisOut_s2mPipe_rData_user[31 : 31];
  end

  assign io_dataAxisOut_valid = headerRecognizer_1_io_dataAxisOut_s2mPipe_m2sPipe_valid;
  assign headerRecognizer_1_io_dataAxisOut_s2mPipe_m2sPipe_ready = io_dataAxisOut_ready;
  assign io_dataAxisOut_payload_data = headerRecognizer_1_io_dataAxisOut_s2mPipe_m2sPipe_payload_data;
  assign io_dataAxisOut_payload_keep = headerRecognizer_1_io_dataAxisOut_s2mPipe_m2sPipe_payload_keep;
  assign io_dataAxisOut_payload_last = headerRecognizer_1_io_dataAxisOut_s2mPipe_m2sPipe_payload_last;
  always @(*) begin
    io_dataAxisOut_payload_user[0 : 0] = headerRecognizer_1_io_dataAxisOut_s2mPipe_m2sPipe_payload_user[0 : 0];
    io_dataAxisOut_payload_user[1 : 1] = headerRecognizer_1_io_dataAxisOut_s2mPipe_m2sPipe_payload_user[1 : 1];
    io_dataAxisOut_payload_user[2 : 2] = headerRecognizer_1_io_dataAxisOut_s2mPipe_m2sPipe_payload_user[2 : 2];
    io_dataAxisOut_payload_user[3 : 3] = headerRecognizer_1_io_dataAxisOut_s2mPipe_m2sPipe_payload_user[3 : 3];
    io_dataAxisOut_payload_user[4 : 4] = headerRecognizer_1_io_dataAxisOut_s2mPipe_m2sPipe_payload_user[4 : 4];
    io_dataAxisOut_payload_user[5 : 5] = headerRecognizer_1_io_dataAxisOut_s2mPipe_m2sPipe_payload_user[5 : 5];
    io_dataAxisOut_payload_user[6 : 6] = headerRecognizer_1_io_dataAxisOut_s2mPipe_m2sPipe_payload_user[6 : 6];
    io_dataAxisOut_payload_user[7 : 7] = headerRecognizer_1_io_dataAxisOut_s2mPipe_m2sPipe_payload_user[7 : 7];
    io_dataAxisOut_payload_user[8 : 8] = headerRecognizer_1_io_dataAxisOut_s2mPipe_m2sPipe_payload_user[8 : 8];
    io_dataAxisOut_payload_user[9 : 9] = headerRecognizer_1_io_dataAxisOut_s2mPipe_m2sPipe_payload_user[9 : 9];
    io_dataAxisOut_payload_user[10 : 10] = headerRecognizer_1_io_dataAxisOut_s2mPipe_m2sPipe_payload_user[10 : 10];
    io_dataAxisOut_payload_user[11 : 11] = headerRecognizer_1_io_dataAxisOut_s2mPipe_m2sPipe_payload_user[11 : 11];
    io_dataAxisOut_payload_user[12 : 12] = headerRecognizer_1_io_dataAxisOut_s2mPipe_m2sPipe_payload_user[12 : 12];
    io_dataAxisOut_payload_user[13 : 13] = headerRecognizer_1_io_dataAxisOut_s2mPipe_m2sPipe_payload_user[13 : 13];
    io_dataAxisOut_payload_user[14 : 14] = headerRecognizer_1_io_dataAxisOut_s2mPipe_m2sPipe_payload_user[14 : 14];
    io_dataAxisOut_payload_user[15 : 15] = headerRecognizer_1_io_dataAxisOut_s2mPipe_m2sPipe_payload_user[15 : 15];
    io_dataAxisOut_payload_user[16 : 16] = headerRecognizer_1_io_dataAxisOut_s2mPipe_m2sPipe_payload_user[16 : 16];
    io_dataAxisOut_payload_user[17 : 17] = headerRecognizer_1_io_dataAxisOut_s2mPipe_m2sPipe_payload_user[17 : 17];
    io_dataAxisOut_payload_user[18 : 18] = headerRecognizer_1_io_dataAxisOut_s2mPipe_m2sPipe_payload_user[18 : 18];
    io_dataAxisOut_payload_user[19 : 19] = headerRecognizer_1_io_dataAxisOut_s2mPipe_m2sPipe_payload_user[19 : 19];
    io_dataAxisOut_payload_user[20 : 20] = headerRecognizer_1_io_dataAxisOut_s2mPipe_m2sPipe_payload_user[20 : 20];
    io_dataAxisOut_payload_user[21 : 21] = headerRecognizer_1_io_dataAxisOut_s2mPipe_m2sPipe_payload_user[21 : 21];
    io_dataAxisOut_payload_user[22 : 22] = headerRecognizer_1_io_dataAxisOut_s2mPipe_m2sPipe_payload_user[22 : 22];
    io_dataAxisOut_payload_user[23 : 23] = headerRecognizer_1_io_dataAxisOut_s2mPipe_m2sPipe_payload_user[23 : 23];
    io_dataAxisOut_payload_user[24 : 24] = headerRecognizer_1_io_dataAxisOut_s2mPipe_m2sPipe_payload_user[24 : 24];
    io_dataAxisOut_payload_user[25 : 25] = headerRecognizer_1_io_dataAxisOut_s2mPipe_m2sPipe_payload_user[25 : 25];
    io_dataAxisOut_payload_user[26 : 26] = headerRecognizer_1_io_dataAxisOut_s2mPipe_m2sPipe_payload_user[26 : 26];
    io_dataAxisOut_payload_user[27 : 27] = headerRecognizer_1_io_dataAxisOut_s2mPipe_m2sPipe_payload_user[27 : 27];
    io_dataAxisOut_payload_user[28 : 28] = headerRecognizer_1_io_dataAxisOut_s2mPipe_m2sPipe_payload_user[28 : 28];
    io_dataAxisOut_payload_user[29 : 29] = headerRecognizer_1_io_dataAxisOut_s2mPipe_m2sPipe_payload_user[29 : 29];
    io_dataAxisOut_payload_user[30 : 30] = headerRecognizer_1_io_dataAxisOut_s2mPipe_m2sPipe_payload_user[30 : 30];
    io_dataAxisOut_payload_user[31 : 31] = headerRecognizer_1_io_dataAxisOut_s2mPipe_m2sPipe_payload_user[31 : 31];
  end

  assign headerRecognizer_1_io_metaOut_ready = (! headerRecognizer_1_io_metaOut_rValid);
  assign headerRecognizer_1_io_metaOut_s2mPipe_valid = (headerRecognizer_1_io_metaOut_valid || headerRecognizer_1_io_metaOut_rValid);
  assign headerRecognizer_1_io_metaOut_s2mPipe_payload_dataLen = (headerRecognizer_1_io_metaOut_rValid ? headerRecognizer_1_io_metaOut_rData_dataLen : headerRecognizer_1_io_metaOut_payload_dataLen);
  assign headerRecognizer_1_io_metaOut_s2mPipe_payload_dstMacAddr = (headerRecognizer_1_io_metaOut_rValid ? headerRecognizer_1_io_metaOut_rData_dstMacAddr : headerRecognizer_1_io_metaOut_payload_dstMacAddr);
  assign headerRecognizer_1_io_metaOut_s2mPipe_payload_dstIpAddr = (headerRecognizer_1_io_metaOut_rValid ? headerRecognizer_1_io_metaOut_rData_dstIpAddr : headerRecognizer_1_io_metaOut_payload_dstIpAddr);
  assign headerRecognizer_1_io_metaOut_s2mPipe_payload_srcMacAddr = (headerRecognizer_1_io_metaOut_rValid ? headerRecognizer_1_io_metaOut_rData_srcMacAddr : headerRecognizer_1_io_metaOut_payload_srcMacAddr);
  assign headerRecognizer_1_io_metaOut_s2mPipe_payload_srcIpAddr = (headerRecognizer_1_io_metaOut_rValid ? headerRecognizer_1_io_metaOut_rData_srcIpAddr : headerRecognizer_1_io_metaOut_payload_srcIpAddr);
  assign headerRecognizer_1_io_metaOut_s2mPipe_payload_dstPort = (headerRecognizer_1_io_metaOut_rValid ? headerRecognizer_1_io_metaOut_rData_dstPort : headerRecognizer_1_io_metaOut_payload_dstPort);
  assign headerRecognizer_1_io_metaOut_s2mPipe_payload_srcPort = (headerRecognizer_1_io_metaOut_rValid ? headerRecognizer_1_io_metaOut_rData_srcPort : headerRecognizer_1_io_metaOut_payload_srcPort);
  always @(*) begin
    headerRecognizer_1_io_metaOut_s2mPipe_ready = headerRecognizer_1_io_metaOut_s2mPipe_m2sPipe_ready;
    if(when_Stream_l368_1) begin
      headerRecognizer_1_io_metaOut_s2mPipe_ready = 1'b1;
    end
  end

  assign when_Stream_l368_1 = (! headerRecognizer_1_io_metaOut_s2mPipe_m2sPipe_valid);
  assign headerRecognizer_1_io_metaOut_s2mPipe_m2sPipe_valid = headerRecognizer_1_io_metaOut_s2mPipe_rValid;
  assign headerRecognizer_1_io_metaOut_s2mPipe_m2sPipe_payload_dataLen = headerRecognizer_1_io_metaOut_s2mPipe_rData_dataLen;
  assign headerRecognizer_1_io_metaOut_s2mPipe_m2sPipe_payload_dstMacAddr = headerRecognizer_1_io_metaOut_s2mPipe_rData_dstMacAddr;
  assign headerRecognizer_1_io_metaOut_s2mPipe_m2sPipe_payload_dstIpAddr = headerRecognizer_1_io_metaOut_s2mPipe_rData_dstIpAddr;
  assign headerRecognizer_1_io_metaOut_s2mPipe_m2sPipe_payload_srcMacAddr = headerRecognizer_1_io_metaOut_s2mPipe_rData_srcMacAddr;
  assign headerRecognizer_1_io_metaOut_s2mPipe_m2sPipe_payload_srcIpAddr = headerRecognizer_1_io_metaOut_s2mPipe_rData_srcIpAddr;
  assign headerRecognizer_1_io_metaOut_s2mPipe_m2sPipe_payload_dstPort = headerRecognizer_1_io_metaOut_s2mPipe_rData_dstPort;
  assign headerRecognizer_1_io_metaOut_s2mPipe_m2sPipe_payload_srcPort = headerRecognizer_1_io_metaOut_s2mPipe_rData_srcPort;
  assign io_metaOut_valid = headerRecognizer_1_io_metaOut_s2mPipe_m2sPipe_valid;
  assign headerRecognizer_1_io_metaOut_s2mPipe_m2sPipe_ready = io_metaOut_ready;
  assign io_metaOut_payload_dataLen = headerRecognizer_1_io_metaOut_s2mPipe_m2sPipe_payload_dataLen;
  assign io_metaOut_payload_dstMacAddr = headerRecognizer_1_io_metaOut_s2mPipe_m2sPipe_payload_dstMacAddr;
  assign io_metaOut_payload_dstIpAddr = headerRecognizer_1_io_metaOut_s2mPipe_m2sPipe_payload_dstIpAddr;
  assign io_metaOut_payload_srcMacAddr = headerRecognizer_1_io_metaOut_s2mPipe_m2sPipe_payload_srcMacAddr;
  assign io_metaOut_payload_srcIpAddr = headerRecognizer_1_io_metaOut_s2mPipe_m2sPipe_payload_srcIpAddr;
  assign io_metaOut_payload_dstPort = headerRecognizer_1_io_metaOut_s2mPipe_m2sPipe_payload_dstPort;
  assign io_metaOut_payload_srcPort = headerRecognizer_1_io_metaOut_s2mPipe_m2sPipe_payload_srcPort;
  always @(posedge clk or posedge reset) begin
    if(reset) begin
      headerRecognizer_1_io_dataAxisOut_rValid <= 1'b0;
      headerRecognizer_1_io_dataAxisOut_s2mPipe_rValid <= 1'b0;
      headerRecognizer_1_io_metaOut_rValid <= 1'b0;
      headerRecognizer_1_io_metaOut_s2mPipe_rValid <= 1'b0;
    end else begin
      if(headerRecognizer_1_io_dataAxisOut_valid) begin
        headerRecognizer_1_io_dataAxisOut_rValid <= 1'b1;
      end
      if(headerRecognizer_1_io_dataAxisOut_s2mPipe_ready) begin
        headerRecognizer_1_io_dataAxisOut_rValid <= 1'b0;
      end
      if(headerRecognizer_1_io_dataAxisOut_s2mPipe_ready) begin
        headerRecognizer_1_io_dataAxisOut_s2mPipe_rValid <= headerRecognizer_1_io_dataAxisOut_s2mPipe_valid;
      end
      if(headerRecognizer_1_io_metaOut_valid) begin
        headerRecognizer_1_io_metaOut_rValid <= 1'b1;
      end
      if(headerRecognizer_1_io_metaOut_s2mPipe_ready) begin
        headerRecognizer_1_io_metaOut_rValid <= 1'b0;
      end
      if(headerRecognizer_1_io_metaOut_s2mPipe_ready) begin
        headerRecognizer_1_io_metaOut_s2mPipe_rValid <= headerRecognizer_1_io_metaOut_s2mPipe_valid;
      end
    end
  end

  always @(posedge clk) begin
    if(headerRecognizer_1_io_dataAxisOut_ready) begin
      headerRecognizer_1_io_dataAxisOut_rData_data <= headerRecognizer_1_io_dataAxisOut_payload_data;
      headerRecognizer_1_io_dataAxisOut_rData_keep <= headerRecognizer_1_io_dataAxisOut_payload_keep;
      headerRecognizer_1_io_dataAxisOut_rData_last <= headerRecognizer_1_io_dataAxisOut_payload_last;
      headerRecognizer_1_io_dataAxisOut_rData_user[0 : 0] <= headerRecognizer_1_io_dataAxisOut_payload_user[0 : 0];
      headerRecognizer_1_io_dataAxisOut_rData_user[1 : 1] <= headerRecognizer_1_io_dataAxisOut_payload_user[1 : 1];
      headerRecognizer_1_io_dataAxisOut_rData_user[2 : 2] <= headerRecognizer_1_io_dataAxisOut_payload_user[2 : 2];
      headerRecognizer_1_io_dataAxisOut_rData_user[3 : 3] <= headerRecognizer_1_io_dataAxisOut_payload_user[3 : 3];
      headerRecognizer_1_io_dataAxisOut_rData_user[4 : 4] <= headerRecognizer_1_io_dataAxisOut_payload_user[4 : 4];
      headerRecognizer_1_io_dataAxisOut_rData_user[5 : 5] <= headerRecognizer_1_io_dataAxisOut_payload_user[5 : 5];
      headerRecognizer_1_io_dataAxisOut_rData_user[6 : 6] <= headerRecognizer_1_io_dataAxisOut_payload_user[6 : 6];
      headerRecognizer_1_io_dataAxisOut_rData_user[7 : 7] <= headerRecognizer_1_io_dataAxisOut_payload_user[7 : 7];
      headerRecognizer_1_io_dataAxisOut_rData_user[8 : 8] <= headerRecognizer_1_io_dataAxisOut_payload_user[8 : 8];
      headerRecognizer_1_io_dataAxisOut_rData_user[9 : 9] <= headerRecognizer_1_io_dataAxisOut_payload_user[9 : 9];
      headerRecognizer_1_io_dataAxisOut_rData_user[10 : 10] <= headerRecognizer_1_io_dataAxisOut_payload_user[10 : 10];
      headerRecognizer_1_io_dataAxisOut_rData_user[11 : 11] <= headerRecognizer_1_io_dataAxisOut_payload_user[11 : 11];
      headerRecognizer_1_io_dataAxisOut_rData_user[12 : 12] <= headerRecognizer_1_io_dataAxisOut_payload_user[12 : 12];
      headerRecognizer_1_io_dataAxisOut_rData_user[13 : 13] <= headerRecognizer_1_io_dataAxisOut_payload_user[13 : 13];
      headerRecognizer_1_io_dataAxisOut_rData_user[14 : 14] <= headerRecognizer_1_io_dataAxisOut_payload_user[14 : 14];
      headerRecognizer_1_io_dataAxisOut_rData_user[15 : 15] <= headerRecognizer_1_io_dataAxisOut_payload_user[15 : 15];
      headerRecognizer_1_io_dataAxisOut_rData_user[16 : 16] <= headerRecognizer_1_io_dataAxisOut_payload_user[16 : 16];
      headerRecognizer_1_io_dataAxisOut_rData_user[17 : 17] <= headerRecognizer_1_io_dataAxisOut_payload_user[17 : 17];
      headerRecognizer_1_io_dataAxisOut_rData_user[18 : 18] <= headerRecognizer_1_io_dataAxisOut_payload_user[18 : 18];
      headerRecognizer_1_io_dataAxisOut_rData_user[19 : 19] <= headerRecognizer_1_io_dataAxisOut_payload_user[19 : 19];
      headerRecognizer_1_io_dataAxisOut_rData_user[20 : 20] <= headerRecognizer_1_io_dataAxisOut_payload_user[20 : 20];
      headerRecognizer_1_io_dataAxisOut_rData_user[21 : 21] <= headerRecognizer_1_io_dataAxisOut_payload_user[21 : 21];
      headerRecognizer_1_io_dataAxisOut_rData_user[22 : 22] <= headerRecognizer_1_io_dataAxisOut_payload_user[22 : 22];
      headerRecognizer_1_io_dataAxisOut_rData_user[23 : 23] <= headerRecognizer_1_io_dataAxisOut_payload_user[23 : 23];
      headerRecognizer_1_io_dataAxisOut_rData_user[24 : 24] <= headerRecognizer_1_io_dataAxisOut_payload_user[24 : 24];
      headerRecognizer_1_io_dataAxisOut_rData_user[25 : 25] <= headerRecognizer_1_io_dataAxisOut_payload_user[25 : 25];
      headerRecognizer_1_io_dataAxisOut_rData_user[26 : 26] <= headerRecognizer_1_io_dataAxisOut_payload_user[26 : 26];
      headerRecognizer_1_io_dataAxisOut_rData_user[27 : 27] <= headerRecognizer_1_io_dataAxisOut_payload_user[27 : 27];
      headerRecognizer_1_io_dataAxisOut_rData_user[28 : 28] <= headerRecognizer_1_io_dataAxisOut_payload_user[28 : 28];
      headerRecognizer_1_io_dataAxisOut_rData_user[29 : 29] <= headerRecognizer_1_io_dataAxisOut_payload_user[29 : 29];
      headerRecognizer_1_io_dataAxisOut_rData_user[30 : 30] <= headerRecognizer_1_io_dataAxisOut_payload_user[30 : 30];
      headerRecognizer_1_io_dataAxisOut_rData_user[31 : 31] <= headerRecognizer_1_io_dataAxisOut_payload_user[31 : 31];
    end
    if(headerRecognizer_1_io_dataAxisOut_s2mPipe_ready) begin
      headerRecognizer_1_io_dataAxisOut_s2mPipe_rData_data <= headerRecognizer_1_io_dataAxisOut_s2mPipe_payload_data;
      headerRecognizer_1_io_dataAxisOut_s2mPipe_rData_keep <= headerRecognizer_1_io_dataAxisOut_s2mPipe_payload_keep;
      headerRecognizer_1_io_dataAxisOut_s2mPipe_rData_last <= headerRecognizer_1_io_dataAxisOut_s2mPipe_payload_last;
      headerRecognizer_1_io_dataAxisOut_s2mPipe_rData_user[0 : 0] <= headerRecognizer_1_io_dataAxisOut_s2mPipe_payload_user[0 : 0];
      headerRecognizer_1_io_dataAxisOut_s2mPipe_rData_user[1 : 1] <= headerRecognizer_1_io_dataAxisOut_s2mPipe_payload_user[1 : 1];
      headerRecognizer_1_io_dataAxisOut_s2mPipe_rData_user[2 : 2] <= headerRecognizer_1_io_dataAxisOut_s2mPipe_payload_user[2 : 2];
      headerRecognizer_1_io_dataAxisOut_s2mPipe_rData_user[3 : 3] <= headerRecognizer_1_io_dataAxisOut_s2mPipe_payload_user[3 : 3];
      headerRecognizer_1_io_dataAxisOut_s2mPipe_rData_user[4 : 4] <= headerRecognizer_1_io_dataAxisOut_s2mPipe_payload_user[4 : 4];
      headerRecognizer_1_io_dataAxisOut_s2mPipe_rData_user[5 : 5] <= headerRecognizer_1_io_dataAxisOut_s2mPipe_payload_user[5 : 5];
      headerRecognizer_1_io_dataAxisOut_s2mPipe_rData_user[6 : 6] <= headerRecognizer_1_io_dataAxisOut_s2mPipe_payload_user[6 : 6];
      headerRecognizer_1_io_dataAxisOut_s2mPipe_rData_user[7 : 7] <= headerRecognizer_1_io_dataAxisOut_s2mPipe_payload_user[7 : 7];
      headerRecognizer_1_io_dataAxisOut_s2mPipe_rData_user[8 : 8] <= headerRecognizer_1_io_dataAxisOut_s2mPipe_payload_user[8 : 8];
      headerRecognizer_1_io_dataAxisOut_s2mPipe_rData_user[9 : 9] <= headerRecognizer_1_io_dataAxisOut_s2mPipe_payload_user[9 : 9];
      headerRecognizer_1_io_dataAxisOut_s2mPipe_rData_user[10 : 10] <= headerRecognizer_1_io_dataAxisOut_s2mPipe_payload_user[10 : 10];
      headerRecognizer_1_io_dataAxisOut_s2mPipe_rData_user[11 : 11] <= headerRecognizer_1_io_dataAxisOut_s2mPipe_payload_user[11 : 11];
      headerRecognizer_1_io_dataAxisOut_s2mPipe_rData_user[12 : 12] <= headerRecognizer_1_io_dataAxisOut_s2mPipe_payload_user[12 : 12];
      headerRecognizer_1_io_dataAxisOut_s2mPipe_rData_user[13 : 13] <= headerRecognizer_1_io_dataAxisOut_s2mPipe_payload_user[13 : 13];
      headerRecognizer_1_io_dataAxisOut_s2mPipe_rData_user[14 : 14] <= headerRecognizer_1_io_dataAxisOut_s2mPipe_payload_user[14 : 14];
      headerRecognizer_1_io_dataAxisOut_s2mPipe_rData_user[15 : 15] <= headerRecognizer_1_io_dataAxisOut_s2mPipe_payload_user[15 : 15];
      headerRecognizer_1_io_dataAxisOut_s2mPipe_rData_user[16 : 16] <= headerRecognizer_1_io_dataAxisOut_s2mPipe_payload_user[16 : 16];
      headerRecognizer_1_io_dataAxisOut_s2mPipe_rData_user[17 : 17] <= headerRecognizer_1_io_dataAxisOut_s2mPipe_payload_user[17 : 17];
      headerRecognizer_1_io_dataAxisOut_s2mPipe_rData_user[18 : 18] <= headerRecognizer_1_io_dataAxisOut_s2mPipe_payload_user[18 : 18];
      headerRecognizer_1_io_dataAxisOut_s2mPipe_rData_user[19 : 19] <= headerRecognizer_1_io_dataAxisOut_s2mPipe_payload_user[19 : 19];
      headerRecognizer_1_io_dataAxisOut_s2mPipe_rData_user[20 : 20] <= headerRecognizer_1_io_dataAxisOut_s2mPipe_payload_user[20 : 20];
      headerRecognizer_1_io_dataAxisOut_s2mPipe_rData_user[21 : 21] <= headerRecognizer_1_io_dataAxisOut_s2mPipe_payload_user[21 : 21];
      headerRecognizer_1_io_dataAxisOut_s2mPipe_rData_user[22 : 22] <= headerRecognizer_1_io_dataAxisOut_s2mPipe_payload_user[22 : 22];
      headerRecognizer_1_io_dataAxisOut_s2mPipe_rData_user[23 : 23] <= headerRecognizer_1_io_dataAxisOut_s2mPipe_payload_user[23 : 23];
      headerRecognizer_1_io_dataAxisOut_s2mPipe_rData_user[24 : 24] <= headerRecognizer_1_io_dataAxisOut_s2mPipe_payload_user[24 : 24];
      headerRecognizer_1_io_dataAxisOut_s2mPipe_rData_user[25 : 25] <= headerRecognizer_1_io_dataAxisOut_s2mPipe_payload_user[25 : 25];
      headerRecognizer_1_io_dataAxisOut_s2mPipe_rData_user[26 : 26] <= headerRecognizer_1_io_dataAxisOut_s2mPipe_payload_user[26 : 26];
      headerRecognizer_1_io_dataAxisOut_s2mPipe_rData_user[27 : 27] <= headerRecognizer_1_io_dataAxisOut_s2mPipe_payload_user[27 : 27];
      headerRecognizer_1_io_dataAxisOut_s2mPipe_rData_user[28 : 28] <= headerRecognizer_1_io_dataAxisOut_s2mPipe_payload_user[28 : 28];
      headerRecognizer_1_io_dataAxisOut_s2mPipe_rData_user[29 : 29] <= headerRecognizer_1_io_dataAxisOut_s2mPipe_payload_user[29 : 29];
      headerRecognizer_1_io_dataAxisOut_s2mPipe_rData_user[30 : 30] <= headerRecognizer_1_io_dataAxisOut_s2mPipe_payload_user[30 : 30];
      headerRecognizer_1_io_dataAxisOut_s2mPipe_rData_user[31 : 31] <= headerRecognizer_1_io_dataAxisOut_s2mPipe_payload_user[31 : 31];
    end
    if(headerRecognizer_1_io_metaOut_ready) begin
      headerRecognizer_1_io_metaOut_rData_dataLen <= headerRecognizer_1_io_metaOut_payload_dataLen;
      headerRecognizer_1_io_metaOut_rData_dstMacAddr <= headerRecognizer_1_io_metaOut_payload_dstMacAddr;
      headerRecognizer_1_io_metaOut_rData_dstIpAddr <= headerRecognizer_1_io_metaOut_payload_dstIpAddr;
      headerRecognizer_1_io_metaOut_rData_srcMacAddr <= headerRecognizer_1_io_metaOut_payload_srcMacAddr;
      headerRecognizer_1_io_metaOut_rData_srcIpAddr <= headerRecognizer_1_io_metaOut_payload_srcIpAddr;
      headerRecognizer_1_io_metaOut_rData_dstPort <= headerRecognizer_1_io_metaOut_payload_dstPort;
      headerRecognizer_1_io_metaOut_rData_srcPort <= headerRecognizer_1_io_metaOut_payload_srcPort;
    end
    if(headerRecognizer_1_io_metaOut_s2mPipe_ready) begin
      headerRecognizer_1_io_metaOut_s2mPipe_rData_dataLen <= headerRecognizer_1_io_metaOut_s2mPipe_payload_dataLen;
      headerRecognizer_1_io_metaOut_s2mPipe_rData_dstMacAddr <= headerRecognizer_1_io_metaOut_s2mPipe_payload_dstMacAddr;
      headerRecognizer_1_io_metaOut_s2mPipe_rData_dstIpAddr <= headerRecognizer_1_io_metaOut_s2mPipe_payload_dstIpAddr;
      headerRecognizer_1_io_metaOut_s2mPipe_rData_srcMacAddr <= headerRecognizer_1_io_metaOut_s2mPipe_payload_srcMacAddr;
      headerRecognizer_1_io_metaOut_s2mPipe_rData_srcIpAddr <= headerRecognizer_1_io_metaOut_s2mPipe_payload_srcIpAddr;
      headerRecognizer_1_io_metaOut_s2mPipe_rData_dstPort <= headerRecognizer_1_io_metaOut_s2mPipe_payload_dstPort;
      headerRecognizer_1_io_metaOut_s2mPipe_rData_srcPort <= headerRecognizer_1_io_metaOut_s2mPipe_payload_srcPort;
    end
  end


endmodule

module HeaderRecognizer (
  input               io_dataAxisIn_valid,
  output reg          io_dataAxisIn_ready,
  input      [255:0]  io_dataAxisIn_payload_data,
  input      [31:0]   io_dataAxisIn_payload_keep,
  input               io_dataAxisIn_payload_last,
  input      [31:0]   io_dataAxisIn_payload_user,
  output              io_metaOut_valid,
  input               io_metaOut_ready,
  output     [11:0]   io_metaOut_payload_dataLen,
  output     [47:0]   io_metaOut_payload_dstMacAddr,
  output     [31:0]   io_metaOut_payload_dstIpAddr,
  output     [47:0]   io_metaOut_payload_srcMacAddr,
  output     [31:0]   io_metaOut_payload_srcIpAddr,
  output     [15:0]   io_metaOut_payload_dstPort,
  output     [15:0]   io_metaOut_payload_srcPort,
  output              io_dataAxisOut_valid,
  input               io_dataAxisOut_ready,
  output     [255:0]  io_dataAxisOut_payload_data,
  output     [31:0]   io_dataAxisOut_payload_keep,
  output              io_dataAxisOut_payload_last,
  output reg [31:0]   io_dataAxisOut_payload_user,
  input               clk,
  input               reset
);

  wire                transactionCounter_io_working;
  wire                transactionCounter_io_last;
  wire                transactionCounter_io_done;
  wire       [5:0]    transactionCounter_io_value;
  wire       [31:0]   _zz__zz_ipv4HeaderExtract_0;
  wire       [7:0]    _zz__zz_ipv4HeaderExtract_0_1;
  wire       [15:0]   _zz_needOneMoreCycle;
  wire       [10:0]   _zz_packetLenReg;
  wire       [15:0]   _zz_packetLenReg_1;
  wire       [223:0]  _zz_maskStage_payload_data_1;
  wire       [191:0]  _zz_maskStage_payload_data_2;
  wire       [159:0]  _zz_maskStage_payload_data_3;
  wire       [127:0]  _zz_maskStage_payload_data_4;
  wire       [95:0]   _zz_maskStage_payload_data_5;
  wire       [63:0]   _zz_maskStage_payload_data_6;
  wire       [31:0]   _zz_maskStage_payload_data_7;
  wire                _zz_maskStage_payload_data_8;
  wire       [7:0]    _zz_maskStage_payload_data_9;
  wire       [7:0]    _zz_maskStage_payload_data_10;
  wire                _zz_maskStage_payload_data_11;
  wire       [7:0]    _zz_maskStage_payload_data_12;
  wire       [7:0]    _zz_maskStage_payload_data_13;
  wire       [7:0]    _zz_maskStage_payload_data_14;
  wire                _zz_maskStage_payload_data_15;
  wire       [7:0]    _zz_maskStage_payload_data_16;
  wire       [7:0]    _zz_maskStage_payload_data_17;
  wire       [7:0]    _zz_maskStage_payload_data_18;
  wire                _zz_maskStage_payload_data_19;
  wire       [7:0]    _zz_maskStage_payload_data_20;
  wire       [7:0]    _zz_maskStage_payload_data_21;
  wire       [7:0]    _zz_maskStage_payload_data_22;
  wire                _zz_maskStage_payload_data_23;
  wire       [7:0]    _zz_maskStage_payload_data_24;
  wire       [7:0]    _zz_maskStage_payload_data_25;
  wire       [7:0]    _zz_maskStage_payload_data_26;
  wire                _zz_maskStage_payload_data_27;
  wire       [7:0]    _zz_maskStage_payload_data_28;
  wire       [7:0]    _zz_maskStage_payload_data_29;
  wire       [7:0]    _zz_maskStage_payload_data_30;
  wire                _zz_maskStage_payload_data_31;
  wire       [7:0]    _zz_maskStage_payload_data_32;
  wire       [7:0]    _zz_maskStage_payload_data_33;
  wire       [7:0]    _zz_maskStage_payload_data_34;
  wire                _zz_maskStage_payload_data_35;
  wire       [7:0]    _zz_maskStage_payload_data_36;
  wire       [7:0]    _zz_maskStage_payload_data_37;
  wire       [7:0]    _zz_maskStage_payload_data_38;
  wire                _zz_maskStage_payload_data_39;
  wire       [7:0]    _zz_maskStage_payload_data_40;
  wire       [7:0]    _zz_maskStage_payload_data_41;
  wire       [223:0]  _zz_maskStage_payload_data_42;
  wire       [191:0]  _zz_maskStage_payload_data_43;
  wire       [159:0]  _zz_maskStage_payload_data_44;
  wire       [127:0]  _zz_maskStage_payload_data_45;
  wire       [95:0]   _zz_maskStage_payload_data_46;
  wire       [63:0]   _zz_maskStage_payload_data_47;
  wire       [31:0]   _zz_maskStage_payload_data_48;
  wire                _zz_maskStage_payload_data_49;
  wire       [7:0]    _zz_maskStage_payload_data_50;
  wire       [7:0]    _zz_maskStage_payload_data_51;
  wire                _zz_maskStage_payload_data_52;
  wire       [7:0]    _zz_maskStage_payload_data_53;
  wire       [7:0]    _zz_maskStage_payload_data_54;
  wire       [7:0]    _zz_maskStage_payload_data_55;
  wire                _zz_maskStage_payload_data_56;
  wire       [7:0]    _zz_maskStage_payload_data_57;
  wire       [7:0]    _zz_maskStage_payload_data_58;
  wire       [7:0]    _zz_maskStage_payload_data_59;
  wire                _zz_maskStage_payload_data_60;
  wire       [7:0]    _zz_maskStage_payload_data_61;
  wire       [7:0]    _zz_maskStage_payload_data_62;
  wire       [7:0]    _zz_maskStage_payload_data_63;
  wire                _zz_maskStage_payload_data_64;
  wire       [7:0]    _zz_maskStage_payload_data_65;
  wire       [7:0]    _zz_maskStage_payload_data_66;
  wire       [7:0]    _zz_maskStage_payload_data_67;
  wire                _zz_maskStage_payload_data_68;
  wire       [7:0]    _zz_maskStage_payload_data_69;
  wire       [7:0]    _zz_maskStage_payload_data_70;
  wire       [7:0]    _zz_maskStage_payload_data_71;
  wire                _zz_maskStage_payload_data_72;
  wire       [7:0]    _zz_maskStage_payload_data_73;
  wire       [7:0]    _zz_maskStage_payload_data_74;
  wire       [7:0]    _zz_maskStage_payload_data_75;
  wire                _zz_maskStage_payload_data_76;
  wire       [7:0]    _zz_maskStage_payload_data_77;
  wire       [7:0]    _zz_maskStage_payload_data_78;
  wire       [7:0]    _zz_maskStage_payload_data_79;
  wire                _zz_maskStage_payload_data_80;
  wire       [7:0]    _zz_maskStage_payload_data_81;
  wire       [7:0]    _zz_maskStage_payload_data_82;
  wire       [27:0]   _zz_maskStage_payload_keep_1;
  wire       [23:0]   _zz_maskStage_payload_keep_2;
  wire       [19:0]   _zz_maskStage_payload_keep_3;
  wire       [15:0]   _zz_maskStage_payload_keep_4;
  wire       [11:0]   _zz_maskStage_payload_keep_5;
  wire       [7:0]    _zz_maskStage_payload_keep_6;
  wire       [3:0]    _zz_maskStage_payload_keep_7;
  wire                _zz_maskStage_payload_keep_8;
  wire       [0:0]    _zz_maskStage_payload_keep_9;
  wire       [0:0]    _zz_maskStage_payload_keep_10;
  wire                _zz_maskStage_payload_keep_11;
  wire       [0:0]    _zz_maskStage_payload_keep_12;
  wire       [0:0]    _zz_maskStage_payload_keep_13;
  wire       [0:0]    _zz_maskStage_payload_keep_14;
  wire                _zz_maskStage_payload_keep_15;
  wire       [0:0]    _zz_maskStage_payload_keep_16;
  wire       [0:0]    _zz_maskStage_payload_keep_17;
  wire       [0:0]    _zz_maskStage_payload_keep_18;
  wire                _zz_maskStage_payload_keep_19;
  wire       [0:0]    _zz_maskStage_payload_keep_20;
  wire       [0:0]    _zz_maskStage_payload_keep_21;
  wire       [0:0]    _zz_maskStage_payload_keep_22;
  wire                _zz_maskStage_payload_keep_23;
  wire       [0:0]    _zz_maskStage_payload_keep_24;
  wire       [0:0]    _zz_maskStage_payload_keep_25;
  wire       [0:0]    _zz_maskStage_payload_keep_26;
  wire                _zz_maskStage_payload_keep_27;
  wire       [0:0]    _zz_maskStage_payload_keep_28;
  wire       [0:0]    _zz_maskStage_payload_keep_29;
  wire       [0:0]    _zz_maskStage_payload_keep_30;
  wire                _zz_maskStage_payload_keep_31;
  wire       [0:0]    _zz_maskStage_payload_keep_32;
  wire       [0:0]    _zz_maskStage_payload_keep_33;
  wire       [0:0]    _zz_maskStage_payload_keep_34;
  wire                _zz_maskStage_payload_keep_35;
  wire       [0:0]    _zz_maskStage_payload_keep_36;
  wire       [0:0]    _zz_maskStage_payload_keep_37;
  wire       [0:0]    _zz_maskStage_payload_keep_38;
  wire                _zz_maskStage_payload_keep_39;
  wire       [0:0]    _zz_maskStage_payload_keep_40;
  wire       [0:0]    _zz_maskStage_payload_keep_41;
  wire       [27:0]   _zz_maskStage_payload_keep_42;
  wire       [23:0]   _zz_maskStage_payload_keep_43;
  wire       [19:0]   _zz_maskStage_payload_keep_44;
  wire       [15:0]   _zz_maskStage_payload_keep_45;
  wire       [11:0]   _zz_maskStage_payload_keep_46;
  wire       [7:0]    _zz_maskStage_payload_keep_47;
  wire       [3:0]    _zz_maskStage_payload_keep_48;
  wire                _zz_maskStage_payload_keep_49;
  wire       [0:0]    _zz_maskStage_payload_keep_50;
  wire       [0:0]    _zz_maskStage_payload_keep_51;
  wire                _zz_maskStage_payload_keep_52;
  wire       [0:0]    _zz_maskStage_payload_keep_53;
  wire       [0:0]    _zz_maskStage_payload_keep_54;
  wire       [0:0]    _zz_maskStage_payload_keep_55;
  wire                _zz_maskStage_payload_keep_56;
  wire       [0:0]    _zz_maskStage_payload_keep_57;
  wire       [0:0]    _zz_maskStage_payload_keep_58;
  wire       [0:0]    _zz_maskStage_payload_keep_59;
  wire                _zz_maskStage_payload_keep_60;
  wire       [0:0]    _zz_maskStage_payload_keep_61;
  wire       [0:0]    _zz_maskStage_payload_keep_62;
  wire       [0:0]    _zz_maskStage_payload_keep_63;
  wire                _zz_maskStage_payload_keep_64;
  wire       [0:0]    _zz_maskStage_payload_keep_65;
  wire       [0:0]    _zz_maskStage_payload_keep_66;
  wire       [0:0]    _zz_maskStage_payload_keep_67;
  wire                _zz_maskStage_payload_keep_68;
  wire       [0:0]    _zz_maskStage_payload_keep_69;
  wire       [0:0]    _zz_maskStage_payload_keep_70;
  wire       [0:0]    _zz_maskStage_payload_keep_71;
  wire                _zz_maskStage_payload_keep_72;
  wire       [0:0]    _zz_maskStage_payload_keep_73;
  wire       [0:0]    _zz_maskStage_payload_keep_74;
  wire       [0:0]    _zz_maskStage_payload_keep_75;
  wire                _zz_maskStage_payload_keep_76;
  wire       [0:0]    _zz_maskStage_payload_keep_77;
  wire       [0:0]    _zz_maskStage_payload_keep_78;
  wire       [0:0]    _zz_maskStage_payload_keep_79;
  wire                _zz_maskStage_payload_keep_80;
  wire       [0:0]    _zz_maskStage_payload_keep_81;
  wire       [0:0]    _zz_maskStage_payload_keep_82;
  reg                 recognizerRunning;
  reg                 recognizerRunning_regNext;
  wire                recognizerStart;
  wire                packetStream_valid;
  reg                 packetStream_ready;
  wire       [255:0]  packetStream_payload_data;
  wire       [31:0]   packetStream_payload_keep;
  wire                packetStream_payload_last;
  reg        [31:0]   packetStream_payload_user;
  wire                packetReg_valid;
  reg                 packetReg_ready;
  wire       [255:0]  packetReg_payload_data;
  wire       [31:0]   packetReg_payload_keep;
  wire                packetReg_payload_last;
  reg        [31:0]   packetReg_payload_user;
  reg                 _zz_packetStream_valid;
  reg                 _zz_packetReg_valid;
  wire                when_Stream_l948;
  wire                when_Stream_l948_1;
  wire                packetStream_fire;
  wire                packetReg_fire;
  wire                packetReg_m2sPipe_valid;
  wire                packetReg_m2sPipe_ready;
  wire       [255:0]  packetReg_m2sPipe_payload_data;
  wire       [31:0]   packetReg_m2sPipe_payload_keep;
  wire                packetReg_m2sPipe_payload_last;
  reg        [31:0]   packetReg_m2sPipe_payload_user;
  reg                 packetReg_rValid;
  reg        [255:0]  packetReg_rData_data;
  reg        [31:0]   packetReg_rData_keep;
  reg                 packetReg_rData_last;
  reg        [31:0]   packetReg_rData_user;
  wire                when_Stream_l368;
  wire                packetStreamReg_valid;
  reg                 packetStreamReg_ready;
  wire       [255:0]  packetStreamReg_payload_data;
  wire       [31:0]   packetStreamReg_payload_keep;
  wire                packetStreamReg_payload_last;
  reg        [31:0]   packetStreamReg_payload_user;
  reg                 packetReg_m2sPipe_rValid;
  reg        [255:0]  packetReg_m2sPipe_rData_data;
  reg        [31:0]   packetReg_m2sPipe_rData_keep;
  reg                 packetReg_m2sPipe_rData_last;
  reg        [31:0]   packetReg_m2sPipe_rData_user;
  wire       [31:0]   _zz_packetStreamReg_payload_user;
  wire       [511:0]  combineData;
  wire                packetStream_fire_1;
  wire                setMeta;
  wire       [111:0]  splitHeader_0;
  wire       [159:0]  splitHeader_1;
  wire       [63:0]   splitHeader_2;
  wire       [175:0]  splitHeader_3;
  wire       [47:0]   ethHeaderExtract_0;
  wire       [47:0]   ethHeaderExtract_1;
  wire       [15:0]   ethHeaderExtract_2;
  wire       [111:0]  _zz_ethHeaderExtract_0;
  wire       [3:0]    ipv4HeaderExtract_0;
  wire       [3:0]    ipv4HeaderExtract_1;
  wire       [5:0]    ipv4HeaderExtract_2;
  wire       [1:0]    ipv4HeaderExtract_3;
  wire       [15:0]   ipv4HeaderExtract_4;
  wire       [15:0]   ipv4HeaderExtract_5;
  wire       [2:0]    ipv4HeaderExtract_6;
  wire       [12:0]   ipv4HeaderExtract_7;
  wire       [7:0]    ipv4HeaderExtract_8;
  wire       [7:0]    ipv4HeaderExtract_9;
  wire       [15:0]   ipv4HeaderExtract_10;
  wire       [31:0]   ipv4HeaderExtract_11;
  wire       [31:0]   ipv4HeaderExtract_12;
  wire       [159:0]  _zz_ipv4HeaderExtract_0;
  wire       [15:0]   udpHeaderExtract_0;
  wire       [15:0]   udpHeaderExtract_1;
  wire       [15:0]   udpHeaderExtract_2;
  wire       [15:0]   udpHeaderExtract_3;
  wire       [63:0]   _zz_udpHeaderExtract_0;
  reg        [47:0]   ethHeaderExtractReg_0;
  reg        [47:0]   ethHeaderExtractReg_1;
  reg        [15:0]   ethHeaderExtractReg_2;
  reg        [3:0]    ipv4HeaderExtractReg_0;
  reg        [3:0]    ipv4HeaderExtractReg_1;
  reg        [5:0]    ipv4HeaderExtractReg_2;
  reg        [1:0]    ipv4HeaderExtractReg_3;
  reg        [15:0]   ipv4HeaderExtractReg_4;
  reg        [15:0]   ipv4HeaderExtractReg_5;
  reg        [2:0]    ipv4HeaderExtractReg_6;
  reg        [12:0]   ipv4HeaderExtractReg_7;
  reg        [7:0]    ipv4HeaderExtractReg_8;
  reg        [7:0]    ipv4HeaderExtractReg_9;
  reg        [15:0]   ipv4HeaderExtractReg_10;
  reg        [31:0]   ipv4HeaderExtractReg_11;
  reg        [31:0]   ipv4HeaderExtractReg_12;
  reg        [15:0]   udpHeaderExtractReg_0;
  reg        [15:0]   udpHeaderExtractReg_1;
  reg        [15:0]   udpHeaderExtractReg_2;
  reg        [15:0]   udpHeaderExtractReg_3;
  reg                 macAddrCorrectReg;
  reg                 ipAddrCorrectReg;
  reg                 isIpReg;
  reg                 isUdpReg;
  wire                headerMatch;
  reg        [15:0]   dataLen;
  reg        [4:0]    shiftLen;
  reg        [5:0]    packetLenReg;
  wire                needOneMoreCycle;
  wire                when_HeaderRecognizer_l91;
  wire                when_HeaderRecognizer_l92;
  wire                when_HeaderRecognizer_l93;
  wire                when_HeaderRecognizer_l94;
  wire                packetStreamReg_fire;
  wire                when_HeaderRecognizer_l97;
  wire                packetStreamReg_fire_1;
  wire                when_HeaderRecognizer_l98;
  wire                packetStreamReg_fire_2;
  wire                when_HeaderRecognizer_l99;
  wire                packetStreamReg_fire_3;
  wire                when_HeaderRecognizer_l100;
  wire                metaCfg_valid;
  wire                metaCfg_ready;
  wire       [11:0]   metaCfg_payload_dataLen;
  wire       [47:0]   metaCfg_payload_dstMacAddr;
  wire       [31:0]   metaCfg_payload_dstIpAddr;
  wire       [47:0]   metaCfg_payload_srcMacAddr;
  wire       [31:0]   metaCfg_payload_srcIpAddr;
  wire       [15:0]   metaCfg_payload_dstPort;
  wire       [15:0]   metaCfg_payload_srcPort;
  reg                 headerMatch_regNext;
  reg                 _zz_metaCfg_valid;
  wire                packetStream_fire_2;
  wire                when_HeaderRecognizer_l122;
  wire                packetStream_fire_3;
  wire                dataStreamRegValid;
  wire                dataStreamValid;
  wire                when_Stream_l438;
  reg                 packetStreamReg_thrown_valid;
  reg                 packetStreamReg_thrown_ready;
  wire       [255:0]  packetStreamReg_thrown_payload_data;
  wire       [31:0]   packetStreamReg_thrown_payload_keep;
  wire                packetStreamReg_thrown_payload_last;
  reg        [31:0]   packetStreamReg_thrown_payload_user;
  wire                packetStreamReg_thrown_m2sPipe_valid;
  wire                packetStreamReg_thrown_m2sPipe_ready;
  wire       [255:0]  packetStreamReg_thrown_m2sPipe_payload_data;
  wire       [31:0]   packetStreamReg_thrown_m2sPipe_payload_keep;
  wire                packetStreamReg_thrown_m2sPipe_payload_last;
  reg        [31:0]   packetStreamReg_thrown_m2sPipe_payload_user;
  reg                 packetStreamReg_thrown_rValid;
  reg        [255:0]  packetStreamReg_thrown_rData_data;
  reg        [31:0]   packetStreamReg_thrown_rData_keep;
  reg                 packetStreamReg_thrown_rData_last;
  reg        [31:0]   packetStreamReg_thrown_rData_user;
  wire                when_Stream_l368_1;
  wire                dataStreamReg_valid;
  wire                dataStreamReg_ready;
  wire       [255:0]  dataStreamReg_payload_data;
  wire       [31:0]   dataStreamReg_payload_keep;
  wire                dataStreamReg_payload_last;
  reg        [31:0]   dataStreamReg_payload_user;
  reg                 packetStreamReg_thrown_m2sPipe_rValid;
  reg        [255:0]  packetStreamReg_thrown_m2sPipe_rData_data;
  reg        [31:0]   packetStreamReg_thrown_m2sPipe_rData_keep;
  reg                 packetStreamReg_thrown_m2sPipe_rData_last;
  reg        [31:0]   packetStreamReg_thrown_m2sPipe_rData_user;
  wire       [31:0]   _zz_dataStreamReg_payload_user;
  wire                when_Stream_l438_1;
  reg                 packetStream_thrown_valid;
  reg                 packetStream_thrown_ready;
  wire       [255:0]  packetStream_thrown_payload_data;
  wire       [31:0]   packetStream_thrown_payload_keep;
  wire                packetStream_thrown_payload_last;
  reg        [31:0]   packetStream_thrown_payload_user;
  wire                packetStream_thrown_m2sPipe_valid;
  wire                packetStream_thrown_m2sPipe_ready;
  wire       [255:0]  packetStream_thrown_m2sPipe_payload_data;
  wire       [31:0]   packetStream_thrown_m2sPipe_payload_keep;
  wire                packetStream_thrown_m2sPipe_payload_last;
  reg        [31:0]   packetStream_thrown_m2sPipe_payload_user;
  reg                 packetStream_thrown_rValid;
  reg        [255:0]  packetStream_thrown_rData_data;
  reg        [31:0]   packetStream_thrown_rData_keep;
  reg                 packetStream_thrown_rData_last;
  reg        [31:0]   packetStream_thrown_rData_user;
  wire                when_Stream_l368_2;
  wire                dataStream_valid;
  wire                dataStream_ready;
  wire       [255:0]  dataStream_payload_data;
  wire       [31:0]   dataStream_payload_keep;
  wire                dataStream_payload_last;
  reg        [31:0]   dataStream_payload_user;
  reg                 packetStream_thrown_m2sPipe_rValid;
  reg        [255:0]  packetStream_thrown_m2sPipe_rData_data;
  reg        [31:0]   packetStream_thrown_m2sPipe_rData_keep;
  reg                 packetStream_thrown_m2sPipe_rData_last;
  reg        [31:0]   packetStream_thrown_m2sPipe_rData_user;
  wire       [31:0]   _zz_dataStream_payload_user;
  reg                 invalidReg;
  wire                withSub;
  reg        [255:0]  _zz_dataJoinStream_payload_2_data;
  reg        [31:0]   _zz_dataJoinStream_payload_2_keep;
  reg                 _zz_dataJoinStream_payload_2_last;
  reg        [31:0]   _zz_dataJoinStream_payload_2_user;
  wire                when_StreamUtils_l26;
  wire                when_StreamUtils_l26_1;
  wire                when_StreamUtils_l26_2;
  wire                when_StreamUtils_l26_3;
  wire                _zz_dataStreamReg_ready;
  reg                 _zz_dataStreamReg_ready_1;
  reg        [31:0]   _zz_dataJoinStream_payload_1_user;
  reg        [31:0]   _zz_dataJoinStream_payload_2_user_1;
  wire                _zz_when_Stream_l368;
  reg                 _zz_dataStreamReg_ready_2;
  reg        [31:0]   _zz_dataJoinStream_payload_1_user_1;
  reg        [31:0]   _zz_dataJoinStream_payload_2_user_2;
  reg                 _zz_when_Stream_l368_1;
  reg        [255:0]  _zz_dataJoinStream_payload_1_data;
  reg        [31:0]   _zz_dataJoinStream_payload_1_keep;
  reg                 _zz_dataJoinStream_payload_1_last;
  reg        [31:0]   _zz_dataJoinStream_payload_1_user_2;
  reg        [255:0]  _zz_dataJoinStream_payload_2_data_1;
  reg        [31:0]   _zz_dataJoinStream_payload_2_keep_1;
  reg                 _zz_dataJoinStream_payload_2_last_1;
  reg        [31:0]   _zz_dataJoinStream_payload_2_user_3;
  wire                when_Stream_l368_3;
  reg                 dataJoinStream_valid;
  wire                dataJoinStream_ready;
  wire       [255:0]  dataJoinStream_payload_1_data;
  wire       [31:0]   dataJoinStream_payload_1_keep;
  wire                dataJoinStream_payload_1_last;
  reg        [31:0]   dataJoinStream_payload_1_user;
  wire       [255:0]  dataJoinStream_payload_2_data;
  wire       [31:0]   dataJoinStream_payload_2_keep;
  wire                dataJoinStream_payload_2_last;
  reg        [31:0]   dataJoinStream_payload_2_user;
  reg                 headerMatch_regNext_1;
  reg                 _zz_io_ctrlFire;
  wire                dataJoinStream_fire;
  wire                maskStage_valid;
  reg                 maskStage_ready;
  wire       [255:0]  maskStage_payload_data;
  wire       [31:0]   maskStage_payload_keep;
  wire                maskStage_payload_last;
  wire       [31:0]   maskStage_payload_user;
  reg        [31:0]   _zz_mask;
  reg        [31:0]   _zz_mask_1;
  reg        [31:0]   _zz_mask_2;
  reg        [31:0]   _zz_mask_3;
  reg        [31:0]   _zz_mask_4;
  reg        [31:0]   _zz_mask_5;
  reg        [31:0]   _zz_mask_6;
  reg        [31:0]   _zz_mask_7;
  reg        [31:0]   _zz_mask_8;
  reg        [31:0]   _zz_mask_9;
  reg        [31:0]   _zz_mask_10;
  reg        [31:0]   _zz_mask_11;
  reg        [31:0]   _zz_mask_12;
  reg        [31:0]   _zz_mask_13;
  reg        [31:0]   _zz_mask_14;
  reg        [31:0]   _zz_mask_15;
  reg        [31:0]   _zz_mask_16;
  reg        [31:0]   _zz_mask_17;
  reg        [31:0]   _zz_mask_18;
  reg        [31:0]   _zz_mask_19;
  reg        [31:0]   _zz_mask_20;
  reg        [31:0]   _zz_mask_21;
  reg        [31:0]   _zz_mask_22;
  reg        [31:0]   _zz_mask_23;
  reg        [31:0]   _zz_mask_24;
  reg        [31:0]   _zz_mask_25;
  reg        [31:0]   _zz_mask_26;
  reg        [31:0]   _zz_mask_27;
  reg        [31:0]   _zz_mask_28;
  reg        [31:0]   _zz_mask_29;
  reg        [31:0]   _zz_mask_30;
  reg        [31:0]   _zz_mask_31;
  wire                dataStreamReg_fire;
  wire                when_HeaderRecognizer_l148;
  reg        [31:0]   mask;
  wire       [31:0]   _zz_maskStage_payload_data;
  wire       [31:0]   _zz_maskStage_payload_keep;
  wire                maskStage_m2sPipe_valid;
  wire                maskStage_m2sPipe_ready;
  wire       [255:0]  maskStage_m2sPipe_payload_data;
  wire       [31:0]   maskStage_m2sPipe_payload_keep;
  wire                maskStage_m2sPipe_payload_last;
  reg        [31:0]   maskStage_m2sPipe_payload_user;
  reg                 maskStage_rValid;
  reg        [255:0]  maskStage_rData_data;
  reg        [31:0]   maskStage_rData_keep;
  reg                 maskStage_rData_last;
  reg        [31:0]   maskStage_rData_user;
  wire                when_Stream_l368_4;
  wire                maskedStage_valid;
  wire                maskedStage_ready;
  wire       [255:0]  maskedStage_payload_data;
  wire       [31:0]   maskedStage_payload_keep;
  wire                maskedStage_payload_last;
  reg        [31:0]   maskedStage_payload_user;
  reg                 maskStage_m2sPipe_rValid;
  reg        [255:0]  maskStage_m2sPipe_rData_data;
  reg        [31:0]   maskStage_m2sPipe_rData_keep;
  reg                 maskStage_m2sPipe_rData_last;
  reg        [31:0]   maskStage_m2sPipe_rData_user;
  wire       [31:0]   _zz_maskedStage_payload_user;
  wire                shiftStage_valid;
  wire                shiftStage_ready;
  wire       [255:0]  shiftStage_payload_data;
  wire       [31:0]   shiftStage_payload_keep;
  wire                shiftStage_payload_last;
  wire       [31:0]   shiftStage_payload_user;
  reg        [255:0]  _zz_shiftStage_payload_data;
  reg        [31:0]   _zz_shiftStage_payload_keep;
  function [31:0] zz__zz_mask_1(input dummy);
    begin
      zz__zz_mask_1 = 32'h0;
      zz__zz_mask_1[31 : 31] = 1'b1;
    end
  endfunction
  wire [31:0] _zz_1;
  function [31:0] zz__zz_mask_2(input dummy);
    begin
      zz__zz_mask_2 = 32'h0;
      zz__zz_mask_2[31 : 30] = 2'b11;
    end
  endfunction
  wire [31:0] _zz_2;
  function [31:0] zz__zz_mask_3(input dummy);
    begin
      zz__zz_mask_3 = 32'h0;
      zz__zz_mask_3[31 : 29] = 3'b111;
    end
  endfunction
  wire [31:0] _zz_3;
  function [31:0] zz__zz_mask_4(input dummy);
    begin
      zz__zz_mask_4 = 32'h0;
      zz__zz_mask_4[31 : 28] = 4'b1111;
    end
  endfunction
  wire [31:0] _zz_4;
  function [31:0] zz__zz_mask_5(input dummy);
    begin
      zz__zz_mask_5 = 32'h0;
      zz__zz_mask_5[31 : 27] = 5'h1f;
    end
  endfunction
  wire [31:0] _zz_5;
  function [31:0] zz__zz_mask_6(input dummy);
    begin
      zz__zz_mask_6 = 32'h0;
      zz__zz_mask_6[31 : 26] = 6'h3f;
    end
  endfunction
  wire [31:0] _zz_6;
  function [31:0] zz__zz_mask_7(input dummy);
    begin
      zz__zz_mask_7 = 32'h0;
      zz__zz_mask_7[31 : 25] = 7'h7f;
    end
  endfunction
  wire [31:0] _zz_7;
  function [31:0] zz__zz_mask_8(input dummy);
    begin
      zz__zz_mask_8 = 32'h0;
      zz__zz_mask_8[31 : 24] = 8'hff;
    end
  endfunction
  wire [31:0] _zz_8;
  function [31:0] zz__zz_mask_9(input dummy);
    begin
      zz__zz_mask_9 = 32'h0;
      zz__zz_mask_9[31 : 23] = 9'h1ff;
    end
  endfunction
  wire [31:0] _zz_9;
  function [31:0] zz__zz_mask_10(input dummy);
    begin
      zz__zz_mask_10 = 32'h0;
      zz__zz_mask_10[31 : 22] = 10'h3ff;
    end
  endfunction
  wire [31:0] _zz_10;
  function [31:0] zz__zz_mask_11(input dummy);
    begin
      zz__zz_mask_11 = 32'h0;
      zz__zz_mask_11[31 : 21] = 11'h7ff;
    end
  endfunction
  wire [31:0] _zz_11;
  function [31:0] zz__zz_mask_12(input dummy);
    begin
      zz__zz_mask_12 = 32'h0;
      zz__zz_mask_12[31 : 20] = 12'hfff;
    end
  endfunction
  wire [31:0] _zz_12;
  function [31:0] zz__zz_mask_13(input dummy);
    begin
      zz__zz_mask_13 = 32'h0;
      zz__zz_mask_13[31 : 19] = 13'h1fff;
    end
  endfunction
  wire [31:0] _zz_13;
  function [31:0] zz__zz_mask_14(input dummy);
    begin
      zz__zz_mask_14 = 32'h0;
      zz__zz_mask_14[31 : 18] = 14'h3fff;
    end
  endfunction
  wire [31:0] _zz_14;
  function [31:0] zz__zz_mask_15(input dummy);
    begin
      zz__zz_mask_15 = 32'h0;
      zz__zz_mask_15[31 : 17] = 15'h7fff;
    end
  endfunction
  wire [31:0] _zz_15;
  function [31:0] zz__zz_mask_16(input dummy);
    begin
      zz__zz_mask_16 = 32'h0;
      zz__zz_mask_16[31 : 16] = 16'hffff;
    end
  endfunction
  wire [31:0] _zz_16;
  function [31:0] zz__zz_mask_17(input dummy);
    begin
      zz__zz_mask_17 = 32'h0;
      zz__zz_mask_17[31 : 15] = 17'h1ffff;
    end
  endfunction
  wire [31:0] _zz_17;
  function [31:0] zz__zz_mask_18(input dummy);
    begin
      zz__zz_mask_18 = 32'h0;
      zz__zz_mask_18[31 : 14] = 18'h3ffff;
    end
  endfunction
  wire [31:0] _zz_18;
  function [31:0] zz__zz_mask_19(input dummy);
    begin
      zz__zz_mask_19 = 32'h0;
      zz__zz_mask_19[31 : 13] = 19'h7ffff;
    end
  endfunction
  wire [31:0] _zz_19;
  function [31:0] zz__zz_mask_20(input dummy);
    begin
      zz__zz_mask_20 = 32'h0;
      zz__zz_mask_20[31 : 12] = 20'hfffff;
    end
  endfunction
  wire [31:0] _zz_20;
  function [31:0] zz__zz_mask_21(input dummy);
    begin
      zz__zz_mask_21 = 32'h0;
      zz__zz_mask_21[31 : 11] = 21'h1fffff;
    end
  endfunction
  wire [31:0] _zz_21;
  function [31:0] zz__zz_mask_22(input dummy);
    begin
      zz__zz_mask_22 = 32'h0;
      zz__zz_mask_22[31 : 10] = 22'h3fffff;
    end
  endfunction
  wire [31:0] _zz_22;
  function [31:0] zz__zz_mask_23(input dummy);
    begin
      zz__zz_mask_23 = 32'h0;
      zz__zz_mask_23[31 : 9] = 23'h7fffff;
    end
  endfunction
  wire [31:0] _zz_23;
  function [31:0] zz__zz_mask_24(input dummy);
    begin
      zz__zz_mask_24 = 32'h0;
      zz__zz_mask_24[31 : 8] = 24'hffffff;
    end
  endfunction
  wire [31:0] _zz_24;
  function [31:0] zz__zz_mask_25(input dummy);
    begin
      zz__zz_mask_25 = 32'h0;
      zz__zz_mask_25[31 : 7] = 25'h1ffffff;
    end
  endfunction
  wire [31:0] _zz_25;
  function [31:0] zz__zz_mask_26(input dummy);
    begin
      zz__zz_mask_26 = 32'h0;
      zz__zz_mask_26[31 : 6] = 26'h3ffffff;
    end
  endfunction
  wire [31:0] _zz_26;
  function [31:0] zz__zz_mask_27(input dummy);
    begin
      zz__zz_mask_27 = 32'h0;
      zz__zz_mask_27[31 : 5] = 27'h7ffffff;
    end
  endfunction
  wire [31:0] _zz_27;
  function [31:0] zz__zz_mask_28(input dummy);
    begin
      zz__zz_mask_28 = 32'h0;
      zz__zz_mask_28[31 : 4] = 28'hfffffff;
    end
  endfunction
  wire [31:0] _zz_28;
  function [31:0] zz__zz_mask_29(input dummy);
    begin
      zz__zz_mask_29 = 32'h0;
      zz__zz_mask_29[31 : 3] = 29'h1fffffff;
    end
  endfunction
  wire [31:0] _zz_29;
  function [31:0] zz__zz_mask_30(input dummy);
    begin
      zz__zz_mask_30 = 32'h0;
      zz__zz_mask_30[31 : 2] = 30'h3fffffff;
    end
  endfunction
  wire [31:0] _zz_30;
  function [31:0] zz__zz_mask_31(input dummy);
    begin
      zz__zz_mask_31 = 32'h0;
      zz__zz_mask_31[31 : 1] = 31'h7fffffff;
    end
  endfunction
  wire [31:0] _zz_31;

  assign _zz_needOneMoreCycle = (ipv4HeaderExtractReg_4 - 16'h001c);
  assign _zz_packetLenReg = (_zz_packetLenReg_1 >>> 5);
  assign _zz_packetLenReg_1 = (ipv4HeaderExtractReg_4 - 16'h001c);
  assign _zz__zz_ipv4HeaderExtract_0 = {{{splitHeader_1[7 : 0],splitHeader_1[15 : 8]},splitHeader_1[23 : 16]},splitHeader_1[31 : 24]};
  assign _zz__zz_ipv4HeaderExtract_0_1 = splitHeader_1[39 : 32];
  assign _zz_maskStage_payload_data_1 = {{{{_zz_maskStage_payload_data_2,_zz_maskStage_payload_data_34},(_zz_maskStage_payload_data_35 ? _zz_maskStage_payload_data_36 : _zz_maskStage_payload_data_37)},(_zz_maskStage_payload_data[5] ? 8'h0 : dataJoinStream_payload_1_data[47 : 40])},(_zz_maskStage_payload_data[4] ? 8'h0 : dataJoinStream_payload_1_data[39 : 32])};
  assign _zz_maskStage_payload_data_38 = (_zz_maskStage_payload_data[3] ? 8'h0 : dataJoinStream_payload_1_data[31 : 24]);
  assign _zz_maskStage_payload_data_39 = _zz_maskStage_payload_data[2];
  assign _zz_maskStage_payload_data_40 = 8'h0;
  assign _zz_maskStage_payload_data_41 = dataJoinStream_payload_1_data[23 : 16];
  assign _zz_maskStage_payload_data_42 = {{{{_zz_maskStage_payload_data_43,_zz_maskStage_payload_data_75},(_zz_maskStage_payload_data_76 ? _zz_maskStage_payload_data_77 : _zz_maskStage_payload_data_78)},(mask[5] ? 8'h0 : dataJoinStream_payload_2_data[47 : 40])},(mask[4] ? 8'h0 : dataJoinStream_payload_2_data[39 : 32])};
  assign _zz_maskStage_payload_data_79 = (mask[3] ? 8'h0 : dataJoinStream_payload_2_data[31 : 24]);
  assign _zz_maskStage_payload_data_80 = mask[2];
  assign _zz_maskStage_payload_data_81 = 8'h0;
  assign _zz_maskStage_payload_data_82 = dataJoinStream_payload_2_data[23 : 16];
  assign _zz_maskStage_payload_data_2 = {{{{_zz_maskStage_payload_data_3,_zz_maskStage_payload_data_30},(_zz_maskStage_payload_data_31 ? _zz_maskStage_payload_data_32 : _zz_maskStage_payload_data_33)},(_zz_maskStage_payload_data[9] ? 8'h0 : dataJoinStream_payload_1_data[79 : 72])},(_zz_maskStage_payload_data[8] ? 8'h0 : dataJoinStream_payload_1_data[71 : 64])};
  assign _zz_maskStage_payload_data_34 = (_zz_maskStage_payload_data[7] ? 8'h0 : dataJoinStream_payload_1_data[63 : 56]);
  assign _zz_maskStage_payload_data_35 = _zz_maskStage_payload_data[6];
  assign _zz_maskStage_payload_data_36 = 8'h0;
  assign _zz_maskStage_payload_data_37 = dataJoinStream_payload_1_data[55 : 48];
  assign _zz_maskStage_payload_data_43 = {{{{_zz_maskStage_payload_data_44,_zz_maskStage_payload_data_71},(_zz_maskStage_payload_data_72 ? _zz_maskStage_payload_data_73 : _zz_maskStage_payload_data_74)},(mask[9] ? 8'h0 : dataJoinStream_payload_2_data[79 : 72])},(mask[8] ? 8'h0 : dataJoinStream_payload_2_data[71 : 64])};
  assign _zz_maskStage_payload_data_75 = (mask[7] ? 8'h0 : dataJoinStream_payload_2_data[63 : 56]);
  assign _zz_maskStage_payload_data_76 = mask[6];
  assign _zz_maskStage_payload_data_77 = 8'h0;
  assign _zz_maskStage_payload_data_78 = dataJoinStream_payload_2_data[55 : 48];
  assign _zz_maskStage_payload_data_3 = {{{{_zz_maskStage_payload_data_4,_zz_maskStage_payload_data_26},(_zz_maskStage_payload_data_27 ? _zz_maskStage_payload_data_28 : _zz_maskStage_payload_data_29)},(_zz_maskStage_payload_data[13] ? 8'h0 : dataJoinStream_payload_1_data[111 : 104])},(_zz_maskStage_payload_data[12] ? 8'h0 : dataJoinStream_payload_1_data[103 : 96])};
  assign _zz_maskStage_payload_data_30 = (_zz_maskStage_payload_data[11] ? 8'h0 : dataJoinStream_payload_1_data[95 : 88]);
  assign _zz_maskStage_payload_data_31 = _zz_maskStage_payload_data[10];
  assign _zz_maskStage_payload_data_32 = 8'h0;
  assign _zz_maskStage_payload_data_33 = dataJoinStream_payload_1_data[87 : 80];
  assign _zz_maskStage_payload_data_44 = {{{{_zz_maskStage_payload_data_45,_zz_maskStage_payload_data_67},(_zz_maskStage_payload_data_68 ? _zz_maskStage_payload_data_69 : _zz_maskStage_payload_data_70)},(mask[13] ? 8'h0 : dataJoinStream_payload_2_data[111 : 104])},(mask[12] ? 8'h0 : dataJoinStream_payload_2_data[103 : 96])};
  assign _zz_maskStage_payload_data_71 = (mask[11] ? 8'h0 : dataJoinStream_payload_2_data[95 : 88]);
  assign _zz_maskStage_payload_data_72 = mask[10];
  assign _zz_maskStage_payload_data_73 = 8'h0;
  assign _zz_maskStage_payload_data_74 = dataJoinStream_payload_2_data[87 : 80];
  assign _zz_maskStage_payload_data_4 = {{{{_zz_maskStage_payload_data_5,_zz_maskStage_payload_data_22},(_zz_maskStage_payload_data_23 ? _zz_maskStage_payload_data_24 : _zz_maskStage_payload_data_25)},(_zz_maskStage_payload_data[17] ? 8'h0 : dataJoinStream_payload_1_data[143 : 136])},(_zz_maskStage_payload_data[16] ? 8'h0 : dataJoinStream_payload_1_data[135 : 128])};
  assign _zz_maskStage_payload_data_26 = (_zz_maskStage_payload_data[15] ? 8'h0 : dataJoinStream_payload_1_data[127 : 120]);
  assign _zz_maskStage_payload_data_27 = _zz_maskStage_payload_data[14];
  assign _zz_maskStage_payload_data_28 = 8'h0;
  assign _zz_maskStage_payload_data_29 = dataJoinStream_payload_1_data[119 : 112];
  assign _zz_maskStage_payload_data_45 = {{{{_zz_maskStage_payload_data_46,_zz_maskStage_payload_data_63},(_zz_maskStage_payload_data_64 ? _zz_maskStage_payload_data_65 : _zz_maskStage_payload_data_66)},(mask[17] ? 8'h0 : dataJoinStream_payload_2_data[143 : 136])},(mask[16] ? 8'h0 : dataJoinStream_payload_2_data[135 : 128])};
  assign _zz_maskStage_payload_data_67 = (mask[15] ? 8'h0 : dataJoinStream_payload_2_data[127 : 120]);
  assign _zz_maskStage_payload_data_68 = mask[14];
  assign _zz_maskStage_payload_data_69 = 8'h0;
  assign _zz_maskStage_payload_data_70 = dataJoinStream_payload_2_data[119 : 112];
  assign _zz_maskStage_payload_data_5 = {{{{_zz_maskStage_payload_data_6,_zz_maskStage_payload_data_18},(_zz_maskStage_payload_data_19 ? _zz_maskStage_payload_data_20 : _zz_maskStage_payload_data_21)},(_zz_maskStage_payload_data[21] ? 8'h0 : dataJoinStream_payload_1_data[175 : 168])},(_zz_maskStage_payload_data[20] ? 8'h0 : dataJoinStream_payload_1_data[167 : 160])};
  assign _zz_maskStage_payload_data_22 = (_zz_maskStage_payload_data[19] ? 8'h0 : dataJoinStream_payload_1_data[159 : 152]);
  assign _zz_maskStage_payload_data_23 = _zz_maskStage_payload_data[18];
  assign _zz_maskStage_payload_data_24 = 8'h0;
  assign _zz_maskStage_payload_data_25 = dataJoinStream_payload_1_data[151 : 144];
  assign _zz_maskStage_payload_data_46 = {{{{_zz_maskStage_payload_data_47,_zz_maskStage_payload_data_59},(_zz_maskStage_payload_data_60 ? _zz_maskStage_payload_data_61 : _zz_maskStage_payload_data_62)},(mask[21] ? 8'h0 : dataJoinStream_payload_2_data[175 : 168])},(mask[20] ? 8'h0 : dataJoinStream_payload_2_data[167 : 160])};
  assign _zz_maskStage_payload_data_63 = (mask[19] ? 8'h0 : dataJoinStream_payload_2_data[159 : 152]);
  assign _zz_maskStage_payload_data_64 = mask[18];
  assign _zz_maskStage_payload_data_65 = 8'h0;
  assign _zz_maskStage_payload_data_66 = dataJoinStream_payload_2_data[151 : 144];
  assign _zz_maskStage_payload_data_6 = {{{{_zz_maskStage_payload_data_7,_zz_maskStage_payload_data_14},(_zz_maskStage_payload_data_15 ? _zz_maskStage_payload_data_16 : _zz_maskStage_payload_data_17)},(_zz_maskStage_payload_data[25] ? 8'h0 : dataJoinStream_payload_1_data[207 : 200])},(_zz_maskStage_payload_data[24] ? 8'h0 : dataJoinStream_payload_1_data[199 : 192])};
  assign _zz_maskStage_payload_data_18 = (_zz_maskStage_payload_data[23] ? 8'h0 : dataJoinStream_payload_1_data[191 : 184]);
  assign _zz_maskStage_payload_data_19 = _zz_maskStage_payload_data[22];
  assign _zz_maskStage_payload_data_20 = 8'h0;
  assign _zz_maskStage_payload_data_21 = dataJoinStream_payload_1_data[183 : 176];
  assign _zz_maskStage_payload_data_47 = {{{{_zz_maskStage_payload_data_48,_zz_maskStage_payload_data_55},(_zz_maskStage_payload_data_56 ? _zz_maskStage_payload_data_57 : _zz_maskStage_payload_data_58)},(mask[25] ? 8'h0 : dataJoinStream_payload_2_data[207 : 200])},(mask[24] ? 8'h0 : dataJoinStream_payload_2_data[199 : 192])};
  assign _zz_maskStage_payload_data_59 = (mask[23] ? 8'h0 : dataJoinStream_payload_2_data[191 : 184]);
  assign _zz_maskStage_payload_data_60 = mask[22];
  assign _zz_maskStage_payload_data_61 = 8'h0;
  assign _zz_maskStage_payload_data_62 = dataJoinStream_payload_2_data[183 : 176];
  assign _zz_maskStage_payload_data_7 = {{{(_zz_maskStage_payload_data_8 ? _zz_maskStage_payload_data_9 : _zz_maskStage_payload_data_10),(_zz_maskStage_payload_data_11 ? _zz_maskStage_payload_data_12 : _zz_maskStage_payload_data_13)},(_zz_maskStage_payload_data[29] ? 8'h0 : dataJoinStream_payload_1_data[239 : 232])},(_zz_maskStage_payload_data[28] ? 8'h0 : dataJoinStream_payload_1_data[231 : 224])};
  assign _zz_maskStage_payload_data_14 = (_zz_maskStage_payload_data[27] ? 8'h0 : dataJoinStream_payload_1_data[223 : 216]);
  assign _zz_maskStage_payload_data_15 = _zz_maskStage_payload_data[26];
  assign _zz_maskStage_payload_data_16 = 8'h0;
  assign _zz_maskStage_payload_data_17 = dataJoinStream_payload_1_data[215 : 208];
  assign _zz_maskStage_payload_data_48 = {{{(_zz_maskStage_payload_data_49 ? _zz_maskStage_payload_data_50 : _zz_maskStage_payload_data_51),(_zz_maskStage_payload_data_52 ? _zz_maskStage_payload_data_53 : _zz_maskStage_payload_data_54)},(mask[29] ? 8'h0 : dataJoinStream_payload_2_data[239 : 232])},(mask[28] ? 8'h0 : dataJoinStream_payload_2_data[231 : 224])};
  assign _zz_maskStage_payload_data_55 = (mask[27] ? 8'h0 : dataJoinStream_payload_2_data[223 : 216]);
  assign _zz_maskStage_payload_data_56 = mask[26];
  assign _zz_maskStage_payload_data_57 = 8'h0;
  assign _zz_maskStage_payload_data_58 = dataJoinStream_payload_2_data[215 : 208];
  assign _zz_maskStage_payload_data_8 = _zz_maskStage_payload_data[31];
  assign _zz_maskStage_payload_data_9 = 8'h0;
  assign _zz_maskStage_payload_data_10 = dataJoinStream_payload_1_data[255 : 248];
  assign _zz_maskStage_payload_data_11 = _zz_maskStage_payload_data[30];
  assign _zz_maskStage_payload_data_12 = 8'h0;
  assign _zz_maskStage_payload_data_13 = dataJoinStream_payload_1_data[247 : 240];
  assign _zz_maskStage_payload_data_49 = mask[31];
  assign _zz_maskStage_payload_data_50 = 8'h0;
  assign _zz_maskStage_payload_data_51 = dataJoinStream_payload_2_data[255 : 248];
  assign _zz_maskStage_payload_data_52 = mask[30];
  assign _zz_maskStage_payload_data_53 = 8'h0;
  assign _zz_maskStage_payload_data_54 = dataJoinStream_payload_2_data[247 : 240];
  assign _zz_maskStage_payload_keep_1 = {{{{_zz_maskStage_payload_keep_2,_zz_maskStage_payload_keep_34},(_zz_maskStage_payload_keep_35 ? _zz_maskStage_payload_keep_36 : _zz_maskStage_payload_keep_37)},(_zz_maskStage_payload_keep[5] ? 1'b0 : dataJoinStream_payload_1_keep[5 : 5])},(_zz_maskStage_payload_keep[4] ? 1'b0 : dataJoinStream_payload_1_keep[4 : 4])};
  assign _zz_maskStage_payload_keep_38 = (_zz_maskStage_payload_keep[3] ? 1'b0 : dataJoinStream_payload_1_keep[3 : 3]);
  assign _zz_maskStage_payload_keep_39 = _zz_maskStage_payload_keep[2];
  assign _zz_maskStage_payload_keep_40 = 1'b0;
  assign _zz_maskStage_payload_keep_41 = dataJoinStream_payload_1_keep[2 : 2];
  assign _zz_maskStage_payload_keep_42 = {{{{_zz_maskStage_payload_keep_43,_zz_maskStage_payload_keep_75},(_zz_maskStage_payload_keep_76 ? _zz_maskStage_payload_keep_77 : _zz_maskStage_payload_keep_78)},(mask[5] ? 1'b0 : dataJoinStream_payload_2_keep[5 : 5])},(mask[4] ? 1'b0 : dataJoinStream_payload_2_keep[4 : 4])};
  assign _zz_maskStage_payload_keep_79 = (mask[3] ? 1'b0 : dataJoinStream_payload_2_keep[3 : 3]);
  assign _zz_maskStage_payload_keep_80 = mask[2];
  assign _zz_maskStage_payload_keep_81 = 1'b0;
  assign _zz_maskStage_payload_keep_82 = dataJoinStream_payload_2_keep[2 : 2];
  assign _zz_maskStage_payload_keep_2 = {{{{_zz_maskStage_payload_keep_3,_zz_maskStage_payload_keep_30},(_zz_maskStage_payload_keep_31 ? _zz_maskStage_payload_keep_32 : _zz_maskStage_payload_keep_33)},(_zz_maskStage_payload_keep[9] ? 1'b0 : dataJoinStream_payload_1_keep[9 : 9])},(_zz_maskStage_payload_keep[8] ? 1'b0 : dataJoinStream_payload_1_keep[8 : 8])};
  assign _zz_maskStage_payload_keep_34 = (_zz_maskStage_payload_keep[7] ? 1'b0 : dataJoinStream_payload_1_keep[7 : 7]);
  assign _zz_maskStage_payload_keep_35 = _zz_maskStage_payload_keep[6];
  assign _zz_maskStage_payload_keep_36 = 1'b0;
  assign _zz_maskStage_payload_keep_37 = dataJoinStream_payload_1_keep[6 : 6];
  assign _zz_maskStage_payload_keep_43 = {{{{_zz_maskStage_payload_keep_44,_zz_maskStage_payload_keep_71},(_zz_maskStage_payload_keep_72 ? _zz_maskStage_payload_keep_73 : _zz_maskStage_payload_keep_74)},(mask[9] ? 1'b0 : dataJoinStream_payload_2_keep[9 : 9])},(mask[8] ? 1'b0 : dataJoinStream_payload_2_keep[8 : 8])};
  assign _zz_maskStage_payload_keep_75 = (mask[7] ? 1'b0 : dataJoinStream_payload_2_keep[7 : 7]);
  assign _zz_maskStage_payload_keep_76 = mask[6];
  assign _zz_maskStage_payload_keep_77 = 1'b0;
  assign _zz_maskStage_payload_keep_78 = dataJoinStream_payload_2_keep[6 : 6];
  assign _zz_maskStage_payload_keep_3 = {{{{_zz_maskStage_payload_keep_4,_zz_maskStage_payload_keep_26},(_zz_maskStage_payload_keep_27 ? _zz_maskStage_payload_keep_28 : _zz_maskStage_payload_keep_29)},(_zz_maskStage_payload_keep[13] ? 1'b0 : dataJoinStream_payload_1_keep[13 : 13])},(_zz_maskStage_payload_keep[12] ? 1'b0 : dataJoinStream_payload_1_keep[12 : 12])};
  assign _zz_maskStage_payload_keep_30 = (_zz_maskStage_payload_keep[11] ? 1'b0 : dataJoinStream_payload_1_keep[11 : 11]);
  assign _zz_maskStage_payload_keep_31 = _zz_maskStage_payload_keep[10];
  assign _zz_maskStage_payload_keep_32 = 1'b0;
  assign _zz_maskStage_payload_keep_33 = dataJoinStream_payload_1_keep[10 : 10];
  assign _zz_maskStage_payload_keep_44 = {{{{_zz_maskStage_payload_keep_45,_zz_maskStage_payload_keep_67},(_zz_maskStage_payload_keep_68 ? _zz_maskStage_payload_keep_69 : _zz_maskStage_payload_keep_70)},(mask[13] ? 1'b0 : dataJoinStream_payload_2_keep[13 : 13])},(mask[12] ? 1'b0 : dataJoinStream_payload_2_keep[12 : 12])};
  assign _zz_maskStage_payload_keep_71 = (mask[11] ? 1'b0 : dataJoinStream_payload_2_keep[11 : 11]);
  assign _zz_maskStage_payload_keep_72 = mask[10];
  assign _zz_maskStage_payload_keep_73 = 1'b0;
  assign _zz_maskStage_payload_keep_74 = dataJoinStream_payload_2_keep[10 : 10];
  assign _zz_maskStage_payload_keep_4 = {{{{_zz_maskStage_payload_keep_5,_zz_maskStage_payload_keep_22},(_zz_maskStage_payload_keep_23 ? _zz_maskStage_payload_keep_24 : _zz_maskStage_payload_keep_25)},(_zz_maskStage_payload_keep[17] ? 1'b0 : dataJoinStream_payload_1_keep[17 : 17])},(_zz_maskStage_payload_keep[16] ? 1'b0 : dataJoinStream_payload_1_keep[16 : 16])};
  assign _zz_maskStage_payload_keep_26 = (_zz_maskStage_payload_keep[15] ? 1'b0 : dataJoinStream_payload_1_keep[15 : 15]);
  assign _zz_maskStage_payload_keep_27 = _zz_maskStage_payload_keep[14];
  assign _zz_maskStage_payload_keep_28 = 1'b0;
  assign _zz_maskStage_payload_keep_29 = dataJoinStream_payload_1_keep[14 : 14];
  assign _zz_maskStage_payload_keep_45 = {{{{_zz_maskStage_payload_keep_46,_zz_maskStage_payload_keep_63},(_zz_maskStage_payload_keep_64 ? _zz_maskStage_payload_keep_65 : _zz_maskStage_payload_keep_66)},(mask[17] ? 1'b0 : dataJoinStream_payload_2_keep[17 : 17])},(mask[16] ? 1'b0 : dataJoinStream_payload_2_keep[16 : 16])};
  assign _zz_maskStage_payload_keep_67 = (mask[15] ? 1'b0 : dataJoinStream_payload_2_keep[15 : 15]);
  assign _zz_maskStage_payload_keep_68 = mask[14];
  assign _zz_maskStage_payload_keep_69 = 1'b0;
  assign _zz_maskStage_payload_keep_70 = dataJoinStream_payload_2_keep[14 : 14];
  assign _zz_maskStage_payload_keep_5 = {{{{_zz_maskStage_payload_keep_6,_zz_maskStage_payload_keep_18},(_zz_maskStage_payload_keep_19 ? _zz_maskStage_payload_keep_20 : _zz_maskStage_payload_keep_21)},(_zz_maskStage_payload_keep[21] ? 1'b0 : dataJoinStream_payload_1_keep[21 : 21])},(_zz_maskStage_payload_keep[20] ? 1'b0 : dataJoinStream_payload_1_keep[20 : 20])};
  assign _zz_maskStage_payload_keep_22 = (_zz_maskStage_payload_keep[19] ? 1'b0 : dataJoinStream_payload_1_keep[19 : 19]);
  assign _zz_maskStage_payload_keep_23 = _zz_maskStage_payload_keep[18];
  assign _zz_maskStage_payload_keep_24 = 1'b0;
  assign _zz_maskStage_payload_keep_25 = dataJoinStream_payload_1_keep[18 : 18];
  assign _zz_maskStage_payload_keep_46 = {{{{_zz_maskStage_payload_keep_47,_zz_maskStage_payload_keep_59},(_zz_maskStage_payload_keep_60 ? _zz_maskStage_payload_keep_61 : _zz_maskStage_payload_keep_62)},(mask[21] ? 1'b0 : dataJoinStream_payload_2_keep[21 : 21])},(mask[20] ? 1'b0 : dataJoinStream_payload_2_keep[20 : 20])};
  assign _zz_maskStage_payload_keep_63 = (mask[19] ? 1'b0 : dataJoinStream_payload_2_keep[19 : 19]);
  assign _zz_maskStage_payload_keep_64 = mask[18];
  assign _zz_maskStage_payload_keep_65 = 1'b0;
  assign _zz_maskStage_payload_keep_66 = dataJoinStream_payload_2_keep[18 : 18];
  assign _zz_maskStage_payload_keep_6 = {{{{_zz_maskStage_payload_keep_7,_zz_maskStage_payload_keep_14},(_zz_maskStage_payload_keep_15 ? _zz_maskStage_payload_keep_16 : _zz_maskStage_payload_keep_17)},(_zz_maskStage_payload_keep[25] ? 1'b0 : dataJoinStream_payload_1_keep[25 : 25])},(_zz_maskStage_payload_keep[24] ? 1'b0 : dataJoinStream_payload_1_keep[24 : 24])};
  assign _zz_maskStage_payload_keep_18 = (_zz_maskStage_payload_keep[23] ? 1'b0 : dataJoinStream_payload_1_keep[23 : 23]);
  assign _zz_maskStage_payload_keep_19 = _zz_maskStage_payload_keep[22];
  assign _zz_maskStage_payload_keep_20 = 1'b0;
  assign _zz_maskStage_payload_keep_21 = dataJoinStream_payload_1_keep[22 : 22];
  assign _zz_maskStage_payload_keep_47 = {{{{_zz_maskStage_payload_keep_48,_zz_maskStage_payload_keep_55},(_zz_maskStage_payload_keep_56 ? _zz_maskStage_payload_keep_57 : _zz_maskStage_payload_keep_58)},(mask[25] ? 1'b0 : dataJoinStream_payload_2_keep[25 : 25])},(mask[24] ? 1'b0 : dataJoinStream_payload_2_keep[24 : 24])};
  assign _zz_maskStage_payload_keep_59 = (mask[23] ? 1'b0 : dataJoinStream_payload_2_keep[23 : 23]);
  assign _zz_maskStage_payload_keep_60 = mask[22];
  assign _zz_maskStage_payload_keep_61 = 1'b0;
  assign _zz_maskStage_payload_keep_62 = dataJoinStream_payload_2_keep[22 : 22];
  assign _zz_maskStage_payload_keep_7 = {{{(_zz_maskStage_payload_keep_8 ? _zz_maskStage_payload_keep_9 : _zz_maskStage_payload_keep_10),(_zz_maskStage_payload_keep_11 ? _zz_maskStage_payload_keep_12 : _zz_maskStage_payload_keep_13)},(_zz_maskStage_payload_keep[29] ? 1'b0 : dataJoinStream_payload_1_keep[29 : 29])},(_zz_maskStage_payload_keep[28] ? 1'b0 : dataJoinStream_payload_1_keep[28 : 28])};
  assign _zz_maskStage_payload_keep_14 = (_zz_maskStage_payload_keep[27] ? 1'b0 : dataJoinStream_payload_1_keep[27 : 27]);
  assign _zz_maskStage_payload_keep_15 = _zz_maskStage_payload_keep[26];
  assign _zz_maskStage_payload_keep_16 = 1'b0;
  assign _zz_maskStage_payload_keep_17 = dataJoinStream_payload_1_keep[26 : 26];
  assign _zz_maskStage_payload_keep_48 = {{{(_zz_maskStage_payload_keep_49 ? _zz_maskStage_payload_keep_50 : _zz_maskStage_payload_keep_51),(_zz_maskStage_payload_keep_52 ? _zz_maskStage_payload_keep_53 : _zz_maskStage_payload_keep_54)},(mask[29] ? 1'b0 : dataJoinStream_payload_2_keep[29 : 29])},(mask[28] ? 1'b0 : dataJoinStream_payload_2_keep[28 : 28])};
  assign _zz_maskStage_payload_keep_55 = (mask[27] ? 1'b0 : dataJoinStream_payload_2_keep[27 : 27]);
  assign _zz_maskStage_payload_keep_56 = mask[26];
  assign _zz_maskStage_payload_keep_57 = 1'b0;
  assign _zz_maskStage_payload_keep_58 = dataJoinStream_payload_2_keep[26 : 26];
  assign _zz_maskStage_payload_keep_8 = _zz_maskStage_payload_keep[31];
  assign _zz_maskStage_payload_keep_9 = 1'b0;
  assign _zz_maskStage_payload_keep_10 = dataJoinStream_payload_1_keep[31 : 31];
  assign _zz_maskStage_payload_keep_11 = _zz_maskStage_payload_keep[30];
  assign _zz_maskStage_payload_keep_12 = 1'b0;
  assign _zz_maskStage_payload_keep_13 = dataJoinStream_payload_1_keep[30 : 30];
  assign _zz_maskStage_payload_keep_49 = mask[31];
  assign _zz_maskStage_payload_keep_50 = 1'b0;
  assign _zz_maskStage_payload_keep_51 = dataJoinStream_payload_2_keep[31 : 31];
  assign _zz_maskStage_payload_keep_52 = mask[30];
  assign _zz_maskStage_payload_keep_53 = 1'b0;
  assign _zz_maskStage_payload_keep_54 = dataJoinStream_payload_2_keep[30 : 30];
  StreamTransactionCounter transactionCounter (
    .io_ctrlFire   (_zz_io_ctrlFire                 ), //i
    .io_targetFire (dataJoinStream_fire             ), //i
    .io_count      (packetLenReg[5:0]               ), //i
    .io_working    (transactionCounter_io_working   ), //o
    .io_last       (transactionCounter_io_last      ), //o
    .io_done       (transactionCounter_io_done      ), //o
    .io_value      (transactionCounter_io_value[5:0]), //o
    .clk           (clk                             ), //i
    .reset         (reset                           )  //i
  );
  assign recognizerStart = (recognizerRunning && (! recognizerRunning_regNext));
  always @(*) begin
    io_dataAxisIn_ready = 1'b1;
    if(when_Stream_l948) begin
      io_dataAxisIn_ready = 1'b0;
    end
    if(when_Stream_l948_1) begin
      io_dataAxisIn_ready = 1'b0;
    end
  end

  assign when_Stream_l948 = ((! packetStream_ready) && _zz_packetStream_valid);
  assign when_Stream_l948_1 = ((! packetReg_ready) && _zz_packetReg_valid);
  assign packetStream_valid = (io_dataAxisIn_valid && _zz_packetStream_valid);
  assign packetStream_payload_data = io_dataAxisIn_payload_data;
  assign packetStream_payload_keep = io_dataAxisIn_payload_keep;
  assign packetStream_payload_last = io_dataAxisIn_payload_last;
  always @(*) begin
    packetStream_payload_user[0 : 0] = io_dataAxisIn_payload_user[0 : 0];
    packetStream_payload_user[1 : 1] = io_dataAxisIn_payload_user[1 : 1];
    packetStream_payload_user[2 : 2] = io_dataAxisIn_payload_user[2 : 2];
    packetStream_payload_user[3 : 3] = io_dataAxisIn_payload_user[3 : 3];
    packetStream_payload_user[4 : 4] = io_dataAxisIn_payload_user[4 : 4];
    packetStream_payload_user[5 : 5] = io_dataAxisIn_payload_user[5 : 5];
    packetStream_payload_user[6 : 6] = io_dataAxisIn_payload_user[6 : 6];
    packetStream_payload_user[7 : 7] = io_dataAxisIn_payload_user[7 : 7];
    packetStream_payload_user[8 : 8] = io_dataAxisIn_payload_user[8 : 8];
    packetStream_payload_user[9 : 9] = io_dataAxisIn_payload_user[9 : 9];
    packetStream_payload_user[10 : 10] = io_dataAxisIn_payload_user[10 : 10];
    packetStream_payload_user[11 : 11] = io_dataAxisIn_payload_user[11 : 11];
    packetStream_payload_user[12 : 12] = io_dataAxisIn_payload_user[12 : 12];
    packetStream_payload_user[13 : 13] = io_dataAxisIn_payload_user[13 : 13];
    packetStream_payload_user[14 : 14] = io_dataAxisIn_payload_user[14 : 14];
    packetStream_payload_user[15 : 15] = io_dataAxisIn_payload_user[15 : 15];
    packetStream_payload_user[16 : 16] = io_dataAxisIn_payload_user[16 : 16];
    packetStream_payload_user[17 : 17] = io_dataAxisIn_payload_user[17 : 17];
    packetStream_payload_user[18 : 18] = io_dataAxisIn_payload_user[18 : 18];
    packetStream_payload_user[19 : 19] = io_dataAxisIn_payload_user[19 : 19];
    packetStream_payload_user[20 : 20] = io_dataAxisIn_payload_user[20 : 20];
    packetStream_payload_user[21 : 21] = io_dataAxisIn_payload_user[21 : 21];
    packetStream_payload_user[22 : 22] = io_dataAxisIn_payload_user[22 : 22];
    packetStream_payload_user[23 : 23] = io_dataAxisIn_payload_user[23 : 23];
    packetStream_payload_user[24 : 24] = io_dataAxisIn_payload_user[24 : 24];
    packetStream_payload_user[25 : 25] = io_dataAxisIn_payload_user[25 : 25];
    packetStream_payload_user[26 : 26] = io_dataAxisIn_payload_user[26 : 26];
    packetStream_payload_user[27 : 27] = io_dataAxisIn_payload_user[27 : 27];
    packetStream_payload_user[28 : 28] = io_dataAxisIn_payload_user[28 : 28];
    packetStream_payload_user[29 : 29] = io_dataAxisIn_payload_user[29 : 29];
    packetStream_payload_user[30 : 30] = io_dataAxisIn_payload_user[30 : 30];
    packetStream_payload_user[31 : 31] = io_dataAxisIn_payload_user[31 : 31];
  end

  assign packetStream_fire = (packetStream_valid && packetStream_ready);
  assign packetReg_valid = (io_dataAxisIn_valid && _zz_packetReg_valid);
  assign packetReg_payload_data = io_dataAxisIn_payload_data;
  assign packetReg_payload_keep = io_dataAxisIn_payload_keep;
  assign packetReg_payload_last = io_dataAxisIn_payload_last;
  always @(*) begin
    packetReg_payload_user[0 : 0] = io_dataAxisIn_payload_user[0 : 0];
    packetReg_payload_user[1 : 1] = io_dataAxisIn_payload_user[1 : 1];
    packetReg_payload_user[2 : 2] = io_dataAxisIn_payload_user[2 : 2];
    packetReg_payload_user[3 : 3] = io_dataAxisIn_payload_user[3 : 3];
    packetReg_payload_user[4 : 4] = io_dataAxisIn_payload_user[4 : 4];
    packetReg_payload_user[5 : 5] = io_dataAxisIn_payload_user[5 : 5];
    packetReg_payload_user[6 : 6] = io_dataAxisIn_payload_user[6 : 6];
    packetReg_payload_user[7 : 7] = io_dataAxisIn_payload_user[7 : 7];
    packetReg_payload_user[8 : 8] = io_dataAxisIn_payload_user[8 : 8];
    packetReg_payload_user[9 : 9] = io_dataAxisIn_payload_user[9 : 9];
    packetReg_payload_user[10 : 10] = io_dataAxisIn_payload_user[10 : 10];
    packetReg_payload_user[11 : 11] = io_dataAxisIn_payload_user[11 : 11];
    packetReg_payload_user[12 : 12] = io_dataAxisIn_payload_user[12 : 12];
    packetReg_payload_user[13 : 13] = io_dataAxisIn_payload_user[13 : 13];
    packetReg_payload_user[14 : 14] = io_dataAxisIn_payload_user[14 : 14];
    packetReg_payload_user[15 : 15] = io_dataAxisIn_payload_user[15 : 15];
    packetReg_payload_user[16 : 16] = io_dataAxisIn_payload_user[16 : 16];
    packetReg_payload_user[17 : 17] = io_dataAxisIn_payload_user[17 : 17];
    packetReg_payload_user[18 : 18] = io_dataAxisIn_payload_user[18 : 18];
    packetReg_payload_user[19 : 19] = io_dataAxisIn_payload_user[19 : 19];
    packetReg_payload_user[20 : 20] = io_dataAxisIn_payload_user[20 : 20];
    packetReg_payload_user[21 : 21] = io_dataAxisIn_payload_user[21 : 21];
    packetReg_payload_user[22 : 22] = io_dataAxisIn_payload_user[22 : 22];
    packetReg_payload_user[23 : 23] = io_dataAxisIn_payload_user[23 : 23];
    packetReg_payload_user[24 : 24] = io_dataAxisIn_payload_user[24 : 24];
    packetReg_payload_user[25 : 25] = io_dataAxisIn_payload_user[25 : 25];
    packetReg_payload_user[26 : 26] = io_dataAxisIn_payload_user[26 : 26];
    packetReg_payload_user[27 : 27] = io_dataAxisIn_payload_user[27 : 27];
    packetReg_payload_user[28 : 28] = io_dataAxisIn_payload_user[28 : 28];
    packetReg_payload_user[29 : 29] = io_dataAxisIn_payload_user[29 : 29];
    packetReg_payload_user[30 : 30] = io_dataAxisIn_payload_user[30 : 30];
    packetReg_payload_user[31 : 31] = io_dataAxisIn_payload_user[31 : 31];
  end

  assign packetReg_fire = (packetReg_valid && packetReg_ready);
  always @(*) begin
    packetReg_ready = packetReg_m2sPipe_ready;
    if(when_Stream_l368) begin
      packetReg_ready = 1'b1;
    end
  end

  assign when_Stream_l368 = (! packetReg_m2sPipe_valid);
  assign packetReg_m2sPipe_valid = packetReg_rValid;
  assign packetReg_m2sPipe_payload_data = packetReg_rData_data;
  assign packetReg_m2sPipe_payload_keep = packetReg_rData_keep;
  assign packetReg_m2sPipe_payload_last = packetReg_rData_last;
  always @(*) begin
    packetReg_m2sPipe_payload_user[0 : 0] = packetReg_rData_user[0 : 0];
    packetReg_m2sPipe_payload_user[1 : 1] = packetReg_rData_user[1 : 1];
    packetReg_m2sPipe_payload_user[2 : 2] = packetReg_rData_user[2 : 2];
    packetReg_m2sPipe_payload_user[3 : 3] = packetReg_rData_user[3 : 3];
    packetReg_m2sPipe_payload_user[4 : 4] = packetReg_rData_user[4 : 4];
    packetReg_m2sPipe_payload_user[5 : 5] = packetReg_rData_user[5 : 5];
    packetReg_m2sPipe_payload_user[6 : 6] = packetReg_rData_user[6 : 6];
    packetReg_m2sPipe_payload_user[7 : 7] = packetReg_rData_user[7 : 7];
    packetReg_m2sPipe_payload_user[8 : 8] = packetReg_rData_user[8 : 8];
    packetReg_m2sPipe_payload_user[9 : 9] = packetReg_rData_user[9 : 9];
    packetReg_m2sPipe_payload_user[10 : 10] = packetReg_rData_user[10 : 10];
    packetReg_m2sPipe_payload_user[11 : 11] = packetReg_rData_user[11 : 11];
    packetReg_m2sPipe_payload_user[12 : 12] = packetReg_rData_user[12 : 12];
    packetReg_m2sPipe_payload_user[13 : 13] = packetReg_rData_user[13 : 13];
    packetReg_m2sPipe_payload_user[14 : 14] = packetReg_rData_user[14 : 14];
    packetReg_m2sPipe_payload_user[15 : 15] = packetReg_rData_user[15 : 15];
    packetReg_m2sPipe_payload_user[16 : 16] = packetReg_rData_user[16 : 16];
    packetReg_m2sPipe_payload_user[17 : 17] = packetReg_rData_user[17 : 17];
    packetReg_m2sPipe_payload_user[18 : 18] = packetReg_rData_user[18 : 18];
    packetReg_m2sPipe_payload_user[19 : 19] = packetReg_rData_user[19 : 19];
    packetReg_m2sPipe_payload_user[20 : 20] = packetReg_rData_user[20 : 20];
    packetReg_m2sPipe_payload_user[21 : 21] = packetReg_rData_user[21 : 21];
    packetReg_m2sPipe_payload_user[22 : 22] = packetReg_rData_user[22 : 22];
    packetReg_m2sPipe_payload_user[23 : 23] = packetReg_rData_user[23 : 23];
    packetReg_m2sPipe_payload_user[24 : 24] = packetReg_rData_user[24 : 24];
    packetReg_m2sPipe_payload_user[25 : 25] = packetReg_rData_user[25 : 25];
    packetReg_m2sPipe_payload_user[26 : 26] = packetReg_rData_user[26 : 26];
    packetReg_m2sPipe_payload_user[27 : 27] = packetReg_rData_user[27 : 27];
    packetReg_m2sPipe_payload_user[28 : 28] = packetReg_rData_user[28 : 28];
    packetReg_m2sPipe_payload_user[29 : 29] = packetReg_rData_user[29 : 29];
    packetReg_m2sPipe_payload_user[30 : 30] = packetReg_rData_user[30 : 30];
    packetReg_m2sPipe_payload_user[31 : 31] = packetReg_rData_user[31 : 31];
  end

  assign packetReg_m2sPipe_ready = (! packetReg_m2sPipe_rValid);
  assign packetStreamReg_valid = (packetReg_m2sPipe_valid || packetReg_m2sPipe_rValid);
  assign _zz_packetStreamReg_payload_user = (packetReg_m2sPipe_rValid ? packetReg_m2sPipe_rData_user : packetReg_m2sPipe_payload_user);
  assign packetStreamReg_payload_data = (packetReg_m2sPipe_rValid ? packetReg_m2sPipe_rData_data : packetReg_m2sPipe_payload_data);
  assign packetStreamReg_payload_keep = (packetReg_m2sPipe_rValid ? packetReg_m2sPipe_rData_keep : packetReg_m2sPipe_payload_keep);
  assign packetStreamReg_payload_last = (packetReg_m2sPipe_rValid ? packetReg_m2sPipe_rData_last : packetReg_m2sPipe_payload_last);
  always @(*) begin
    packetStreamReg_payload_user[0 : 0] = _zz_packetStreamReg_payload_user[0 : 0];
    packetStreamReg_payload_user[1 : 1] = _zz_packetStreamReg_payload_user[1 : 1];
    packetStreamReg_payload_user[2 : 2] = _zz_packetStreamReg_payload_user[2 : 2];
    packetStreamReg_payload_user[3 : 3] = _zz_packetStreamReg_payload_user[3 : 3];
    packetStreamReg_payload_user[4 : 4] = _zz_packetStreamReg_payload_user[4 : 4];
    packetStreamReg_payload_user[5 : 5] = _zz_packetStreamReg_payload_user[5 : 5];
    packetStreamReg_payload_user[6 : 6] = _zz_packetStreamReg_payload_user[6 : 6];
    packetStreamReg_payload_user[7 : 7] = _zz_packetStreamReg_payload_user[7 : 7];
    packetStreamReg_payload_user[8 : 8] = _zz_packetStreamReg_payload_user[8 : 8];
    packetStreamReg_payload_user[9 : 9] = _zz_packetStreamReg_payload_user[9 : 9];
    packetStreamReg_payload_user[10 : 10] = _zz_packetStreamReg_payload_user[10 : 10];
    packetStreamReg_payload_user[11 : 11] = _zz_packetStreamReg_payload_user[11 : 11];
    packetStreamReg_payload_user[12 : 12] = _zz_packetStreamReg_payload_user[12 : 12];
    packetStreamReg_payload_user[13 : 13] = _zz_packetStreamReg_payload_user[13 : 13];
    packetStreamReg_payload_user[14 : 14] = _zz_packetStreamReg_payload_user[14 : 14];
    packetStreamReg_payload_user[15 : 15] = _zz_packetStreamReg_payload_user[15 : 15];
    packetStreamReg_payload_user[16 : 16] = _zz_packetStreamReg_payload_user[16 : 16];
    packetStreamReg_payload_user[17 : 17] = _zz_packetStreamReg_payload_user[17 : 17];
    packetStreamReg_payload_user[18 : 18] = _zz_packetStreamReg_payload_user[18 : 18];
    packetStreamReg_payload_user[19 : 19] = _zz_packetStreamReg_payload_user[19 : 19];
    packetStreamReg_payload_user[20 : 20] = _zz_packetStreamReg_payload_user[20 : 20];
    packetStreamReg_payload_user[21 : 21] = _zz_packetStreamReg_payload_user[21 : 21];
    packetStreamReg_payload_user[22 : 22] = _zz_packetStreamReg_payload_user[22 : 22];
    packetStreamReg_payload_user[23 : 23] = _zz_packetStreamReg_payload_user[23 : 23];
    packetStreamReg_payload_user[24 : 24] = _zz_packetStreamReg_payload_user[24 : 24];
    packetStreamReg_payload_user[25 : 25] = _zz_packetStreamReg_payload_user[25 : 25];
    packetStreamReg_payload_user[26 : 26] = _zz_packetStreamReg_payload_user[26 : 26];
    packetStreamReg_payload_user[27 : 27] = _zz_packetStreamReg_payload_user[27 : 27];
    packetStreamReg_payload_user[28 : 28] = _zz_packetStreamReg_payload_user[28 : 28];
    packetStreamReg_payload_user[29 : 29] = _zz_packetStreamReg_payload_user[29 : 29];
    packetStreamReg_payload_user[30 : 30] = _zz_packetStreamReg_payload_user[30 : 30];
    packetStreamReg_payload_user[31 : 31] = _zz_packetStreamReg_payload_user[31 : 31];
  end

  assign combineData = {packetStream_payload_data,packetStreamReg_payload_data};
  assign packetStream_fire_1 = (packetStream_valid && packetStream_ready);
  assign setMeta = (recognizerStart && packetStream_fire_1);
  assign splitHeader_0 = combineData[111 : 0];
  assign splitHeader_1 = combineData[271 : 112];
  assign splitHeader_2 = combineData[335 : 272];
  assign splitHeader_3 = combineData[511 : 336];
  assign _zz_ethHeaderExtract_0 = {{{{{{{{{{{{{splitHeader_0[7 : 0],splitHeader_0[15 : 8]},splitHeader_0[23 : 16]},splitHeader_0[31 : 24]},splitHeader_0[39 : 32]},splitHeader_0[47 : 40]},splitHeader_0[55 : 48]},splitHeader_0[63 : 56]},splitHeader_0[71 : 64]},splitHeader_0[79 : 72]},splitHeader_0[87 : 80]},splitHeader_0[95 : 88]},splitHeader_0[103 : 96]},splitHeader_0[111 : 104]};
  assign ethHeaderExtract_0 = _zz_ethHeaderExtract_0[111 : 64];
  assign ethHeaderExtract_1 = _zz_ethHeaderExtract_0[63 : 16];
  assign ethHeaderExtract_2 = _zz_ethHeaderExtract_0[15 : 0];
  assign _zz_ipv4HeaderExtract_0 = {{{{{{{{{{{{{{{{_zz__zz_ipv4HeaderExtract_0,_zz__zz_ipv4HeaderExtract_0_1},splitHeader_1[47 : 40]},splitHeader_1[55 : 48]},splitHeader_1[63 : 56]},splitHeader_1[71 : 64]},splitHeader_1[79 : 72]},splitHeader_1[87 : 80]},splitHeader_1[95 : 88]},splitHeader_1[103 : 96]},splitHeader_1[111 : 104]},splitHeader_1[119 : 112]},splitHeader_1[127 : 120]},splitHeader_1[135 : 128]},splitHeader_1[143 : 136]},splitHeader_1[151 : 144]},splitHeader_1[159 : 152]};
  assign ipv4HeaderExtract_0 = _zz_ipv4HeaderExtract_0[159 : 156];
  assign ipv4HeaderExtract_1 = _zz_ipv4HeaderExtract_0[155 : 152];
  assign ipv4HeaderExtract_2 = _zz_ipv4HeaderExtract_0[151 : 146];
  assign ipv4HeaderExtract_3 = _zz_ipv4HeaderExtract_0[145 : 144];
  assign ipv4HeaderExtract_4 = _zz_ipv4HeaderExtract_0[143 : 128];
  assign ipv4HeaderExtract_5 = _zz_ipv4HeaderExtract_0[127 : 112];
  assign ipv4HeaderExtract_6 = _zz_ipv4HeaderExtract_0[111 : 109];
  assign ipv4HeaderExtract_7 = _zz_ipv4HeaderExtract_0[108 : 96];
  assign ipv4HeaderExtract_8 = _zz_ipv4HeaderExtract_0[95 : 88];
  assign ipv4HeaderExtract_9 = _zz_ipv4HeaderExtract_0[87 : 80];
  assign ipv4HeaderExtract_10 = _zz_ipv4HeaderExtract_0[79 : 64];
  assign ipv4HeaderExtract_11 = _zz_ipv4HeaderExtract_0[63 : 32];
  assign ipv4HeaderExtract_12 = _zz_ipv4HeaderExtract_0[31 : 0];
  assign _zz_udpHeaderExtract_0 = {{{{{{{splitHeader_2[7 : 0],splitHeader_2[15 : 8]},splitHeader_2[23 : 16]},splitHeader_2[31 : 24]},splitHeader_2[39 : 32]},splitHeader_2[47 : 40]},splitHeader_2[55 : 48]},splitHeader_2[63 : 56]};
  assign udpHeaderExtract_0 = _zz_udpHeaderExtract_0[63 : 48];
  assign udpHeaderExtract_1 = _zz_udpHeaderExtract_0[47 : 32];
  assign udpHeaderExtract_2 = _zz_udpHeaderExtract_0[31 : 16];
  assign udpHeaderExtract_3 = _zz_udpHeaderExtract_0[15 : 0];
  assign headerMatch = (((macAddrCorrectReg && ipAddrCorrectReg) && isIpReg) && isUdpReg);
  assign needOneMoreCycle = ((_zz_needOneMoreCycle & 16'h001f) != 16'h0);
  assign when_HeaderRecognizer_l91 = (ethHeaderExtract_0 == 48'hfccffccffccf);
  assign when_HeaderRecognizer_l92 = (ipv4HeaderExtract_12 == 32'hc0a80103);
  assign when_HeaderRecognizer_l93 = (ethHeaderExtract_2 == 16'h0800);
  assign when_HeaderRecognizer_l94 = (ipv4HeaderExtract_9 == 8'h11);
  assign packetStreamReg_fire = (packetStreamReg_valid && packetStreamReg_ready);
  assign when_HeaderRecognizer_l97 = (packetStreamReg_payload_last && packetStreamReg_fire);
  assign packetStreamReg_fire_1 = (packetStreamReg_valid && packetStreamReg_ready);
  assign when_HeaderRecognizer_l98 = (packetStreamReg_payload_last && packetStreamReg_fire_1);
  assign packetStreamReg_fire_2 = (packetStreamReg_valid && packetStreamReg_ready);
  assign when_HeaderRecognizer_l99 = (packetStreamReg_payload_last && packetStreamReg_fire_2);
  assign packetStreamReg_fire_3 = (packetStreamReg_valid && packetStreamReg_ready);
  assign when_HeaderRecognizer_l100 = (packetStreamReg_payload_last && packetStreamReg_fire_3);
  assign metaCfg_valid = _zz_metaCfg_valid;
  assign metaCfg_payload_dataLen = dataLen[11:0];
  assign metaCfg_payload_srcMacAddr = ethHeaderExtractReg_1;
  assign metaCfg_payload_srcIpAddr = ipv4HeaderExtractReg_11;
  assign metaCfg_payload_srcPort = udpHeaderExtractReg_0;
  assign metaCfg_payload_dstPort = udpHeaderExtractReg_1;
  assign metaCfg_payload_dstMacAddr = ethHeaderExtractReg_0;
  assign metaCfg_payload_dstIpAddr = ipv4HeaderExtractReg_12;
  assign io_metaOut_valid = metaCfg_valid;
  assign metaCfg_ready = io_metaOut_ready;
  assign io_metaOut_payload_dataLen = metaCfg_payload_dataLen;
  assign io_metaOut_payload_dstMacAddr = metaCfg_payload_dstMacAddr;
  assign io_metaOut_payload_dstIpAddr = metaCfg_payload_dstIpAddr;
  assign io_metaOut_payload_srcMacAddr = metaCfg_payload_srcMacAddr;
  assign io_metaOut_payload_srcIpAddr = metaCfg_payload_srcIpAddr;
  assign io_metaOut_payload_dstPort = metaCfg_payload_dstPort;
  assign io_metaOut_payload_srcPort = metaCfg_payload_srcPort;
  assign packetStream_fire_2 = (packetStream_valid && packetStream_ready);
  assign when_HeaderRecognizer_l122 = (packetStream_payload_last && packetStream_fire_2);
  assign packetStream_fire_3 = (packetStream_valid && packetStream_ready);
  assign dataStreamRegValid = ((headerMatch && recognizerRunning) || headerMatch);
  assign dataStreamValid = (headerMatch && recognizerRunning);
  assign when_Stream_l438 = (! dataStreamRegValid);
  always @(*) begin
    packetStreamReg_thrown_valid = packetStreamReg_valid;
    if(when_Stream_l438) begin
      packetStreamReg_thrown_valid = 1'b0;
    end
  end

  always @(*) begin
    packetStreamReg_ready = packetStreamReg_thrown_ready;
    if(when_Stream_l438) begin
      packetStreamReg_ready = 1'b1;
    end
  end

  assign packetStreamReg_thrown_payload_data = packetStreamReg_payload_data;
  assign packetStreamReg_thrown_payload_keep = packetStreamReg_payload_keep;
  assign packetStreamReg_thrown_payload_last = packetStreamReg_payload_last;
  always @(*) begin
    packetStreamReg_thrown_payload_user[0 : 0] = packetStreamReg_payload_user[0 : 0];
    packetStreamReg_thrown_payload_user[1 : 1] = packetStreamReg_payload_user[1 : 1];
    packetStreamReg_thrown_payload_user[2 : 2] = packetStreamReg_payload_user[2 : 2];
    packetStreamReg_thrown_payload_user[3 : 3] = packetStreamReg_payload_user[3 : 3];
    packetStreamReg_thrown_payload_user[4 : 4] = packetStreamReg_payload_user[4 : 4];
    packetStreamReg_thrown_payload_user[5 : 5] = packetStreamReg_payload_user[5 : 5];
    packetStreamReg_thrown_payload_user[6 : 6] = packetStreamReg_payload_user[6 : 6];
    packetStreamReg_thrown_payload_user[7 : 7] = packetStreamReg_payload_user[7 : 7];
    packetStreamReg_thrown_payload_user[8 : 8] = packetStreamReg_payload_user[8 : 8];
    packetStreamReg_thrown_payload_user[9 : 9] = packetStreamReg_payload_user[9 : 9];
    packetStreamReg_thrown_payload_user[10 : 10] = packetStreamReg_payload_user[10 : 10];
    packetStreamReg_thrown_payload_user[11 : 11] = packetStreamReg_payload_user[11 : 11];
    packetStreamReg_thrown_payload_user[12 : 12] = packetStreamReg_payload_user[12 : 12];
    packetStreamReg_thrown_payload_user[13 : 13] = packetStreamReg_payload_user[13 : 13];
    packetStreamReg_thrown_payload_user[14 : 14] = packetStreamReg_payload_user[14 : 14];
    packetStreamReg_thrown_payload_user[15 : 15] = packetStreamReg_payload_user[15 : 15];
    packetStreamReg_thrown_payload_user[16 : 16] = packetStreamReg_payload_user[16 : 16];
    packetStreamReg_thrown_payload_user[17 : 17] = packetStreamReg_payload_user[17 : 17];
    packetStreamReg_thrown_payload_user[18 : 18] = packetStreamReg_payload_user[18 : 18];
    packetStreamReg_thrown_payload_user[19 : 19] = packetStreamReg_payload_user[19 : 19];
    packetStreamReg_thrown_payload_user[20 : 20] = packetStreamReg_payload_user[20 : 20];
    packetStreamReg_thrown_payload_user[21 : 21] = packetStreamReg_payload_user[21 : 21];
    packetStreamReg_thrown_payload_user[22 : 22] = packetStreamReg_payload_user[22 : 22];
    packetStreamReg_thrown_payload_user[23 : 23] = packetStreamReg_payload_user[23 : 23];
    packetStreamReg_thrown_payload_user[24 : 24] = packetStreamReg_payload_user[24 : 24];
    packetStreamReg_thrown_payload_user[25 : 25] = packetStreamReg_payload_user[25 : 25];
    packetStreamReg_thrown_payload_user[26 : 26] = packetStreamReg_payload_user[26 : 26];
    packetStreamReg_thrown_payload_user[27 : 27] = packetStreamReg_payload_user[27 : 27];
    packetStreamReg_thrown_payload_user[28 : 28] = packetStreamReg_payload_user[28 : 28];
    packetStreamReg_thrown_payload_user[29 : 29] = packetStreamReg_payload_user[29 : 29];
    packetStreamReg_thrown_payload_user[30 : 30] = packetStreamReg_payload_user[30 : 30];
    packetStreamReg_thrown_payload_user[31 : 31] = packetStreamReg_payload_user[31 : 31];
  end

  always @(*) begin
    packetStreamReg_thrown_ready = packetStreamReg_thrown_m2sPipe_ready;
    if(when_Stream_l368_1) begin
      packetStreamReg_thrown_ready = 1'b1;
    end
  end

  assign when_Stream_l368_1 = (! packetStreamReg_thrown_m2sPipe_valid);
  assign packetStreamReg_thrown_m2sPipe_valid = packetStreamReg_thrown_rValid;
  assign packetStreamReg_thrown_m2sPipe_payload_data = packetStreamReg_thrown_rData_data;
  assign packetStreamReg_thrown_m2sPipe_payload_keep = packetStreamReg_thrown_rData_keep;
  assign packetStreamReg_thrown_m2sPipe_payload_last = packetStreamReg_thrown_rData_last;
  always @(*) begin
    packetStreamReg_thrown_m2sPipe_payload_user[0 : 0] = packetStreamReg_thrown_rData_user[0 : 0];
    packetStreamReg_thrown_m2sPipe_payload_user[1 : 1] = packetStreamReg_thrown_rData_user[1 : 1];
    packetStreamReg_thrown_m2sPipe_payload_user[2 : 2] = packetStreamReg_thrown_rData_user[2 : 2];
    packetStreamReg_thrown_m2sPipe_payload_user[3 : 3] = packetStreamReg_thrown_rData_user[3 : 3];
    packetStreamReg_thrown_m2sPipe_payload_user[4 : 4] = packetStreamReg_thrown_rData_user[4 : 4];
    packetStreamReg_thrown_m2sPipe_payload_user[5 : 5] = packetStreamReg_thrown_rData_user[5 : 5];
    packetStreamReg_thrown_m2sPipe_payload_user[6 : 6] = packetStreamReg_thrown_rData_user[6 : 6];
    packetStreamReg_thrown_m2sPipe_payload_user[7 : 7] = packetStreamReg_thrown_rData_user[7 : 7];
    packetStreamReg_thrown_m2sPipe_payload_user[8 : 8] = packetStreamReg_thrown_rData_user[8 : 8];
    packetStreamReg_thrown_m2sPipe_payload_user[9 : 9] = packetStreamReg_thrown_rData_user[9 : 9];
    packetStreamReg_thrown_m2sPipe_payload_user[10 : 10] = packetStreamReg_thrown_rData_user[10 : 10];
    packetStreamReg_thrown_m2sPipe_payload_user[11 : 11] = packetStreamReg_thrown_rData_user[11 : 11];
    packetStreamReg_thrown_m2sPipe_payload_user[12 : 12] = packetStreamReg_thrown_rData_user[12 : 12];
    packetStreamReg_thrown_m2sPipe_payload_user[13 : 13] = packetStreamReg_thrown_rData_user[13 : 13];
    packetStreamReg_thrown_m2sPipe_payload_user[14 : 14] = packetStreamReg_thrown_rData_user[14 : 14];
    packetStreamReg_thrown_m2sPipe_payload_user[15 : 15] = packetStreamReg_thrown_rData_user[15 : 15];
    packetStreamReg_thrown_m2sPipe_payload_user[16 : 16] = packetStreamReg_thrown_rData_user[16 : 16];
    packetStreamReg_thrown_m2sPipe_payload_user[17 : 17] = packetStreamReg_thrown_rData_user[17 : 17];
    packetStreamReg_thrown_m2sPipe_payload_user[18 : 18] = packetStreamReg_thrown_rData_user[18 : 18];
    packetStreamReg_thrown_m2sPipe_payload_user[19 : 19] = packetStreamReg_thrown_rData_user[19 : 19];
    packetStreamReg_thrown_m2sPipe_payload_user[20 : 20] = packetStreamReg_thrown_rData_user[20 : 20];
    packetStreamReg_thrown_m2sPipe_payload_user[21 : 21] = packetStreamReg_thrown_rData_user[21 : 21];
    packetStreamReg_thrown_m2sPipe_payload_user[22 : 22] = packetStreamReg_thrown_rData_user[22 : 22];
    packetStreamReg_thrown_m2sPipe_payload_user[23 : 23] = packetStreamReg_thrown_rData_user[23 : 23];
    packetStreamReg_thrown_m2sPipe_payload_user[24 : 24] = packetStreamReg_thrown_rData_user[24 : 24];
    packetStreamReg_thrown_m2sPipe_payload_user[25 : 25] = packetStreamReg_thrown_rData_user[25 : 25];
    packetStreamReg_thrown_m2sPipe_payload_user[26 : 26] = packetStreamReg_thrown_rData_user[26 : 26];
    packetStreamReg_thrown_m2sPipe_payload_user[27 : 27] = packetStreamReg_thrown_rData_user[27 : 27];
    packetStreamReg_thrown_m2sPipe_payload_user[28 : 28] = packetStreamReg_thrown_rData_user[28 : 28];
    packetStreamReg_thrown_m2sPipe_payload_user[29 : 29] = packetStreamReg_thrown_rData_user[29 : 29];
    packetStreamReg_thrown_m2sPipe_payload_user[30 : 30] = packetStreamReg_thrown_rData_user[30 : 30];
    packetStreamReg_thrown_m2sPipe_payload_user[31 : 31] = packetStreamReg_thrown_rData_user[31 : 31];
  end

  assign packetStreamReg_thrown_m2sPipe_ready = (! packetStreamReg_thrown_m2sPipe_rValid);
  assign dataStreamReg_valid = (packetStreamReg_thrown_m2sPipe_valid || packetStreamReg_thrown_m2sPipe_rValid);
  assign _zz_dataStreamReg_payload_user = (packetStreamReg_thrown_m2sPipe_rValid ? packetStreamReg_thrown_m2sPipe_rData_user : packetStreamReg_thrown_m2sPipe_payload_user);
  assign dataStreamReg_payload_data = (packetStreamReg_thrown_m2sPipe_rValid ? packetStreamReg_thrown_m2sPipe_rData_data : packetStreamReg_thrown_m2sPipe_payload_data);
  assign dataStreamReg_payload_keep = (packetStreamReg_thrown_m2sPipe_rValid ? packetStreamReg_thrown_m2sPipe_rData_keep : packetStreamReg_thrown_m2sPipe_payload_keep);
  assign dataStreamReg_payload_last = (packetStreamReg_thrown_m2sPipe_rValid ? packetStreamReg_thrown_m2sPipe_rData_last : packetStreamReg_thrown_m2sPipe_payload_last);
  always @(*) begin
    dataStreamReg_payload_user[0 : 0] = _zz_dataStreamReg_payload_user[0 : 0];
    dataStreamReg_payload_user[1 : 1] = _zz_dataStreamReg_payload_user[1 : 1];
    dataStreamReg_payload_user[2 : 2] = _zz_dataStreamReg_payload_user[2 : 2];
    dataStreamReg_payload_user[3 : 3] = _zz_dataStreamReg_payload_user[3 : 3];
    dataStreamReg_payload_user[4 : 4] = _zz_dataStreamReg_payload_user[4 : 4];
    dataStreamReg_payload_user[5 : 5] = _zz_dataStreamReg_payload_user[5 : 5];
    dataStreamReg_payload_user[6 : 6] = _zz_dataStreamReg_payload_user[6 : 6];
    dataStreamReg_payload_user[7 : 7] = _zz_dataStreamReg_payload_user[7 : 7];
    dataStreamReg_payload_user[8 : 8] = _zz_dataStreamReg_payload_user[8 : 8];
    dataStreamReg_payload_user[9 : 9] = _zz_dataStreamReg_payload_user[9 : 9];
    dataStreamReg_payload_user[10 : 10] = _zz_dataStreamReg_payload_user[10 : 10];
    dataStreamReg_payload_user[11 : 11] = _zz_dataStreamReg_payload_user[11 : 11];
    dataStreamReg_payload_user[12 : 12] = _zz_dataStreamReg_payload_user[12 : 12];
    dataStreamReg_payload_user[13 : 13] = _zz_dataStreamReg_payload_user[13 : 13];
    dataStreamReg_payload_user[14 : 14] = _zz_dataStreamReg_payload_user[14 : 14];
    dataStreamReg_payload_user[15 : 15] = _zz_dataStreamReg_payload_user[15 : 15];
    dataStreamReg_payload_user[16 : 16] = _zz_dataStreamReg_payload_user[16 : 16];
    dataStreamReg_payload_user[17 : 17] = _zz_dataStreamReg_payload_user[17 : 17];
    dataStreamReg_payload_user[18 : 18] = _zz_dataStreamReg_payload_user[18 : 18];
    dataStreamReg_payload_user[19 : 19] = _zz_dataStreamReg_payload_user[19 : 19];
    dataStreamReg_payload_user[20 : 20] = _zz_dataStreamReg_payload_user[20 : 20];
    dataStreamReg_payload_user[21 : 21] = _zz_dataStreamReg_payload_user[21 : 21];
    dataStreamReg_payload_user[22 : 22] = _zz_dataStreamReg_payload_user[22 : 22];
    dataStreamReg_payload_user[23 : 23] = _zz_dataStreamReg_payload_user[23 : 23];
    dataStreamReg_payload_user[24 : 24] = _zz_dataStreamReg_payload_user[24 : 24];
    dataStreamReg_payload_user[25 : 25] = _zz_dataStreamReg_payload_user[25 : 25];
    dataStreamReg_payload_user[26 : 26] = _zz_dataStreamReg_payload_user[26 : 26];
    dataStreamReg_payload_user[27 : 27] = _zz_dataStreamReg_payload_user[27 : 27];
    dataStreamReg_payload_user[28 : 28] = _zz_dataStreamReg_payload_user[28 : 28];
    dataStreamReg_payload_user[29 : 29] = _zz_dataStreamReg_payload_user[29 : 29];
    dataStreamReg_payload_user[30 : 30] = _zz_dataStreamReg_payload_user[30 : 30];
    dataStreamReg_payload_user[31 : 31] = _zz_dataStreamReg_payload_user[31 : 31];
  end

  assign when_Stream_l438_1 = (! dataStreamValid);
  always @(*) begin
    packetStream_thrown_valid = packetStream_valid;
    if(when_Stream_l438_1) begin
      packetStream_thrown_valid = 1'b0;
    end
  end

  always @(*) begin
    packetStream_ready = packetStream_thrown_ready;
    if(when_Stream_l438_1) begin
      packetStream_ready = 1'b1;
    end
  end

  assign packetStream_thrown_payload_data = packetStream_payload_data;
  assign packetStream_thrown_payload_keep = packetStream_payload_keep;
  assign packetStream_thrown_payload_last = packetStream_payload_last;
  always @(*) begin
    packetStream_thrown_payload_user[0 : 0] = packetStream_payload_user[0 : 0];
    packetStream_thrown_payload_user[1 : 1] = packetStream_payload_user[1 : 1];
    packetStream_thrown_payload_user[2 : 2] = packetStream_payload_user[2 : 2];
    packetStream_thrown_payload_user[3 : 3] = packetStream_payload_user[3 : 3];
    packetStream_thrown_payload_user[4 : 4] = packetStream_payload_user[4 : 4];
    packetStream_thrown_payload_user[5 : 5] = packetStream_payload_user[5 : 5];
    packetStream_thrown_payload_user[6 : 6] = packetStream_payload_user[6 : 6];
    packetStream_thrown_payload_user[7 : 7] = packetStream_payload_user[7 : 7];
    packetStream_thrown_payload_user[8 : 8] = packetStream_payload_user[8 : 8];
    packetStream_thrown_payload_user[9 : 9] = packetStream_payload_user[9 : 9];
    packetStream_thrown_payload_user[10 : 10] = packetStream_payload_user[10 : 10];
    packetStream_thrown_payload_user[11 : 11] = packetStream_payload_user[11 : 11];
    packetStream_thrown_payload_user[12 : 12] = packetStream_payload_user[12 : 12];
    packetStream_thrown_payload_user[13 : 13] = packetStream_payload_user[13 : 13];
    packetStream_thrown_payload_user[14 : 14] = packetStream_payload_user[14 : 14];
    packetStream_thrown_payload_user[15 : 15] = packetStream_payload_user[15 : 15];
    packetStream_thrown_payload_user[16 : 16] = packetStream_payload_user[16 : 16];
    packetStream_thrown_payload_user[17 : 17] = packetStream_payload_user[17 : 17];
    packetStream_thrown_payload_user[18 : 18] = packetStream_payload_user[18 : 18];
    packetStream_thrown_payload_user[19 : 19] = packetStream_payload_user[19 : 19];
    packetStream_thrown_payload_user[20 : 20] = packetStream_payload_user[20 : 20];
    packetStream_thrown_payload_user[21 : 21] = packetStream_payload_user[21 : 21];
    packetStream_thrown_payload_user[22 : 22] = packetStream_payload_user[22 : 22];
    packetStream_thrown_payload_user[23 : 23] = packetStream_payload_user[23 : 23];
    packetStream_thrown_payload_user[24 : 24] = packetStream_payload_user[24 : 24];
    packetStream_thrown_payload_user[25 : 25] = packetStream_payload_user[25 : 25];
    packetStream_thrown_payload_user[26 : 26] = packetStream_payload_user[26 : 26];
    packetStream_thrown_payload_user[27 : 27] = packetStream_payload_user[27 : 27];
    packetStream_thrown_payload_user[28 : 28] = packetStream_payload_user[28 : 28];
    packetStream_thrown_payload_user[29 : 29] = packetStream_payload_user[29 : 29];
    packetStream_thrown_payload_user[30 : 30] = packetStream_payload_user[30 : 30];
    packetStream_thrown_payload_user[31 : 31] = packetStream_payload_user[31 : 31];
  end

  always @(*) begin
    packetStream_thrown_ready = packetStream_thrown_m2sPipe_ready;
    if(when_Stream_l368_2) begin
      packetStream_thrown_ready = 1'b1;
    end
  end

  assign when_Stream_l368_2 = (! packetStream_thrown_m2sPipe_valid);
  assign packetStream_thrown_m2sPipe_valid = packetStream_thrown_rValid;
  assign packetStream_thrown_m2sPipe_payload_data = packetStream_thrown_rData_data;
  assign packetStream_thrown_m2sPipe_payload_keep = packetStream_thrown_rData_keep;
  assign packetStream_thrown_m2sPipe_payload_last = packetStream_thrown_rData_last;
  always @(*) begin
    packetStream_thrown_m2sPipe_payload_user[0 : 0] = packetStream_thrown_rData_user[0 : 0];
    packetStream_thrown_m2sPipe_payload_user[1 : 1] = packetStream_thrown_rData_user[1 : 1];
    packetStream_thrown_m2sPipe_payload_user[2 : 2] = packetStream_thrown_rData_user[2 : 2];
    packetStream_thrown_m2sPipe_payload_user[3 : 3] = packetStream_thrown_rData_user[3 : 3];
    packetStream_thrown_m2sPipe_payload_user[4 : 4] = packetStream_thrown_rData_user[4 : 4];
    packetStream_thrown_m2sPipe_payload_user[5 : 5] = packetStream_thrown_rData_user[5 : 5];
    packetStream_thrown_m2sPipe_payload_user[6 : 6] = packetStream_thrown_rData_user[6 : 6];
    packetStream_thrown_m2sPipe_payload_user[7 : 7] = packetStream_thrown_rData_user[7 : 7];
    packetStream_thrown_m2sPipe_payload_user[8 : 8] = packetStream_thrown_rData_user[8 : 8];
    packetStream_thrown_m2sPipe_payload_user[9 : 9] = packetStream_thrown_rData_user[9 : 9];
    packetStream_thrown_m2sPipe_payload_user[10 : 10] = packetStream_thrown_rData_user[10 : 10];
    packetStream_thrown_m2sPipe_payload_user[11 : 11] = packetStream_thrown_rData_user[11 : 11];
    packetStream_thrown_m2sPipe_payload_user[12 : 12] = packetStream_thrown_rData_user[12 : 12];
    packetStream_thrown_m2sPipe_payload_user[13 : 13] = packetStream_thrown_rData_user[13 : 13];
    packetStream_thrown_m2sPipe_payload_user[14 : 14] = packetStream_thrown_rData_user[14 : 14];
    packetStream_thrown_m2sPipe_payload_user[15 : 15] = packetStream_thrown_rData_user[15 : 15];
    packetStream_thrown_m2sPipe_payload_user[16 : 16] = packetStream_thrown_rData_user[16 : 16];
    packetStream_thrown_m2sPipe_payload_user[17 : 17] = packetStream_thrown_rData_user[17 : 17];
    packetStream_thrown_m2sPipe_payload_user[18 : 18] = packetStream_thrown_rData_user[18 : 18];
    packetStream_thrown_m2sPipe_payload_user[19 : 19] = packetStream_thrown_rData_user[19 : 19];
    packetStream_thrown_m2sPipe_payload_user[20 : 20] = packetStream_thrown_rData_user[20 : 20];
    packetStream_thrown_m2sPipe_payload_user[21 : 21] = packetStream_thrown_rData_user[21 : 21];
    packetStream_thrown_m2sPipe_payload_user[22 : 22] = packetStream_thrown_rData_user[22 : 22];
    packetStream_thrown_m2sPipe_payload_user[23 : 23] = packetStream_thrown_rData_user[23 : 23];
    packetStream_thrown_m2sPipe_payload_user[24 : 24] = packetStream_thrown_rData_user[24 : 24];
    packetStream_thrown_m2sPipe_payload_user[25 : 25] = packetStream_thrown_rData_user[25 : 25];
    packetStream_thrown_m2sPipe_payload_user[26 : 26] = packetStream_thrown_rData_user[26 : 26];
    packetStream_thrown_m2sPipe_payload_user[27 : 27] = packetStream_thrown_rData_user[27 : 27];
    packetStream_thrown_m2sPipe_payload_user[28 : 28] = packetStream_thrown_rData_user[28 : 28];
    packetStream_thrown_m2sPipe_payload_user[29 : 29] = packetStream_thrown_rData_user[29 : 29];
    packetStream_thrown_m2sPipe_payload_user[30 : 30] = packetStream_thrown_rData_user[30 : 30];
    packetStream_thrown_m2sPipe_payload_user[31 : 31] = packetStream_thrown_rData_user[31 : 31];
  end

  assign packetStream_thrown_m2sPipe_ready = (! packetStream_thrown_m2sPipe_rValid);
  assign dataStream_valid = (packetStream_thrown_m2sPipe_valid || packetStream_thrown_m2sPipe_rValid);
  assign _zz_dataStream_payload_user = (packetStream_thrown_m2sPipe_rValid ? packetStream_thrown_m2sPipe_rData_user : packetStream_thrown_m2sPipe_payload_user);
  assign dataStream_payload_data = (packetStream_thrown_m2sPipe_rValid ? packetStream_thrown_m2sPipe_rData_data : packetStream_thrown_m2sPipe_payload_data);
  assign dataStream_payload_keep = (packetStream_thrown_m2sPipe_rValid ? packetStream_thrown_m2sPipe_rData_keep : packetStream_thrown_m2sPipe_payload_keep);
  assign dataStream_payload_last = (packetStream_thrown_m2sPipe_rValid ? packetStream_thrown_m2sPipe_rData_last : packetStream_thrown_m2sPipe_payload_last);
  always @(*) begin
    dataStream_payload_user[0 : 0] = _zz_dataStream_payload_user[0 : 0];
    dataStream_payload_user[1 : 1] = _zz_dataStream_payload_user[1 : 1];
    dataStream_payload_user[2 : 2] = _zz_dataStream_payload_user[2 : 2];
    dataStream_payload_user[3 : 3] = _zz_dataStream_payload_user[3 : 3];
    dataStream_payload_user[4 : 4] = _zz_dataStream_payload_user[4 : 4];
    dataStream_payload_user[5 : 5] = _zz_dataStream_payload_user[5 : 5];
    dataStream_payload_user[6 : 6] = _zz_dataStream_payload_user[6 : 6];
    dataStream_payload_user[7 : 7] = _zz_dataStream_payload_user[7 : 7];
    dataStream_payload_user[8 : 8] = _zz_dataStream_payload_user[8 : 8];
    dataStream_payload_user[9 : 9] = _zz_dataStream_payload_user[9 : 9];
    dataStream_payload_user[10 : 10] = _zz_dataStream_payload_user[10 : 10];
    dataStream_payload_user[11 : 11] = _zz_dataStream_payload_user[11 : 11];
    dataStream_payload_user[12 : 12] = _zz_dataStream_payload_user[12 : 12];
    dataStream_payload_user[13 : 13] = _zz_dataStream_payload_user[13 : 13];
    dataStream_payload_user[14 : 14] = _zz_dataStream_payload_user[14 : 14];
    dataStream_payload_user[15 : 15] = _zz_dataStream_payload_user[15 : 15];
    dataStream_payload_user[16 : 16] = _zz_dataStream_payload_user[16 : 16];
    dataStream_payload_user[17 : 17] = _zz_dataStream_payload_user[17 : 17];
    dataStream_payload_user[18 : 18] = _zz_dataStream_payload_user[18 : 18];
    dataStream_payload_user[19 : 19] = _zz_dataStream_payload_user[19 : 19];
    dataStream_payload_user[20 : 20] = _zz_dataStream_payload_user[20 : 20];
    dataStream_payload_user[21 : 21] = _zz_dataStream_payload_user[21 : 21];
    dataStream_payload_user[22 : 22] = _zz_dataStream_payload_user[22 : 22];
    dataStream_payload_user[23 : 23] = _zz_dataStream_payload_user[23 : 23];
    dataStream_payload_user[24 : 24] = _zz_dataStream_payload_user[24 : 24];
    dataStream_payload_user[25 : 25] = _zz_dataStream_payload_user[25 : 25];
    dataStream_payload_user[26 : 26] = _zz_dataStream_payload_user[26 : 26];
    dataStream_payload_user[27 : 27] = _zz_dataStream_payload_user[27 : 27];
    dataStream_payload_user[28 : 28] = _zz_dataStream_payload_user[28 : 28];
    dataStream_payload_user[29 : 29] = _zz_dataStream_payload_user[29 : 29];
    dataStream_payload_user[30 : 30] = _zz_dataStream_payload_user[30 : 30];
    dataStream_payload_user[31 : 31] = _zz_dataStream_payload_user[31 : 31];
  end

  assign withSub = (dataStream_valid && dataStreamReg_valid);
  assign dataStream_ready = (withSub ? (_zz_dataStreamReg_ready && _zz_dataStreamReg_ready_1) : 1'b0);
  assign when_StreamUtils_l26 = (! dataStream_valid);
  always @(*) begin
    if(when_StreamUtils_l26) begin
      _zz_dataJoinStream_payload_2_data = 256'h0;
    end else begin
      _zz_dataJoinStream_payload_2_data = dataStream_payload_data;
    end
  end

  assign when_StreamUtils_l26_1 = (! dataStream_valid);
  always @(*) begin
    if(when_StreamUtils_l26_1) begin
      _zz_dataJoinStream_payload_2_keep = 32'h0;
    end else begin
      _zz_dataJoinStream_payload_2_keep = dataStream_payload_keep;
    end
  end

  assign when_StreamUtils_l26_2 = (! dataStream_valid);
  always @(*) begin
    if(when_StreamUtils_l26_2) begin
      _zz_dataJoinStream_payload_2_last = 1'b0;
    end else begin
      _zz_dataJoinStream_payload_2_last = dataStream_payload_last;
    end
  end

  assign when_StreamUtils_l26_3 = (! dataStream_valid);
  always @(*) begin
    if(when_StreamUtils_l26_3) begin
      _zz_dataJoinStream_payload_2_user = 32'h0;
    end else begin
      _zz_dataJoinStream_payload_2_user = dataStream_payload_user;
    end
  end

  assign _zz_dataStreamReg_ready = (withSub ? (dataStreamReg_valid && dataStream_valid) : dataStreamReg_valid);
  assign dataStreamReg_ready = (_zz_dataStreamReg_ready && _zz_dataStreamReg_ready_1);
  always @(*) begin
    _zz_dataJoinStream_payload_1_user[0 : 0] = dataStreamReg_payload_user[0 : 0];
    _zz_dataJoinStream_payload_1_user[1 : 1] = dataStreamReg_payload_user[1 : 1];
    _zz_dataJoinStream_payload_1_user[2 : 2] = dataStreamReg_payload_user[2 : 2];
    _zz_dataJoinStream_payload_1_user[3 : 3] = dataStreamReg_payload_user[3 : 3];
    _zz_dataJoinStream_payload_1_user[4 : 4] = dataStreamReg_payload_user[4 : 4];
    _zz_dataJoinStream_payload_1_user[5 : 5] = dataStreamReg_payload_user[5 : 5];
    _zz_dataJoinStream_payload_1_user[6 : 6] = dataStreamReg_payload_user[6 : 6];
    _zz_dataJoinStream_payload_1_user[7 : 7] = dataStreamReg_payload_user[7 : 7];
    _zz_dataJoinStream_payload_1_user[8 : 8] = dataStreamReg_payload_user[8 : 8];
    _zz_dataJoinStream_payload_1_user[9 : 9] = dataStreamReg_payload_user[9 : 9];
    _zz_dataJoinStream_payload_1_user[10 : 10] = dataStreamReg_payload_user[10 : 10];
    _zz_dataJoinStream_payload_1_user[11 : 11] = dataStreamReg_payload_user[11 : 11];
    _zz_dataJoinStream_payload_1_user[12 : 12] = dataStreamReg_payload_user[12 : 12];
    _zz_dataJoinStream_payload_1_user[13 : 13] = dataStreamReg_payload_user[13 : 13];
    _zz_dataJoinStream_payload_1_user[14 : 14] = dataStreamReg_payload_user[14 : 14];
    _zz_dataJoinStream_payload_1_user[15 : 15] = dataStreamReg_payload_user[15 : 15];
    _zz_dataJoinStream_payload_1_user[16 : 16] = dataStreamReg_payload_user[16 : 16];
    _zz_dataJoinStream_payload_1_user[17 : 17] = dataStreamReg_payload_user[17 : 17];
    _zz_dataJoinStream_payload_1_user[18 : 18] = dataStreamReg_payload_user[18 : 18];
    _zz_dataJoinStream_payload_1_user[19 : 19] = dataStreamReg_payload_user[19 : 19];
    _zz_dataJoinStream_payload_1_user[20 : 20] = dataStreamReg_payload_user[20 : 20];
    _zz_dataJoinStream_payload_1_user[21 : 21] = dataStreamReg_payload_user[21 : 21];
    _zz_dataJoinStream_payload_1_user[22 : 22] = dataStreamReg_payload_user[22 : 22];
    _zz_dataJoinStream_payload_1_user[23 : 23] = dataStreamReg_payload_user[23 : 23];
    _zz_dataJoinStream_payload_1_user[24 : 24] = dataStreamReg_payload_user[24 : 24];
    _zz_dataJoinStream_payload_1_user[25 : 25] = dataStreamReg_payload_user[25 : 25];
    _zz_dataJoinStream_payload_1_user[26 : 26] = dataStreamReg_payload_user[26 : 26];
    _zz_dataJoinStream_payload_1_user[27 : 27] = dataStreamReg_payload_user[27 : 27];
    _zz_dataJoinStream_payload_1_user[28 : 28] = dataStreamReg_payload_user[28 : 28];
    _zz_dataJoinStream_payload_1_user[29 : 29] = dataStreamReg_payload_user[29 : 29];
    _zz_dataJoinStream_payload_1_user[30 : 30] = dataStreamReg_payload_user[30 : 30];
    _zz_dataJoinStream_payload_1_user[31 : 31] = dataStreamReg_payload_user[31 : 31];
  end

  always @(*) begin
    _zz_dataJoinStream_payload_2_user_1[0 : 0] = _zz_dataJoinStream_payload_2_user[0 : 0];
    _zz_dataJoinStream_payload_2_user_1[1 : 1] = _zz_dataJoinStream_payload_2_user[1 : 1];
    _zz_dataJoinStream_payload_2_user_1[2 : 2] = _zz_dataJoinStream_payload_2_user[2 : 2];
    _zz_dataJoinStream_payload_2_user_1[3 : 3] = _zz_dataJoinStream_payload_2_user[3 : 3];
    _zz_dataJoinStream_payload_2_user_1[4 : 4] = _zz_dataJoinStream_payload_2_user[4 : 4];
    _zz_dataJoinStream_payload_2_user_1[5 : 5] = _zz_dataJoinStream_payload_2_user[5 : 5];
    _zz_dataJoinStream_payload_2_user_1[6 : 6] = _zz_dataJoinStream_payload_2_user[6 : 6];
    _zz_dataJoinStream_payload_2_user_1[7 : 7] = _zz_dataJoinStream_payload_2_user[7 : 7];
    _zz_dataJoinStream_payload_2_user_1[8 : 8] = _zz_dataJoinStream_payload_2_user[8 : 8];
    _zz_dataJoinStream_payload_2_user_1[9 : 9] = _zz_dataJoinStream_payload_2_user[9 : 9];
    _zz_dataJoinStream_payload_2_user_1[10 : 10] = _zz_dataJoinStream_payload_2_user[10 : 10];
    _zz_dataJoinStream_payload_2_user_1[11 : 11] = _zz_dataJoinStream_payload_2_user[11 : 11];
    _zz_dataJoinStream_payload_2_user_1[12 : 12] = _zz_dataJoinStream_payload_2_user[12 : 12];
    _zz_dataJoinStream_payload_2_user_1[13 : 13] = _zz_dataJoinStream_payload_2_user[13 : 13];
    _zz_dataJoinStream_payload_2_user_1[14 : 14] = _zz_dataJoinStream_payload_2_user[14 : 14];
    _zz_dataJoinStream_payload_2_user_1[15 : 15] = _zz_dataJoinStream_payload_2_user[15 : 15];
    _zz_dataJoinStream_payload_2_user_1[16 : 16] = _zz_dataJoinStream_payload_2_user[16 : 16];
    _zz_dataJoinStream_payload_2_user_1[17 : 17] = _zz_dataJoinStream_payload_2_user[17 : 17];
    _zz_dataJoinStream_payload_2_user_1[18 : 18] = _zz_dataJoinStream_payload_2_user[18 : 18];
    _zz_dataJoinStream_payload_2_user_1[19 : 19] = _zz_dataJoinStream_payload_2_user[19 : 19];
    _zz_dataJoinStream_payload_2_user_1[20 : 20] = _zz_dataJoinStream_payload_2_user[20 : 20];
    _zz_dataJoinStream_payload_2_user_1[21 : 21] = _zz_dataJoinStream_payload_2_user[21 : 21];
    _zz_dataJoinStream_payload_2_user_1[22 : 22] = _zz_dataJoinStream_payload_2_user[22 : 22];
    _zz_dataJoinStream_payload_2_user_1[23 : 23] = _zz_dataJoinStream_payload_2_user[23 : 23];
    _zz_dataJoinStream_payload_2_user_1[24 : 24] = _zz_dataJoinStream_payload_2_user[24 : 24];
    _zz_dataJoinStream_payload_2_user_1[25 : 25] = _zz_dataJoinStream_payload_2_user[25 : 25];
    _zz_dataJoinStream_payload_2_user_1[26 : 26] = _zz_dataJoinStream_payload_2_user[26 : 26];
    _zz_dataJoinStream_payload_2_user_1[27 : 27] = _zz_dataJoinStream_payload_2_user[27 : 27];
    _zz_dataJoinStream_payload_2_user_1[28 : 28] = _zz_dataJoinStream_payload_2_user[28 : 28];
    _zz_dataJoinStream_payload_2_user_1[29 : 29] = _zz_dataJoinStream_payload_2_user[29 : 29];
    _zz_dataJoinStream_payload_2_user_1[30 : 30] = _zz_dataJoinStream_payload_2_user[30 : 30];
    _zz_dataJoinStream_payload_2_user_1[31 : 31] = _zz_dataJoinStream_payload_2_user[31 : 31];
  end

  always @(*) begin
    _zz_dataStreamReg_ready_1 = _zz_dataStreamReg_ready_2;
    if(when_Stream_l368_3) begin
      _zz_dataStreamReg_ready_1 = 1'b1;
    end
  end

  assign when_Stream_l368_3 = (! _zz_when_Stream_l368);
  assign _zz_when_Stream_l368 = _zz_when_Stream_l368_1;
  always @(*) begin
    _zz_dataJoinStream_payload_1_user_1[0 : 0] = _zz_dataJoinStream_payload_1_user_2[0 : 0];
    _zz_dataJoinStream_payload_1_user_1[1 : 1] = _zz_dataJoinStream_payload_1_user_2[1 : 1];
    _zz_dataJoinStream_payload_1_user_1[2 : 2] = _zz_dataJoinStream_payload_1_user_2[2 : 2];
    _zz_dataJoinStream_payload_1_user_1[3 : 3] = _zz_dataJoinStream_payload_1_user_2[3 : 3];
    _zz_dataJoinStream_payload_1_user_1[4 : 4] = _zz_dataJoinStream_payload_1_user_2[4 : 4];
    _zz_dataJoinStream_payload_1_user_1[5 : 5] = _zz_dataJoinStream_payload_1_user_2[5 : 5];
    _zz_dataJoinStream_payload_1_user_1[6 : 6] = _zz_dataJoinStream_payload_1_user_2[6 : 6];
    _zz_dataJoinStream_payload_1_user_1[7 : 7] = _zz_dataJoinStream_payload_1_user_2[7 : 7];
    _zz_dataJoinStream_payload_1_user_1[8 : 8] = _zz_dataJoinStream_payload_1_user_2[8 : 8];
    _zz_dataJoinStream_payload_1_user_1[9 : 9] = _zz_dataJoinStream_payload_1_user_2[9 : 9];
    _zz_dataJoinStream_payload_1_user_1[10 : 10] = _zz_dataJoinStream_payload_1_user_2[10 : 10];
    _zz_dataJoinStream_payload_1_user_1[11 : 11] = _zz_dataJoinStream_payload_1_user_2[11 : 11];
    _zz_dataJoinStream_payload_1_user_1[12 : 12] = _zz_dataJoinStream_payload_1_user_2[12 : 12];
    _zz_dataJoinStream_payload_1_user_1[13 : 13] = _zz_dataJoinStream_payload_1_user_2[13 : 13];
    _zz_dataJoinStream_payload_1_user_1[14 : 14] = _zz_dataJoinStream_payload_1_user_2[14 : 14];
    _zz_dataJoinStream_payload_1_user_1[15 : 15] = _zz_dataJoinStream_payload_1_user_2[15 : 15];
    _zz_dataJoinStream_payload_1_user_1[16 : 16] = _zz_dataJoinStream_payload_1_user_2[16 : 16];
    _zz_dataJoinStream_payload_1_user_1[17 : 17] = _zz_dataJoinStream_payload_1_user_2[17 : 17];
    _zz_dataJoinStream_payload_1_user_1[18 : 18] = _zz_dataJoinStream_payload_1_user_2[18 : 18];
    _zz_dataJoinStream_payload_1_user_1[19 : 19] = _zz_dataJoinStream_payload_1_user_2[19 : 19];
    _zz_dataJoinStream_payload_1_user_1[20 : 20] = _zz_dataJoinStream_payload_1_user_2[20 : 20];
    _zz_dataJoinStream_payload_1_user_1[21 : 21] = _zz_dataJoinStream_payload_1_user_2[21 : 21];
    _zz_dataJoinStream_payload_1_user_1[22 : 22] = _zz_dataJoinStream_payload_1_user_2[22 : 22];
    _zz_dataJoinStream_payload_1_user_1[23 : 23] = _zz_dataJoinStream_payload_1_user_2[23 : 23];
    _zz_dataJoinStream_payload_1_user_1[24 : 24] = _zz_dataJoinStream_payload_1_user_2[24 : 24];
    _zz_dataJoinStream_payload_1_user_1[25 : 25] = _zz_dataJoinStream_payload_1_user_2[25 : 25];
    _zz_dataJoinStream_payload_1_user_1[26 : 26] = _zz_dataJoinStream_payload_1_user_2[26 : 26];
    _zz_dataJoinStream_payload_1_user_1[27 : 27] = _zz_dataJoinStream_payload_1_user_2[27 : 27];
    _zz_dataJoinStream_payload_1_user_1[28 : 28] = _zz_dataJoinStream_payload_1_user_2[28 : 28];
    _zz_dataJoinStream_payload_1_user_1[29 : 29] = _zz_dataJoinStream_payload_1_user_2[29 : 29];
    _zz_dataJoinStream_payload_1_user_1[30 : 30] = _zz_dataJoinStream_payload_1_user_2[30 : 30];
    _zz_dataJoinStream_payload_1_user_1[31 : 31] = _zz_dataJoinStream_payload_1_user_2[31 : 31];
  end

  always @(*) begin
    _zz_dataJoinStream_payload_2_user_2[0 : 0] = _zz_dataJoinStream_payload_2_user_3[0 : 0];
    _zz_dataJoinStream_payload_2_user_2[1 : 1] = _zz_dataJoinStream_payload_2_user_3[1 : 1];
    _zz_dataJoinStream_payload_2_user_2[2 : 2] = _zz_dataJoinStream_payload_2_user_3[2 : 2];
    _zz_dataJoinStream_payload_2_user_2[3 : 3] = _zz_dataJoinStream_payload_2_user_3[3 : 3];
    _zz_dataJoinStream_payload_2_user_2[4 : 4] = _zz_dataJoinStream_payload_2_user_3[4 : 4];
    _zz_dataJoinStream_payload_2_user_2[5 : 5] = _zz_dataJoinStream_payload_2_user_3[5 : 5];
    _zz_dataJoinStream_payload_2_user_2[6 : 6] = _zz_dataJoinStream_payload_2_user_3[6 : 6];
    _zz_dataJoinStream_payload_2_user_2[7 : 7] = _zz_dataJoinStream_payload_2_user_3[7 : 7];
    _zz_dataJoinStream_payload_2_user_2[8 : 8] = _zz_dataJoinStream_payload_2_user_3[8 : 8];
    _zz_dataJoinStream_payload_2_user_2[9 : 9] = _zz_dataJoinStream_payload_2_user_3[9 : 9];
    _zz_dataJoinStream_payload_2_user_2[10 : 10] = _zz_dataJoinStream_payload_2_user_3[10 : 10];
    _zz_dataJoinStream_payload_2_user_2[11 : 11] = _zz_dataJoinStream_payload_2_user_3[11 : 11];
    _zz_dataJoinStream_payload_2_user_2[12 : 12] = _zz_dataJoinStream_payload_2_user_3[12 : 12];
    _zz_dataJoinStream_payload_2_user_2[13 : 13] = _zz_dataJoinStream_payload_2_user_3[13 : 13];
    _zz_dataJoinStream_payload_2_user_2[14 : 14] = _zz_dataJoinStream_payload_2_user_3[14 : 14];
    _zz_dataJoinStream_payload_2_user_2[15 : 15] = _zz_dataJoinStream_payload_2_user_3[15 : 15];
    _zz_dataJoinStream_payload_2_user_2[16 : 16] = _zz_dataJoinStream_payload_2_user_3[16 : 16];
    _zz_dataJoinStream_payload_2_user_2[17 : 17] = _zz_dataJoinStream_payload_2_user_3[17 : 17];
    _zz_dataJoinStream_payload_2_user_2[18 : 18] = _zz_dataJoinStream_payload_2_user_3[18 : 18];
    _zz_dataJoinStream_payload_2_user_2[19 : 19] = _zz_dataJoinStream_payload_2_user_3[19 : 19];
    _zz_dataJoinStream_payload_2_user_2[20 : 20] = _zz_dataJoinStream_payload_2_user_3[20 : 20];
    _zz_dataJoinStream_payload_2_user_2[21 : 21] = _zz_dataJoinStream_payload_2_user_3[21 : 21];
    _zz_dataJoinStream_payload_2_user_2[22 : 22] = _zz_dataJoinStream_payload_2_user_3[22 : 22];
    _zz_dataJoinStream_payload_2_user_2[23 : 23] = _zz_dataJoinStream_payload_2_user_3[23 : 23];
    _zz_dataJoinStream_payload_2_user_2[24 : 24] = _zz_dataJoinStream_payload_2_user_3[24 : 24];
    _zz_dataJoinStream_payload_2_user_2[25 : 25] = _zz_dataJoinStream_payload_2_user_3[25 : 25];
    _zz_dataJoinStream_payload_2_user_2[26 : 26] = _zz_dataJoinStream_payload_2_user_3[26 : 26];
    _zz_dataJoinStream_payload_2_user_2[27 : 27] = _zz_dataJoinStream_payload_2_user_3[27 : 27];
    _zz_dataJoinStream_payload_2_user_2[28 : 28] = _zz_dataJoinStream_payload_2_user_3[28 : 28];
    _zz_dataJoinStream_payload_2_user_2[29 : 29] = _zz_dataJoinStream_payload_2_user_3[29 : 29];
    _zz_dataJoinStream_payload_2_user_2[30 : 30] = _zz_dataJoinStream_payload_2_user_3[30 : 30];
    _zz_dataJoinStream_payload_2_user_2[31 : 31] = _zz_dataJoinStream_payload_2_user_3[31 : 31];
  end

  always @(*) begin
    dataJoinStream_valid = _zz_when_Stream_l368;
    if(invalidReg) begin
      dataJoinStream_valid = 1'b0;
    end
  end

  always @(*) begin
    _zz_dataStreamReg_ready_2 = dataJoinStream_ready;
    if(invalidReg) begin
      _zz_dataStreamReg_ready_2 = 1'b1;
    end
  end

  assign dataJoinStream_payload_1_data = _zz_dataJoinStream_payload_1_data;
  assign dataJoinStream_payload_1_keep = _zz_dataJoinStream_payload_1_keep;
  assign dataJoinStream_payload_1_last = _zz_dataJoinStream_payload_1_last;
  always @(*) begin
    dataJoinStream_payload_1_user[0 : 0] = _zz_dataJoinStream_payload_1_user_1[0 : 0];
    dataJoinStream_payload_1_user[1 : 1] = _zz_dataJoinStream_payload_1_user_1[1 : 1];
    dataJoinStream_payload_1_user[2 : 2] = _zz_dataJoinStream_payload_1_user_1[2 : 2];
    dataJoinStream_payload_1_user[3 : 3] = _zz_dataJoinStream_payload_1_user_1[3 : 3];
    dataJoinStream_payload_1_user[4 : 4] = _zz_dataJoinStream_payload_1_user_1[4 : 4];
    dataJoinStream_payload_1_user[5 : 5] = _zz_dataJoinStream_payload_1_user_1[5 : 5];
    dataJoinStream_payload_1_user[6 : 6] = _zz_dataJoinStream_payload_1_user_1[6 : 6];
    dataJoinStream_payload_1_user[7 : 7] = _zz_dataJoinStream_payload_1_user_1[7 : 7];
    dataJoinStream_payload_1_user[8 : 8] = _zz_dataJoinStream_payload_1_user_1[8 : 8];
    dataJoinStream_payload_1_user[9 : 9] = _zz_dataJoinStream_payload_1_user_1[9 : 9];
    dataJoinStream_payload_1_user[10 : 10] = _zz_dataJoinStream_payload_1_user_1[10 : 10];
    dataJoinStream_payload_1_user[11 : 11] = _zz_dataJoinStream_payload_1_user_1[11 : 11];
    dataJoinStream_payload_1_user[12 : 12] = _zz_dataJoinStream_payload_1_user_1[12 : 12];
    dataJoinStream_payload_1_user[13 : 13] = _zz_dataJoinStream_payload_1_user_1[13 : 13];
    dataJoinStream_payload_1_user[14 : 14] = _zz_dataJoinStream_payload_1_user_1[14 : 14];
    dataJoinStream_payload_1_user[15 : 15] = _zz_dataJoinStream_payload_1_user_1[15 : 15];
    dataJoinStream_payload_1_user[16 : 16] = _zz_dataJoinStream_payload_1_user_1[16 : 16];
    dataJoinStream_payload_1_user[17 : 17] = _zz_dataJoinStream_payload_1_user_1[17 : 17];
    dataJoinStream_payload_1_user[18 : 18] = _zz_dataJoinStream_payload_1_user_1[18 : 18];
    dataJoinStream_payload_1_user[19 : 19] = _zz_dataJoinStream_payload_1_user_1[19 : 19];
    dataJoinStream_payload_1_user[20 : 20] = _zz_dataJoinStream_payload_1_user_1[20 : 20];
    dataJoinStream_payload_1_user[21 : 21] = _zz_dataJoinStream_payload_1_user_1[21 : 21];
    dataJoinStream_payload_1_user[22 : 22] = _zz_dataJoinStream_payload_1_user_1[22 : 22];
    dataJoinStream_payload_1_user[23 : 23] = _zz_dataJoinStream_payload_1_user_1[23 : 23];
    dataJoinStream_payload_1_user[24 : 24] = _zz_dataJoinStream_payload_1_user_1[24 : 24];
    dataJoinStream_payload_1_user[25 : 25] = _zz_dataJoinStream_payload_1_user_1[25 : 25];
    dataJoinStream_payload_1_user[26 : 26] = _zz_dataJoinStream_payload_1_user_1[26 : 26];
    dataJoinStream_payload_1_user[27 : 27] = _zz_dataJoinStream_payload_1_user_1[27 : 27];
    dataJoinStream_payload_1_user[28 : 28] = _zz_dataJoinStream_payload_1_user_1[28 : 28];
    dataJoinStream_payload_1_user[29 : 29] = _zz_dataJoinStream_payload_1_user_1[29 : 29];
    dataJoinStream_payload_1_user[30 : 30] = _zz_dataJoinStream_payload_1_user_1[30 : 30];
    dataJoinStream_payload_1_user[31 : 31] = _zz_dataJoinStream_payload_1_user_1[31 : 31];
  end

  assign dataJoinStream_payload_2_data = _zz_dataJoinStream_payload_2_data_1;
  assign dataJoinStream_payload_2_keep = _zz_dataJoinStream_payload_2_keep_1;
  assign dataJoinStream_payload_2_last = _zz_dataJoinStream_payload_2_last_1;
  always @(*) begin
    dataJoinStream_payload_2_user[0 : 0] = _zz_dataJoinStream_payload_2_user_2[0 : 0];
    dataJoinStream_payload_2_user[1 : 1] = _zz_dataJoinStream_payload_2_user_2[1 : 1];
    dataJoinStream_payload_2_user[2 : 2] = _zz_dataJoinStream_payload_2_user_2[2 : 2];
    dataJoinStream_payload_2_user[3 : 3] = _zz_dataJoinStream_payload_2_user_2[3 : 3];
    dataJoinStream_payload_2_user[4 : 4] = _zz_dataJoinStream_payload_2_user_2[4 : 4];
    dataJoinStream_payload_2_user[5 : 5] = _zz_dataJoinStream_payload_2_user_2[5 : 5];
    dataJoinStream_payload_2_user[6 : 6] = _zz_dataJoinStream_payload_2_user_2[6 : 6];
    dataJoinStream_payload_2_user[7 : 7] = _zz_dataJoinStream_payload_2_user_2[7 : 7];
    dataJoinStream_payload_2_user[8 : 8] = _zz_dataJoinStream_payload_2_user_2[8 : 8];
    dataJoinStream_payload_2_user[9 : 9] = _zz_dataJoinStream_payload_2_user_2[9 : 9];
    dataJoinStream_payload_2_user[10 : 10] = _zz_dataJoinStream_payload_2_user_2[10 : 10];
    dataJoinStream_payload_2_user[11 : 11] = _zz_dataJoinStream_payload_2_user_2[11 : 11];
    dataJoinStream_payload_2_user[12 : 12] = _zz_dataJoinStream_payload_2_user_2[12 : 12];
    dataJoinStream_payload_2_user[13 : 13] = _zz_dataJoinStream_payload_2_user_2[13 : 13];
    dataJoinStream_payload_2_user[14 : 14] = _zz_dataJoinStream_payload_2_user_2[14 : 14];
    dataJoinStream_payload_2_user[15 : 15] = _zz_dataJoinStream_payload_2_user_2[15 : 15];
    dataJoinStream_payload_2_user[16 : 16] = _zz_dataJoinStream_payload_2_user_2[16 : 16];
    dataJoinStream_payload_2_user[17 : 17] = _zz_dataJoinStream_payload_2_user_2[17 : 17];
    dataJoinStream_payload_2_user[18 : 18] = _zz_dataJoinStream_payload_2_user_2[18 : 18];
    dataJoinStream_payload_2_user[19 : 19] = _zz_dataJoinStream_payload_2_user_2[19 : 19];
    dataJoinStream_payload_2_user[20 : 20] = _zz_dataJoinStream_payload_2_user_2[20 : 20];
    dataJoinStream_payload_2_user[21 : 21] = _zz_dataJoinStream_payload_2_user_2[21 : 21];
    dataJoinStream_payload_2_user[22 : 22] = _zz_dataJoinStream_payload_2_user_2[22 : 22];
    dataJoinStream_payload_2_user[23 : 23] = _zz_dataJoinStream_payload_2_user_2[23 : 23];
    dataJoinStream_payload_2_user[24 : 24] = _zz_dataJoinStream_payload_2_user_2[24 : 24];
    dataJoinStream_payload_2_user[25 : 25] = _zz_dataJoinStream_payload_2_user_2[25 : 25];
    dataJoinStream_payload_2_user[26 : 26] = _zz_dataJoinStream_payload_2_user_2[26 : 26];
    dataJoinStream_payload_2_user[27 : 27] = _zz_dataJoinStream_payload_2_user_2[27 : 27];
    dataJoinStream_payload_2_user[28 : 28] = _zz_dataJoinStream_payload_2_user_2[28 : 28];
    dataJoinStream_payload_2_user[29 : 29] = _zz_dataJoinStream_payload_2_user_2[29 : 29];
    dataJoinStream_payload_2_user[30 : 30] = _zz_dataJoinStream_payload_2_user_2[30 : 30];
    dataJoinStream_payload_2_user[31 : 31] = _zz_dataJoinStream_payload_2_user_2[31 : 31];
  end

  assign dataJoinStream_fire = (dataJoinStream_valid && dataJoinStream_ready);
  always @(*) begin
    case(shiftLen)
      5'h0 : begin
        _zz_mask = 32'hffffffff;
      end
      5'h01 : begin
        _zz_mask = _zz_mask_1;
      end
      5'h02 : begin
        _zz_mask = _zz_mask_2;
      end
      5'h03 : begin
        _zz_mask = _zz_mask_3;
      end
      5'h04 : begin
        _zz_mask = _zz_mask_4;
      end
      5'h05 : begin
        _zz_mask = _zz_mask_5;
      end
      5'h06 : begin
        _zz_mask = _zz_mask_6;
      end
      5'h07 : begin
        _zz_mask = _zz_mask_7;
      end
      5'h08 : begin
        _zz_mask = _zz_mask_8;
      end
      5'h09 : begin
        _zz_mask = _zz_mask_9;
      end
      5'h0a : begin
        _zz_mask = _zz_mask_10;
      end
      5'h0b : begin
        _zz_mask = _zz_mask_11;
      end
      5'h0c : begin
        _zz_mask = _zz_mask_12;
      end
      5'h0d : begin
        _zz_mask = _zz_mask_13;
      end
      5'h0e : begin
        _zz_mask = _zz_mask_14;
      end
      5'h0f : begin
        _zz_mask = _zz_mask_15;
      end
      5'h10 : begin
        _zz_mask = _zz_mask_16;
      end
      5'h11 : begin
        _zz_mask = _zz_mask_17;
      end
      5'h12 : begin
        _zz_mask = _zz_mask_18;
      end
      5'h13 : begin
        _zz_mask = _zz_mask_19;
      end
      5'h14 : begin
        _zz_mask = _zz_mask_20;
      end
      5'h15 : begin
        _zz_mask = _zz_mask_21;
      end
      5'h16 : begin
        _zz_mask = _zz_mask_22;
      end
      5'h17 : begin
        _zz_mask = _zz_mask_23;
      end
      5'h18 : begin
        _zz_mask = _zz_mask_24;
      end
      5'h19 : begin
        _zz_mask = _zz_mask_25;
      end
      5'h1a : begin
        _zz_mask = _zz_mask_26;
      end
      5'h1b : begin
        _zz_mask = _zz_mask_27;
      end
      5'h1c : begin
        _zz_mask = _zz_mask_28;
      end
      5'h1d : begin
        _zz_mask = _zz_mask_29;
      end
      5'h1e : begin
        _zz_mask = _zz_mask_30;
      end
      default : begin
        _zz_mask = _zz_mask_31;
      end
    endcase
  end

  assign _zz_1 = zz__zz_mask_1(1'b0);
  always @(*) _zz_mask_1 = _zz_1;
  assign _zz_2 = zz__zz_mask_2(1'b0);
  always @(*) _zz_mask_2 = _zz_2;
  assign _zz_3 = zz__zz_mask_3(1'b0);
  always @(*) _zz_mask_3 = _zz_3;
  assign _zz_4 = zz__zz_mask_4(1'b0);
  always @(*) _zz_mask_4 = _zz_4;
  assign _zz_5 = zz__zz_mask_5(1'b0);
  always @(*) _zz_mask_5 = _zz_5;
  assign _zz_6 = zz__zz_mask_6(1'b0);
  always @(*) _zz_mask_6 = _zz_6;
  assign _zz_7 = zz__zz_mask_7(1'b0);
  always @(*) _zz_mask_7 = _zz_7;
  assign _zz_8 = zz__zz_mask_8(1'b0);
  always @(*) _zz_mask_8 = _zz_8;
  assign _zz_9 = zz__zz_mask_9(1'b0);
  always @(*) _zz_mask_9 = _zz_9;
  assign _zz_10 = zz__zz_mask_10(1'b0);
  always @(*) _zz_mask_10 = _zz_10;
  assign _zz_11 = zz__zz_mask_11(1'b0);
  always @(*) _zz_mask_11 = _zz_11;
  assign _zz_12 = zz__zz_mask_12(1'b0);
  always @(*) _zz_mask_12 = _zz_12;
  assign _zz_13 = zz__zz_mask_13(1'b0);
  always @(*) _zz_mask_13 = _zz_13;
  assign _zz_14 = zz__zz_mask_14(1'b0);
  always @(*) _zz_mask_14 = _zz_14;
  assign _zz_15 = zz__zz_mask_15(1'b0);
  always @(*) _zz_mask_15 = _zz_15;
  assign _zz_16 = zz__zz_mask_16(1'b0);
  always @(*) _zz_mask_16 = _zz_16;
  assign _zz_17 = zz__zz_mask_17(1'b0);
  always @(*) _zz_mask_17 = _zz_17;
  assign _zz_18 = zz__zz_mask_18(1'b0);
  always @(*) _zz_mask_18 = _zz_18;
  assign _zz_19 = zz__zz_mask_19(1'b0);
  always @(*) _zz_mask_19 = _zz_19;
  assign _zz_20 = zz__zz_mask_20(1'b0);
  always @(*) _zz_mask_20 = _zz_20;
  assign _zz_21 = zz__zz_mask_21(1'b0);
  always @(*) _zz_mask_21 = _zz_21;
  assign _zz_22 = zz__zz_mask_22(1'b0);
  always @(*) _zz_mask_22 = _zz_22;
  assign _zz_23 = zz__zz_mask_23(1'b0);
  always @(*) _zz_mask_23 = _zz_23;
  assign _zz_24 = zz__zz_mask_24(1'b0);
  always @(*) _zz_mask_24 = _zz_24;
  assign _zz_25 = zz__zz_mask_25(1'b0);
  always @(*) _zz_mask_25 = _zz_25;
  assign _zz_26 = zz__zz_mask_26(1'b0);
  always @(*) _zz_mask_26 = _zz_26;
  assign _zz_27 = zz__zz_mask_27(1'b0);
  always @(*) _zz_mask_27 = _zz_27;
  assign _zz_28 = zz__zz_mask_28(1'b0);
  always @(*) _zz_mask_28 = _zz_28;
  assign _zz_29 = zz__zz_mask_29(1'b0);
  always @(*) _zz_mask_29 = _zz_29;
  assign _zz_30 = zz__zz_mask_30(1'b0);
  always @(*) _zz_mask_30 = _zz_30;
  assign _zz_31 = zz__zz_mask_31(1'b0);
  always @(*) _zz_mask_31 = _zz_31;
  assign dataStreamReg_fire = (dataStreamReg_valid && dataStreamReg_ready);
  assign when_HeaderRecognizer_l148 = (headerMatch && dataStreamReg_fire);
  assign maskStage_valid = dataJoinStream_valid;
  assign dataJoinStream_ready = maskStage_ready;
  assign _zz_maskStage_payload_data = (~ mask);
  assign maskStage_payload_data = ({{{{_zz_maskStage_payload_data_1,_zz_maskStage_payload_data_38},(_zz_maskStage_payload_data_39 ? _zz_maskStage_payload_data_40 : _zz_maskStage_payload_data_41)},(_zz_maskStage_payload_data[1] ? 8'h0 : dataJoinStream_payload_1_data[15 : 8])},(_zz_maskStage_payload_data[0] ? 8'h0 : dataJoinStream_payload_1_data[7 : 0])} | {{{{_zz_maskStage_payload_data_42,_zz_maskStage_payload_data_79},(_zz_maskStage_payload_data_80 ? _zz_maskStage_payload_data_81 : _zz_maskStage_payload_data_82)},(mask[1] ? 8'h0 : dataJoinStream_payload_2_data[15 : 8])},(mask[0] ? 8'h0 : dataJoinStream_payload_2_data[7 : 0])});
  assign _zz_maskStage_payload_keep = (~ mask);
  assign maskStage_payload_keep = ({{{{_zz_maskStage_payload_keep_1,_zz_maskStage_payload_keep_38},(_zz_maskStage_payload_keep_39 ? _zz_maskStage_payload_keep_40 : _zz_maskStage_payload_keep_41)},(_zz_maskStage_payload_keep[1] ? 1'b0 : dataJoinStream_payload_1_keep[1 : 1])},(_zz_maskStage_payload_keep[0] ? 1'b0 : dataJoinStream_payload_1_keep[0 : 0])} | {{{{_zz_maskStage_payload_keep_42,_zz_maskStage_payload_keep_79},(_zz_maskStage_payload_keep_80 ? _zz_maskStage_payload_keep_81 : _zz_maskStage_payload_keep_82)},(mask[1] ? 1'b0 : dataJoinStream_payload_2_keep[1 : 1])},(mask[0] ? 1'b0 : dataJoinStream_payload_2_keep[0 : 0])});
  assign maskStage_payload_last = transactionCounter_io_done;
  always @(*) begin
    maskStage_ready = maskStage_m2sPipe_ready;
    if(when_Stream_l368_4) begin
      maskStage_ready = 1'b1;
    end
  end

  assign when_Stream_l368_4 = (! maskStage_m2sPipe_valid);
  assign maskStage_m2sPipe_valid = maskStage_rValid;
  assign maskStage_m2sPipe_payload_data = maskStage_rData_data;
  assign maskStage_m2sPipe_payload_keep = maskStage_rData_keep;
  assign maskStage_m2sPipe_payload_last = maskStage_rData_last;
  always @(*) begin
    maskStage_m2sPipe_payload_user[0 : 0] = maskStage_rData_user[0 : 0];
    maskStage_m2sPipe_payload_user[1 : 1] = maskStage_rData_user[1 : 1];
    maskStage_m2sPipe_payload_user[2 : 2] = maskStage_rData_user[2 : 2];
    maskStage_m2sPipe_payload_user[3 : 3] = maskStage_rData_user[3 : 3];
    maskStage_m2sPipe_payload_user[4 : 4] = maskStage_rData_user[4 : 4];
    maskStage_m2sPipe_payload_user[5 : 5] = maskStage_rData_user[5 : 5];
    maskStage_m2sPipe_payload_user[6 : 6] = maskStage_rData_user[6 : 6];
    maskStage_m2sPipe_payload_user[7 : 7] = maskStage_rData_user[7 : 7];
    maskStage_m2sPipe_payload_user[8 : 8] = maskStage_rData_user[8 : 8];
    maskStage_m2sPipe_payload_user[9 : 9] = maskStage_rData_user[9 : 9];
    maskStage_m2sPipe_payload_user[10 : 10] = maskStage_rData_user[10 : 10];
    maskStage_m2sPipe_payload_user[11 : 11] = maskStage_rData_user[11 : 11];
    maskStage_m2sPipe_payload_user[12 : 12] = maskStage_rData_user[12 : 12];
    maskStage_m2sPipe_payload_user[13 : 13] = maskStage_rData_user[13 : 13];
    maskStage_m2sPipe_payload_user[14 : 14] = maskStage_rData_user[14 : 14];
    maskStage_m2sPipe_payload_user[15 : 15] = maskStage_rData_user[15 : 15];
    maskStage_m2sPipe_payload_user[16 : 16] = maskStage_rData_user[16 : 16];
    maskStage_m2sPipe_payload_user[17 : 17] = maskStage_rData_user[17 : 17];
    maskStage_m2sPipe_payload_user[18 : 18] = maskStage_rData_user[18 : 18];
    maskStage_m2sPipe_payload_user[19 : 19] = maskStage_rData_user[19 : 19];
    maskStage_m2sPipe_payload_user[20 : 20] = maskStage_rData_user[20 : 20];
    maskStage_m2sPipe_payload_user[21 : 21] = maskStage_rData_user[21 : 21];
    maskStage_m2sPipe_payload_user[22 : 22] = maskStage_rData_user[22 : 22];
    maskStage_m2sPipe_payload_user[23 : 23] = maskStage_rData_user[23 : 23];
    maskStage_m2sPipe_payload_user[24 : 24] = maskStage_rData_user[24 : 24];
    maskStage_m2sPipe_payload_user[25 : 25] = maskStage_rData_user[25 : 25];
    maskStage_m2sPipe_payload_user[26 : 26] = maskStage_rData_user[26 : 26];
    maskStage_m2sPipe_payload_user[27 : 27] = maskStage_rData_user[27 : 27];
    maskStage_m2sPipe_payload_user[28 : 28] = maskStage_rData_user[28 : 28];
    maskStage_m2sPipe_payload_user[29 : 29] = maskStage_rData_user[29 : 29];
    maskStage_m2sPipe_payload_user[30 : 30] = maskStage_rData_user[30 : 30];
    maskStage_m2sPipe_payload_user[31 : 31] = maskStage_rData_user[31 : 31];
  end

  assign maskStage_m2sPipe_ready = (! maskStage_m2sPipe_rValid);
  assign maskedStage_valid = (maskStage_m2sPipe_valid || maskStage_m2sPipe_rValid);
  assign _zz_maskedStage_payload_user = (maskStage_m2sPipe_rValid ? maskStage_m2sPipe_rData_user : maskStage_m2sPipe_payload_user);
  assign maskedStage_payload_data = (maskStage_m2sPipe_rValid ? maskStage_m2sPipe_rData_data : maskStage_m2sPipe_payload_data);
  assign maskedStage_payload_keep = (maskStage_m2sPipe_rValid ? maskStage_m2sPipe_rData_keep : maskStage_m2sPipe_payload_keep);
  assign maskedStage_payload_last = (maskStage_m2sPipe_rValid ? maskStage_m2sPipe_rData_last : maskStage_m2sPipe_payload_last);
  always @(*) begin
    maskedStage_payload_user[0 : 0] = _zz_maskedStage_payload_user[0 : 0];
    maskedStage_payload_user[1 : 1] = _zz_maskedStage_payload_user[1 : 1];
    maskedStage_payload_user[2 : 2] = _zz_maskedStage_payload_user[2 : 2];
    maskedStage_payload_user[3 : 3] = _zz_maskedStage_payload_user[3 : 3];
    maskedStage_payload_user[4 : 4] = _zz_maskedStage_payload_user[4 : 4];
    maskedStage_payload_user[5 : 5] = _zz_maskedStage_payload_user[5 : 5];
    maskedStage_payload_user[6 : 6] = _zz_maskedStage_payload_user[6 : 6];
    maskedStage_payload_user[7 : 7] = _zz_maskedStage_payload_user[7 : 7];
    maskedStage_payload_user[8 : 8] = _zz_maskedStage_payload_user[8 : 8];
    maskedStage_payload_user[9 : 9] = _zz_maskedStage_payload_user[9 : 9];
    maskedStage_payload_user[10 : 10] = _zz_maskedStage_payload_user[10 : 10];
    maskedStage_payload_user[11 : 11] = _zz_maskedStage_payload_user[11 : 11];
    maskedStage_payload_user[12 : 12] = _zz_maskedStage_payload_user[12 : 12];
    maskedStage_payload_user[13 : 13] = _zz_maskedStage_payload_user[13 : 13];
    maskedStage_payload_user[14 : 14] = _zz_maskedStage_payload_user[14 : 14];
    maskedStage_payload_user[15 : 15] = _zz_maskedStage_payload_user[15 : 15];
    maskedStage_payload_user[16 : 16] = _zz_maskedStage_payload_user[16 : 16];
    maskedStage_payload_user[17 : 17] = _zz_maskedStage_payload_user[17 : 17];
    maskedStage_payload_user[18 : 18] = _zz_maskedStage_payload_user[18 : 18];
    maskedStage_payload_user[19 : 19] = _zz_maskedStage_payload_user[19 : 19];
    maskedStage_payload_user[20 : 20] = _zz_maskedStage_payload_user[20 : 20];
    maskedStage_payload_user[21 : 21] = _zz_maskedStage_payload_user[21 : 21];
    maskedStage_payload_user[22 : 22] = _zz_maskedStage_payload_user[22 : 22];
    maskedStage_payload_user[23 : 23] = _zz_maskedStage_payload_user[23 : 23];
    maskedStage_payload_user[24 : 24] = _zz_maskedStage_payload_user[24 : 24];
    maskedStage_payload_user[25 : 25] = _zz_maskedStage_payload_user[25 : 25];
    maskedStage_payload_user[26 : 26] = _zz_maskedStage_payload_user[26 : 26];
    maskedStage_payload_user[27 : 27] = _zz_maskedStage_payload_user[27 : 27];
    maskedStage_payload_user[28 : 28] = _zz_maskedStage_payload_user[28 : 28];
    maskedStage_payload_user[29 : 29] = _zz_maskedStage_payload_user[29 : 29];
    maskedStage_payload_user[30 : 30] = _zz_maskedStage_payload_user[30 : 30];
    maskedStage_payload_user[31 : 31] = _zz_maskedStage_payload_user[31 : 31];
  end

  assign shiftStage_valid = maskedStage_valid;
  assign maskedStage_ready = shiftStage_ready;
  always @(*) begin
    case(shiftLen)
      5'h0 : begin
        _zz_shiftStage_payload_data = maskedStage_payload_data[255 : 0];
      end
      5'h01 : begin
        _zz_shiftStage_payload_data = {maskedStage_payload_data[247 : 0],maskedStage_payload_data[255 : 248]};
      end
      5'h02 : begin
        _zz_shiftStage_payload_data = {maskedStage_payload_data[239 : 0],maskedStage_payload_data[255 : 240]};
      end
      5'h03 : begin
        _zz_shiftStage_payload_data = {maskedStage_payload_data[231 : 0],maskedStage_payload_data[255 : 232]};
      end
      5'h04 : begin
        _zz_shiftStage_payload_data = {maskedStage_payload_data[223 : 0],maskedStage_payload_data[255 : 224]};
      end
      5'h05 : begin
        _zz_shiftStage_payload_data = {maskedStage_payload_data[215 : 0],maskedStage_payload_data[255 : 216]};
      end
      5'h06 : begin
        _zz_shiftStage_payload_data = {maskedStage_payload_data[207 : 0],maskedStage_payload_data[255 : 208]};
      end
      5'h07 : begin
        _zz_shiftStage_payload_data = {maskedStage_payload_data[199 : 0],maskedStage_payload_data[255 : 200]};
      end
      5'h08 : begin
        _zz_shiftStage_payload_data = {maskedStage_payload_data[191 : 0],maskedStage_payload_data[255 : 192]};
      end
      5'h09 : begin
        _zz_shiftStage_payload_data = {maskedStage_payload_data[183 : 0],maskedStage_payload_data[255 : 184]};
      end
      5'h0a : begin
        _zz_shiftStage_payload_data = {maskedStage_payload_data[175 : 0],maskedStage_payload_data[255 : 176]};
      end
      5'h0b : begin
        _zz_shiftStage_payload_data = {maskedStage_payload_data[167 : 0],maskedStage_payload_data[255 : 168]};
      end
      5'h0c : begin
        _zz_shiftStage_payload_data = {maskedStage_payload_data[159 : 0],maskedStage_payload_data[255 : 160]};
      end
      5'h0d : begin
        _zz_shiftStage_payload_data = {maskedStage_payload_data[151 : 0],maskedStage_payload_data[255 : 152]};
      end
      5'h0e : begin
        _zz_shiftStage_payload_data = {maskedStage_payload_data[143 : 0],maskedStage_payload_data[255 : 144]};
      end
      5'h0f : begin
        _zz_shiftStage_payload_data = {maskedStage_payload_data[135 : 0],maskedStage_payload_data[255 : 136]};
      end
      5'h10 : begin
        _zz_shiftStage_payload_data = {maskedStage_payload_data[127 : 0],maskedStage_payload_data[255 : 128]};
      end
      5'h11 : begin
        _zz_shiftStage_payload_data = {maskedStage_payload_data[119 : 0],maskedStage_payload_data[255 : 120]};
      end
      5'h12 : begin
        _zz_shiftStage_payload_data = {maskedStage_payload_data[111 : 0],maskedStage_payload_data[255 : 112]};
      end
      5'h13 : begin
        _zz_shiftStage_payload_data = {maskedStage_payload_data[103 : 0],maskedStage_payload_data[255 : 104]};
      end
      5'h14 : begin
        _zz_shiftStage_payload_data = {maskedStage_payload_data[95 : 0],maskedStage_payload_data[255 : 96]};
      end
      5'h15 : begin
        _zz_shiftStage_payload_data = {maskedStage_payload_data[87 : 0],maskedStage_payload_data[255 : 88]};
      end
      5'h16 : begin
        _zz_shiftStage_payload_data = {maskedStage_payload_data[79 : 0],maskedStage_payload_data[255 : 80]};
      end
      5'h17 : begin
        _zz_shiftStage_payload_data = {maskedStage_payload_data[71 : 0],maskedStage_payload_data[255 : 72]};
      end
      5'h18 : begin
        _zz_shiftStage_payload_data = {maskedStage_payload_data[63 : 0],maskedStage_payload_data[255 : 64]};
      end
      5'h19 : begin
        _zz_shiftStage_payload_data = {maskedStage_payload_data[55 : 0],maskedStage_payload_data[255 : 56]};
      end
      5'h1a : begin
        _zz_shiftStage_payload_data = {maskedStage_payload_data[47 : 0],maskedStage_payload_data[255 : 48]};
      end
      5'h1b : begin
        _zz_shiftStage_payload_data = {maskedStage_payload_data[39 : 0],maskedStage_payload_data[255 : 40]};
      end
      5'h1c : begin
        _zz_shiftStage_payload_data = {maskedStage_payload_data[31 : 0],maskedStage_payload_data[255 : 32]};
      end
      5'h1d : begin
        _zz_shiftStage_payload_data = {maskedStage_payload_data[23 : 0],maskedStage_payload_data[255 : 24]};
      end
      5'h1e : begin
        _zz_shiftStage_payload_data = {maskedStage_payload_data[15 : 0],maskedStage_payload_data[255 : 16]};
      end
      default : begin
        _zz_shiftStage_payload_data = {maskedStage_payload_data[7 : 0],maskedStage_payload_data[255 : 8]};
      end
    endcase
  end

  assign shiftStage_payload_data = _zz_shiftStage_payload_data;
  always @(*) begin
    case(shiftLen)
      5'h0 : begin
        _zz_shiftStage_payload_keep = maskedStage_payload_keep[31 : 0];
      end
      5'h01 : begin
        _zz_shiftStage_payload_keep = {maskedStage_payload_keep[30 : 0],maskedStage_payload_keep[31 : 31]};
      end
      5'h02 : begin
        _zz_shiftStage_payload_keep = {maskedStage_payload_keep[29 : 0],maskedStage_payload_keep[31 : 30]};
      end
      5'h03 : begin
        _zz_shiftStage_payload_keep = {maskedStage_payload_keep[28 : 0],maskedStage_payload_keep[31 : 29]};
      end
      5'h04 : begin
        _zz_shiftStage_payload_keep = {maskedStage_payload_keep[27 : 0],maskedStage_payload_keep[31 : 28]};
      end
      5'h05 : begin
        _zz_shiftStage_payload_keep = {maskedStage_payload_keep[26 : 0],maskedStage_payload_keep[31 : 27]};
      end
      5'h06 : begin
        _zz_shiftStage_payload_keep = {maskedStage_payload_keep[25 : 0],maskedStage_payload_keep[31 : 26]};
      end
      5'h07 : begin
        _zz_shiftStage_payload_keep = {maskedStage_payload_keep[24 : 0],maskedStage_payload_keep[31 : 25]};
      end
      5'h08 : begin
        _zz_shiftStage_payload_keep = {maskedStage_payload_keep[23 : 0],maskedStage_payload_keep[31 : 24]};
      end
      5'h09 : begin
        _zz_shiftStage_payload_keep = {maskedStage_payload_keep[22 : 0],maskedStage_payload_keep[31 : 23]};
      end
      5'h0a : begin
        _zz_shiftStage_payload_keep = {maskedStage_payload_keep[21 : 0],maskedStage_payload_keep[31 : 22]};
      end
      5'h0b : begin
        _zz_shiftStage_payload_keep = {maskedStage_payload_keep[20 : 0],maskedStage_payload_keep[31 : 21]};
      end
      5'h0c : begin
        _zz_shiftStage_payload_keep = {maskedStage_payload_keep[19 : 0],maskedStage_payload_keep[31 : 20]};
      end
      5'h0d : begin
        _zz_shiftStage_payload_keep = {maskedStage_payload_keep[18 : 0],maskedStage_payload_keep[31 : 19]};
      end
      5'h0e : begin
        _zz_shiftStage_payload_keep = {maskedStage_payload_keep[17 : 0],maskedStage_payload_keep[31 : 18]};
      end
      5'h0f : begin
        _zz_shiftStage_payload_keep = {maskedStage_payload_keep[16 : 0],maskedStage_payload_keep[31 : 17]};
      end
      5'h10 : begin
        _zz_shiftStage_payload_keep = {maskedStage_payload_keep[15 : 0],maskedStage_payload_keep[31 : 16]};
      end
      5'h11 : begin
        _zz_shiftStage_payload_keep = {maskedStage_payload_keep[14 : 0],maskedStage_payload_keep[31 : 15]};
      end
      5'h12 : begin
        _zz_shiftStage_payload_keep = {maskedStage_payload_keep[13 : 0],maskedStage_payload_keep[31 : 14]};
      end
      5'h13 : begin
        _zz_shiftStage_payload_keep = {maskedStage_payload_keep[12 : 0],maskedStage_payload_keep[31 : 13]};
      end
      5'h14 : begin
        _zz_shiftStage_payload_keep = {maskedStage_payload_keep[11 : 0],maskedStage_payload_keep[31 : 12]};
      end
      5'h15 : begin
        _zz_shiftStage_payload_keep = {maskedStage_payload_keep[10 : 0],maskedStage_payload_keep[31 : 11]};
      end
      5'h16 : begin
        _zz_shiftStage_payload_keep = {maskedStage_payload_keep[9 : 0],maskedStage_payload_keep[31 : 10]};
      end
      5'h17 : begin
        _zz_shiftStage_payload_keep = {maskedStage_payload_keep[8 : 0],maskedStage_payload_keep[31 : 9]};
      end
      5'h18 : begin
        _zz_shiftStage_payload_keep = {maskedStage_payload_keep[7 : 0],maskedStage_payload_keep[31 : 8]};
      end
      5'h19 : begin
        _zz_shiftStage_payload_keep = {maskedStage_payload_keep[6 : 0],maskedStage_payload_keep[31 : 7]};
      end
      5'h1a : begin
        _zz_shiftStage_payload_keep = {maskedStage_payload_keep[5 : 0],maskedStage_payload_keep[31 : 6]};
      end
      5'h1b : begin
        _zz_shiftStage_payload_keep = {maskedStage_payload_keep[4 : 0],maskedStage_payload_keep[31 : 5]};
      end
      5'h1c : begin
        _zz_shiftStage_payload_keep = {maskedStage_payload_keep[3 : 0],maskedStage_payload_keep[31 : 4]};
      end
      5'h1d : begin
        _zz_shiftStage_payload_keep = {maskedStage_payload_keep[2 : 0],maskedStage_payload_keep[31 : 3]};
      end
      5'h1e : begin
        _zz_shiftStage_payload_keep = {maskedStage_payload_keep[1 : 0],maskedStage_payload_keep[31 : 2]};
      end
      default : begin
        _zz_shiftStage_payload_keep = {maskedStage_payload_keep[0 : 0],maskedStage_payload_keep[31 : 1]};
      end
    endcase
  end

  assign shiftStage_payload_keep = _zz_shiftStage_payload_keep;
  assign shiftStage_payload_user = 32'h0;
  assign shiftStage_payload_last = maskedStage_payload_last;
  assign io_dataAxisOut_valid = shiftStage_valid;
  assign shiftStage_ready = io_dataAxisOut_ready;
  assign io_dataAxisOut_payload_data = shiftStage_payload_data;
  assign io_dataAxisOut_payload_keep = shiftStage_payload_keep;
  assign io_dataAxisOut_payload_last = shiftStage_payload_last;
  always @(*) begin
    io_dataAxisOut_payload_user[0 : 0] = shiftStage_payload_user[0 : 0];
    io_dataAxisOut_payload_user[1 : 1] = shiftStage_payload_user[1 : 1];
    io_dataAxisOut_payload_user[2 : 2] = shiftStage_payload_user[2 : 2];
    io_dataAxisOut_payload_user[3 : 3] = shiftStage_payload_user[3 : 3];
    io_dataAxisOut_payload_user[4 : 4] = shiftStage_payload_user[4 : 4];
    io_dataAxisOut_payload_user[5 : 5] = shiftStage_payload_user[5 : 5];
    io_dataAxisOut_payload_user[6 : 6] = shiftStage_payload_user[6 : 6];
    io_dataAxisOut_payload_user[7 : 7] = shiftStage_payload_user[7 : 7];
    io_dataAxisOut_payload_user[8 : 8] = shiftStage_payload_user[8 : 8];
    io_dataAxisOut_payload_user[9 : 9] = shiftStage_payload_user[9 : 9];
    io_dataAxisOut_payload_user[10 : 10] = shiftStage_payload_user[10 : 10];
    io_dataAxisOut_payload_user[11 : 11] = shiftStage_payload_user[11 : 11];
    io_dataAxisOut_payload_user[12 : 12] = shiftStage_payload_user[12 : 12];
    io_dataAxisOut_payload_user[13 : 13] = shiftStage_payload_user[13 : 13];
    io_dataAxisOut_payload_user[14 : 14] = shiftStage_payload_user[14 : 14];
    io_dataAxisOut_payload_user[15 : 15] = shiftStage_payload_user[15 : 15];
    io_dataAxisOut_payload_user[16 : 16] = shiftStage_payload_user[16 : 16];
    io_dataAxisOut_payload_user[17 : 17] = shiftStage_payload_user[17 : 17];
    io_dataAxisOut_payload_user[18 : 18] = shiftStage_payload_user[18 : 18];
    io_dataAxisOut_payload_user[19 : 19] = shiftStage_payload_user[19 : 19];
    io_dataAxisOut_payload_user[20 : 20] = shiftStage_payload_user[20 : 20];
    io_dataAxisOut_payload_user[21 : 21] = shiftStage_payload_user[21 : 21];
    io_dataAxisOut_payload_user[22 : 22] = shiftStage_payload_user[22 : 22];
    io_dataAxisOut_payload_user[23 : 23] = shiftStage_payload_user[23 : 23];
    io_dataAxisOut_payload_user[24 : 24] = shiftStage_payload_user[24 : 24];
    io_dataAxisOut_payload_user[25 : 25] = shiftStage_payload_user[25 : 25];
    io_dataAxisOut_payload_user[26 : 26] = shiftStage_payload_user[26 : 26];
    io_dataAxisOut_payload_user[27 : 27] = shiftStage_payload_user[27 : 27];
    io_dataAxisOut_payload_user[28 : 28] = shiftStage_payload_user[28 : 28];
    io_dataAxisOut_payload_user[29 : 29] = shiftStage_payload_user[29 : 29];
    io_dataAxisOut_payload_user[30 : 30] = shiftStage_payload_user[30 : 30];
    io_dataAxisOut_payload_user[31 : 31] = shiftStage_payload_user[31 : 31];
  end

  always @(posedge clk or posedge reset) begin
    if(reset) begin
      recognizerRunning <= 1'b0;
      _zz_packetStream_valid <= 1'b1;
      _zz_packetReg_valid <= 1'b1;
      packetReg_rValid <= 1'b0;
      packetReg_m2sPipe_rValid <= 1'b0;
      macAddrCorrectReg <= 1'b0;
      ipAddrCorrectReg <= 1'b0;
      isIpReg <= 1'b0;
      isUdpReg <= 1'b0;
      dataLen <= 16'h0;
      shiftLen <= 5'h0;
      packetLenReg <= 6'h0;
      _zz_metaCfg_valid <= 1'b0;
      packetStreamReg_thrown_rValid <= 1'b0;
      packetStreamReg_thrown_m2sPipe_rValid <= 1'b0;
      packetStream_thrown_rValid <= 1'b0;
      packetStream_thrown_m2sPipe_rValid <= 1'b0;
      invalidReg <= 1'b0;
      _zz_when_Stream_l368_1 <= 1'b0;
      _zz_io_ctrlFire <= 1'b0;
      mask <= 32'h0;
      maskStage_rValid <= 1'b0;
      maskStage_m2sPipe_rValid <= 1'b0;
    end else begin
      if(packetStream_fire) begin
        _zz_packetStream_valid <= 1'b0;
      end
      if(packetReg_fire) begin
        _zz_packetReg_valid <= 1'b0;
      end
      if(io_dataAxisIn_ready) begin
        _zz_packetStream_valid <= 1'b1;
        _zz_packetReg_valid <= 1'b1;
      end
      if(packetReg_ready) begin
        packetReg_rValid <= packetReg_valid;
      end
      if(packetReg_m2sPipe_valid) begin
        packetReg_m2sPipe_rValid <= 1'b1;
      end
      if(packetStreamReg_ready) begin
        packetReg_m2sPipe_rValid <= 1'b0;
      end
      if(recognizerStart) begin
        if(when_HeaderRecognizer_l91) begin
          macAddrCorrectReg <= 1'b1;
        end
        if(when_HeaderRecognizer_l92) begin
          ipAddrCorrectReg <= 1'b1;
        end
        if(when_HeaderRecognizer_l93) begin
          isIpReg <= 1'b1;
        end
        if(when_HeaderRecognizer_l94) begin
          isUdpReg <= 1'b1;
        end
      end
      if(when_HeaderRecognizer_l97) begin
        macAddrCorrectReg <= 1'b0;
      end
      if(when_HeaderRecognizer_l98) begin
        ipAddrCorrectReg <= 1'b0;
      end
      if(when_HeaderRecognizer_l99) begin
        isIpReg <= 1'b0;
      end
      if(when_HeaderRecognizer_l100) begin
        isUdpReg <= 1'b0;
      end
      if(headerMatch) begin
        dataLen <= (ipv4HeaderExtractReg_4 - 16'h001c);
        shiftLen <= 5'h16;
        packetLenReg <= (_zz_packetLenReg[5 : 0] - (needOneMoreCycle ? 6'h0 : 6'h01));
      end
      _zz_metaCfg_valid <= (headerMatch && (! headerMatch_regNext));
      if(when_HeaderRecognizer_l122) begin
        recognizerRunning <= 1'b0;
      end else begin
        if(packetStream_fire_3) begin
          recognizerRunning <= 1'b1;
        end
      end
      if(packetStreamReg_thrown_ready) begin
        packetStreamReg_thrown_rValid <= packetStreamReg_thrown_valid;
      end
      if(packetStreamReg_thrown_m2sPipe_valid) begin
        packetStreamReg_thrown_m2sPipe_rValid <= 1'b1;
      end
      if(dataStreamReg_ready) begin
        packetStreamReg_thrown_m2sPipe_rValid <= 1'b0;
      end
      if(packetStream_thrown_ready) begin
        packetStream_thrown_rValid <= packetStream_thrown_valid;
      end
      if(packetStream_thrown_m2sPipe_valid) begin
        packetStream_thrown_m2sPipe_rValid <= 1'b1;
      end
      if(dataStream_ready) begin
        packetStream_thrown_m2sPipe_rValid <= 1'b0;
      end
      if(_zz_dataStreamReg_ready_1) begin
        _zz_when_Stream_l368_1 <= _zz_dataStreamReg_ready;
      end
      _zz_io_ctrlFire <= (headerMatch && (! headerMatch_regNext_1));
      invalidReg <= transactionCounter_io_done;
      if(when_HeaderRecognizer_l148) begin
        mask <= _zz_mask;
      end
      if(maskStage_ready) begin
        maskStage_rValid <= maskStage_valid;
      end
      if(maskStage_m2sPipe_valid) begin
        maskStage_m2sPipe_rValid <= 1'b1;
      end
      if(maskedStage_ready) begin
        maskStage_m2sPipe_rValid <= 1'b0;
      end
    end
  end

  always @(posedge clk) begin
    recognizerRunning_regNext <= recognizerRunning;
    if(packetReg_ready) begin
      packetReg_rData_data <= packetReg_payload_data;
      packetReg_rData_keep <= packetReg_payload_keep;
      packetReg_rData_last <= packetReg_payload_last;
      packetReg_rData_user[0 : 0] <= packetReg_payload_user[0 : 0];
      packetReg_rData_user[1 : 1] <= packetReg_payload_user[1 : 1];
      packetReg_rData_user[2 : 2] <= packetReg_payload_user[2 : 2];
      packetReg_rData_user[3 : 3] <= packetReg_payload_user[3 : 3];
      packetReg_rData_user[4 : 4] <= packetReg_payload_user[4 : 4];
      packetReg_rData_user[5 : 5] <= packetReg_payload_user[5 : 5];
      packetReg_rData_user[6 : 6] <= packetReg_payload_user[6 : 6];
      packetReg_rData_user[7 : 7] <= packetReg_payload_user[7 : 7];
      packetReg_rData_user[8 : 8] <= packetReg_payload_user[8 : 8];
      packetReg_rData_user[9 : 9] <= packetReg_payload_user[9 : 9];
      packetReg_rData_user[10 : 10] <= packetReg_payload_user[10 : 10];
      packetReg_rData_user[11 : 11] <= packetReg_payload_user[11 : 11];
      packetReg_rData_user[12 : 12] <= packetReg_payload_user[12 : 12];
      packetReg_rData_user[13 : 13] <= packetReg_payload_user[13 : 13];
      packetReg_rData_user[14 : 14] <= packetReg_payload_user[14 : 14];
      packetReg_rData_user[15 : 15] <= packetReg_payload_user[15 : 15];
      packetReg_rData_user[16 : 16] <= packetReg_payload_user[16 : 16];
      packetReg_rData_user[17 : 17] <= packetReg_payload_user[17 : 17];
      packetReg_rData_user[18 : 18] <= packetReg_payload_user[18 : 18];
      packetReg_rData_user[19 : 19] <= packetReg_payload_user[19 : 19];
      packetReg_rData_user[20 : 20] <= packetReg_payload_user[20 : 20];
      packetReg_rData_user[21 : 21] <= packetReg_payload_user[21 : 21];
      packetReg_rData_user[22 : 22] <= packetReg_payload_user[22 : 22];
      packetReg_rData_user[23 : 23] <= packetReg_payload_user[23 : 23];
      packetReg_rData_user[24 : 24] <= packetReg_payload_user[24 : 24];
      packetReg_rData_user[25 : 25] <= packetReg_payload_user[25 : 25];
      packetReg_rData_user[26 : 26] <= packetReg_payload_user[26 : 26];
      packetReg_rData_user[27 : 27] <= packetReg_payload_user[27 : 27];
      packetReg_rData_user[28 : 28] <= packetReg_payload_user[28 : 28];
      packetReg_rData_user[29 : 29] <= packetReg_payload_user[29 : 29];
      packetReg_rData_user[30 : 30] <= packetReg_payload_user[30 : 30];
      packetReg_rData_user[31 : 31] <= packetReg_payload_user[31 : 31];
    end
    if(packetReg_m2sPipe_ready) begin
      packetReg_m2sPipe_rData_data <= packetReg_m2sPipe_payload_data;
      packetReg_m2sPipe_rData_keep <= packetReg_m2sPipe_payload_keep;
      packetReg_m2sPipe_rData_last <= packetReg_m2sPipe_payload_last;
      packetReg_m2sPipe_rData_user[0 : 0] <= packetReg_m2sPipe_payload_user[0 : 0];
      packetReg_m2sPipe_rData_user[1 : 1] <= packetReg_m2sPipe_payload_user[1 : 1];
      packetReg_m2sPipe_rData_user[2 : 2] <= packetReg_m2sPipe_payload_user[2 : 2];
      packetReg_m2sPipe_rData_user[3 : 3] <= packetReg_m2sPipe_payload_user[3 : 3];
      packetReg_m2sPipe_rData_user[4 : 4] <= packetReg_m2sPipe_payload_user[4 : 4];
      packetReg_m2sPipe_rData_user[5 : 5] <= packetReg_m2sPipe_payload_user[5 : 5];
      packetReg_m2sPipe_rData_user[6 : 6] <= packetReg_m2sPipe_payload_user[6 : 6];
      packetReg_m2sPipe_rData_user[7 : 7] <= packetReg_m2sPipe_payload_user[7 : 7];
      packetReg_m2sPipe_rData_user[8 : 8] <= packetReg_m2sPipe_payload_user[8 : 8];
      packetReg_m2sPipe_rData_user[9 : 9] <= packetReg_m2sPipe_payload_user[9 : 9];
      packetReg_m2sPipe_rData_user[10 : 10] <= packetReg_m2sPipe_payload_user[10 : 10];
      packetReg_m2sPipe_rData_user[11 : 11] <= packetReg_m2sPipe_payload_user[11 : 11];
      packetReg_m2sPipe_rData_user[12 : 12] <= packetReg_m2sPipe_payload_user[12 : 12];
      packetReg_m2sPipe_rData_user[13 : 13] <= packetReg_m2sPipe_payload_user[13 : 13];
      packetReg_m2sPipe_rData_user[14 : 14] <= packetReg_m2sPipe_payload_user[14 : 14];
      packetReg_m2sPipe_rData_user[15 : 15] <= packetReg_m2sPipe_payload_user[15 : 15];
      packetReg_m2sPipe_rData_user[16 : 16] <= packetReg_m2sPipe_payload_user[16 : 16];
      packetReg_m2sPipe_rData_user[17 : 17] <= packetReg_m2sPipe_payload_user[17 : 17];
      packetReg_m2sPipe_rData_user[18 : 18] <= packetReg_m2sPipe_payload_user[18 : 18];
      packetReg_m2sPipe_rData_user[19 : 19] <= packetReg_m2sPipe_payload_user[19 : 19];
      packetReg_m2sPipe_rData_user[20 : 20] <= packetReg_m2sPipe_payload_user[20 : 20];
      packetReg_m2sPipe_rData_user[21 : 21] <= packetReg_m2sPipe_payload_user[21 : 21];
      packetReg_m2sPipe_rData_user[22 : 22] <= packetReg_m2sPipe_payload_user[22 : 22];
      packetReg_m2sPipe_rData_user[23 : 23] <= packetReg_m2sPipe_payload_user[23 : 23];
      packetReg_m2sPipe_rData_user[24 : 24] <= packetReg_m2sPipe_payload_user[24 : 24];
      packetReg_m2sPipe_rData_user[25 : 25] <= packetReg_m2sPipe_payload_user[25 : 25];
      packetReg_m2sPipe_rData_user[26 : 26] <= packetReg_m2sPipe_payload_user[26 : 26];
      packetReg_m2sPipe_rData_user[27 : 27] <= packetReg_m2sPipe_payload_user[27 : 27];
      packetReg_m2sPipe_rData_user[28 : 28] <= packetReg_m2sPipe_payload_user[28 : 28];
      packetReg_m2sPipe_rData_user[29 : 29] <= packetReg_m2sPipe_payload_user[29 : 29];
      packetReg_m2sPipe_rData_user[30 : 30] <= packetReg_m2sPipe_payload_user[30 : 30];
      packetReg_m2sPipe_rData_user[31 : 31] <= packetReg_m2sPipe_payload_user[31 : 31];
    end
    if(setMeta) begin
      ethHeaderExtractReg_0 <= ethHeaderExtract_0;
    end
    if(setMeta) begin
      ethHeaderExtractReg_1 <= ethHeaderExtract_1;
    end
    if(setMeta) begin
      ethHeaderExtractReg_2 <= ethHeaderExtract_2;
    end
    if(setMeta) begin
      ipv4HeaderExtractReg_0 <= ipv4HeaderExtract_0;
    end
    if(setMeta) begin
      ipv4HeaderExtractReg_1 <= ipv4HeaderExtract_1;
    end
    if(setMeta) begin
      ipv4HeaderExtractReg_2 <= ipv4HeaderExtract_2;
    end
    if(setMeta) begin
      ipv4HeaderExtractReg_3 <= ipv4HeaderExtract_3;
    end
    if(setMeta) begin
      ipv4HeaderExtractReg_4 <= ipv4HeaderExtract_4;
    end
    if(setMeta) begin
      ipv4HeaderExtractReg_5 <= ipv4HeaderExtract_5;
    end
    if(setMeta) begin
      ipv4HeaderExtractReg_6 <= ipv4HeaderExtract_6;
    end
    if(setMeta) begin
      ipv4HeaderExtractReg_7 <= ipv4HeaderExtract_7;
    end
    if(setMeta) begin
      ipv4HeaderExtractReg_8 <= ipv4HeaderExtract_8;
    end
    if(setMeta) begin
      ipv4HeaderExtractReg_9 <= ipv4HeaderExtract_9;
    end
    if(setMeta) begin
      ipv4HeaderExtractReg_10 <= ipv4HeaderExtract_10;
    end
    if(setMeta) begin
      ipv4HeaderExtractReg_11 <= ipv4HeaderExtract_11;
    end
    if(setMeta) begin
      ipv4HeaderExtractReg_12 <= ipv4HeaderExtract_12;
    end
    if(setMeta) begin
      udpHeaderExtractReg_0 <= udpHeaderExtract_0;
    end
    if(setMeta) begin
      udpHeaderExtractReg_1 <= udpHeaderExtract_1;
    end
    if(setMeta) begin
      udpHeaderExtractReg_2 <= udpHeaderExtract_2;
    end
    if(setMeta) begin
      udpHeaderExtractReg_3 <= udpHeaderExtract_3;
    end
    headerMatch_regNext <= headerMatch;
    if(packetStreamReg_thrown_ready) begin
      packetStreamReg_thrown_rData_data <= packetStreamReg_thrown_payload_data;
      packetStreamReg_thrown_rData_keep <= packetStreamReg_thrown_payload_keep;
      packetStreamReg_thrown_rData_last <= packetStreamReg_thrown_payload_last;
      packetStreamReg_thrown_rData_user[0 : 0] <= packetStreamReg_thrown_payload_user[0 : 0];
      packetStreamReg_thrown_rData_user[1 : 1] <= packetStreamReg_thrown_payload_user[1 : 1];
      packetStreamReg_thrown_rData_user[2 : 2] <= packetStreamReg_thrown_payload_user[2 : 2];
      packetStreamReg_thrown_rData_user[3 : 3] <= packetStreamReg_thrown_payload_user[3 : 3];
      packetStreamReg_thrown_rData_user[4 : 4] <= packetStreamReg_thrown_payload_user[4 : 4];
      packetStreamReg_thrown_rData_user[5 : 5] <= packetStreamReg_thrown_payload_user[5 : 5];
      packetStreamReg_thrown_rData_user[6 : 6] <= packetStreamReg_thrown_payload_user[6 : 6];
      packetStreamReg_thrown_rData_user[7 : 7] <= packetStreamReg_thrown_payload_user[7 : 7];
      packetStreamReg_thrown_rData_user[8 : 8] <= packetStreamReg_thrown_payload_user[8 : 8];
      packetStreamReg_thrown_rData_user[9 : 9] <= packetStreamReg_thrown_payload_user[9 : 9];
      packetStreamReg_thrown_rData_user[10 : 10] <= packetStreamReg_thrown_payload_user[10 : 10];
      packetStreamReg_thrown_rData_user[11 : 11] <= packetStreamReg_thrown_payload_user[11 : 11];
      packetStreamReg_thrown_rData_user[12 : 12] <= packetStreamReg_thrown_payload_user[12 : 12];
      packetStreamReg_thrown_rData_user[13 : 13] <= packetStreamReg_thrown_payload_user[13 : 13];
      packetStreamReg_thrown_rData_user[14 : 14] <= packetStreamReg_thrown_payload_user[14 : 14];
      packetStreamReg_thrown_rData_user[15 : 15] <= packetStreamReg_thrown_payload_user[15 : 15];
      packetStreamReg_thrown_rData_user[16 : 16] <= packetStreamReg_thrown_payload_user[16 : 16];
      packetStreamReg_thrown_rData_user[17 : 17] <= packetStreamReg_thrown_payload_user[17 : 17];
      packetStreamReg_thrown_rData_user[18 : 18] <= packetStreamReg_thrown_payload_user[18 : 18];
      packetStreamReg_thrown_rData_user[19 : 19] <= packetStreamReg_thrown_payload_user[19 : 19];
      packetStreamReg_thrown_rData_user[20 : 20] <= packetStreamReg_thrown_payload_user[20 : 20];
      packetStreamReg_thrown_rData_user[21 : 21] <= packetStreamReg_thrown_payload_user[21 : 21];
      packetStreamReg_thrown_rData_user[22 : 22] <= packetStreamReg_thrown_payload_user[22 : 22];
      packetStreamReg_thrown_rData_user[23 : 23] <= packetStreamReg_thrown_payload_user[23 : 23];
      packetStreamReg_thrown_rData_user[24 : 24] <= packetStreamReg_thrown_payload_user[24 : 24];
      packetStreamReg_thrown_rData_user[25 : 25] <= packetStreamReg_thrown_payload_user[25 : 25];
      packetStreamReg_thrown_rData_user[26 : 26] <= packetStreamReg_thrown_payload_user[26 : 26];
      packetStreamReg_thrown_rData_user[27 : 27] <= packetStreamReg_thrown_payload_user[27 : 27];
      packetStreamReg_thrown_rData_user[28 : 28] <= packetStreamReg_thrown_payload_user[28 : 28];
      packetStreamReg_thrown_rData_user[29 : 29] <= packetStreamReg_thrown_payload_user[29 : 29];
      packetStreamReg_thrown_rData_user[30 : 30] <= packetStreamReg_thrown_payload_user[30 : 30];
      packetStreamReg_thrown_rData_user[31 : 31] <= packetStreamReg_thrown_payload_user[31 : 31];
    end
    if(packetStreamReg_thrown_m2sPipe_ready) begin
      packetStreamReg_thrown_m2sPipe_rData_data <= packetStreamReg_thrown_m2sPipe_payload_data;
      packetStreamReg_thrown_m2sPipe_rData_keep <= packetStreamReg_thrown_m2sPipe_payload_keep;
      packetStreamReg_thrown_m2sPipe_rData_last <= packetStreamReg_thrown_m2sPipe_payload_last;
      packetStreamReg_thrown_m2sPipe_rData_user[0 : 0] <= packetStreamReg_thrown_m2sPipe_payload_user[0 : 0];
      packetStreamReg_thrown_m2sPipe_rData_user[1 : 1] <= packetStreamReg_thrown_m2sPipe_payload_user[1 : 1];
      packetStreamReg_thrown_m2sPipe_rData_user[2 : 2] <= packetStreamReg_thrown_m2sPipe_payload_user[2 : 2];
      packetStreamReg_thrown_m2sPipe_rData_user[3 : 3] <= packetStreamReg_thrown_m2sPipe_payload_user[3 : 3];
      packetStreamReg_thrown_m2sPipe_rData_user[4 : 4] <= packetStreamReg_thrown_m2sPipe_payload_user[4 : 4];
      packetStreamReg_thrown_m2sPipe_rData_user[5 : 5] <= packetStreamReg_thrown_m2sPipe_payload_user[5 : 5];
      packetStreamReg_thrown_m2sPipe_rData_user[6 : 6] <= packetStreamReg_thrown_m2sPipe_payload_user[6 : 6];
      packetStreamReg_thrown_m2sPipe_rData_user[7 : 7] <= packetStreamReg_thrown_m2sPipe_payload_user[7 : 7];
      packetStreamReg_thrown_m2sPipe_rData_user[8 : 8] <= packetStreamReg_thrown_m2sPipe_payload_user[8 : 8];
      packetStreamReg_thrown_m2sPipe_rData_user[9 : 9] <= packetStreamReg_thrown_m2sPipe_payload_user[9 : 9];
      packetStreamReg_thrown_m2sPipe_rData_user[10 : 10] <= packetStreamReg_thrown_m2sPipe_payload_user[10 : 10];
      packetStreamReg_thrown_m2sPipe_rData_user[11 : 11] <= packetStreamReg_thrown_m2sPipe_payload_user[11 : 11];
      packetStreamReg_thrown_m2sPipe_rData_user[12 : 12] <= packetStreamReg_thrown_m2sPipe_payload_user[12 : 12];
      packetStreamReg_thrown_m2sPipe_rData_user[13 : 13] <= packetStreamReg_thrown_m2sPipe_payload_user[13 : 13];
      packetStreamReg_thrown_m2sPipe_rData_user[14 : 14] <= packetStreamReg_thrown_m2sPipe_payload_user[14 : 14];
      packetStreamReg_thrown_m2sPipe_rData_user[15 : 15] <= packetStreamReg_thrown_m2sPipe_payload_user[15 : 15];
      packetStreamReg_thrown_m2sPipe_rData_user[16 : 16] <= packetStreamReg_thrown_m2sPipe_payload_user[16 : 16];
      packetStreamReg_thrown_m2sPipe_rData_user[17 : 17] <= packetStreamReg_thrown_m2sPipe_payload_user[17 : 17];
      packetStreamReg_thrown_m2sPipe_rData_user[18 : 18] <= packetStreamReg_thrown_m2sPipe_payload_user[18 : 18];
      packetStreamReg_thrown_m2sPipe_rData_user[19 : 19] <= packetStreamReg_thrown_m2sPipe_payload_user[19 : 19];
      packetStreamReg_thrown_m2sPipe_rData_user[20 : 20] <= packetStreamReg_thrown_m2sPipe_payload_user[20 : 20];
      packetStreamReg_thrown_m2sPipe_rData_user[21 : 21] <= packetStreamReg_thrown_m2sPipe_payload_user[21 : 21];
      packetStreamReg_thrown_m2sPipe_rData_user[22 : 22] <= packetStreamReg_thrown_m2sPipe_payload_user[22 : 22];
      packetStreamReg_thrown_m2sPipe_rData_user[23 : 23] <= packetStreamReg_thrown_m2sPipe_payload_user[23 : 23];
      packetStreamReg_thrown_m2sPipe_rData_user[24 : 24] <= packetStreamReg_thrown_m2sPipe_payload_user[24 : 24];
      packetStreamReg_thrown_m2sPipe_rData_user[25 : 25] <= packetStreamReg_thrown_m2sPipe_payload_user[25 : 25];
      packetStreamReg_thrown_m2sPipe_rData_user[26 : 26] <= packetStreamReg_thrown_m2sPipe_payload_user[26 : 26];
      packetStreamReg_thrown_m2sPipe_rData_user[27 : 27] <= packetStreamReg_thrown_m2sPipe_payload_user[27 : 27];
      packetStreamReg_thrown_m2sPipe_rData_user[28 : 28] <= packetStreamReg_thrown_m2sPipe_payload_user[28 : 28];
      packetStreamReg_thrown_m2sPipe_rData_user[29 : 29] <= packetStreamReg_thrown_m2sPipe_payload_user[29 : 29];
      packetStreamReg_thrown_m2sPipe_rData_user[30 : 30] <= packetStreamReg_thrown_m2sPipe_payload_user[30 : 30];
      packetStreamReg_thrown_m2sPipe_rData_user[31 : 31] <= packetStreamReg_thrown_m2sPipe_payload_user[31 : 31];
    end
    if(packetStream_thrown_ready) begin
      packetStream_thrown_rData_data <= packetStream_thrown_payload_data;
      packetStream_thrown_rData_keep <= packetStream_thrown_payload_keep;
      packetStream_thrown_rData_last <= packetStream_thrown_payload_last;
      packetStream_thrown_rData_user[0 : 0] <= packetStream_thrown_payload_user[0 : 0];
      packetStream_thrown_rData_user[1 : 1] <= packetStream_thrown_payload_user[1 : 1];
      packetStream_thrown_rData_user[2 : 2] <= packetStream_thrown_payload_user[2 : 2];
      packetStream_thrown_rData_user[3 : 3] <= packetStream_thrown_payload_user[3 : 3];
      packetStream_thrown_rData_user[4 : 4] <= packetStream_thrown_payload_user[4 : 4];
      packetStream_thrown_rData_user[5 : 5] <= packetStream_thrown_payload_user[5 : 5];
      packetStream_thrown_rData_user[6 : 6] <= packetStream_thrown_payload_user[6 : 6];
      packetStream_thrown_rData_user[7 : 7] <= packetStream_thrown_payload_user[7 : 7];
      packetStream_thrown_rData_user[8 : 8] <= packetStream_thrown_payload_user[8 : 8];
      packetStream_thrown_rData_user[9 : 9] <= packetStream_thrown_payload_user[9 : 9];
      packetStream_thrown_rData_user[10 : 10] <= packetStream_thrown_payload_user[10 : 10];
      packetStream_thrown_rData_user[11 : 11] <= packetStream_thrown_payload_user[11 : 11];
      packetStream_thrown_rData_user[12 : 12] <= packetStream_thrown_payload_user[12 : 12];
      packetStream_thrown_rData_user[13 : 13] <= packetStream_thrown_payload_user[13 : 13];
      packetStream_thrown_rData_user[14 : 14] <= packetStream_thrown_payload_user[14 : 14];
      packetStream_thrown_rData_user[15 : 15] <= packetStream_thrown_payload_user[15 : 15];
      packetStream_thrown_rData_user[16 : 16] <= packetStream_thrown_payload_user[16 : 16];
      packetStream_thrown_rData_user[17 : 17] <= packetStream_thrown_payload_user[17 : 17];
      packetStream_thrown_rData_user[18 : 18] <= packetStream_thrown_payload_user[18 : 18];
      packetStream_thrown_rData_user[19 : 19] <= packetStream_thrown_payload_user[19 : 19];
      packetStream_thrown_rData_user[20 : 20] <= packetStream_thrown_payload_user[20 : 20];
      packetStream_thrown_rData_user[21 : 21] <= packetStream_thrown_payload_user[21 : 21];
      packetStream_thrown_rData_user[22 : 22] <= packetStream_thrown_payload_user[22 : 22];
      packetStream_thrown_rData_user[23 : 23] <= packetStream_thrown_payload_user[23 : 23];
      packetStream_thrown_rData_user[24 : 24] <= packetStream_thrown_payload_user[24 : 24];
      packetStream_thrown_rData_user[25 : 25] <= packetStream_thrown_payload_user[25 : 25];
      packetStream_thrown_rData_user[26 : 26] <= packetStream_thrown_payload_user[26 : 26];
      packetStream_thrown_rData_user[27 : 27] <= packetStream_thrown_payload_user[27 : 27];
      packetStream_thrown_rData_user[28 : 28] <= packetStream_thrown_payload_user[28 : 28];
      packetStream_thrown_rData_user[29 : 29] <= packetStream_thrown_payload_user[29 : 29];
      packetStream_thrown_rData_user[30 : 30] <= packetStream_thrown_payload_user[30 : 30];
      packetStream_thrown_rData_user[31 : 31] <= packetStream_thrown_payload_user[31 : 31];
    end
    if(packetStream_thrown_m2sPipe_ready) begin
      packetStream_thrown_m2sPipe_rData_data <= packetStream_thrown_m2sPipe_payload_data;
      packetStream_thrown_m2sPipe_rData_keep <= packetStream_thrown_m2sPipe_payload_keep;
      packetStream_thrown_m2sPipe_rData_last <= packetStream_thrown_m2sPipe_payload_last;
      packetStream_thrown_m2sPipe_rData_user[0 : 0] <= packetStream_thrown_m2sPipe_payload_user[0 : 0];
      packetStream_thrown_m2sPipe_rData_user[1 : 1] <= packetStream_thrown_m2sPipe_payload_user[1 : 1];
      packetStream_thrown_m2sPipe_rData_user[2 : 2] <= packetStream_thrown_m2sPipe_payload_user[2 : 2];
      packetStream_thrown_m2sPipe_rData_user[3 : 3] <= packetStream_thrown_m2sPipe_payload_user[3 : 3];
      packetStream_thrown_m2sPipe_rData_user[4 : 4] <= packetStream_thrown_m2sPipe_payload_user[4 : 4];
      packetStream_thrown_m2sPipe_rData_user[5 : 5] <= packetStream_thrown_m2sPipe_payload_user[5 : 5];
      packetStream_thrown_m2sPipe_rData_user[6 : 6] <= packetStream_thrown_m2sPipe_payload_user[6 : 6];
      packetStream_thrown_m2sPipe_rData_user[7 : 7] <= packetStream_thrown_m2sPipe_payload_user[7 : 7];
      packetStream_thrown_m2sPipe_rData_user[8 : 8] <= packetStream_thrown_m2sPipe_payload_user[8 : 8];
      packetStream_thrown_m2sPipe_rData_user[9 : 9] <= packetStream_thrown_m2sPipe_payload_user[9 : 9];
      packetStream_thrown_m2sPipe_rData_user[10 : 10] <= packetStream_thrown_m2sPipe_payload_user[10 : 10];
      packetStream_thrown_m2sPipe_rData_user[11 : 11] <= packetStream_thrown_m2sPipe_payload_user[11 : 11];
      packetStream_thrown_m2sPipe_rData_user[12 : 12] <= packetStream_thrown_m2sPipe_payload_user[12 : 12];
      packetStream_thrown_m2sPipe_rData_user[13 : 13] <= packetStream_thrown_m2sPipe_payload_user[13 : 13];
      packetStream_thrown_m2sPipe_rData_user[14 : 14] <= packetStream_thrown_m2sPipe_payload_user[14 : 14];
      packetStream_thrown_m2sPipe_rData_user[15 : 15] <= packetStream_thrown_m2sPipe_payload_user[15 : 15];
      packetStream_thrown_m2sPipe_rData_user[16 : 16] <= packetStream_thrown_m2sPipe_payload_user[16 : 16];
      packetStream_thrown_m2sPipe_rData_user[17 : 17] <= packetStream_thrown_m2sPipe_payload_user[17 : 17];
      packetStream_thrown_m2sPipe_rData_user[18 : 18] <= packetStream_thrown_m2sPipe_payload_user[18 : 18];
      packetStream_thrown_m2sPipe_rData_user[19 : 19] <= packetStream_thrown_m2sPipe_payload_user[19 : 19];
      packetStream_thrown_m2sPipe_rData_user[20 : 20] <= packetStream_thrown_m2sPipe_payload_user[20 : 20];
      packetStream_thrown_m2sPipe_rData_user[21 : 21] <= packetStream_thrown_m2sPipe_payload_user[21 : 21];
      packetStream_thrown_m2sPipe_rData_user[22 : 22] <= packetStream_thrown_m2sPipe_payload_user[22 : 22];
      packetStream_thrown_m2sPipe_rData_user[23 : 23] <= packetStream_thrown_m2sPipe_payload_user[23 : 23];
      packetStream_thrown_m2sPipe_rData_user[24 : 24] <= packetStream_thrown_m2sPipe_payload_user[24 : 24];
      packetStream_thrown_m2sPipe_rData_user[25 : 25] <= packetStream_thrown_m2sPipe_payload_user[25 : 25];
      packetStream_thrown_m2sPipe_rData_user[26 : 26] <= packetStream_thrown_m2sPipe_payload_user[26 : 26];
      packetStream_thrown_m2sPipe_rData_user[27 : 27] <= packetStream_thrown_m2sPipe_payload_user[27 : 27];
      packetStream_thrown_m2sPipe_rData_user[28 : 28] <= packetStream_thrown_m2sPipe_payload_user[28 : 28];
      packetStream_thrown_m2sPipe_rData_user[29 : 29] <= packetStream_thrown_m2sPipe_payload_user[29 : 29];
      packetStream_thrown_m2sPipe_rData_user[30 : 30] <= packetStream_thrown_m2sPipe_payload_user[30 : 30];
      packetStream_thrown_m2sPipe_rData_user[31 : 31] <= packetStream_thrown_m2sPipe_payload_user[31 : 31];
    end
    if(_zz_dataStreamReg_ready_1) begin
      _zz_dataJoinStream_payload_1_data <= dataStreamReg_payload_data;
      _zz_dataJoinStream_payload_1_keep <= dataStreamReg_payload_keep;
      _zz_dataJoinStream_payload_1_last <= dataStreamReg_payload_last;
      _zz_dataJoinStream_payload_1_user_2[0 : 0] <= _zz_dataJoinStream_payload_1_user[0 : 0];
      _zz_dataJoinStream_payload_1_user_2[1 : 1] <= _zz_dataJoinStream_payload_1_user[1 : 1];
      _zz_dataJoinStream_payload_1_user_2[2 : 2] <= _zz_dataJoinStream_payload_1_user[2 : 2];
      _zz_dataJoinStream_payload_1_user_2[3 : 3] <= _zz_dataJoinStream_payload_1_user[3 : 3];
      _zz_dataJoinStream_payload_1_user_2[4 : 4] <= _zz_dataJoinStream_payload_1_user[4 : 4];
      _zz_dataJoinStream_payload_1_user_2[5 : 5] <= _zz_dataJoinStream_payload_1_user[5 : 5];
      _zz_dataJoinStream_payload_1_user_2[6 : 6] <= _zz_dataJoinStream_payload_1_user[6 : 6];
      _zz_dataJoinStream_payload_1_user_2[7 : 7] <= _zz_dataJoinStream_payload_1_user[7 : 7];
      _zz_dataJoinStream_payload_1_user_2[8 : 8] <= _zz_dataJoinStream_payload_1_user[8 : 8];
      _zz_dataJoinStream_payload_1_user_2[9 : 9] <= _zz_dataJoinStream_payload_1_user[9 : 9];
      _zz_dataJoinStream_payload_1_user_2[10 : 10] <= _zz_dataJoinStream_payload_1_user[10 : 10];
      _zz_dataJoinStream_payload_1_user_2[11 : 11] <= _zz_dataJoinStream_payload_1_user[11 : 11];
      _zz_dataJoinStream_payload_1_user_2[12 : 12] <= _zz_dataJoinStream_payload_1_user[12 : 12];
      _zz_dataJoinStream_payload_1_user_2[13 : 13] <= _zz_dataJoinStream_payload_1_user[13 : 13];
      _zz_dataJoinStream_payload_1_user_2[14 : 14] <= _zz_dataJoinStream_payload_1_user[14 : 14];
      _zz_dataJoinStream_payload_1_user_2[15 : 15] <= _zz_dataJoinStream_payload_1_user[15 : 15];
      _zz_dataJoinStream_payload_1_user_2[16 : 16] <= _zz_dataJoinStream_payload_1_user[16 : 16];
      _zz_dataJoinStream_payload_1_user_2[17 : 17] <= _zz_dataJoinStream_payload_1_user[17 : 17];
      _zz_dataJoinStream_payload_1_user_2[18 : 18] <= _zz_dataJoinStream_payload_1_user[18 : 18];
      _zz_dataJoinStream_payload_1_user_2[19 : 19] <= _zz_dataJoinStream_payload_1_user[19 : 19];
      _zz_dataJoinStream_payload_1_user_2[20 : 20] <= _zz_dataJoinStream_payload_1_user[20 : 20];
      _zz_dataJoinStream_payload_1_user_2[21 : 21] <= _zz_dataJoinStream_payload_1_user[21 : 21];
      _zz_dataJoinStream_payload_1_user_2[22 : 22] <= _zz_dataJoinStream_payload_1_user[22 : 22];
      _zz_dataJoinStream_payload_1_user_2[23 : 23] <= _zz_dataJoinStream_payload_1_user[23 : 23];
      _zz_dataJoinStream_payload_1_user_2[24 : 24] <= _zz_dataJoinStream_payload_1_user[24 : 24];
      _zz_dataJoinStream_payload_1_user_2[25 : 25] <= _zz_dataJoinStream_payload_1_user[25 : 25];
      _zz_dataJoinStream_payload_1_user_2[26 : 26] <= _zz_dataJoinStream_payload_1_user[26 : 26];
      _zz_dataJoinStream_payload_1_user_2[27 : 27] <= _zz_dataJoinStream_payload_1_user[27 : 27];
      _zz_dataJoinStream_payload_1_user_2[28 : 28] <= _zz_dataJoinStream_payload_1_user[28 : 28];
      _zz_dataJoinStream_payload_1_user_2[29 : 29] <= _zz_dataJoinStream_payload_1_user[29 : 29];
      _zz_dataJoinStream_payload_1_user_2[30 : 30] <= _zz_dataJoinStream_payload_1_user[30 : 30];
      _zz_dataJoinStream_payload_1_user_2[31 : 31] <= _zz_dataJoinStream_payload_1_user[31 : 31];
      _zz_dataJoinStream_payload_2_data_1 <= _zz_dataJoinStream_payload_2_data;
      _zz_dataJoinStream_payload_2_keep_1 <= _zz_dataJoinStream_payload_2_keep;
      _zz_dataJoinStream_payload_2_last_1 <= _zz_dataJoinStream_payload_2_last;
      _zz_dataJoinStream_payload_2_user_3[0 : 0] <= _zz_dataJoinStream_payload_2_user_1[0 : 0];
      _zz_dataJoinStream_payload_2_user_3[1 : 1] <= _zz_dataJoinStream_payload_2_user_1[1 : 1];
      _zz_dataJoinStream_payload_2_user_3[2 : 2] <= _zz_dataJoinStream_payload_2_user_1[2 : 2];
      _zz_dataJoinStream_payload_2_user_3[3 : 3] <= _zz_dataJoinStream_payload_2_user_1[3 : 3];
      _zz_dataJoinStream_payload_2_user_3[4 : 4] <= _zz_dataJoinStream_payload_2_user_1[4 : 4];
      _zz_dataJoinStream_payload_2_user_3[5 : 5] <= _zz_dataJoinStream_payload_2_user_1[5 : 5];
      _zz_dataJoinStream_payload_2_user_3[6 : 6] <= _zz_dataJoinStream_payload_2_user_1[6 : 6];
      _zz_dataJoinStream_payload_2_user_3[7 : 7] <= _zz_dataJoinStream_payload_2_user_1[7 : 7];
      _zz_dataJoinStream_payload_2_user_3[8 : 8] <= _zz_dataJoinStream_payload_2_user_1[8 : 8];
      _zz_dataJoinStream_payload_2_user_3[9 : 9] <= _zz_dataJoinStream_payload_2_user_1[9 : 9];
      _zz_dataJoinStream_payload_2_user_3[10 : 10] <= _zz_dataJoinStream_payload_2_user_1[10 : 10];
      _zz_dataJoinStream_payload_2_user_3[11 : 11] <= _zz_dataJoinStream_payload_2_user_1[11 : 11];
      _zz_dataJoinStream_payload_2_user_3[12 : 12] <= _zz_dataJoinStream_payload_2_user_1[12 : 12];
      _zz_dataJoinStream_payload_2_user_3[13 : 13] <= _zz_dataJoinStream_payload_2_user_1[13 : 13];
      _zz_dataJoinStream_payload_2_user_3[14 : 14] <= _zz_dataJoinStream_payload_2_user_1[14 : 14];
      _zz_dataJoinStream_payload_2_user_3[15 : 15] <= _zz_dataJoinStream_payload_2_user_1[15 : 15];
      _zz_dataJoinStream_payload_2_user_3[16 : 16] <= _zz_dataJoinStream_payload_2_user_1[16 : 16];
      _zz_dataJoinStream_payload_2_user_3[17 : 17] <= _zz_dataJoinStream_payload_2_user_1[17 : 17];
      _zz_dataJoinStream_payload_2_user_3[18 : 18] <= _zz_dataJoinStream_payload_2_user_1[18 : 18];
      _zz_dataJoinStream_payload_2_user_3[19 : 19] <= _zz_dataJoinStream_payload_2_user_1[19 : 19];
      _zz_dataJoinStream_payload_2_user_3[20 : 20] <= _zz_dataJoinStream_payload_2_user_1[20 : 20];
      _zz_dataJoinStream_payload_2_user_3[21 : 21] <= _zz_dataJoinStream_payload_2_user_1[21 : 21];
      _zz_dataJoinStream_payload_2_user_3[22 : 22] <= _zz_dataJoinStream_payload_2_user_1[22 : 22];
      _zz_dataJoinStream_payload_2_user_3[23 : 23] <= _zz_dataJoinStream_payload_2_user_1[23 : 23];
      _zz_dataJoinStream_payload_2_user_3[24 : 24] <= _zz_dataJoinStream_payload_2_user_1[24 : 24];
      _zz_dataJoinStream_payload_2_user_3[25 : 25] <= _zz_dataJoinStream_payload_2_user_1[25 : 25];
      _zz_dataJoinStream_payload_2_user_3[26 : 26] <= _zz_dataJoinStream_payload_2_user_1[26 : 26];
      _zz_dataJoinStream_payload_2_user_3[27 : 27] <= _zz_dataJoinStream_payload_2_user_1[27 : 27];
      _zz_dataJoinStream_payload_2_user_3[28 : 28] <= _zz_dataJoinStream_payload_2_user_1[28 : 28];
      _zz_dataJoinStream_payload_2_user_3[29 : 29] <= _zz_dataJoinStream_payload_2_user_1[29 : 29];
      _zz_dataJoinStream_payload_2_user_3[30 : 30] <= _zz_dataJoinStream_payload_2_user_1[30 : 30];
      _zz_dataJoinStream_payload_2_user_3[31 : 31] <= _zz_dataJoinStream_payload_2_user_1[31 : 31];
    end
    headerMatch_regNext_1 <= headerMatch;
    if(maskStage_ready) begin
      maskStage_rData_data <= maskStage_payload_data;
      maskStage_rData_keep <= maskStage_payload_keep;
      maskStage_rData_last <= maskStage_payload_last;
      maskStage_rData_user[0 : 0] <= maskStage_payload_user[0 : 0];
      maskStage_rData_user[1 : 1] <= maskStage_payload_user[1 : 1];
      maskStage_rData_user[2 : 2] <= maskStage_payload_user[2 : 2];
      maskStage_rData_user[3 : 3] <= maskStage_payload_user[3 : 3];
      maskStage_rData_user[4 : 4] <= maskStage_payload_user[4 : 4];
      maskStage_rData_user[5 : 5] <= maskStage_payload_user[5 : 5];
      maskStage_rData_user[6 : 6] <= maskStage_payload_user[6 : 6];
      maskStage_rData_user[7 : 7] <= maskStage_payload_user[7 : 7];
      maskStage_rData_user[8 : 8] <= maskStage_payload_user[8 : 8];
      maskStage_rData_user[9 : 9] <= maskStage_payload_user[9 : 9];
      maskStage_rData_user[10 : 10] <= maskStage_payload_user[10 : 10];
      maskStage_rData_user[11 : 11] <= maskStage_payload_user[11 : 11];
      maskStage_rData_user[12 : 12] <= maskStage_payload_user[12 : 12];
      maskStage_rData_user[13 : 13] <= maskStage_payload_user[13 : 13];
      maskStage_rData_user[14 : 14] <= maskStage_payload_user[14 : 14];
      maskStage_rData_user[15 : 15] <= maskStage_payload_user[15 : 15];
      maskStage_rData_user[16 : 16] <= maskStage_payload_user[16 : 16];
      maskStage_rData_user[17 : 17] <= maskStage_payload_user[17 : 17];
      maskStage_rData_user[18 : 18] <= maskStage_payload_user[18 : 18];
      maskStage_rData_user[19 : 19] <= maskStage_payload_user[19 : 19];
      maskStage_rData_user[20 : 20] <= maskStage_payload_user[20 : 20];
      maskStage_rData_user[21 : 21] <= maskStage_payload_user[21 : 21];
      maskStage_rData_user[22 : 22] <= maskStage_payload_user[22 : 22];
      maskStage_rData_user[23 : 23] <= maskStage_payload_user[23 : 23];
      maskStage_rData_user[24 : 24] <= maskStage_payload_user[24 : 24];
      maskStage_rData_user[25 : 25] <= maskStage_payload_user[25 : 25];
      maskStage_rData_user[26 : 26] <= maskStage_payload_user[26 : 26];
      maskStage_rData_user[27 : 27] <= maskStage_payload_user[27 : 27];
      maskStage_rData_user[28 : 28] <= maskStage_payload_user[28 : 28];
      maskStage_rData_user[29 : 29] <= maskStage_payload_user[29 : 29];
      maskStage_rData_user[30 : 30] <= maskStage_payload_user[30 : 30];
      maskStage_rData_user[31 : 31] <= maskStage_payload_user[31 : 31];
    end
    if(maskStage_m2sPipe_ready) begin
      maskStage_m2sPipe_rData_data <= maskStage_m2sPipe_payload_data;
      maskStage_m2sPipe_rData_keep <= maskStage_m2sPipe_payload_keep;
      maskStage_m2sPipe_rData_last <= maskStage_m2sPipe_payload_last;
      maskStage_m2sPipe_rData_user[0 : 0] <= maskStage_m2sPipe_payload_user[0 : 0];
      maskStage_m2sPipe_rData_user[1 : 1] <= maskStage_m2sPipe_payload_user[1 : 1];
      maskStage_m2sPipe_rData_user[2 : 2] <= maskStage_m2sPipe_payload_user[2 : 2];
      maskStage_m2sPipe_rData_user[3 : 3] <= maskStage_m2sPipe_payload_user[3 : 3];
      maskStage_m2sPipe_rData_user[4 : 4] <= maskStage_m2sPipe_payload_user[4 : 4];
      maskStage_m2sPipe_rData_user[5 : 5] <= maskStage_m2sPipe_payload_user[5 : 5];
      maskStage_m2sPipe_rData_user[6 : 6] <= maskStage_m2sPipe_payload_user[6 : 6];
      maskStage_m2sPipe_rData_user[7 : 7] <= maskStage_m2sPipe_payload_user[7 : 7];
      maskStage_m2sPipe_rData_user[8 : 8] <= maskStage_m2sPipe_payload_user[8 : 8];
      maskStage_m2sPipe_rData_user[9 : 9] <= maskStage_m2sPipe_payload_user[9 : 9];
      maskStage_m2sPipe_rData_user[10 : 10] <= maskStage_m2sPipe_payload_user[10 : 10];
      maskStage_m2sPipe_rData_user[11 : 11] <= maskStage_m2sPipe_payload_user[11 : 11];
      maskStage_m2sPipe_rData_user[12 : 12] <= maskStage_m2sPipe_payload_user[12 : 12];
      maskStage_m2sPipe_rData_user[13 : 13] <= maskStage_m2sPipe_payload_user[13 : 13];
      maskStage_m2sPipe_rData_user[14 : 14] <= maskStage_m2sPipe_payload_user[14 : 14];
      maskStage_m2sPipe_rData_user[15 : 15] <= maskStage_m2sPipe_payload_user[15 : 15];
      maskStage_m2sPipe_rData_user[16 : 16] <= maskStage_m2sPipe_payload_user[16 : 16];
      maskStage_m2sPipe_rData_user[17 : 17] <= maskStage_m2sPipe_payload_user[17 : 17];
      maskStage_m2sPipe_rData_user[18 : 18] <= maskStage_m2sPipe_payload_user[18 : 18];
      maskStage_m2sPipe_rData_user[19 : 19] <= maskStage_m2sPipe_payload_user[19 : 19];
      maskStage_m2sPipe_rData_user[20 : 20] <= maskStage_m2sPipe_payload_user[20 : 20];
      maskStage_m2sPipe_rData_user[21 : 21] <= maskStage_m2sPipe_payload_user[21 : 21];
      maskStage_m2sPipe_rData_user[22 : 22] <= maskStage_m2sPipe_payload_user[22 : 22];
      maskStage_m2sPipe_rData_user[23 : 23] <= maskStage_m2sPipe_payload_user[23 : 23];
      maskStage_m2sPipe_rData_user[24 : 24] <= maskStage_m2sPipe_payload_user[24 : 24];
      maskStage_m2sPipe_rData_user[25 : 25] <= maskStage_m2sPipe_payload_user[25 : 25];
      maskStage_m2sPipe_rData_user[26 : 26] <= maskStage_m2sPipe_payload_user[26 : 26];
      maskStage_m2sPipe_rData_user[27 : 27] <= maskStage_m2sPipe_payload_user[27 : 27];
      maskStage_m2sPipe_rData_user[28 : 28] <= maskStage_m2sPipe_payload_user[28 : 28];
      maskStage_m2sPipe_rData_user[29 : 29] <= maskStage_m2sPipe_payload_user[29 : 29];
      maskStage_m2sPipe_rData_user[30 : 30] <= maskStage_m2sPipe_payload_user[30 : 30];
      maskStage_m2sPipe_rData_user[31 : 31] <= maskStage_m2sPipe_payload_user[31 : 31];
    end
  end


endmodule

module StreamFifo (
  input               io_push_valid,
  output              io_push_ready,
  input      [255:0]  io_push_payload_data,
  input      [31:0]   io_push_payload_keep,
  input               io_push_payload_last,
  input      [31:0]   io_push_payload_user,
  output              io_pop_valid,
  input               io_pop_ready,
  output     [255:0]  io_pop_payload_data,
  output     [31:0]   io_pop_payload_keep,
  output              io_pop_payload_last,
  output reg [31:0]   io_pop_payload_user,
  input               io_flush,
  output     [8:0]    io_occupancy,
  output     [8:0]    io_availability,
  input               clk,
  input               reset
);

  reg        [320:0]  _zz_logic_ram_port0;
  wire       [7:0]    _zz_logic_pushPtr_valueNext;
  wire       [0:0]    _zz_logic_pushPtr_valueNext_1;
  wire       [7:0]    _zz_logic_popPtr_valueNext;
  wire       [0:0]    _zz_logic_popPtr_valueNext_1;
  wire                _zz_logic_ram_port;
  wire                _zz__zz_io_pop_payload_data;
  wire       [320:0]  _zz_logic_ram_port_1;
  wire       [7:0]    _zz_io_availability;
  reg                 _zz_1;
  reg                 logic_pushPtr_willIncrement;
  reg                 logic_pushPtr_willClear;
  reg        [7:0]    logic_pushPtr_valueNext;
  reg        [7:0]    logic_pushPtr_value;
  wire                logic_pushPtr_willOverflowIfInc;
  wire                logic_pushPtr_willOverflow;
  reg                 logic_popPtr_willIncrement;
  reg                 logic_popPtr_willClear;
  reg        [7:0]    logic_popPtr_valueNext;
  reg        [7:0]    logic_popPtr_value;
  wire                logic_popPtr_willOverflowIfInc;
  wire                logic_popPtr_willOverflow;
  wire                logic_ptrMatch;
  reg                 logic_risingOccupancy;
  wire                logic_pushing;
  wire                logic_popping;
  wire                logic_empty;
  wire                logic_full;
  reg                 _zz_io_pop_valid;
  wire       [31:0]   _zz_io_pop_payload_user;
  wire       [320:0]  _zz_io_pop_payload_data;
  wire                when_Stream_l1078;
  wire       [7:0]    logic_ptrDif;
  reg [320:0] logic_ram [0:255];

  assign _zz_logic_pushPtr_valueNext_1 = logic_pushPtr_willIncrement;
  assign _zz_logic_pushPtr_valueNext = {7'd0, _zz_logic_pushPtr_valueNext_1};
  assign _zz_logic_popPtr_valueNext_1 = logic_popPtr_willIncrement;
  assign _zz_logic_popPtr_valueNext = {7'd0, _zz_logic_popPtr_valueNext_1};
  assign _zz_io_availability = (logic_popPtr_value - logic_pushPtr_value);
  assign _zz__zz_io_pop_payload_data = 1'b1;
  assign _zz_logic_ram_port_1 = {io_push_payload_user,{io_push_payload_last,{io_push_payload_keep,io_push_payload_data}}};
  always @(posedge clk) begin
    if(_zz__zz_io_pop_payload_data) begin
      _zz_logic_ram_port0 <= logic_ram[logic_popPtr_valueNext];
    end
  end

  always @(posedge clk) begin
    if(_zz_1) begin
      logic_ram[logic_pushPtr_value] <= _zz_logic_ram_port_1;
    end
  end

  always @(*) begin
    _zz_1 = 1'b0;
    if(logic_pushing) begin
      _zz_1 = 1'b1;
    end
  end

  always @(*) begin
    logic_pushPtr_willIncrement = 1'b0;
    if(logic_pushing) begin
      logic_pushPtr_willIncrement = 1'b1;
    end
  end

  always @(*) begin
    logic_pushPtr_willClear = 1'b0;
    if(io_flush) begin
      logic_pushPtr_willClear = 1'b1;
    end
  end

  assign logic_pushPtr_willOverflowIfInc = (logic_pushPtr_value == 8'hff);
  assign logic_pushPtr_willOverflow = (logic_pushPtr_willOverflowIfInc && logic_pushPtr_willIncrement);
  always @(*) begin
    logic_pushPtr_valueNext = (logic_pushPtr_value + _zz_logic_pushPtr_valueNext);
    if(logic_pushPtr_willClear) begin
      logic_pushPtr_valueNext = 8'h0;
    end
  end

  always @(*) begin
    logic_popPtr_willIncrement = 1'b0;
    if(logic_popping) begin
      logic_popPtr_willIncrement = 1'b1;
    end
  end

  always @(*) begin
    logic_popPtr_willClear = 1'b0;
    if(io_flush) begin
      logic_popPtr_willClear = 1'b1;
    end
  end

  assign logic_popPtr_willOverflowIfInc = (logic_popPtr_value == 8'hff);
  assign logic_popPtr_willOverflow = (logic_popPtr_willOverflowIfInc && logic_popPtr_willIncrement);
  always @(*) begin
    logic_popPtr_valueNext = (logic_popPtr_value + _zz_logic_popPtr_valueNext);
    if(logic_popPtr_willClear) begin
      logic_popPtr_valueNext = 8'h0;
    end
  end

  assign logic_ptrMatch = (logic_pushPtr_value == logic_popPtr_value);
  assign logic_pushing = (io_push_valid && io_push_ready);
  assign logic_popping = (io_pop_valid && io_pop_ready);
  assign logic_empty = (logic_ptrMatch && (! logic_risingOccupancy));
  assign logic_full = (logic_ptrMatch && logic_risingOccupancy);
  assign io_push_ready = (! logic_full);
  assign io_pop_valid = ((! logic_empty) && (! (_zz_io_pop_valid && (! logic_full))));
  assign _zz_io_pop_payload_data = _zz_logic_ram_port0;
  assign _zz_io_pop_payload_user = _zz_io_pop_payload_data[320 : 289];
  assign io_pop_payload_data = _zz_io_pop_payload_data[255 : 0];
  assign io_pop_payload_keep = _zz_io_pop_payload_data[287 : 256];
  assign io_pop_payload_last = _zz_io_pop_payload_data[288];
  always @(*) begin
    io_pop_payload_user[0 : 0] = _zz_io_pop_payload_user[0 : 0];
    io_pop_payload_user[1 : 1] = _zz_io_pop_payload_user[1 : 1];
    io_pop_payload_user[2 : 2] = _zz_io_pop_payload_user[2 : 2];
    io_pop_payload_user[3 : 3] = _zz_io_pop_payload_user[3 : 3];
    io_pop_payload_user[4 : 4] = _zz_io_pop_payload_user[4 : 4];
    io_pop_payload_user[5 : 5] = _zz_io_pop_payload_user[5 : 5];
    io_pop_payload_user[6 : 6] = _zz_io_pop_payload_user[6 : 6];
    io_pop_payload_user[7 : 7] = _zz_io_pop_payload_user[7 : 7];
    io_pop_payload_user[8 : 8] = _zz_io_pop_payload_user[8 : 8];
    io_pop_payload_user[9 : 9] = _zz_io_pop_payload_user[9 : 9];
    io_pop_payload_user[10 : 10] = _zz_io_pop_payload_user[10 : 10];
    io_pop_payload_user[11 : 11] = _zz_io_pop_payload_user[11 : 11];
    io_pop_payload_user[12 : 12] = _zz_io_pop_payload_user[12 : 12];
    io_pop_payload_user[13 : 13] = _zz_io_pop_payload_user[13 : 13];
    io_pop_payload_user[14 : 14] = _zz_io_pop_payload_user[14 : 14];
    io_pop_payload_user[15 : 15] = _zz_io_pop_payload_user[15 : 15];
    io_pop_payload_user[16 : 16] = _zz_io_pop_payload_user[16 : 16];
    io_pop_payload_user[17 : 17] = _zz_io_pop_payload_user[17 : 17];
    io_pop_payload_user[18 : 18] = _zz_io_pop_payload_user[18 : 18];
    io_pop_payload_user[19 : 19] = _zz_io_pop_payload_user[19 : 19];
    io_pop_payload_user[20 : 20] = _zz_io_pop_payload_user[20 : 20];
    io_pop_payload_user[21 : 21] = _zz_io_pop_payload_user[21 : 21];
    io_pop_payload_user[22 : 22] = _zz_io_pop_payload_user[22 : 22];
    io_pop_payload_user[23 : 23] = _zz_io_pop_payload_user[23 : 23];
    io_pop_payload_user[24 : 24] = _zz_io_pop_payload_user[24 : 24];
    io_pop_payload_user[25 : 25] = _zz_io_pop_payload_user[25 : 25];
    io_pop_payload_user[26 : 26] = _zz_io_pop_payload_user[26 : 26];
    io_pop_payload_user[27 : 27] = _zz_io_pop_payload_user[27 : 27];
    io_pop_payload_user[28 : 28] = _zz_io_pop_payload_user[28 : 28];
    io_pop_payload_user[29 : 29] = _zz_io_pop_payload_user[29 : 29];
    io_pop_payload_user[30 : 30] = _zz_io_pop_payload_user[30 : 30];
    io_pop_payload_user[31 : 31] = _zz_io_pop_payload_user[31 : 31];
  end

  assign when_Stream_l1078 = (logic_pushing != logic_popping);
  assign logic_ptrDif = (logic_pushPtr_value - logic_popPtr_value);
  assign io_occupancy = {(logic_risingOccupancy && logic_ptrMatch),logic_ptrDif};
  assign io_availability = {((! logic_risingOccupancy) && logic_ptrMatch),_zz_io_availability};
  always @(posedge clk or posedge reset) begin
    if(reset) begin
      logic_pushPtr_value <= 8'h0;
      logic_popPtr_value <= 8'h0;
      logic_risingOccupancy <= 1'b0;
      _zz_io_pop_valid <= 1'b0;
    end else begin
      logic_pushPtr_value <= logic_pushPtr_valueNext;
      logic_popPtr_value <= logic_popPtr_valueNext;
      _zz_io_pop_valid <= (logic_popPtr_valueNext == logic_pushPtr_value);
      if(when_Stream_l1078) begin
        logic_risingOccupancy <= logic_pushing;
      end
      if(io_flush) begin
        logic_risingOccupancy <= 1'b0;
      end
    end
  end


endmodule

module StreamTransactionCounter (
  input               io_ctrlFire,
  input               io_targetFire,
  input      [5:0]    io_count,
  output              io_working,
  output              io_last,
  output              io_done,
  output     [5:0]    io_value,
  input               clk,
  input               reset
);

  wire       [5:0]    _zz_counter_valueNext;
  wire       [0:0]    _zz_counter_valueNext_1;
  reg        [5:0]    countReg;
  reg                 counter_willIncrement;
  reg                 counter_willClear;
  reg        [5:0]    counter_valueNext;
  reg        [5:0]    counter_value;
  wire                counter_willOverflowIfInc;
  wire                counter_willOverflow;
  wire       [5:0]    expected;
  wire                lastOne;
  reg                 running;
  wire                done;
  wire                doneWithFire;
  wire                when_Stream_l1776;

  assign _zz_counter_valueNext_1 = counter_willIncrement;
  assign _zz_counter_valueNext = {5'd0, _zz_counter_valueNext_1};
  always @(*) begin
    counter_willIncrement = 1'b0;
    if(!done) begin
      if(io_targetFire) begin
        counter_willIncrement = 1'b1;
      end
    end
  end

  always @(*) begin
    counter_willClear = 1'b0;
    if(done) begin
      counter_willClear = 1'b1;
    end
  end

  assign counter_willOverflowIfInc = (counter_value == 6'h3f);
  assign counter_willOverflow = (counter_willOverflowIfInc && counter_willIncrement);
  always @(*) begin
    counter_valueNext = (counter_value + _zz_counter_valueNext);
    if(counter_willClear) begin
      counter_valueNext = 6'h0;
    end
  end

  assign expected = countReg;
  assign lastOne = (counter_value == expected);
  assign done = (lastOne && io_targetFire);
  assign doneWithFire = 1'b1;
  assign when_Stream_l1776 = (done && io_ctrlFire);
  assign io_working = running;
  assign io_last = lastOne;
  assign io_done = (lastOne && io_targetFire);
  assign io_value = counter_value;
  always @(posedge clk) begin
    if(io_ctrlFire) begin
      countReg <= io_count;
    end
  end

  always @(posedge clk or posedge reset) begin
    if(reset) begin
      counter_value <= 6'h0;
      running <= 1'b0;
    end else begin
      counter_value <= counter_valueNext;
      if(when_Stream_l1776) begin
        running <= doneWithFire;
      end else begin
        if(io_ctrlFire) begin
          running <= 1'b1;
        end else begin
          if(done) begin
            running <= 1'b0;
          end
        end
      end
    end
  end


endmodule
