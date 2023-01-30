// Generator : SpinalHDL v1.7.1    git head : 0444bb76ab1d6e19f0ec46bc03c4769776deb7d5
// Component : TxTop
// Git hash  : ad1b4551b969650a2c4cc6464eab127a247ff4cf
// 
// @Author : Jinyuan Huang (Jerry) jjyy.huang@gmail.com
// @Create : Thu Jan 26 19:44:43 UTC 2023

`timescale 1ns/1ps

module TxTop (
  input               io_metaIn_valid,
  output              io_metaIn_ready,
  input      [11:0]   io_metaIn_payload_dataLen,
  input      [47:0]   io_metaIn_payload_dstMacAddr,
  input      [31:0]   io_metaIn_payload_dstIpAddr,
  input      [47:0]   io_metaIn_payload_srcMacAddr,
  input      [31:0]   io_metaIn_payload_srcIpAddr,
  input      [15:0]   io_metaIn_payload_dstPort,
  input      [15:0]   io_metaIn_payload_srcPort,
  input               io_dataAxisIn_valid,
  output              io_dataAxisIn_ready,
  input      [255:0]  io_dataAxisIn_payload_data,
  input      [31:0]   io_dataAxisIn_payload_keep,
  input               io_dataAxisIn_payload_last,
  input      [31:0]   io_dataAxisIn_payload_user,
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
  reg        [31:0]   headerGenerator_1_io_headerAxisOut_fifo_io_push_payload_user;
  reg        [31:0]   io_dataAxisIn_fifo_io_pop_fork_io_input_payload_user;
  reg                 io_dataAxisIn_fifo_io_pop_fork_io_outputs_0_ready;
  wire                io_dataAxisIn_fifo_io_pop_fork_io_outputs_1_ready;
  reg        [31:0]   streamMux_1_io_inputs_0_payload_user;
  reg        [31:0]   streamMux_1_io_inputs_1_payload_user;
  wire                streamMux_1_io_output_ready;
  wire                io_dataAxisIn_fifo_io_push_ready;
  wire                io_dataAxisIn_fifo_io_pop_valid;
  wire       [255:0]  io_dataAxisIn_fifo_io_pop_payload_data;
  wire       [31:0]   io_dataAxisIn_fifo_io_pop_payload_keep;
  wire                io_dataAxisIn_fifo_io_pop_payload_last;
  wire       [31:0]   io_dataAxisIn_fifo_io_pop_payload_user;
  wire       [8:0]    io_dataAxisIn_fifo_io_occupancy;
  wire       [8:0]    io_dataAxisIn_fifo_io_availability;
  wire                io_metaIn_fifo_io_push_ready;
  wire                io_metaIn_fifo_io_pop_valid;
  wire       [11:0]   io_metaIn_fifo_io_pop_payload_dataLen;
  wire       [47:0]   io_metaIn_fifo_io_pop_payload_dstMacAddr;
  wire       [31:0]   io_metaIn_fifo_io_pop_payload_dstIpAddr;
  wire       [47:0]   io_metaIn_fifo_io_pop_payload_srcMacAddr;
  wire       [31:0]   io_metaIn_fifo_io_pop_payload_srcIpAddr;
  wire       [15:0]   io_metaIn_fifo_io_pop_payload_dstPort;
  wire       [15:0]   io_metaIn_fifo_io_pop_payload_srcPort;
  wire       [2:0]    io_metaIn_fifo_io_occupancy;
  wire       [2:0]    io_metaIn_fifo_io_availability;
  wire                headerGenerator_1_io_metaIn_ready;
  wire                headerGenerator_1_io_headerAxisOut_valid;
  wire       [255:0]  headerGenerator_1_io_headerAxisOut_payload_data;
  wire       [31:0]   headerGenerator_1_io_headerAxisOut_payload_keep;
  wire                headerGenerator_1_io_headerAxisOut_payload_last;
  wire       [31:0]   headerGenerator_1_io_headerAxisOut_payload_user;
  wire                headerGenerator_1_io_headerAxisOut_fifo_io_push_ready;
  wire                headerGenerator_1_io_headerAxisOut_fifo_io_pop_valid;
  wire       [255:0]  headerGenerator_1_io_headerAxisOut_fifo_io_pop_payload_data;
  wire       [31:0]   headerGenerator_1_io_headerAxisOut_fifo_io_pop_payload_keep;
  wire                headerGenerator_1_io_headerAxisOut_fifo_io_pop_payload_last;
  wire       [31:0]   headerGenerator_1_io_headerAxisOut_fifo_io_pop_payload_user;
  wire       [4:0]    headerGenerator_1_io_headerAxisOut_fifo_io_occupancy;
  wire       [4:0]    headerGenerator_1_io_headerAxisOut_fifo_io_availability;
  wire                io_dataAxisIn_fifo_io_pop_fork_io_input_ready;
  wire                io_dataAxisIn_fifo_io_pop_fork_io_outputs_0_valid;
  wire       [255:0]  io_dataAxisIn_fifo_io_pop_fork_io_outputs_0_payload_data;
  wire       [31:0]   io_dataAxisIn_fifo_io_pop_fork_io_outputs_0_payload_keep;
  wire                io_dataAxisIn_fifo_io_pop_fork_io_outputs_0_payload_last;
  wire       [31:0]   io_dataAxisIn_fifo_io_pop_fork_io_outputs_0_payload_user;
  wire                io_dataAxisIn_fifo_io_pop_fork_io_outputs_1_valid;
  wire       [255:0]  io_dataAxisIn_fifo_io_pop_fork_io_outputs_1_payload_data;
  wire       [31:0]   io_dataAxisIn_fifo_io_pop_fork_io_outputs_1_payload_keep;
  wire                io_dataAxisIn_fifo_io_pop_fork_io_outputs_1_payload_last;
  wire       [31:0]   io_dataAxisIn_fifo_io_pop_fork_io_outputs_1_payload_user;
  wire                streamMux_1_io_inputs_0_ready;
  wire                streamMux_1_io_inputs_1_ready;
  wire                streamMux_1_io_output_valid;
  wire       [255:0]  streamMux_1_io_output_payload_data;
  wire       [31:0]   streamMux_1_io_output_payload_keep;
  wire                streamMux_1_io_output_payload_last;
  wire       [31:0]   streamMux_1_io_output_payload_user;
  wire                transactionCounter_io_working;
  wire                transactionCounter_io_last;
  wire                transactionCounter_io_done;
  wire       [5:0]    transactionCounter_io_value;
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
  wire                dataBufferedReg_valid;
  wire                dataBufferedReg_ready;
  wire       [255:0]  dataBufferedReg_payload_data;
  wire       [31:0]   dataBufferedReg_payload_keep;
  wire                dataBufferedReg_payload_last;
  reg        [31:0]   dataBufferedReg_payload_user;
  reg                 io_dataAxisIn_fifo_io_pop_fork_io_outputs_0_rValid;
  reg        [255:0]  io_dataAxisIn_fifo_io_pop_fork_io_outputs_0_rData_data;
  reg        [31:0]   io_dataAxisIn_fifo_io_pop_fork_io_outputs_0_rData_keep;
  reg                 io_dataAxisIn_fifo_io_pop_fork_io_outputs_0_rData_last;
  reg        [31:0]   io_dataAxisIn_fifo_io_pop_fork_io_outputs_0_rData_user;
  wire                when_Stream_l368;
  reg        [0:0]    streamMuxReg;
  reg                 streamJoinReg0;
  reg                 streamJoinReg1;
  wire                invalidData;
  wire                streamMux_1_io_output_s2mPipe_valid;
  reg                 streamMux_1_io_output_s2mPipe_ready;
  wire       [255:0]  streamMux_1_io_output_s2mPipe_payload_data;
  wire       [31:0]   streamMux_1_io_output_s2mPipe_payload_keep;
  wire                streamMux_1_io_output_s2mPipe_payload_last;
  reg        [31:0]   streamMux_1_io_output_s2mPipe_payload_user;
  reg                 streamMux_1_io_output_rValid;
  reg        [255:0]  streamMux_1_io_output_rData_data;
  reg        [31:0]   streamMux_1_io_output_rData_keep;
  reg                 streamMux_1_io_output_rData_last;
  reg        [31:0]   streamMux_1_io_output_rData_user;
  wire       [31:0]   _zz_payload_user;
  reg                 selectedStream_valid;
  wire                selectedStream_ready;
  wire       [255:0]  selectedStream_payload_data;
  wire       [31:0]   selectedStream_payload_keep;
  wire                selectedStream_payload_last;
  reg        [31:0]   selectedStream_payload_user;
  reg        [255:0]  _zz_joinedStream_payload_2_data;
  reg        [31:0]   _zz_joinedStream_payload_2_keep;
  reg                 _zz_joinedStream_payload_2_last;
  reg        [31:0]   _zz_joinedStream_payload_2_user;
  wire                when_StreamUtils_l26;
  wire                when_StreamUtils_l26_1;
  wire                when_StreamUtils_l26_2;
  wire                when_StreamUtils_l26_3;
  wire                _zz_selectedStream_ready;
  reg                 _zz_selectedStream_ready_1;
  reg        [31:0]   _zz_joinedStream_payload_1_user;
  reg        [31:0]   _zz_joinedStream_payload_2_user_1;
  wire                joinedStream_valid;
  wire                joinedStream_ready;
  wire       [255:0]  joinedStream_payload_1_data;
  wire       [31:0]   joinedStream_payload_1_keep;
  wire                joinedStream_payload_1_last;
  reg        [31:0]   joinedStream_payload_1_user;
  wire       [255:0]  joinedStream_payload_2_data;
  wire       [31:0]   joinedStream_payload_2_keep;
  wire                joinedStream_payload_2_last;
  reg        [31:0]   joinedStream_payload_2_user;
  reg                 _zz_joinedStream_valid;
  reg        [255:0]  _zz_joinedStream_payload_1_data;
  reg        [31:0]   _zz_joinedStream_payload_1_keep;
  reg                 _zz_joinedStream_payload_1_last;
  reg        [31:0]   _zz_joinedStream_payload_1_user_1;
  reg        [255:0]  _zz_joinedStream_payload_2_data_1;
  reg        [31:0]   _zz_joinedStream_payload_2_keep_1;
  reg                 _zz_joinedStream_payload_2_last_1;
  reg        [31:0]   _zz_joinedStream_payload_2_user_2;
  wire                when_Stream_l368_1;
  wire                io_dataAxisIn_fifo_io_pop_fork_io_outputs_1_fire;
  wire                when_UDPTx_l64;
  wire                selectedStream_fire;
  wire                when_UDPTx_l66;
  wire                headerGenerator_1_io_headerAxisOut_fifo_io_pop_fire;
  wire                when_UDPTx_l70;
  wire                dataBufferedReg_fire;
  wire                when_UDPTx_l72;
  wire                io_dataAxisIn_fifo_io_pop_fork_io_outputs_1_fire_1;
  wire                when_UDPTx_l76;
  wire                selectedStream_fire_1;
  wire                when_UDPTx_l78;
  reg        [31:0]   maskReg;
  reg        [4:0]    shiftLenReg;
  wire       [5:0]    packetLen;
  wire                maskStage_valid;
  reg                 maskStage_ready;
  wire       [255:0]  maskStage_payload_data;
  wire       [31:0]   maskStage_payload_keep;
  wire                maskStage_payload_last;
  wire       [31:0]   maskStage_payload_user;
  wire                isUserCmd;
  wire                selectedStream_fire_2;
  wire                cntTrigger;
  wire                selectedStream_fire_3;
  wire       [4:0]    switch_Utils_l58;
  reg        [31:0]   _zz_maskReg;
  reg        [31:0]   _zz_maskReg_1;
  reg        [31:0]   _zz_maskReg_2;
  reg        [31:0]   _zz_maskReg_3;
  reg        [31:0]   _zz_maskReg_4;
  reg        [31:0]   _zz_maskReg_5;
  reg        [31:0]   _zz_maskReg_6;
  reg        [31:0]   _zz_maskReg_7;
  reg        [31:0]   _zz_maskReg_8;
  reg        [31:0]   _zz_maskReg_9;
  reg        [31:0]   _zz_maskReg_10;
  reg        [31:0]   _zz_maskReg_11;
  reg        [31:0]   _zz_maskReg_12;
  reg        [31:0]   _zz_maskReg_13;
  reg        [31:0]   _zz_maskReg_14;
  reg        [31:0]   _zz_maskReg_15;
  reg        [31:0]   _zz_maskReg_16;
  reg        [31:0]   _zz_maskReg_17;
  reg        [31:0]   _zz_maskReg_18;
  reg        [31:0]   _zz_maskReg_19;
  reg        [31:0]   _zz_maskReg_20;
  reg        [31:0]   _zz_maskReg_21;
  reg        [31:0]   _zz_maskReg_22;
  reg        [31:0]   _zz_maskReg_23;
  reg        [31:0]   _zz_maskReg_24;
  reg        [31:0]   _zz_maskReg_25;
  reg        [31:0]   _zz_maskReg_26;
  reg        [31:0]   _zz_maskReg_27;
  reg        [31:0]   _zz_maskReg_28;
  reg        [31:0]   _zz_maskReg_29;
  reg        [31:0]   _zz_maskReg_30;
  reg        [31:0]   _zz_maskReg_31;
  wire                maskStage_fire;
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
  wire                when_Stream_l368_2;
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
  reg        [4:0]    shiftLenRegNxt;
  wire                shiftStage_valid;
  wire                shiftStage_ready;
  wire       [255:0]  shiftStage_payload_data;
  wire       [31:0]   shiftStage_payload_keep;
  wire                shiftStage_payload_last;
  wire       [31:0]   shiftStage_payload_user;
  reg        [255:0]  _zz_shiftStage_payload_data;
  reg        [31:0]   _zz_shiftStage_payload_keep;
  wire                shiftStage_s2mPipe_valid;
  reg                 shiftStage_s2mPipe_ready;
  wire       [255:0]  shiftStage_s2mPipe_payload_data;
  wire       [31:0]   shiftStage_s2mPipe_payload_keep;
  wire                shiftStage_s2mPipe_payload_last;
  reg        [31:0]   shiftStage_s2mPipe_payload_user;
  reg                 shiftStage_rValid;
  reg        [255:0]  shiftStage_rData_data;
  reg        [31:0]   shiftStage_rData_keep;
  reg                 shiftStage_rData_last;
  reg        [31:0]   shiftStage_rData_user;
  wire       [31:0]   _zz_shiftStage_s2mPipe_payload_user;
  wire                shiftStage_s2mPipe_m2sPipe_valid;
  wire                shiftStage_s2mPipe_m2sPipe_ready;
  wire       [255:0]  shiftStage_s2mPipe_m2sPipe_payload_data;
  wire       [31:0]   shiftStage_s2mPipe_m2sPipe_payload_keep;
  wire                shiftStage_s2mPipe_m2sPipe_payload_last;
  reg        [31:0]   shiftStage_s2mPipe_m2sPipe_payload_user;
  reg                 shiftStage_s2mPipe_rValid;
  reg        [255:0]  shiftStage_s2mPipe_rData_data;
  reg        [31:0]   shiftStage_s2mPipe_rData_keep;
  reg                 shiftStage_s2mPipe_rData_last;
  reg        [31:0]   shiftStage_s2mPipe_rData_user;
  wire                when_Stream_l368_3;
  function [31:0] zz__zz_maskReg_1(input dummy);
    begin
      zz__zz_maskReg_1 = 32'h0;
      zz__zz_maskReg_1[31 : 31] = 1'b1;
    end
  endfunction
  wire [31:0] _zz_1;
  function [31:0] zz__zz_maskReg_2(input dummy);
    begin
      zz__zz_maskReg_2 = 32'h0;
      zz__zz_maskReg_2[31 : 30] = 2'b11;
    end
  endfunction
  wire [31:0] _zz_2;
  function [31:0] zz__zz_maskReg_3(input dummy);
    begin
      zz__zz_maskReg_3 = 32'h0;
      zz__zz_maskReg_3[31 : 29] = 3'b111;
    end
  endfunction
  wire [31:0] _zz_3;
  function [31:0] zz__zz_maskReg_4(input dummy);
    begin
      zz__zz_maskReg_4 = 32'h0;
      zz__zz_maskReg_4[31 : 28] = 4'b1111;
    end
  endfunction
  wire [31:0] _zz_4;
  function [31:0] zz__zz_maskReg_5(input dummy);
    begin
      zz__zz_maskReg_5 = 32'h0;
      zz__zz_maskReg_5[31 : 27] = 5'h1f;
    end
  endfunction
  wire [31:0] _zz_5;
  function [31:0] zz__zz_maskReg_6(input dummy);
    begin
      zz__zz_maskReg_6 = 32'h0;
      zz__zz_maskReg_6[31 : 26] = 6'h3f;
    end
  endfunction
  wire [31:0] _zz_6;
  function [31:0] zz__zz_maskReg_7(input dummy);
    begin
      zz__zz_maskReg_7 = 32'h0;
      zz__zz_maskReg_7[31 : 25] = 7'h7f;
    end
  endfunction
  wire [31:0] _zz_7;
  function [31:0] zz__zz_maskReg_8(input dummy);
    begin
      zz__zz_maskReg_8 = 32'h0;
      zz__zz_maskReg_8[31 : 24] = 8'hff;
    end
  endfunction
  wire [31:0] _zz_8;
  function [31:0] zz__zz_maskReg_9(input dummy);
    begin
      zz__zz_maskReg_9 = 32'h0;
      zz__zz_maskReg_9[31 : 23] = 9'h1ff;
    end
  endfunction
  wire [31:0] _zz_9;
  function [31:0] zz__zz_maskReg_10(input dummy);
    begin
      zz__zz_maskReg_10 = 32'h0;
      zz__zz_maskReg_10[31 : 22] = 10'h3ff;
    end
  endfunction
  wire [31:0] _zz_10;
  function [31:0] zz__zz_maskReg_11(input dummy);
    begin
      zz__zz_maskReg_11 = 32'h0;
      zz__zz_maskReg_11[31 : 21] = 11'h7ff;
    end
  endfunction
  wire [31:0] _zz_11;
  function [31:0] zz__zz_maskReg_12(input dummy);
    begin
      zz__zz_maskReg_12 = 32'h0;
      zz__zz_maskReg_12[31 : 20] = 12'hfff;
    end
  endfunction
  wire [31:0] _zz_12;
  function [31:0] zz__zz_maskReg_13(input dummy);
    begin
      zz__zz_maskReg_13 = 32'h0;
      zz__zz_maskReg_13[31 : 19] = 13'h1fff;
    end
  endfunction
  wire [31:0] _zz_13;
  function [31:0] zz__zz_maskReg_14(input dummy);
    begin
      zz__zz_maskReg_14 = 32'h0;
      zz__zz_maskReg_14[31 : 18] = 14'h3fff;
    end
  endfunction
  wire [31:0] _zz_14;
  function [31:0] zz__zz_maskReg_15(input dummy);
    begin
      zz__zz_maskReg_15 = 32'h0;
      zz__zz_maskReg_15[31 : 17] = 15'h7fff;
    end
  endfunction
  wire [31:0] _zz_15;
  function [31:0] zz__zz_maskReg_16(input dummy);
    begin
      zz__zz_maskReg_16 = 32'h0;
      zz__zz_maskReg_16[31 : 16] = 16'hffff;
    end
  endfunction
  wire [31:0] _zz_16;
  function [31:0] zz__zz_maskReg_17(input dummy);
    begin
      zz__zz_maskReg_17 = 32'h0;
      zz__zz_maskReg_17[31 : 15] = 17'h1ffff;
    end
  endfunction
  wire [31:0] _zz_17;
  function [31:0] zz__zz_maskReg_18(input dummy);
    begin
      zz__zz_maskReg_18 = 32'h0;
      zz__zz_maskReg_18[31 : 14] = 18'h3ffff;
    end
  endfunction
  wire [31:0] _zz_18;
  function [31:0] zz__zz_maskReg_19(input dummy);
    begin
      zz__zz_maskReg_19 = 32'h0;
      zz__zz_maskReg_19[31 : 13] = 19'h7ffff;
    end
  endfunction
  wire [31:0] _zz_19;
  function [31:0] zz__zz_maskReg_20(input dummy);
    begin
      zz__zz_maskReg_20 = 32'h0;
      zz__zz_maskReg_20[31 : 12] = 20'hfffff;
    end
  endfunction
  wire [31:0] _zz_20;
  function [31:0] zz__zz_maskReg_21(input dummy);
    begin
      zz__zz_maskReg_21 = 32'h0;
      zz__zz_maskReg_21[31 : 11] = 21'h1fffff;
    end
  endfunction
  wire [31:0] _zz_21;
  function [31:0] zz__zz_maskReg_22(input dummy);
    begin
      zz__zz_maskReg_22 = 32'h0;
      zz__zz_maskReg_22[31 : 10] = 22'h3fffff;
    end
  endfunction
  wire [31:0] _zz_22;
  function [31:0] zz__zz_maskReg_23(input dummy);
    begin
      zz__zz_maskReg_23 = 32'h0;
      zz__zz_maskReg_23[31 : 9] = 23'h7fffff;
    end
  endfunction
  wire [31:0] _zz_23;
  function [31:0] zz__zz_maskReg_24(input dummy);
    begin
      zz__zz_maskReg_24 = 32'h0;
      zz__zz_maskReg_24[31 : 8] = 24'hffffff;
    end
  endfunction
  wire [31:0] _zz_24;
  function [31:0] zz__zz_maskReg_25(input dummy);
    begin
      zz__zz_maskReg_25 = 32'h0;
      zz__zz_maskReg_25[31 : 7] = 25'h1ffffff;
    end
  endfunction
  wire [31:0] _zz_25;
  function [31:0] zz__zz_maskReg_26(input dummy);
    begin
      zz__zz_maskReg_26 = 32'h0;
      zz__zz_maskReg_26[31 : 6] = 26'h3ffffff;
    end
  endfunction
  wire [31:0] _zz_26;
  function [31:0] zz__zz_maskReg_27(input dummy);
    begin
      zz__zz_maskReg_27 = 32'h0;
      zz__zz_maskReg_27[31 : 5] = 27'h7ffffff;
    end
  endfunction
  wire [31:0] _zz_27;
  function [31:0] zz__zz_maskReg_28(input dummy);
    begin
      zz__zz_maskReg_28 = 32'h0;
      zz__zz_maskReg_28[31 : 4] = 28'hfffffff;
    end
  endfunction
  wire [31:0] _zz_28;
  function [31:0] zz__zz_maskReg_29(input dummy);
    begin
      zz__zz_maskReg_29 = 32'h0;
      zz__zz_maskReg_29[31 : 3] = 29'h1fffffff;
    end
  endfunction
  wire [31:0] _zz_29;
  function [31:0] zz__zz_maskReg_30(input dummy);
    begin
      zz__zz_maskReg_30 = 32'h0;
      zz__zz_maskReg_30[31 : 2] = 30'h3fffffff;
    end
  endfunction
  wire [31:0] _zz_30;
  function [31:0] zz__zz_maskReg_31(input dummy);
    begin
      zz__zz_maskReg_31 = 32'h0;
      zz__zz_maskReg_31[31 : 1] = 31'h7fffffff;
    end
  endfunction
  wire [31:0] _zz_31;

  assign _zz_maskStage_payload_data_1 = {{{{_zz_maskStage_payload_data_2,_zz_maskStage_payload_data_34},(_zz_maskStage_payload_data_35 ? _zz_maskStage_payload_data_36 : _zz_maskStage_payload_data_37)},(_zz_maskStage_payload_data[5] ? 8'h0 : joinedStream_payload_1_data[47 : 40])},(_zz_maskStage_payload_data[4] ? 8'h0 : joinedStream_payload_1_data[39 : 32])};
  assign _zz_maskStage_payload_data_38 = (_zz_maskStage_payload_data[3] ? 8'h0 : joinedStream_payload_1_data[31 : 24]);
  assign _zz_maskStage_payload_data_39 = _zz_maskStage_payload_data[2];
  assign _zz_maskStage_payload_data_40 = 8'h0;
  assign _zz_maskStage_payload_data_41 = joinedStream_payload_1_data[23 : 16];
  assign _zz_maskStage_payload_data_42 = {{{{_zz_maskStage_payload_data_43,_zz_maskStage_payload_data_75},(_zz_maskStage_payload_data_76 ? _zz_maskStage_payload_data_77 : _zz_maskStage_payload_data_78)},(maskReg[5] ? 8'h0 : joinedStream_payload_2_data[47 : 40])},(maskReg[4] ? 8'h0 : joinedStream_payload_2_data[39 : 32])};
  assign _zz_maskStage_payload_data_79 = (maskReg[3] ? 8'h0 : joinedStream_payload_2_data[31 : 24]);
  assign _zz_maskStage_payload_data_80 = maskReg[2];
  assign _zz_maskStage_payload_data_81 = 8'h0;
  assign _zz_maskStage_payload_data_82 = joinedStream_payload_2_data[23 : 16];
  assign _zz_maskStage_payload_data_2 = {{{{_zz_maskStage_payload_data_3,_zz_maskStage_payload_data_30},(_zz_maskStage_payload_data_31 ? _zz_maskStage_payload_data_32 : _zz_maskStage_payload_data_33)},(_zz_maskStage_payload_data[9] ? 8'h0 : joinedStream_payload_1_data[79 : 72])},(_zz_maskStage_payload_data[8] ? 8'h0 : joinedStream_payload_1_data[71 : 64])};
  assign _zz_maskStage_payload_data_34 = (_zz_maskStage_payload_data[7] ? 8'h0 : joinedStream_payload_1_data[63 : 56]);
  assign _zz_maskStage_payload_data_35 = _zz_maskStage_payload_data[6];
  assign _zz_maskStage_payload_data_36 = 8'h0;
  assign _zz_maskStage_payload_data_37 = joinedStream_payload_1_data[55 : 48];
  assign _zz_maskStage_payload_data_43 = {{{{_zz_maskStage_payload_data_44,_zz_maskStage_payload_data_71},(_zz_maskStage_payload_data_72 ? _zz_maskStage_payload_data_73 : _zz_maskStage_payload_data_74)},(maskReg[9] ? 8'h0 : joinedStream_payload_2_data[79 : 72])},(maskReg[8] ? 8'h0 : joinedStream_payload_2_data[71 : 64])};
  assign _zz_maskStage_payload_data_75 = (maskReg[7] ? 8'h0 : joinedStream_payload_2_data[63 : 56]);
  assign _zz_maskStage_payload_data_76 = maskReg[6];
  assign _zz_maskStage_payload_data_77 = 8'h0;
  assign _zz_maskStage_payload_data_78 = joinedStream_payload_2_data[55 : 48];
  assign _zz_maskStage_payload_data_3 = {{{{_zz_maskStage_payload_data_4,_zz_maskStage_payload_data_26},(_zz_maskStage_payload_data_27 ? _zz_maskStage_payload_data_28 : _zz_maskStage_payload_data_29)},(_zz_maskStage_payload_data[13] ? 8'h0 : joinedStream_payload_1_data[111 : 104])},(_zz_maskStage_payload_data[12] ? 8'h0 : joinedStream_payload_1_data[103 : 96])};
  assign _zz_maskStage_payload_data_30 = (_zz_maskStage_payload_data[11] ? 8'h0 : joinedStream_payload_1_data[95 : 88]);
  assign _zz_maskStage_payload_data_31 = _zz_maskStage_payload_data[10];
  assign _zz_maskStage_payload_data_32 = 8'h0;
  assign _zz_maskStage_payload_data_33 = joinedStream_payload_1_data[87 : 80];
  assign _zz_maskStage_payload_data_44 = {{{{_zz_maskStage_payload_data_45,_zz_maskStage_payload_data_67},(_zz_maskStage_payload_data_68 ? _zz_maskStage_payload_data_69 : _zz_maskStage_payload_data_70)},(maskReg[13] ? 8'h0 : joinedStream_payload_2_data[111 : 104])},(maskReg[12] ? 8'h0 : joinedStream_payload_2_data[103 : 96])};
  assign _zz_maskStage_payload_data_71 = (maskReg[11] ? 8'h0 : joinedStream_payload_2_data[95 : 88]);
  assign _zz_maskStage_payload_data_72 = maskReg[10];
  assign _zz_maskStage_payload_data_73 = 8'h0;
  assign _zz_maskStage_payload_data_74 = joinedStream_payload_2_data[87 : 80];
  assign _zz_maskStage_payload_data_4 = {{{{_zz_maskStage_payload_data_5,_zz_maskStage_payload_data_22},(_zz_maskStage_payload_data_23 ? _zz_maskStage_payload_data_24 : _zz_maskStage_payload_data_25)},(_zz_maskStage_payload_data[17] ? 8'h0 : joinedStream_payload_1_data[143 : 136])},(_zz_maskStage_payload_data[16] ? 8'h0 : joinedStream_payload_1_data[135 : 128])};
  assign _zz_maskStage_payload_data_26 = (_zz_maskStage_payload_data[15] ? 8'h0 : joinedStream_payload_1_data[127 : 120]);
  assign _zz_maskStage_payload_data_27 = _zz_maskStage_payload_data[14];
  assign _zz_maskStage_payload_data_28 = 8'h0;
  assign _zz_maskStage_payload_data_29 = joinedStream_payload_1_data[119 : 112];
  assign _zz_maskStage_payload_data_45 = {{{{_zz_maskStage_payload_data_46,_zz_maskStage_payload_data_63},(_zz_maskStage_payload_data_64 ? _zz_maskStage_payload_data_65 : _zz_maskStage_payload_data_66)},(maskReg[17] ? 8'h0 : joinedStream_payload_2_data[143 : 136])},(maskReg[16] ? 8'h0 : joinedStream_payload_2_data[135 : 128])};
  assign _zz_maskStage_payload_data_67 = (maskReg[15] ? 8'h0 : joinedStream_payload_2_data[127 : 120]);
  assign _zz_maskStage_payload_data_68 = maskReg[14];
  assign _zz_maskStage_payload_data_69 = 8'h0;
  assign _zz_maskStage_payload_data_70 = joinedStream_payload_2_data[119 : 112];
  assign _zz_maskStage_payload_data_5 = {{{{_zz_maskStage_payload_data_6,_zz_maskStage_payload_data_18},(_zz_maskStage_payload_data_19 ? _zz_maskStage_payload_data_20 : _zz_maskStage_payload_data_21)},(_zz_maskStage_payload_data[21] ? 8'h0 : joinedStream_payload_1_data[175 : 168])},(_zz_maskStage_payload_data[20] ? 8'h0 : joinedStream_payload_1_data[167 : 160])};
  assign _zz_maskStage_payload_data_22 = (_zz_maskStage_payload_data[19] ? 8'h0 : joinedStream_payload_1_data[159 : 152]);
  assign _zz_maskStage_payload_data_23 = _zz_maskStage_payload_data[18];
  assign _zz_maskStage_payload_data_24 = 8'h0;
  assign _zz_maskStage_payload_data_25 = joinedStream_payload_1_data[151 : 144];
  assign _zz_maskStage_payload_data_46 = {{{{_zz_maskStage_payload_data_47,_zz_maskStage_payload_data_59},(_zz_maskStage_payload_data_60 ? _zz_maskStage_payload_data_61 : _zz_maskStage_payload_data_62)},(maskReg[21] ? 8'h0 : joinedStream_payload_2_data[175 : 168])},(maskReg[20] ? 8'h0 : joinedStream_payload_2_data[167 : 160])};
  assign _zz_maskStage_payload_data_63 = (maskReg[19] ? 8'h0 : joinedStream_payload_2_data[159 : 152]);
  assign _zz_maskStage_payload_data_64 = maskReg[18];
  assign _zz_maskStage_payload_data_65 = 8'h0;
  assign _zz_maskStage_payload_data_66 = joinedStream_payload_2_data[151 : 144];
  assign _zz_maskStage_payload_data_6 = {{{{_zz_maskStage_payload_data_7,_zz_maskStage_payload_data_14},(_zz_maskStage_payload_data_15 ? _zz_maskStage_payload_data_16 : _zz_maskStage_payload_data_17)},(_zz_maskStage_payload_data[25] ? 8'h0 : joinedStream_payload_1_data[207 : 200])},(_zz_maskStage_payload_data[24] ? 8'h0 : joinedStream_payload_1_data[199 : 192])};
  assign _zz_maskStage_payload_data_18 = (_zz_maskStage_payload_data[23] ? 8'h0 : joinedStream_payload_1_data[191 : 184]);
  assign _zz_maskStage_payload_data_19 = _zz_maskStage_payload_data[22];
  assign _zz_maskStage_payload_data_20 = 8'h0;
  assign _zz_maskStage_payload_data_21 = joinedStream_payload_1_data[183 : 176];
  assign _zz_maskStage_payload_data_47 = {{{{_zz_maskStage_payload_data_48,_zz_maskStage_payload_data_55},(_zz_maskStage_payload_data_56 ? _zz_maskStage_payload_data_57 : _zz_maskStage_payload_data_58)},(maskReg[25] ? 8'h0 : joinedStream_payload_2_data[207 : 200])},(maskReg[24] ? 8'h0 : joinedStream_payload_2_data[199 : 192])};
  assign _zz_maskStage_payload_data_59 = (maskReg[23] ? 8'h0 : joinedStream_payload_2_data[191 : 184]);
  assign _zz_maskStage_payload_data_60 = maskReg[22];
  assign _zz_maskStage_payload_data_61 = 8'h0;
  assign _zz_maskStage_payload_data_62 = joinedStream_payload_2_data[183 : 176];
  assign _zz_maskStage_payload_data_7 = {{{(_zz_maskStage_payload_data_8 ? _zz_maskStage_payload_data_9 : _zz_maskStage_payload_data_10),(_zz_maskStage_payload_data_11 ? _zz_maskStage_payload_data_12 : _zz_maskStage_payload_data_13)},(_zz_maskStage_payload_data[29] ? 8'h0 : joinedStream_payload_1_data[239 : 232])},(_zz_maskStage_payload_data[28] ? 8'h0 : joinedStream_payload_1_data[231 : 224])};
  assign _zz_maskStage_payload_data_14 = (_zz_maskStage_payload_data[27] ? 8'h0 : joinedStream_payload_1_data[223 : 216]);
  assign _zz_maskStage_payload_data_15 = _zz_maskStage_payload_data[26];
  assign _zz_maskStage_payload_data_16 = 8'h0;
  assign _zz_maskStage_payload_data_17 = joinedStream_payload_1_data[215 : 208];
  assign _zz_maskStage_payload_data_48 = {{{(_zz_maskStage_payload_data_49 ? _zz_maskStage_payload_data_50 : _zz_maskStage_payload_data_51),(_zz_maskStage_payload_data_52 ? _zz_maskStage_payload_data_53 : _zz_maskStage_payload_data_54)},(maskReg[29] ? 8'h0 : joinedStream_payload_2_data[239 : 232])},(maskReg[28] ? 8'h0 : joinedStream_payload_2_data[231 : 224])};
  assign _zz_maskStage_payload_data_55 = (maskReg[27] ? 8'h0 : joinedStream_payload_2_data[223 : 216]);
  assign _zz_maskStage_payload_data_56 = maskReg[26];
  assign _zz_maskStage_payload_data_57 = 8'h0;
  assign _zz_maskStage_payload_data_58 = joinedStream_payload_2_data[215 : 208];
  assign _zz_maskStage_payload_data_8 = _zz_maskStage_payload_data[31];
  assign _zz_maskStage_payload_data_9 = 8'h0;
  assign _zz_maskStage_payload_data_10 = joinedStream_payload_1_data[255 : 248];
  assign _zz_maskStage_payload_data_11 = _zz_maskStage_payload_data[30];
  assign _zz_maskStage_payload_data_12 = 8'h0;
  assign _zz_maskStage_payload_data_13 = joinedStream_payload_1_data[247 : 240];
  assign _zz_maskStage_payload_data_49 = maskReg[31];
  assign _zz_maskStage_payload_data_50 = 8'h0;
  assign _zz_maskStage_payload_data_51 = joinedStream_payload_2_data[255 : 248];
  assign _zz_maskStage_payload_data_52 = maskReg[30];
  assign _zz_maskStage_payload_data_53 = 8'h0;
  assign _zz_maskStage_payload_data_54 = joinedStream_payload_2_data[247 : 240];
  assign _zz_maskStage_payload_keep_1 = {{{{_zz_maskStage_payload_keep_2,_zz_maskStage_payload_keep_34},(_zz_maskStage_payload_keep_35 ? _zz_maskStage_payload_keep_36 : _zz_maskStage_payload_keep_37)},(_zz_maskStage_payload_keep[5] ? 1'b0 : joinedStream_payload_1_keep[5 : 5])},(_zz_maskStage_payload_keep[4] ? 1'b0 : joinedStream_payload_1_keep[4 : 4])};
  assign _zz_maskStage_payload_keep_38 = (_zz_maskStage_payload_keep[3] ? 1'b0 : joinedStream_payload_1_keep[3 : 3]);
  assign _zz_maskStage_payload_keep_39 = _zz_maskStage_payload_keep[2];
  assign _zz_maskStage_payload_keep_40 = 1'b0;
  assign _zz_maskStage_payload_keep_41 = joinedStream_payload_1_keep[2 : 2];
  assign _zz_maskStage_payload_keep_42 = {{{{_zz_maskStage_payload_keep_43,_zz_maskStage_payload_keep_75},(_zz_maskStage_payload_keep_76 ? _zz_maskStage_payload_keep_77 : _zz_maskStage_payload_keep_78)},(maskReg[5] ? 1'b0 : joinedStream_payload_2_keep[5 : 5])},(maskReg[4] ? 1'b0 : joinedStream_payload_2_keep[4 : 4])};
  assign _zz_maskStage_payload_keep_79 = (maskReg[3] ? 1'b0 : joinedStream_payload_2_keep[3 : 3]);
  assign _zz_maskStage_payload_keep_80 = maskReg[2];
  assign _zz_maskStage_payload_keep_81 = 1'b0;
  assign _zz_maskStage_payload_keep_82 = joinedStream_payload_2_keep[2 : 2];
  assign _zz_maskStage_payload_keep_2 = {{{{_zz_maskStage_payload_keep_3,_zz_maskStage_payload_keep_30},(_zz_maskStage_payload_keep_31 ? _zz_maskStage_payload_keep_32 : _zz_maskStage_payload_keep_33)},(_zz_maskStage_payload_keep[9] ? 1'b0 : joinedStream_payload_1_keep[9 : 9])},(_zz_maskStage_payload_keep[8] ? 1'b0 : joinedStream_payload_1_keep[8 : 8])};
  assign _zz_maskStage_payload_keep_34 = (_zz_maskStage_payload_keep[7] ? 1'b0 : joinedStream_payload_1_keep[7 : 7]);
  assign _zz_maskStage_payload_keep_35 = _zz_maskStage_payload_keep[6];
  assign _zz_maskStage_payload_keep_36 = 1'b0;
  assign _zz_maskStage_payload_keep_37 = joinedStream_payload_1_keep[6 : 6];
  assign _zz_maskStage_payload_keep_43 = {{{{_zz_maskStage_payload_keep_44,_zz_maskStage_payload_keep_71},(_zz_maskStage_payload_keep_72 ? _zz_maskStage_payload_keep_73 : _zz_maskStage_payload_keep_74)},(maskReg[9] ? 1'b0 : joinedStream_payload_2_keep[9 : 9])},(maskReg[8] ? 1'b0 : joinedStream_payload_2_keep[8 : 8])};
  assign _zz_maskStage_payload_keep_75 = (maskReg[7] ? 1'b0 : joinedStream_payload_2_keep[7 : 7]);
  assign _zz_maskStage_payload_keep_76 = maskReg[6];
  assign _zz_maskStage_payload_keep_77 = 1'b0;
  assign _zz_maskStage_payload_keep_78 = joinedStream_payload_2_keep[6 : 6];
  assign _zz_maskStage_payload_keep_3 = {{{{_zz_maskStage_payload_keep_4,_zz_maskStage_payload_keep_26},(_zz_maskStage_payload_keep_27 ? _zz_maskStage_payload_keep_28 : _zz_maskStage_payload_keep_29)},(_zz_maskStage_payload_keep[13] ? 1'b0 : joinedStream_payload_1_keep[13 : 13])},(_zz_maskStage_payload_keep[12] ? 1'b0 : joinedStream_payload_1_keep[12 : 12])};
  assign _zz_maskStage_payload_keep_30 = (_zz_maskStage_payload_keep[11] ? 1'b0 : joinedStream_payload_1_keep[11 : 11]);
  assign _zz_maskStage_payload_keep_31 = _zz_maskStage_payload_keep[10];
  assign _zz_maskStage_payload_keep_32 = 1'b0;
  assign _zz_maskStage_payload_keep_33 = joinedStream_payload_1_keep[10 : 10];
  assign _zz_maskStage_payload_keep_44 = {{{{_zz_maskStage_payload_keep_45,_zz_maskStage_payload_keep_67},(_zz_maskStage_payload_keep_68 ? _zz_maskStage_payload_keep_69 : _zz_maskStage_payload_keep_70)},(maskReg[13] ? 1'b0 : joinedStream_payload_2_keep[13 : 13])},(maskReg[12] ? 1'b0 : joinedStream_payload_2_keep[12 : 12])};
  assign _zz_maskStage_payload_keep_71 = (maskReg[11] ? 1'b0 : joinedStream_payload_2_keep[11 : 11]);
  assign _zz_maskStage_payload_keep_72 = maskReg[10];
  assign _zz_maskStage_payload_keep_73 = 1'b0;
  assign _zz_maskStage_payload_keep_74 = joinedStream_payload_2_keep[10 : 10];
  assign _zz_maskStage_payload_keep_4 = {{{{_zz_maskStage_payload_keep_5,_zz_maskStage_payload_keep_22},(_zz_maskStage_payload_keep_23 ? _zz_maskStage_payload_keep_24 : _zz_maskStage_payload_keep_25)},(_zz_maskStage_payload_keep[17] ? 1'b0 : joinedStream_payload_1_keep[17 : 17])},(_zz_maskStage_payload_keep[16] ? 1'b0 : joinedStream_payload_1_keep[16 : 16])};
  assign _zz_maskStage_payload_keep_26 = (_zz_maskStage_payload_keep[15] ? 1'b0 : joinedStream_payload_1_keep[15 : 15]);
  assign _zz_maskStage_payload_keep_27 = _zz_maskStage_payload_keep[14];
  assign _zz_maskStage_payload_keep_28 = 1'b0;
  assign _zz_maskStage_payload_keep_29 = joinedStream_payload_1_keep[14 : 14];
  assign _zz_maskStage_payload_keep_45 = {{{{_zz_maskStage_payload_keep_46,_zz_maskStage_payload_keep_63},(_zz_maskStage_payload_keep_64 ? _zz_maskStage_payload_keep_65 : _zz_maskStage_payload_keep_66)},(maskReg[17] ? 1'b0 : joinedStream_payload_2_keep[17 : 17])},(maskReg[16] ? 1'b0 : joinedStream_payload_2_keep[16 : 16])};
  assign _zz_maskStage_payload_keep_67 = (maskReg[15] ? 1'b0 : joinedStream_payload_2_keep[15 : 15]);
  assign _zz_maskStage_payload_keep_68 = maskReg[14];
  assign _zz_maskStage_payload_keep_69 = 1'b0;
  assign _zz_maskStage_payload_keep_70 = joinedStream_payload_2_keep[14 : 14];
  assign _zz_maskStage_payload_keep_5 = {{{{_zz_maskStage_payload_keep_6,_zz_maskStage_payload_keep_18},(_zz_maskStage_payload_keep_19 ? _zz_maskStage_payload_keep_20 : _zz_maskStage_payload_keep_21)},(_zz_maskStage_payload_keep[21] ? 1'b0 : joinedStream_payload_1_keep[21 : 21])},(_zz_maskStage_payload_keep[20] ? 1'b0 : joinedStream_payload_1_keep[20 : 20])};
  assign _zz_maskStage_payload_keep_22 = (_zz_maskStage_payload_keep[19] ? 1'b0 : joinedStream_payload_1_keep[19 : 19]);
  assign _zz_maskStage_payload_keep_23 = _zz_maskStage_payload_keep[18];
  assign _zz_maskStage_payload_keep_24 = 1'b0;
  assign _zz_maskStage_payload_keep_25 = joinedStream_payload_1_keep[18 : 18];
  assign _zz_maskStage_payload_keep_46 = {{{{_zz_maskStage_payload_keep_47,_zz_maskStage_payload_keep_59},(_zz_maskStage_payload_keep_60 ? _zz_maskStage_payload_keep_61 : _zz_maskStage_payload_keep_62)},(maskReg[21] ? 1'b0 : joinedStream_payload_2_keep[21 : 21])},(maskReg[20] ? 1'b0 : joinedStream_payload_2_keep[20 : 20])};
  assign _zz_maskStage_payload_keep_63 = (maskReg[19] ? 1'b0 : joinedStream_payload_2_keep[19 : 19]);
  assign _zz_maskStage_payload_keep_64 = maskReg[18];
  assign _zz_maskStage_payload_keep_65 = 1'b0;
  assign _zz_maskStage_payload_keep_66 = joinedStream_payload_2_keep[18 : 18];
  assign _zz_maskStage_payload_keep_6 = {{{{_zz_maskStage_payload_keep_7,_zz_maskStage_payload_keep_14},(_zz_maskStage_payload_keep_15 ? _zz_maskStage_payload_keep_16 : _zz_maskStage_payload_keep_17)},(_zz_maskStage_payload_keep[25] ? 1'b0 : joinedStream_payload_1_keep[25 : 25])},(_zz_maskStage_payload_keep[24] ? 1'b0 : joinedStream_payload_1_keep[24 : 24])};
  assign _zz_maskStage_payload_keep_18 = (_zz_maskStage_payload_keep[23] ? 1'b0 : joinedStream_payload_1_keep[23 : 23]);
  assign _zz_maskStage_payload_keep_19 = _zz_maskStage_payload_keep[22];
  assign _zz_maskStage_payload_keep_20 = 1'b0;
  assign _zz_maskStage_payload_keep_21 = joinedStream_payload_1_keep[22 : 22];
  assign _zz_maskStage_payload_keep_47 = {{{{_zz_maskStage_payload_keep_48,_zz_maskStage_payload_keep_55},(_zz_maskStage_payload_keep_56 ? _zz_maskStage_payload_keep_57 : _zz_maskStage_payload_keep_58)},(maskReg[25] ? 1'b0 : joinedStream_payload_2_keep[25 : 25])},(maskReg[24] ? 1'b0 : joinedStream_payload_2_keep[24 : 24])};
  assign _zz_maskStage_payload_keep_59 = (maskReg[23] ? 1'b0 : joinedStream_payload_2_keep[23 : 23]);
  assign _zz_maskStage_payload_keep_60 = maskReg[22];
  assign _zz_maskStage_payload_keep_61 = 1'b0;
  assign _zz_maskStage_payload_keep_62 = joinedStream_payload_2_keep[22 : 22];
  assign _zz_maskStage_payload_keep_7 = {{{(_zz_maskStage_payload_keep_8 ? _zz_maskStage_payload_keep_9 : _zz_maskStage_payload_keep_10),(_zz_maskStage_payload_keep_11 ? _zz_maskStage_payload_keep_12 : _zz_maskStage_payload_keep_13)},(_zz_maskStage_payload_keep[29] ? 1'b0 : joinedStream_payload_1_keep[29 : 29])},(_zz_maskStage_payload_keep[28] ? 1'b0 : joinedStream_payload_1_keep[28 : 28])};
  assign _zz_maskStage_payload_keep_14 = (_zz_maskStage_payload_keep[27] ? 1'b0 : joinedStream_payload_1_keep[27 : 27]);
  assign _zz_maskStage_payload_keep_15 = _zz_maskStage_payload_keep[26];
  assign _zz_maskStage_payload_keep_16 = 1'b0;
  assign _zz_maskStage_payload_keep_17 = joinedStream_payload_1_keep[26 : 26];
  assign _zz_maskStage_payload_keep_48 = {{{(_zz_maskStage_payload_keep_49 ? _zz_maskStage_payload_keep_50 : _zz_maskStage_payload_keep_51),(_zz_maskStage_payload_keep_52 ? _zz_maskStage_payload_keep_53 : _zz_maskStage_payload_keep_54)},(maskReg[29] ? 1'b0 : joinedStream_payload_2_keep[29 : 29])},(maskReg[28] ? 1'b0 : joinedStream_payload_2_keep[28 : 28])};
  assign _zz_maskStage_payload_keep_55 = (maskReg[27] ? 1'b0 : joinedStream_payload_2_keep[27 : 27]);
  assign _zz_maskStage_payload_keep_56 = maskReg[26];
  assign _zz_maskStage_payload_keep_57 = 1'b0;
  assign _zz_maskStage_payload_keep_58 = joinedStream_payload_2_keep[26 : 26];
  assign _zz_maskStage_payload_keep_8 = _zz_maskStage_payload_keep[31];
  assign _zz_maskStage_payload_keep_9 = 1'b0;
  assign _zz_maskStage_payload_keep_10 = joinedStream_payload_1_keep[31 : 31];
  assign _zz_maskStage_payload_keep_11 = _zz_maskStage_payload_keep[30];
  assign _zz_maskStage_payload_keep_12 = 1'b0;
  assign _zz_maskStage_payload_keep_13 = joinedStream_payload_1_keep[30 : 30];
  assign _zz_maskStage_payload_keep_49 = maskReg[31];
  assign _zz_maskStage_payload_keep_50 = 1'b0;
  assign _zz_maskStage_payload_keep_51 = joinedStream_payload_2_keep[31 : 31];
  assign _zz_maskStage_payload_keep_52 = maskReg[30];
  assign _zz_maskStage_payload_keep_53 = 1'b0;
  assign _zz_maskStage_payload_keep_54 = joinedStream_payload_2_keep[30 : 30];
  StreamFifo io_dataAxisIn_fifo (
    .io_push_valid        (io_dataAxisIn_valid                          ), //i
    .io_push_ready        (io_dataAxisIn_fifo_io_push_ready             ), //o
    .io_push_payload_data (io_dataAxisIn_payload_data[255:0]            ), //i
    .io_push_payload_keep (io_dataAxisIn_payload_keep[31:0]             ), //i
    .io_push_payload_last (io_dataAxisIn_payload_last                   ), //i
    .io_push_payload_user (io_dataAxisIn_fifo_io_push_payload_user[31:0]), //i
    .io_pop_valid         (io_dataAxisIn_fifo_io_pop_valid              ), //o
    .io_pop_ready         (io_dataAxisIn_fifo_io_pop_fork_io_input_ready), //i
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
  StreamFifo_1 io_metaIn_fifo (
    .io_push_valid              (io_metaIn_valid                               ), //i
    .io_push_ready              (io_metaIn_fifo_io_push_ready                  ), //o
    .io_push_payload_dataLen    (io_metaIn_payload_dataLen[11:0]               ), //i
    .io_push_payload_dstMacAddr (io_metaIn_payload_dstMacAddr[47:0]            ), //i
    .io_push_payload_dstIpAddr  (io_metaIn_payload_dstIpAddr[31:0]             ), //i
    .io_push_payload_srcMacAddr (io_metaIn_payload_srcMacAddr[47:0]            ), //i
    .io_push_payload_srcIpAddr  (io_metaIn_payload_srcIpAddr[31:0]             ), //i
    .io_push_payload_dstPort    (io_metaIn_payload_dstPort[15:0]               ), //i
    .io_push_payload_srcPort    (io_metaIn_payload_srcPort[15:0]               ), //i
    .io_pop_valid               (io_metaIn_fifo_io_pop_valid                   ), //o
    .io_pop_ready               (headerGenerator_1_io_metaIn_ready             ), //i
    .io_pop_payload_dataLen     (io_metaIn_fifo_io_pop_payload_dataLen[11:0]   ), //o
    .io_pop_payload_dstMacAddr  (io_metaIn_fifo_io_pop_payload_dstMacAddr[47:0]), //o
    .io_pop_payload_dstIpAddr   (io_metaIn_fifo_io_pop_payload_dstIpAddr[31:0] ), //o
    .io_pop_payload_srcMacAddr  (io_metaIn_fifo_io_pop_payload_srcMacAddr[47:0]), //o
    .io_pop_payload_srcIpAddr   (io_metaIn_fifo_io_pop_payload_srcIpAddr[31:0] ), //o
    .io_pop_payload_dstPort     (io_metaIn_fifo_io_pop_payload_dstPort[15:0]   ), //o
    .io_pop_payload_srcPort     (io_metaIn_fifo_io_pop_payload_srcPort[15:0]   ), //o
    .io_flush                   (1'b0                                          ), //i
    .io_occupancy               (io_metaIn_fifo_io_occupancy[2:0]              ), //o
    .io_availability            (io_metaIn_fifo_io_availability[2:0]           ), //o
    .clk                        (clk                                           ), //i
    .reset                      (reset                                         )  //i
  );
  HeaderGenerator headerGenerator_1 (
    .io_metaIn_valid               (io_metaIn_fifo_io_pop_valid                           ), //i
    .io_metaIn_ready               (headerGenerator_1_io_metaIn_ready                     ), //o
    .io_metaIn_payload_dataLen     (io_metaIn_fifo_io_pop_payload_dataLen[11:0]           ), //i
    .io_metaIn_payload_dstMacAddr  (io_metaIn_fifo_io_pop_payload_dstMacAddr[47:0]        ), //i
    .io_metaIn_payload_dstIpAddr   (io_metaIn_fifo_io_pop_payload_dstIpAddr[31:0]         ), //i
    .io_metaIn_payload_srcMacAddr  (io_metaIn_fifo_io_pop_payload_srcMacAddr[47:0]        ), //i
    .io_metaIn_payload_srcIpAddr   (io_metaIn_fifo_io_pop_payload_srcIpAddr[31:0]         ), //i
    .io_metaIn_payload_dstPort     (io_metaIn_fifo_io_pop_payload_dstPort[15:0]           ), //i
    .io_metaIn_payload_srcPort     (io_metaIn_fifo_io_pop_payload_srcPort[15:0]           ), //i
    .io_headerAxisOut_valid        (headerGenerator_1_io_headerAxisOut_valid              ), //o
    .io_headerAxisOut_ready        (headerGenerator_1_io_headerAxisOut_fifo_io_push_ready ), //i
    .io_headerAxisOut_payload_data (headerGenerator_1_io_headerAxisOut_payload_data[255:0]), //o
    .io_headerAxisOut_payload_keep (headerGenerator_1_io_headerAxisOut_payload_keep[31:0] ), //o
    .io_headerAxisOut_payload_last (headerGenerator_1_io_headerAxisOut_payload_last       ), //o
    .io_headerAxisOut_payload_user (headerGenerator_1_io_headerAxisOut_payload_user[31:0] ), //o
    .clk                           (clk                                                   ), //i
    .reset                         (reset                                                 )  //i
  );
  StreamFifo_2 headerGenerator_1_io_headerAxisOut_fifo (
    .io_push_valid        (headerGenerator_1_io_headerAxisOut_valid                          ), //i
    .io_push_ready        (headerGenerator_1_io_headerAxisOut_fifo_io_push_ready             ), //o
    .io_push_payload_data (headerGenerator_1_io_headerAxisOut_payload_data[255:0]            ), //i
    .io_push_payload_keep (headerGenerator_1_io_headerAxisOut_payload_keep[31:0]             ), //i
    .io_push_payload_last (headerGenerator_1_io_headerAxisOut_payload_last                   ), //i
    .io_push_payload_user (headerGenerator_1_io_headerAxisOut_fifo_io_push_payload_user[31:0]), //i
    .io_pop_valid         (headerGenerator_1_io_headerAxisOut_fifo_io_pop_valid              ), //o
    .io_pop_ready         (streamMux_1_io_inputs_0_ready                                     ), //i
    .io_pop_payload_data  (headerGenerator_1_io_headerAxisOut_fifo_io_pop_payload_data[255:0]), //o
    .io_pop_payload_keep  (headerGenerator_1_io_headerAxisOut_fifo_io_pop_payload_keep[31:0] ), //o
    .io_pop_payload_last  (headerGenerator_1_io_headerAxisOut_fifo_io_pop_payload_last       ), //o
    .io_pop_payload_user  (headerGenerator_1_io_headerAxisOut_fifo_io_pop_payload_user[31:0] ), //o
    .io_flush             (1'b0                                                              ), //i
    .io_occupancy         (headerGenerator_1_io_headerAxisOut_fifo_io_occupancy[4:0]         ), //o
    .io_availability      (headerGenerator_1_io_headerAxisOut_fifo_io_availability[4:0]      ), //o
    .clk                  (clk                                                               ), //i
    .reset                (reset                                                             )  //i
  );
  StreamFork io_dataAxisIn_fifo_io_pop_fork (
    .io_input_valid            (io_dataAxisIn_fifo_io_pop_valid                                ), //i
    .io_input_ready            (io_dataAxisIn_fifo_io_pop_fork_io_input_ready                  ), //o
    .io_input_payload_data     (io_dataAxisIn_fifo_io_pop_payload_data[255:0]                  ), //i
    .io_input_payload_keep     (io_dataAxisIn_fifo_io_pop_payload_keep[31:0]                   ), //i
    .io_input_payload_last     (io_dataAxisIn_fifo_io_pop_payload_last                         ), //i
    .io_input_payload_user     (io_dataAxisIn_fifo_io_pop_fork_io_input_payload_user[31:0]     ), //i
    .io_outputs_0_valid        (io_dataAxisIn_fifo_io_pop_fork_io_outputs_0_valid              ), //o
    .io_outputs_0_ready        (io_dataAxisIn_fifo_io_pop_fork_io_outputs_0_ready              ), //i
    .io_outputs_0_payload_data (io_dataAxisIn_fifo_io_pop_fork_io_outputs_0_payload_data[255:0]), //o
    .io_outputs_0_payload_keep (io_dataAxisIn_fifo_io_pop_fork_io_outputs_0_payload_keep[31:0] ), //o
    .io_outputs_0_payload_last (io_dataAxisIn_fifo_io_pop_fork_io_outputs_0_payload_last       ), //o
    .io_outputs_0_payload_user (io_dataAxisIn_fifo_io_pop_fork_io_outputs_0_payload_user[31:0] ), //o
    .io_outputs_1_valid        (io_dataAxisIn_fifo_io_pop_fork_io_outputs_1_valid              ), //o
    .io_outputs_1_ready        (io_dataAxisIn_fifo_io_pop_fork_io_outputs_1_ready              ), //i
    .io_outputs_1_payload_data (io_dataAxisIn_fifo_io_pop_fork_io_outputs_1_payload_data[255:0]), //o
    .io_outputs_1_payload_keep (io_dataAxisIn_fifo_io_pop_fork_io_outputs_1_payload_keep[31:0] ), //o
    .io_outputs_1_payload_last (io_dataAxisIn_fifo_io_pop_fork_io_outputs_1_payload_last       ), //o
    .io_outputs_1_payload_user (io_dataAxisIn_fifo_io_pop_fork_io_outputs_1_payload_user[31:0] ), //o
    .clk                       (clk                                                            ), //i
    .reset                     (reset                                                          )  //i
  );
  StreamMux streamMux_1 (
    .io_select                (streamMuxReg                                                      ), //i
    .io_inputs_0_valid        (headerGenerator_1_io_headerAxisOut_fifo_io_pop_valid              ), //i
    .io_inputs_0_ready        (streamMux_1_io_inputs_0_ready                                     ), //o
    .io_inputs_0_payload_data (headerGenerator_1_io_headerAxisOut_fifo_io_pop_payload_data[255:0]), //i
    .io_inputs_0_payload_keep (headerGenerator_1_io_headerAxisOut_fifo_io_pop_payload_keep[31:0] ), //i
    .io_inputs_0_payload_last (headerGenerator_1_io_headerAxisOut_fifo_io_pop_payload_last       ), //i
    .io_inputs_0_payload_user (streamMux_1_io_inputs_0_payload_user[31:0]                        ), //i
    .io_inputs_1_valid        (dataBufferedReg_valid                                             ), //i
    .io_inputs_1_ready        (streamMux_1_io_inputs_1_ready                                     ), //o
    .io_inputs_1_payload_data (dataBufferedReg_payload_data[255:0]                               ), //i
    .io_inputs_1_payload_keep (dataBufferedReg_payload_keep[31:0]                                ), //i
    .io_inputs_1_payload_last (dataBufferedReg_payload_last                                      ), //i
    .io_inputs_1_payload_user (streamMux_1_io_inputs_1_payload_user[31:0]                        ), //i
    .io_output_valid          (streamMux_1_io_output_valid                                       ), //o
    .io_output_ready          (streamMux_1_io_output_ready                                       ), //i
    .io_output_payload_data   (streamMux_1_io_output_payload_data[255:0]                         ), //o
    .io_output_payload_keep   (streamMux_1_io_output_payload_keep[31:0]                          ), //o
    .io_output_payload_last   (streamMux_1_io_output_payload_last                                ), //o
    .io_output_payload_user   (streamMux_1_io_output_payload_user[31:0]                          )  //o
  );
  StreamTransactionCounter transactionCounter (
    .io_ctrlFire   (cntTrigger                      ), //i
    .io_targetFire (maskStage_fire                  ), //i
    .io_count      (packetLen[5:0]                  ), //i
    .io_working    (transactionCounter_io_working   ), //o
    .io_last       (transactionCounter_io_last      ), //o
    .io_done       (transactionCounter_io_done      ), //o
    .io_value      (transactionCounter_io_value[5:0]), //o
    .clk           (clk                             ), //i
    .reset         (reset                           )  //i
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

  assign io_metaIn_ready = io_metaIn_fifo_io_push_ready;
  always @(*) begin
    headerGenerator_1_io_headerAxisOut_fifo_io_push_payload_user[0 : 0] = headerGenerator_1_io_headerAxisOut_payload_user[0 : 0];
    headerGenerator_1_io_headerAxisOut_fifo_io_push_payload_user[1 : 1] = headerGenerator_1_io_headerAxisOut_payload_user[1 : 1];
    headerGenerator_1_io_headerAxisOut_fifo_io_push_payload_user[2 : 2] = headerGenerator_1_io_headerAxisOut_payload_user[2 : 2];
    headerGenerator_1_io_headerAxisOut_fifo_io_push_payload_user[3 : 3] = headerGenerator_1_io_headerAxisOut_payload_user[3 : 3];
    headerGenerator_1_io_headerAxisOut_fifo_io_push_payload_user[4 : 4] = headerGenerator_1_io_headerAxisOut_payload_user[4 : 4];
    headerGenerator_1_io_headerAxisOut_fifo_io_push_payload_user[5 : 5] = headerGenerator_1_io_headerAxisOut_payload_user[5 : 5];
    headerGenerator_1_io_headerAxisOut_fifo_io_push_payload_user[6 : 6] = headerGenerator_1_io_headerAxisOut_payload_user[6 : 6];
    headerGenerator_1_io_headerAxisOut_fifo_io_push_payload_user[7 : 7] = headerGenerator_1_io_headerAxisOut_payload_user[7 : 7];
    headerGenerator_1_io_headerAxisOut_fifo_io_push_payload_user[8 : 8] = headerGenerator_1_io_headerAxisOut_payload_user[8 : 8];
    headerGenerator_1_io_headerAxisOut_fifo_io_push_payload_user[9 : 9] = headerGenerator_1_io_headerAxisOut_payload_user[9 : 9];
    headerGenerator_1_io_headerAxisOut_fifo_io_push_payload_user[10 : 10] = headerGenerator_1_io_headerAxisOut_payload_user[10 : 10];
    headerGenerator_1_io_headerAxisOut_fifo_io_push_payload_user[11 : 11] = headerGenerator_1_io_headerAxisOut_payload_user[11 : 11];
    headerGenerator_1_io_headerAxisOut_fifo_io_push_payload_user[12 : 12] = headerGenerator_1_io_headerAxisOut_payload_user[12 : 12];
    headerGenerator_1_io_headerAxisOut_fifo_io_push_payload_user[13 : 13] = headerGenerator_1_io_headerAxisOut_payload_user[13 : 13];
    headerGenerator_1_io_headerAxisOut_fifo_io_push_payload_user[14 : 14] = headerGenerator_1_io_headerAxisOut_payload_user[14 : 14];
    headerGenerator_1_io_headerAxisOut_fifo_io_push_payload_user[15 : 15] = headerGenerator_1_io_headerAxisOut_payload_user[15 : 15];
    headerGenerator_1_io_headerAxisOut_fifo_io_push_payload_user[16 : 16] = headerGenerator_1_io_headerAxisOut_payload_user[16 : 16];
    headerGenerator_1_io_headerAxisOut_fifo_io_push_payload_user[17 : 17] = headerGenerator_1_io_headerAxisOut_payload_user[17 : 17];
    headerGenerator_1_io_headerAxisOut_fifo_io_push_payload_user[18 : 18] = headerGenerator_1_io_headerAxisOut_payload_user[18 : 18];
    headerGenerator_1_io_headerAxisOut_fifo_io_push_payload_user[19 : 19] = headerGenerator_1_io_headerAxisOut_payload_user[19 : 19];
    headerGenerator_1_io_headerAxisOut_fifo_io_push_payload_user[20 : 20] = headerGenerator_1_io_headerAxisOut_payload_user[20 : 20];
    headerGenerator_1_io_headerAxisOut_fifo_io_push_payload_user[21 : 21] = headerGenerator_1_io_headerAxisOut_payload_user[21 : 21];
    headerGenerator_1_io_headerAxisOut_fifo_io_push_payload_user[22 : 22] = headerGenerator_1_io_headerAxisOut_payload_user[22 : 22];
    headerGenerator_1_io_headerAxisOut_fifo_io_push_payload_user[23 : 23] = headerGenerator_1_io_headerAxisOut_payload_user[23 : 23];
    headerGenerator_1_io_headerAxisOut_fifo_io_push_payload_user[24 : 24] = headerGenerator_1_io_headerAxisOut_payload_user[24 : 24];
    headerGenerator_1_io_headerAxisOut_fifo_io_push_payload_user[25 : 25] = headerGenerator_1_io_headerAxisOut_payload_user[25 : 25];
    headerGenerator_1_io_headerAxisOut_fifo_io_push_payload_user[26 : 26] = headerGenerator_1_io_headerAxisOut_payload_user[26 : 26];
    headerGenerator_1_io_headerAxisOut_fifo_io_push_payload_user[27 : 27] = headerGenerator_1_io_headerAxisOut_payload_user[27 : 27];
    headerGenerator_1_io_headerAxisOut_fifo_io_push_payload_user[28 : 28] = headerGenerator_1_io_headerAxisOut_payload_user[28 : 28];
    headerGenerator_1_io_headerAxisOut_fifo_io_push_payload_user[29 : 29] = headerGenerator_1_io_headerAxisOut_payload_user[29 : 29];
    headerGenerator_1_io_headerAxisOut_fifo_io_push_payload_user[30 : 30] = headerGenerator_1_io_headerAxisOut_payload_user[30 : 30];
    headerGenerator_1_io_headerAxisOut_fifo_io_push_payload_user[31 : 31] = headerGenerator_1_io_headerAxisOut_payload_user[31 : 31];
  end

  always @(*) begin
    io_dataAxisIn_fifo_io_pop_fork_io_input_payload_user[0 : 0] = io_dataAxisIn_fifo_io_pop_payload_user[0 : 0];
    io_dataAxisIn_fifo_io_pop_fork_io_input_payload_user[1 : 1] = io_dataAxisIn_fifo_io_pop_payload_user[1 : 1];
    io_dataAxisIn_fifo_io_pop_fork_io_input_payload_user[2 : 2] = io_dataAxisIn_fifo_io_pop_payload_user[2 : 2];
    io_dataAxisIn_fifo_io_pop_fork_io_input_payload_user[3 : 3] = io_dataAxisIn_fifo_io_pop_payload_user[3 : 3];
    io_dataAxisIn_fifo_io_pop_fork_io_input_payload_user[4 : 4] = io_dataAxisIn_fifo_io_pop_payload_user[4 : 4];
    io_dataAxisIn_fifo_io_pop_fork_io_input_payload_user[5 : 5] = io_dataAxisIn_fifo_io_pop_payload_user[5 : 5];
    io_dataAxisIn_fifo_io_pop_fork_io_input_payload_user[6 : 6] = io_dataAxisIn_fifo_io_pop_payload_user[6 : 6];
    io_dataAxisIn_fifo_io_pop_fork_io_input_payload_user[7 : 7] = io_dataAxisIn_fifo_io_pop_payload_user[7 : 7];
    io_dataAxisIn_fifo_io_pop_fork_io_input_payload_user[8 : 8] = io_dataAxisIn_fifo_io_pop_payload_user[8 : 8];
    io_dataAxisIn_fifo_io_pop_fork_io_input_payload_user[9 : 9] = io_dataAxisIn_fifo_io_pop_payload_user[9 : 9];
    io_dataAxisIn_fifo_io_pop_fork_io_input_payload_user[10 : 10] = io_dataAxisIn_fifo_io_pop_payload_user[10 : 10];
    io_dataAxisIn_fifo_io_pop_fork_io_input_payload_user[11 : 11] = io_dataAxisIn_fifo_io_pop_payload_user[11 : 11];
    io_dataAxisIn_fifo_io_pop_fork_io_input_payload_user[12 : 12] = io_dataAxisIn_fifo_io_pop_payload_user[12 : 12];
    io_dataAxisIn_fifo_io_pop_fork_io_input_payload_user[13 : 13] = io_dataAxisIn_fifo_io_pop_payload_user[13 : 13];
    io_dataAxisIn_fifo_io_pop_fork_io_input_payload_user[14 : 14] = io_dataAxisIn_fifo_io_pop_payload_user[14 : 14];
    io_dataAxisIn_fifo_io_pop_fork_io_input_payload_user[15 : 15] = io_dataAxisIn_fifo_io_pop_payload_user[15 : 15];
    io_dataAxisIn_fifo_io_pop_fork_io_input_payload_user[16 : 16] = io_dataAxisIn_fifo_io_pop_payload_user[16 : 16];
    io_dataAxisIn_fifo_io_pop_fork_io_input_payload_user[17 : 17] = io_dataAxisIn_fifo_io_pop_payload_user[17 : 17];
    io_dataAxisIn_fifo_io_pop_fork_io_input_payload_user[18 : 18] = io_dataAxisIn_fifo_io_pop_payload_user[18 : 18];
    io_dataAxisIn_fifo_io_pop_fork_io_input_payload_user[19 : 19] = io_dataAxisIn_fifo_io_pop_payload_user[19 : 19];
    io_dataAxisIn_fifo_io_pop_fork_io_input_payload_user[20 : 20] = io_dataAxisIn_fifo_io_pop_payload_user[20 : 20];
    io_dataAxisIn_fifo_io_pop_fork_io_input_payload_user[21 : 21] = io_dataAxisIn_fifo_io_pop_payload_user[21 : 21];
    io_dataAxisIn_fifo_io_pop_fork_io_input_payload_user[22 : 22] = io_dataAxisIn_fifo_io_pop_payload_user[22 : 22];
    io_dataAxisIn_fifo_io_pop_fork_io_input_payload_user[23 : 23] = io_dataAxisIn_fifo_io_pop_payload_user[23 : 23];
    io_dataAxisIn_fifo_io_pop_fork_io_input_payload_user[24 : 24] = io_dataAxisIn_fifo_io_pop_payload_user[24 : 24];
    io_dataAxisIn_fifo_io_pop_fork_io_input_payload_user[25 : 25] = io_dataAxisIn_fifo_io_pop_payload_user[25 : 25];
    io_dataAxisIn_fifo_io_pop_fork_io_input_payload_user[26 : 26] = io_dataAxisIn_fifo_io_pop_payload_user[26 : 26];
    io_dataAxisIn_fifo_io_pop_fork_io_input_payload_user[27 : 27] = io_dataAxisIn_fifo_io_pop_payload_user[27 : 27];
    io_dataAxisIn_fifo_io_pop_fork_io_input_payload_user[28 : 28] = io_dataAxisIn_fifo_io_pop_payload_user[28 : 28];
    io_dataAxisIn_fifo_io_pop_fork_io_input_payload_user[29 : 29] = io_dataAxisIn_fifo_io_pop_payload_user[29 : 29];
    io_dataAxisIn_fifo_io_pop_fork_io_input_payload_user[30 : 30] = io_dataAxisIn_fifo_io_pop_payload_user[30 : 30];
    io_dataAxisIn_fifo_io_pop_fork_io_input_payload_user[31 : 31] = io_dataAxisIn_fifo_io_pop_payload_user[31 : 31];
  end

  always @(*) begin
    io_dataAxisIn_fifo_io_pop_fork_io_outputs_0_ready = dataBufferedReg_ready;
    if(when_Stream_l368) begin
      io_dataAxisIn_fifo_io_pop_fork_io_outputs_0_ready = 1'b1;
    end
  end

  assign when_Stream_l368 = (! dataBufferedReg_valid);
  assign dataBufferedReg_valid = io_dataAxisIn_fifo_io_pop_fork_io_outputs_0_rValid;
  assign dataBufferedReg_payload_data = io_dataAxisIn_fifo_io_pop_fork_io_outputs_0_rData_data;
  assign dataBufferedReg_payload_keep = io_dataAxisIn_fifo_io_pop_fork_io_outputs_0_rData_keep;
  assign dataBufferedReg_payload_last = io_dataAxisIn_fifo_io_pop_fork_io_outputs_0_rData_last;
  always @(*) begin
    dataBufferedReg_payload_user[0 : 0] = io_dataAxisIn_fifo_io_pop_fork_io_outputs_0_rData_user[0 : 0];
    dataBufferedReg_payload_user[1 : 1] = io_dataAxisIn_fifo_io_pop_fork_io_outputs_0_rData_user[1 : 1];
    dataBufferedReg_payload_user[2 : 2] = io_dataAxisIn_fifo_io_pop_fork_io_outputs_0_rData_user[2 : 2];
    dataBufferedReg_payload_user[3 : 3] = io_dataAxisIn_fifo_io_pop_fork_io_outputs_0_rData_user[3 : 3];
    dataBufferedReg_payload_user[4 : 4] = io_dataAxisIn_fifo_io_pop_fork_io_outputs_0_rData_user[4 : 4];
    dataBufferedReg_payload_user[5 : 5] = io_dataAxisIn_fifo_io_pop_fork_io_outputs_0_rData_user[5 : 5];
    dataBufferedReg_payload_user[6 : 6] = io_dataAxisIn_fifo_io_pop_fork_io_outputs_0_rData_user[6 : 6];
    dataBufferedReg_payload_user[7 : 7] = io_dataAxisIn_fifo_io_pop_fork_io_outputs_0_rData_user[7 : 7];
    dataBufferedReg_payload_user[8 : 8] = io_dataAxisIn_fifo_io_pop_fork_io_outputs_0_rData_user[8 : 8];
    dataBufferedReg_payload_user[9 : 9] = io_dataAxisIn_fifo_io_pop_fork_io_outputs_0_rData_user[9 : 9];
    dataBufferedReg_payload_user[10 : 10] = io_dataAxisIn_fifo_io_pop_fork_io_outputs_0_rData_user[10 : 10];
    dataBufferedReg_payload_user[11 : 11] = io_dataAxisIn_fifo_io_pop_fork_io_outputs_0_rData_user[11 : 11];
    dataBufferedReg_payload_user[12 : 12] = io_dataAxisIn_fifo_io_pop_fork_io_outputs_0_rData_user[12 : 12];
    dataBufferedReg_payload_user[13 : 13] = io_dataAxisIn_fifo_io_pop_fork_io_outputs_0_rData_user[13 : 13];
    dataBufferedReg_payload_user[14 : 14] = io_dataAxisIn_fifo_io_pop_fork_io_outputs_0_rData_user[14 : 14];
    dataBufferedReg_payload_user[15 : 15] = io_dataAxisIn_fifo_io_pop_fork_io_outputs_0_rData_user[15 : 15];
    dataBufferedReg_payload_user[16 : 16] = io_dataAxisIn_fifo_io_pop_fork_io_outputs_0_rData_user[16 : 16];
    dataBufferedReg_payload_user[17 : 17] = io_dataAxisIn_fifo_io_pop_fork_io_outputs_0_rData_user[17 : 17];
    dataBufferedReg_payload_user[18 : 18] = io_dataAxisIn_fifo_io_pop_fork_io_outputs_0_rData_user[18 : 18];
    dataBufferedReg_payload_user[19 : 19] = io_dataAxisIn_fifo_io_pop_fork_io_outputs_0_rData_user[19 : 19];
    dataBufferedReg_payload_user[20 : 20] = io_dataAxisIn_fifo_io_pop_fork_io_outputs_0_rData_user[20 : 20];
    dataBufferedReg_payload_user[21 : 21] = io_dataAxisIn_fifo_io_pop_fork_io_outputs_0_rData_user[21 : 21];
    dataBufferedReg_payload_user[22 : 22] = io_dataAxisIn_fifo_io_pop_fork_io_outputs_0_rData_user[22 : 22];
    dataBufferedReg_payload_user[23 : 23] = io_dataAxisIn_fifo_io_pop_fork_io_outputs_0_rData_user[23 : 23];
    dataBufferedReg_payload_user[24 : 24] = io_dataAxisIn_fifo_io_pop_fork_io_outputs_0_rData_user[24 : 24];
    dataBufferedReg_payload_user[25 : 25] = io_dataAxisIn_fifo_io_pop_fork_io_outputs_0_rData_user[25 : 25];
    dataBufferedReg_payload_user[26 : 26] = io_dataAxisIn_fifo_io_pop_fork_io_outputs_0_rData_user[26 : 26];
    dataBufferedReg_payload_user[27 : 27] = io_dataAxisIn_fifo_io_pop_fork_io_outputs_0_rData_user[27 : 27];
    dataBufferedReg_payload_user[28 : 28] = io_dataAxisIn_fifo_io_pop_fork_io_outputs_0_rData_user[28 : 28];
    dataBufferedReg_payload_user[29 : 29] = io_dataAxisIn_fifo_io_pop_fork_io_outputs_0_rData_user[29 : 29];
    dataBufferedReg_payload_user[30 : 30] = io_dataAxisIn_fifo_io_pop_fork_io_outputs_0_rData_user[30 : 30];
    dataBufferedReg_payload_user[31 : 31] = io_dataAxisIn_fifo_io_pop_fork_io_outputs_0_rData_user[31 : 31];
  end

  always @(*) begin
    streamMux_1_io_inputs_0_payload_user[0 : 0] = headerGenerator_1_io_headerAxisOut_fifo_io_pop_payload_user[0 : 0];
    streamMux_1_io_inputs_0_payload_user[1 : 1] = headerGenerator_1_io_headerAxisOut_fifo_io_pop_payload_user[1 : 1];
    streamMux_1_io_inputs_0_payload_user[2 : 2] = headerGenerator_1_io_headerAxisOut_fifo_io_pop_payload_user[2 : 2];
    streamMux_1_io_inputs_0_payload_user[3 : 3] = headerGenerator_1_io_headerAxisOut_fifo_io_pop_payload_user[3 : 3];
    streamMux_1_io_inputs_0_payload_user[4 : 4] = headerGenerator_1_io_headerAxisOut_fifo_io_pop_payload_user[4 : 4];
    streamMux_1_io_inputs_0_payload_user[5 : 5] = headerGenerator_1_io_headerAxisOut_fifo_io_pop_payload_user[5 : 5];
    streamMux_1_io_inputs_0_payload_user[6 : 6] = headerGenerator_1_io_headerAxisOut_fifo_io_pop_payload_user[6 : 6];
    streamMux_1_io_inputs_0_payload_user[7 : 7] = headerGenerator_1_io_headerAxisOut_fifo_io_pop_payload_user[7 : 7];
    streamMux_1_io_inputs_0_payload_user[8 : 8] = headerGenerator_1_io_headerAxisOut_fifo_io_pop_payload_user[8 : 8];
    streamMux_1_io_inputs_0_payload_user[9 : 9] = headerGenerator_1_io_headerAxisOut_fifo_io_pop_payload_user[9 : 9];
    streamMux_1_io_inputs_0_payload_user[10 : 10] = headerGenerator_1_io_headerAxisOut_fifo_io_pop_payload_user[10 : 10];
    streamMux_1_io_inputs_0_payload_user[11 : 11] = headerGenerator_1_io_headerAxisOut_fifo_io_pop_payload_user[11 : 11];
    streamMux_1_io_inputs_0_payload_user[12 : 12] = headerGenerator_1_io_headerAxisOut_fifo_io_pop_payload_user[12 : 12];
    streamMux_1_io_inputs_0_payload_user[13 : 13] = headerGenerator_1_io_headerAxisOut_fifo_io_pop_payload_user[13 : 13];
    streamMux_1_io_inputs_0_payload_user[14 : 14] = headerGenerator_1_io_headerAxisOut_fifo_io_pop_payload_user[14 : 14];
    streamMux_1_io_inputs_0_payload_user[15 : 15] = headerGenerator_1_io_headerAxisOut_fifo_io_pop_payload_user[15 : 15];
    streamMux_1_io_inputs_0_payload_user[16 : 16] = headerGenerator_1_io_headerAxisOut_fifo_io_pop_payload_user[16 : 16];
    streamMux_1_io_inputs_0_payload_user[17 : 17] = headerGenerator_1_io_headerAxisOut_fifo_io_pop_payload_user[17 : 17];
    streamMux_1_io_inputs_0_payload_user[18 : 18] = headerGenerator_1_io_headerAxisOut_fifo_io_pop_payload_user[18 : 18];
    streamMux_1_io_inputs_0_payload_user[19 : 19] = headerGenerator_1_io_headerAxisOut_fifo_io_pop_payload_user[19 : 19];
    streamMux_1_io_inputs_0_payload_user[20 : 20] = headerGenerator_1_io_headerAxisOut_fifo_io_pop_payload_user[20 : 20];
    streamMux_1_io_inputs_0_payload_user[21 : 21] = headerGenerator_1_io_headerAxisOut_fifo_io_pop_payload_user[21 : 21];
    streamMux_1_io_inputs_0_payload_user[22 : 22] = headerGenerator_1_io_headerAxisOut_fifo_io_pop_payload_user[22 : 22];
    streamMux_1_io_inputs_0_payload_user[23 : 23] = headerGenerator_1_io_headerAxisOut_fifo_io_pop_payload_user[23 : 23];
    streamMux_1_io_inputs_0_payload_user[24 : 24] = headerGenerator_1_io_headerAxisOut_fifo_io_pop_payload_user[24 : 24];
    streamMux_1_io_inputs_0_payload_user[25 : 25] = headerGenerator_1_io_headerAxisOut_fifo_io_pop_payload_user[25 : 25];
    streamMux_1_io_inputs_0_payload_user[26 : 26] = headerGenerator_1_io_headerAxisOut_fifo_io_pop_payload_user[26 : 26];
    streamMux_1_io_inputs_0_payload_user[27 : 27] = headerGenerator_1_io_headerAxisOut_fifo_io_pop_payload_user[27 : 27];
    streamMux_1_io_inputs_0_payload_user[28 : 28] = headerGenerator_1_io_headerAxisOut_fifo_io_pop_payload_user[28 : 28];
    streamMux_1_io_inputs_0_payload_user[29 : 29] = headerGenerator_1_io_headerAxisOut_fifo_io_pop_payload_user[29 : 29];
    streamMux_1_io_inputs_0_payload_user[30 : 30] = headerGenerator_1_io_headerAxisOut_fifo_io_pop_payload_user[30 : 30];
    streamMux_1_io_inputs_0_payload_user[31 : 31] = headerGenerator_1_io_headerAxisOut_fifo_io_pop_payload_user[31 : 31];
  end

  assign dataBufferedReg_ready = streamMux_1_io_inputs_1_ready;
  always @(*) begin
    streamMux_1_io_inputs_1_payload_user[0 : 0] = dataBufferedReg_payload_user[0 : 0];
    streamMux_1_io_inputs_1_payload_user[1 : 1] = dataBufferedReg_payload_user[1 : 1];
    streamMux_1_io_inputs_1_payload_user[2 : 2] = dataBufferedReg_payload_user[2 : 2];
    streamMux_1_io_inputs_1_payload_user[3 : 3] = dataBufferedReg_payload_user[3 : 3];
    streamMux_1_io_inputs_1_payload_user[4 : 4] = dataBufferedReg_payload_user[4 : 4];
    streamMux_1_io_inputs_1_payload_user[5 : 5] = dataBufferedReg_payload_user[5 : 5];
    streamMux_1_io_inputs_1_payload_user[6 : 6] = dataBufferedReg_payload_user[6 : 6];
    streamMux_1_io_inputs_1_payload_user[7 : 7] = dataBufferedReg_payload_user[7 : 7];
    streamMux_1_io_inputs_1_payload_user[8 : 8] = dataBufferedReg_payload_user[8 : 8];
    streamMux_1_io_inputs_1_payload_user[9 : 9] = dataBufferedReg_payload_user[9 : 9];
    streamMux_1_io_inputs_1_payload_user[10 : 10] = dataBufferedReg_payload_user[10 : 10];
    streamMux_1_io_inputs_1_payload_user[11 : 11] = dataBufferedReg_payload_user[11 : 11];
    streamMux_1_io_inputs_1_payload_user[12 : 12] = dataBufferedReg_payload_user[12 : 12];
    streamMux_1_io_inputs_1_payload_user[13 : 13] = dataBufferedReg_payload_user[13 : 13];
    streamMux_1_io_inputs_1_payload_user[14 : 14] = dataBufferedReg_payload_user[14 : 14];
    streamMux_1_io_inputs_1_payload_user[15 : 15] = dataBufferedReg_payload_user[15 : 15];
    streamMux_1_io_inputs_1_payload_user[16 : 16] = dataBufferedReg_payload_user[16 : 16];
    streamMux_1_io_inputs_1_payload_user[17 : 17] = dataBufferedReg_payload_user[17 : 17];
    streamMux_1_io_inputs_1_payload_user[18 : 18] = dataBufferedReg_payload_user[18 : 18];
    streamMux_1_io_inputs_1_payload_user[19 : 19] = dataBufferedReg_payload_user[19 : 19];
    streamMux_1_io_inputs_1_payload_user[20 : 20] = dataBufferedReg_payload_user[20 : 20];
    streamMux_1_io_inputs_1_payload_user[21 : 21] = dataBufferedReg_payload_user[21 : 21];
    streamMux_1_io_inputs_1_payload_user[22 : 22] = dataBufferedReg_payload_user[22 : 22];
    streamMux_1_io_inputs_1_payload_user[23 : 23] = dataBufferedReg_payload_user[23 : 23];
    streamMux_1_io_inputs_1_payload_user[24 : 24] = dataBufferedReg_payload_user[24 : 24];
    streamMux_1_io_inputs_1_payload_user[25 : 25] = dataBufferedReg_payload_user[25 : 25];
    streamMux_1_io_inputs_1_payload_user[26 : 26] = dataBufferedReg_payload_user[26 : 26];
    streamMux_1_io_inputs_1_payload_user[27 : 27] = dataBufferedReg_payload_user[27 : 27];
    streamMux_1_io_inputs_1_payload_user[28 : 28] = dataBufferedReg_payload_user[28 : 28];
    streamMux_1_io_inputs_1_payload_user[29 : 29] = dataBufferedReg_payload_user[29 : 29];
    streamMux_1_io_inputs_1_payload_user[30 : 30] = dataBufferedReg_payload_user[30 : 30];
    streamMux_1_io_inputs_1_payload_user[31 : 31] = dataBufferedReg_payload_user[31 : 31];
  end

  assign streamMux_1_io_output_ready = (! streamMux_1_io_output_rValid);
  assign streamMux_1_io_output_s2mPipe_valid = (streamMux_1_io_output_valid || streamMux_1_io_output_rValid);
  assign _zz_payload_user = (streamMux_1_io_output_rValid ? streamMux_1_io_output_rData_user : streamMux_1_io_output_payload_user);
  assign streamMux_1_io_output_s2mPipe_payload_data = (streamMux_1_io_output_rValid ? streamMux_1_io_output_rData_data : streamMux_1_io_output_payload_data);
  assign streamMux_1_io_output_s2mPipe_payload_keep = (streamMux_1_io_output_rValid ? streamMux_1_io_output_rData_keep : streamMux_1_io_output_payload_keep);
  assign streamMux_1_io_output_s2mPipe_payload_last = (streamMux_1_io_output_rValid ? streamMux_1_io_output_rData_last : streamMux_1_io_output_payload_last);
  always @(*) begin
    streamMux_1_io_output_s2mPipe_payload_user[0 : 0] = _zz_payload_user[0 : 0];
    streamMux_1_io_output_s2mPipe_payload_user[1 : 1] = _zz_payload_user[1 : 1];
    streamMux_1_io_output_s2mPipe_payload_user[2 : 2] = _zz_payload_user[2 : 2];
    streamMux_1_io_output_s2mPipe_payload_user[3 : 3] = _zz_payload_user[3 : 3];
    streamMux_1_io_output_s2mPipe_payload_user[4 : 4] = _zz_payload_user[4 : 4];
    streamMux_1_io_output_s2mPipe_payload_user[5 : 5] = _zz_payload_user[5 : 5];
    streamMux_1_io_output_s2mPipe_payload_user[6 : 6] = _zz_payload_user[6 : 6];
    streamMux_1_io_output_s2mPipe_payload_user[7 : 7] = _zz_payload_user[7 : 7];
    streamMux_1_io_output_s2mPipe_payload_user[8 : 8] = _zz_payload_user[8 : 8];
    streamMux_1_io_output_s2mPipe_payload_user[9 : 9] = _zz_payload_user[9 : 9];
    streamMux_1_io_output_s2mPipe_payload_user[10 : 10] = _zz_payload_user[10 : 10];
    streamMux_1_io_output_s2mPipe_payload_user[11 : 11] = _zz_payload_user[11 : 11];
    streamMux_1_io_output_s2mPipe_payload_user[12 : 12] = _zz_payload_user[12 : 12];
    streamMux_1_io_output_s2mPipe_payload_user[13 : 13] = _zz_payload_user[13 : 13];
    streamMux_1_io_output_s2mPipe_payload_user[14 : 14] = _zz_payload_user[14 : 14];
    streamMux_1_io_output_s2mPipe_payload_user[15 : 15] = _zz_payload_user[15 : 15];
    streamMux_1_io_output_s2mPipe_payload_user[16 : 16] = _zz_payload_user[16 : 16];
    streamMux_1_io_output_s2mPipe_payload_user[17 : 17] = _zz_payload_user[17 : 17];
    streamMux_1_io_output_s2mPipe_payload_user[18 : 18] = _zz_payload_user[18 : 18];
    streamMux_1_io_output_s2mPipe_payload_user[19 : 19] = _zz_payload_user[19 : 19];
    streamMux_1_io_output_s2mPipe_payload_user[20 : 20] = _zz_payload_user[20 : 20];
    streamMux_1_io_output_s2mPipe_payload_user[21 : 21] = _zz_payload_user[21 : 21];
    streamMux_1_io_output_s2mPipe_payload_user[22 : 22] = _zz_payload_user[22 : 22];
    streamMux_1_io_output_s2mPipe_payload_user[23 : 23] = _zz_payload_user[23 : 23];
    streamMux_1_io_output_s2mPipe_payload_user[24 : 24] = _zz_payload_user[24 : 24];
    streamMux_1_io_output_s2mPipe_payload_user[25 : 25] = _zz_payload_user[25 : 25];
    streamMux_1_io_output_s2mPipe_payload_user[26 : 26] = _zz_payload_user[26 : 26];
    streamMux_1_io_output_s2mPipe_payload_user[27 : 27] = _zz_payload_user[27 : 27];
    streamMux_1_io_output_s2mPipe_payload_user[28 : 28] = _zz_payload_user[28 : 28];
    streamMux_1_io_output_s2mPipe_payload_user[29 : 29] = _zz_payload_user[29 : 29];
    streamMux_1_io_output_s2mPipe_payload_user[30 : 30] = _zz_payload_user[30 : 30];
    streamMux_1_io_output_s2mPipe_payload_user[31 : 31] = _zz_payload_user[31 : 31];
  end

  always @(*) begin
    selectedStream_valid = streamMux_1_io_output_s2mPipe_valid;
    if(invalidData) begin
      selectedStream_valid = 1'b0;
    end
  end

  always @(*) begin
    streamMux_1_io_output_s2mPipe_ready = selectedStream_ready;
    if(invalidData) begin
      streamMux_1_io_output_s2mPipe_ready = 1'b1;
    end
  end

  assign selectedStream_payload_data = streamMux_1_io_output_s2mPipe_payload_data;
  assign selectedStream_payload_keep = streamMux_1_io_output_s2mPipe_payload_keep;
  assign selectedStream_payload_last = streamMux_1_io_output_s2mPipe_payload_last;
  always @(*) begin
    selectedStream_payload_user[0 : 0] = streamMux_1_io_output_s2mPipe_payload_user[0 : 0];
    selectedStream_payload_user[1 : 1] = streamMux_1_io_output_s2mPipe_payload_user[1 : 1];
    selectedStream_payload_user[2 : 2] = streamMux_1_io_output_s2mPipe_payload_user[2 : 2];
    selectedStream_payload_user[3 : 3] = streamMux_1_io_output_s2mPipe_payload_user[3 : 3];
    selectedStream_payload_user[4 : 4] = streamMux_1_io_output_s2mPipe_payload_user[4 : 4];
    selectedStream_payload_user[5 : 5] = streamMux_1_io_output_s2mPipe_payload_user[5 : 5];
    selectedStream_payload_user[6 : 6] = streamMux_1_io_output_s2mPipe_payload_user[6 : 6];
    selectedStream_payload_user[7 : 7] = streamMux_1_io_output_s2mPipe_payload_user[7 : 7];
    selectedStream_payload_user[8 : 8] = streamMux_1_io_output_s2mPipe_payload_user[8 : 8];
    selectedStream_payload_user[9 : 9] = streamMux_1_io_output_s2mPipe_payload_user[9 : 9];
    selectedStream_payload_user[10 : 10] = streamMux_1_io_output_s2mPipe_payload_user[10 : 10];
    selectedStream_payload_user[11 : 11] = streamMux_1_io_output_s2mPipe_payload_user[11 : 11];
    selectedStream_payload_user[12 : 12] = streamMux_1_io_output_s2mPipe_payload_user[12 : 12];
    selectedStream_payload_user[13 : 13] = streamMux_1_io_output_s2mPipe_payload_user[13 : 13];
    selectedStream_payload_user[14 : 14] = streamMux_1_io_output_s2mPipe_payload_user[14 : 14];
    selectedStream_payload_user[15 : 15] = streamMux_1_io_output_s2mPipe_payload_user[15 : 15];
    selectedStream_payload_user[16 : 16] = streamMux_1_io_output_s2mPipe_payload_user[16 : 16];
    selectedStream_payload_user[17 : 17] = streamMux_1_io_output_s2mPipe_payload_user[17 : 17];
    selectedStream_payload_user[18 : 18] = streamMux_1_io_output_s2mPipe_payload_user[18 : 18];
    selectedStream_payload_user[19 : 19] = streamMux_1_io_output_s2mPipe_payload_user[19 : 19];
    selectedStream_payload_user[20 : 20] = streamMux_1_io_output_s2mPipe_payload_user[20 : 20];
    selectedStream_payload_user[21 : 21] = streamMux_1_io_output_s2mPipe_payload_user[21 : 21];
    selectedStream_payload_user[22 : 22] = streamMux_1_io_output_s2mPipe_payload_user[22 : 22];
    selectedStream_payload_user[23 : 23] = streamMux_1_io_output_s2mPipe_payload_user[23 : 23];
    selectedStream_payload_user[24 : 24] = streamMux_1_io_output_s2mPipe_payload_user[24 : 24];
    selectedStream_payload_user[25 : 25] = streamMux_1_io_output_s2mPipe_payload_user[25 : 25];
    selectedStream_payload_user[26 : 26] = streamMux_1_io_output_s2mPipe_payload_user[26 : 26];
    selectedStream_payload_user[27 : 27] = streamMux_1_io_output_s2mPipe_payload_user[27 : 27];
    selectedStream_payload_user[28 : 28] = streamMux_1_io_output_s2mPipe_payload_user[28 : 28];
    selectedStream_payload_user[29 : 29] = streamMux_1_io_output_s2mPipe_payload_user[29 : 29];
    selectedStream_payload_user[30 : 30] = streamMux_1_io_output_s2mPipe_payload_user[30 : 30];
    selectedStream_payload_user[31 : 31] = streamMux_1_io_output_s2mPipe_payload_user[31 : 31];
  end

  assign io_dataAxisIn_fifo_io_pop_fork_io_outputs_1_ready = (streamJoinReg1 ? (_zz_selectedStream_ready && _zz_selectedStream_ready_1) : 1'b0);
  assign when_StreamUtils_l26 = (! io_dataAxisIn_fifo_io_pop_fork_io_outputs_1_valid);
  always @(*) begin
    if(when_StreamUtils_l26) begin
      _zz_joinedStream_payload_2_data = 256'h0;
    end else begin
      _zz_joinedStream_payload_2_data = io_dataAxisIn_fifo_io_pop_fork_io_outputs_1_payload_data;
    end
  end

  assign when_StreamUtils_l26_1 = (! io_dataAxisIn_fifo_io_pop_fork_io_outputs_1_valid);
  always @(*) begin
    if(when_StreamUtils_l26_1) begin
      _zz_joinedStream_payload_2_keep = 32'h0;
    end else begin
      _zz_joinedStream_payload_2_keep = io_dataAxisIn_fifo_io_pop_fork_io_outputs_1_payload_keep;
    end
  end

  assign when_StreamUtils_l26_2 = (! io_dataAxisIn_fifo_io_pop_fork_io_outputs_1_valid);
  always @(*) begin
    if(when_StreamUtils_l26_2) begin
      _zz_joinedStream_payload_2_last = 1'b0;
    end else begin
      _zz_joinedStream_payload_2_last = io_dataAxisIn_fifo_io_pop_fork_io_outputs_1_payload_last;
    end
  end

  assign when_StreamUtils_l26_3 = (! io_dataAxisIn_fifo_io_pop_fork_io_outputs_1_valid);
  always @(*) begin
    if(when_StreamUtils_l26_3) begin
      _zz_joinedStream_payload_2_user = 32'h0;
    end else begin
      _zz_joinedStream_payload_2_user = io_dataAxisIn_fifo_io_pop_fork_io_outputs_1_payload_user;
    end
  end

  assign _zz_selectedStream_ready = (streamJoinReg1 ? (selectedStream_valid && io_dataAxisIn_fifo_io_pop_fork_io_outputs_1_valid) : selectedStream_valid);
  assign selectedStream_ready = (_zz_selectedStream_ready && _zz_selectedStream_ready_1);
  always @(*) begin
    _zz_joinedStream_payload_1_user[0 : 0] = selectedStream_payload_user[0 : 0];
    _zz_joinedStream_payload_1_user[1 : 1] = selectedStream_payload_user[1 : 1];
    _zz_joinedStream_payload_1_user[2 : 2] = selectedStream_payload_user[2 : 2];
    _zz_joinedStream_payload_1_user[3 : 3] = selectedStream_payload_user[3 : 3];
    _zz_joinedStream_payload_1_user[4 : 4] = selectedStream_payload_user[4 : 4];
    _zz_joinedStream_payload_1_user[5 : 5] = selectedStream_payload_user[5 : 5];
    _zz_joinedStream_payload_1_user[6 : 6] = selectedStream_payload_user[6 : 6];
    _zz_joinedStream_payload_1_user[7 : 7] = selectedStream_payload_user[7 : 7];
    _zz_joinedStream_payload_1_user[8 : 8] = selectedStream_payload_user[8 : 8];
    _zz_joinedStream_payload_1_user[9 : 9] = selectedStream_payload_user[9 : 9];
    _zz_joinedStream_payload_1_user[10 : 10] = selectedStream_payload_user[10 : 10];
    _zz_joinedStream_payload_1_user[11 : 11] = selectedStream_payload_user[11 : 11];
    _zz_joinedStream_payload_1_user[12 : 12] = selectedStream_payload_user[12 : 12];
    _zz_joinedStream_payload_1_user[13 : 13] = selectedStream_payload_user[13 : 13];
    _zz_joinedStream_payload_1_user[14 : 14] = selectedStream_payload_user[14 : 14];
    _zz_joinedStream_payload_1_user[15 : 15] = selectedStream_payload_user[15 : 15];
    _zz_joinedStream_payload_1_user[16 : 16] = selectedStream_payload_user[16 : 16];
    _zz_joinedStream_payload_1_user[17 : 17] = selectedStream_payload_user[17 : 17];
    _zz_joinedStream_payload_1_user[18 : 18] = selectedStream_payload_user[18 : 18];
    _zz_joinedStream_payload_1_user[19 : 19] = selectedStream_payload_user[19 : 19];
    _zz_joinedStream_payload_1_user[20 : 20] = selectedStream_payload_user[20 : 20];
    _zz_joinedStream_payload_1_user[21 : 21] = selectedStream_payload_user[21 : 21];
    _zz_joinedStream_payload_1_user[22 : 22] = selectedStream_payload_user[22 : 22];
    _zz_joinedStream_payload_1_user[23 : 23] = selectedStream_payload_user[23 : 23];
    _zz_joinedStream_payload_1_user[24 : 24] = selectedStream_payload_user[24 : 24];
    _zz_joinedStream_payload_1_user[25 : 25] = selectedStream_payload_user[25 : 25];
    _zz_joinedStream_payload_1_user[26 : 26] = selectedStream_payload_user[26 : 26];
    _zz_joinedStream_payload_1_user[27 : 27] = selectedStream_payload_user[27 : 27];
    _zz_joinedStream_payload_1_user[28 : 28] = selectedStream_payload_user[28 : 28];
    _zz_joinedStream_payload_1_user[29 : 29] = selectedStream_payload_user[29 : 29];
    _zz_joinedStream_payload_1_user[30 : 30] = selectedStream_payload_user[30 : 30];
    _zz_joinedStream_payload_1_user[31 : 31] = selectedStream_payload_user[31 : 31];
  end

  always @(*) begin
    _zz_joinedStream_payload_2_user_1[0 : 0] = _zz_joinedStream_payload_2_user[0 : 0];
    _zz_joinedStream_payload_2_user_1[1 : 1] = _zz_joinedStream_payload_2_user[1 : 1];
    _zz_joinedStream_payload_2_user_1[2 : 2] = _zz_joinedStream_payload_2_user[2 : 2];
    _zz_joinedStream_payload_2_user_1[3 : 3] = _zz_joinedStream_payload_2_user[3 : 3];
    _zz_joinedStream_payload_2_user_1[4 : 4] = _zz_joinedStream_payload_2_user[4 : 4];
    _zz_joinedStream_payload_2_user_1[5 : 5] = _zz_joinedStream_payload_2_user[5 : 5];
    _zz_joinedStream_payload_2_user_1[6 : 6] = _zz_joinedStream_payload_2_user[6 : 6];
    _zz_joinedStream_payload_2_user_1[7 : 7] = _zz_joinedStream_payload_2_user[7 : 7];
    _zz_joinedStream_payload_2_user_1[8 : 8] = _zz_joinedStream_payload_2_user[8 : 8];
    _zz_joinedStream_payload_2_user_1[9 : 9] = _zz_joinedStream_payload_2_user[9 : 9];
    _zz_joinedStream_payload_2_user_1[10 : 10] = _zz_joinedStream_payload_2_user[10 : 10];
    _zz_joinedStream_payload_2_user_1[11 : 11] = _zz_joinedStream_payload_2_user[11 : 11];
    _zz_joinedStream_payload_2_user_1[12 : 12] = _zz_joinedStream_payload_2_user[12 : 12];
    _zz_joinedStream_payload_2_user_1[13 : 13] = _zz_joinedStream_payload_2_user[13 : 13];
    _zz_joinedStream_payload_2_user_1[14 : 14] = _zz_joinedStream_payload_2_user[14 : 14];
    _zz_joinedStream_payload_2_user_1[15 : 15] = _zz_joinedStream_payload_2_user[15 : 15];
    _zz_joinedStream_payload_2_user_1[16 : 16] = _zz_joinedStream_payload_2_user[16 : 16];
    _zz_joinedStream_payload_2_user_1[17 : 17] = _zz_joinedStream_payload_2_user[17 : 17];
    _zz_joinedStream_payload_2_user_1[18 : 18] = _zz_joinedStream_payload_2_user[18 : 18];
    _zz_joinedStream_payload_2_user_1[19 : 19] = _zz_joinedStream_payload_2_user[19 : 19];
    _zz_joinedStream_payload_2_user_1[20 : 20] = _zz_joinedStream_payload_2_user[20 : 20];
    _zz_joinedStream_payload_2_user_1[21 : 21] = _zz_joinedStream_payload_2_user[21 : 21];
    _zz_joinedStream_payload_2_user_1[22 : 22] = _zz_joinedStream_payload_2_user[22 : 22];
    _zz_joinedStream_payload_2_user_1[23 : 23] = _zz_joinedStream_payload_2_user[23 : 23];
    _zz_joinedStream_payload_2_user_1[24 : 24] = _zz_joinedStream_payload_2_user[24 : 24];
    _zz_joinedStream_payload_2_user_1[25 : 25] = _zz_joinedStream_payload_2_user[25 : 25];
    _zz_joinedStream_payload_2_user_1[26 : 26] = _zz_joinedStream_payload_2_user[26 : 26];
    _zz_joinedStream_payload_2_user_1[27 : 27] = _zz_joinedStream_payload_2_user[27 : 27];
    _zz_joinedStream_payload_2_user_1[28 : 28] = _zz_joinedStream_payload_2_user[28 : 28];
    _zz_joinedStream_payload_2_user_1[29 : 29] = _zz_joinedStream_payload_2_user[29 : 29];
    _zz_joinedStream_payload_2_user_1[30 : 30] = _zz_joinedStream_payload_2_user[30 : 30];
    _zz_joinedStream_payload_2_user_1[31 : 31] = _zz_joinedStream_payload_2_user[31 : 31];
  end

  always @(*) begin
    _zz_selectedStream_ready_1 = joinedStream_ready;
    if(when_Stream_l368_1) begin
      _zz_selectedStream_ready_1 = 1'b1;
    end
  end

  assign when_Stream_l368_1 = (! joinedStream_valid);
  assign joinedStream_valid = _zz_joinedStream_valid;
  assign joinedStream_payload_1_data = _zz_joinedStream_payload_1_data;
  assign joinedStream_payload_1_keep = _zz_joinedStream_payload_1_keep;
  assign joinedStream_payload_1_last = _zz_joinedStream_payload_1_last;
  always @(*) begin
    joinedStream_payload_1_user[0 : 0] = _zz_joinedStream_payload_1_user_1[0 : 0];
    joinedStream_payload_1_user[1 : 1] = _zz_joinedStream_payload_1_user_1[1 : 1];
    joinedStream_payload_1_user[2 : 2] = _zz_joinedStream_payload_1_user_1[2 : 2];
    joinedStream_payload_1_user[3 : 3] = _zz_joinedStream_payload_1_user_1[3 : 3];
    joinedStream_payload_1_user[4 : 4] = _zz_joinedStream_payload_1_user_1[4 : 4];
    joinedStream_payload_1_user[5 : 5] = _zz_joinedStream_payload_1_user_1[5 : 5];
    joinedStream_payload_1_user[6 : 6] = _zz_joinedStream_payload_1_user_1[6 : 6];
    joinedStream_payload_1_user[7 : 7] = _zz_joinedStream_payload_1_user_1[7 : 7];
    joinedStream_payload_1_user[8 : 8] = _zz_joinedStream_payload_1_user_1[8 : 8];
    joinedStream_payload_1_user[9 : 9] = _zz_joinedStream_payload_1_user_1[9 : 9];
    joinedStream_payload_1_user[10 : 10] = _zz_joinedStream_payload_1_user_1[10 : 10];
    joinedStream_payload_1_user[11 : 11] = _zz_joinedStream_payload_1_user_1[11 : 11];
    joinedStream_payload_1_user[12 : 12] = _zz_joinedStream_payload_1_user_1[12 : 12];
    joinedStream_payload_1_user[13 : 13] = _zz_joinedStream_payload_1_user_1[13 : 13];
    joinedStream_payload_1_user[14 : 14] = _zz_joinedStream_payload_1_user_1[14 : 14];
    joinedStream_payload_1_user[15 : 15] = _zz_joinedStream_payload_1_user_1[15 : 15];
    joinedStream_payload_1_user[16 : 16] = _zz_joinedStream_payload_1_user_1[16 : 16];
    joinedStream_payload_1_user[17 : 17] = _zz_joinedStream_payload_1_user_1[17 : 17];
    joinedStream_payload_1_user[18 : 18] = _zz_joinedStream_payload_1_user_1[18 : 18];
    joinedStream_payload_1_user[19 : 19] = _zz_joinedStream_payload_1_user_1[19 : 19];
    joinedStream_payload_1_user[20 : 20] = _zz_joinedStream_payload_1_user_1[20 : 20];
    joinedStream_payload_1_user[21 : 21] = _zz_joinedStream_payload_1_user_1[21 : 21];
    joinedStream_payload_1_user[22 : 22] = _zz_joinedStream_payload_1_user_1[22 : 22];
    joinedStream_payload_1_user[23 : 23] = _zz_joinedStream_payload_1_user_1[23 : 23];
    joinedStream_payload_1_user[24 : 24] = _zz_joinedStream_payload_1_user_1[24 : 24];
    joinedStream_payload_1_user[25 : 25] = _zz_joinedStream_payload_1_user_1[25 : 25];
    joinedStream_payload_1_user[26 : 26] = _zz_joinedStream_payload_1_user_1[26 : 26];
    joinedStream_payload_1_user[27 : 27] = _zz_joinedStream_payload_1_user_1[27 : 27];
    joinedStream_payload_1_user[28 : 28] = _zz_joinedStream_payload_1_user_1[28 : 28];
    joinedStream_payload_1_user[29 : 29] = _zz_joinedStream_payload_1_user_1[29 : 29];
    joinedStream_payload_1_user[30 : 30] = _zz_joinedStream_payload_1_user_1[30 : 30];
    joinedStream_payload_1_user[31 : 31] = _zz_joinedStream_payload_1_user_1[31 : 31];
  end

  assign joinedStream_payload_2_data = _zz_joinedStream_payload_2_data_1;
  assign joinedStream_payload_2_keep = _zz_joinedStream_payload_2_keep_1;
  assign joinedStream_payload_2_last = _zz_joinedStream_payload_2_last_1;
  always @(*) begin
    joinedStream_payload_2_user[0 : 0] = _zz_joinedStream_payload_2_user_2[0 : 0];
    joinedStream_payload_2_user[1 : 1] = _zz_joinedStream_payload_2_user_2[1 : 1];
    joinedStream_payload_2_user[2 : 2] = _zz_joinedStream_payload_2_user_2[2 : 2];
    joinedStream_payload_2_user[3 : 3] = _zz_joinedStream_payload_2_user_2[3 : 3];
    joinedStream_payload_2_user[4 : 4] = _zz_joinedStream_payload_2_user_2[4 : 4];
    joinedStream_payload_2_user[5 : 5] = _zz_joinedStream_payload_2_user_2[5 : 5];
    joinedStream_payload_2_user[6 : 6] = _zz_joinedStream_payload_2_user_2[6 : 6];
    joinedStream_payload_2_user[7 : 7] = _zz_joinedStream_payload_2_user_2[7 : 7];
    joinedStream_payload_2_user[8 : 8] = _zz_joinedStream_payload_2_user_2[8 : 8];
    joinedStream_payload_2_user[9 : 9] = _zz_joinedStream_payload_2_user_2[9 : 9];
    joinedStream_payload_2_user[10 : 10] = _zz_joinedStream_payload_2_user_2[10 : 10];
    joinedStream_payload_2_user[11 : 11] = _zz_joinedStream_payload_2_user_2[11 : 11];
    joinedStream_payload_2_user[12 : 12] = _zz_joinedStream_payload_2_user_2[12 : 12];
    joinedStream_payload_2_user[13 : 13] = _zz_joinedStream_payload_2_user_2[13 : 13];
    joinedStream_payload_2_user[14 : 14] = _zz_joinedStream_payload_2_user_2[14 : 14];
    joinedStream_payload_2_user[15 : 15] = _zz_joinedStream_payload_2_user_2[15 : 15];
    joinedStream_payload_2_user[16 : 16] = _zz_joinedStream_payload_2_user_2[16 : 16];
    joinedStream_payload_2_user[17 : 17] = _zz_joinedStream_payload_2_user_2[17 : 17];
    joinedStream_payload_2_user[18 : 18] = _zz_joinedStream_payload_2_user_2[18 : 18];
    joinedStream_payload_2_user[19 : 19] = _zz_joinedStream_payload_2_user_2[19 : 19];
    joinedStream_payload_2_user[20 : 20] = _zz_joinedStream_payload_2_user_2[20 : 20];
    joinedStream_payload_2_user[21 : 21] = _zz_joinedStream_payload_2_user_2[21 : 21];
    joinedStream_payload_2_user[22 : 22] = _zz_joinedStream_payload_2_user_2[22 : 22];
    joinedStream_payload_2_user[23 : 23] = _zz_joinedStream_payload_2_user_2[23 : 23];
    joinedStream_payload_2_user[24 : 24] = _zz_joinedStream_payload_2_user_2[24 : 24];
    joinedStream_payload_2_user[25 : 25] = _zz_joinedStream_payload_2_user_2[25 : 25];
    joinedStream_payload_2_user[26 : 26] = _zz_joinedStream_payload_2_user_2[26 : 26];
    joinedStream_payload_2_user[27 : 27] = _zz_joinedStream_payload_2_user_2[27 : 27];
    joinedStream_payload_2_user[28 : 28] = _zz_joinedStream_payload_2_user_2[28 : 28];
    joinedStream_payload_2_user[29 : 29] = _zz_joinedStream_payload_2_user_2[29 : 29];
    joinedStream_payload_2_user[30 : 30] = _zz_joinedStream_payload_2_user_2[30 : 30];
    joinedStream_payload_2_user[31 : 31] = _zz_joinedStream_payload_2_user_2[31 : 31];
  end

  assign io_dataAxisIn_fifo_io_pop_fork_io_outputs_1_fire = (io_dataAxisIn_fifo_io_pop_fork_io_outputs_1_valid && io_dataAxisIn_fifo_io_pop_fork_io_outputs_1_ready);
  assign when_UDPTx_l64 = (io_dataAxisIn_fifo_io_pop_fork_io_outputs_1_payload_last && io_dataAxisIn_fifo_io_pop_fork_io_outputs_1_fire);
  assign selectedStream_fire = (selectedStream_valid && selectedStream_ready);
  assign when_UDPTx_l66 = (selectedStream_fire && (! streamMuxReg[0]));
  assign headerGenerator_1_io_headerAxisOut_fifo_io_pop_fire = (headerGenerator_1_io_headerAxisOut_fifo_io_pop_valid && streamMux_1_io_inputs_0_ready);
  assign when_UDPTx_l70 = (headerGenerator_1_io_headerAxisOut_fifo_io_pop_payload_last && headerGenerator_1_io_headerAxisOut_fifo_io_pop_fire);
  assign dataBufferedReg_fire = (dataBufferedReg_valid && dataBufferedReg_ready);
  assign when_UDPTx_l72 = ((dataBufferedReg_payload_last && dataBufferedReg_fire) || invalidData);
  assign io_dataAxisIn_fifo_io_pop_fork_io_outputs_1_fire_1 = (io_dataAxisIn_fifo_io_pop_fork_io_outputs_1_valid && io_dataAxisIn_fifo_io_pop_fork_io_outputs_1_ready);
  assign when_UDPTx_l76 = (io_dataAxisIn_fifo_io_pop_fork_io_outputs_1_payload_last && io_dataAxisIn_fifo_io_pop_fork_io_outputs_1_fire_1);
  assign selectedStream_fire_1 = (selectedStream_valid && selectedStream_ready);
  assign when_UDPTx_l78 = ((selectedStream_payload_last && selectedStream_fire_1) || invalidData);
  assign packetLen = (selectedStream_payload_user[19 : 14] - 6'h01);
  assign isUserCmd = ((selectedStream_payload_user[7 : 0] == 8'ha5) && (selectedStream_payload_user[31 : 24] == 8'h5a));
  assign selectedStream_fire_2 = (selectedStream_valid && selectedStream_ready);
  assign cntTrigger = ((selectedStream_fire_2 && isUserCmd) && selectedStream_payload_user[13]);
  assign selectedStream_fire_3 = (selectedStream_valid && selectedStream_ready);
  assign switch_Utils_l58 = selectedStream_payload_user[12 : 8];
  always @(*) begin
    case(switch_Utils_l58)
      5'h0 : begin
        _zz_maskReg = 32'hffffffff;
      end
      5'h01 : begin
        _zz_maskReg = _zz_maskReg_1;
      end
      5'h02 : begin
        _zz_maskReg = _zz_maskReg_2;
      end
      5'h03 : begin
        _zz_maskReg = _zz_maskReg_3;
      end
      5'h04 : begin
        _zz_maskReg = _zz_maskReg_4;
      end
      5'h05 : begin
        _zz_maskReg = _zz_maskReg_5;
      end
      5'h06 : begin
        _zz_maskReg = _zz_maskReg_6;
      end
      5'h07 : begin
        _zz_maskReg = _zz_maskReg_7;
      end
      5'h08 : begin
        _zz_maskReg = _zz_maskReg_8;
      end
      5'h09 : begin
        _zz_maskReg = _zz_maskReg_9;
      end
      5'h0a : begin
        _zz_maskReg = _zz_maskReg_10;
      end
      5'h0b : begin
        _zz_maskReg = _zz_maskReg_11;
      end
      5'h0c : begin
        _zz_maskReg = _zz_maskReg_12;
      end
      5'h0d : begin
        _zz_maskReg = _zz_maskReg_13;
      end
      5'h0e : begin
        _zz_maskReg = _zz_maskReg_14;
      end
      5'h0f : begin
        _zz_maskReg = _zz_maskReg_15;
      end
      5'h10 : begin
        _zz_maskReg = _zz_maskReg_16;
      end
      5'h11 : begin
        _zz_maskReg = _zz_maskReg_17;
      end
      5'h12 : begin
        _zz_maskReg = _zz_maskReg_18;
      end
      5'h13 : begin
        _zz_maskReg = _zz_maskReg_19;
      end
      5'h14 : begin
        _zz_maskReg = _zz_maskReg_20;
      end
      5'h15 : begin
        _zz_maskReg = _zz_maskReg_21;
      end
      5'h16 : begin
        _zz_maskReg = _zz_maskReg_22;
      end
      5'h17 : begin
        _zz_maskReg = _zz_maskReg_23;
      end
      5'h18 : begin
        _zz_maskReg = _zz_maskReg_24;
      end
      5'h19 : begin
        _zz_maskReg = _zz_maskReg_25;
      end
      5'h1a : begin
        _zz_maskReg = _zz_maskReg_26;
      end
      5'h1b : begin
        _zz_maskReg = _zz_maskReg_27;
      end
      5'h1c : begin
        _zz_maskReg = _zz_maskReg_28;
      end
      5'h1d : begin
        _zz_maskReg = _zz_maskReg_29;
      end
      5'h1e : begin
        _zz_maskReg = _zz_maskReg_30;
      end
      default : begin
        _zz_maskReg = _zz_maskReg_31;
      end
    endcase
  end

  assign _zz_1 = zz__zz_maskReg_1(1'b0);
  always @(*) _zz_maskReg_1 = _zz_1;
  assign _zz_2 = zz__zz_maskReg_2(1'b0);
  always @(*) _zz_maskReg_2 = _zz_2;
  assign _zz_3 = zz__zz_maskReg_3(1'b0);
  always @(*) _zz_maskReg_3 = _zz_3;
  assign _zz_4 = zz__zz_maskReg_4(1'b0);
  always @(*) _zz_maskReg_4 = _zz_4;
  assign _zz_5 = zz__zz_maskReg_5(1'b0);
  always @(*) _zz_maskReg_5 = _zz_5;
  assign _zz_6 = zz__zz_maskReg_6(1'b0);
  always @(*) _zz_maskReg_6 = _zz_6;
  assign _zz_7 = zz__zz_maskReg_7(1'b0);
  always @(*) _zz_maskReg_7 = _zz_7;
  assign _zz_8 = zz__zz_maskReg_8(1'b0);
  always @(*) _zz_maskReg_8 = _zz_8;
  assign _zz_9 = zz__zz_maskReg_9(1'b0);
  always @(*) _zz_maskReg_9 = _zz_9;
  assign _zz_10 = zz__zz_maskReg_10(1'b0);
  always @(*) _zz_maskReg_10 = _zz_10;
  assign _zz_11 = zz__zz_maskReg_11(1'b0);
  always @(*) _zz_maskReg_11 = _zz_11;
  assign _zz_12 = zz__zz_maskReg_12(1'b0);
  always @(*) _zz_maskReg_12 = _zz_12;
  assign _zz_13 = zz__zz_maskReg_13(1'b0);
  always @(*) _zz_maskReg_13 = _zz_13;
  assign _zz_14 = zz__zz_maskReg_14(1'b0);
  always @(*) _zz_maskReg_14 = _zz_14;
  assign _zz_15 = zz__zz_maskReg_15(1'b0);
  always @(*) _zz_maskReg_15 = _zz_15;
  assign _zz_16 = zz__zz_maskReg_16(1'b0);
  always @(*) _zz_maskReg_16 = _zz_16;
  assign _zz_17 = zz__zz_maskReg_17(1'b0);
  always @(*) _zz_maskReg_17 = _zz_17;
  assign _zz_18 = zz__zz_maskReg_18(1'b0);
  always @(*) _zz_maskReg_18 = _zz_18;
  assign _zz_19 = zz__zz_maskReg_19(1'b0);
  always @(*) _zz_maskReg_19 = _zz_19;
  assign _zz_20 = zz__zz_maskReg_20(1'b0);
  always @(*) _zz_maskReg_20 = _zz_20;
  assign _zz_21 = zz__zz_maskReg_21(1'b0);
  always @(*) _zz_maskReg_21 = _zz_21;
  assign _zz_22 = zz__zz_maskReg_22(1'b0);
  always @(*) _zz_maskReg_22 = _zz_22;
  assign _zz_23 = zz__zz_maskReg_23(1'b0);
  always @(*) _zz_maskReg_23 = _zz_23;
  assign _zz_24 = zz__zz_maskReg_24(1'b0);
  always @(*) _zz_maskReg_24 = _zz_24;
  assign _zz_25 = zz__zz_maskReg_25(1'b0);
  always @(*) _zz_maskReg_25 = _zz_25;
  assign _zz_26 = zz__zz_maskReg_26(1'b0);
  always @(*) _zz_maskReg_26 = _zz_26;
  assign _zz_27 = zz__zz_maskReg_27(1'b0);
  always @(*) _zz_maskReg_27 = _zz_27;
  assign _zz_28 = zz__zz_maskReg_28(1'b0);
  always @(*) _zz_maskReg_28 = _zz_28;
  assign _zz_29 = zz__zz_maskReg_29(1'b0);
  always @(*) _zz_maskReg_29 = _zz_29;
  assign _zz_30 = zz__zz_maskReg_30(1'b0);
  always @(*) _zz_maskReg_30 = _zz_30;
  assign _zz_31 = zz__zz_maskReg_31(1'b0);
  always @(*) _zz_maskReg_31 = _zz_31;
  assign maskStage_fire = (maskStage_valid && maskStage_ready);
  assign invalidData = (transactionCounter_io_done && streamJoinReg0);
  assign maskStage_valid = joinedStream_valid;
  assign joinedStream_ready = maskStage_ready;
  assign _zz_maskStage_payload_data = (~ maskReg);
  assign maskStage_payload_data = ({{{{_zz_maskStage_payload_data_1,_zz_maskStage_payload_data_38},(_zz_maskStage_payload_data_39 ? _zz_maskStage_payload_data_40 : _zz_maskStage_payload_data_41)},(_zz_maskStage_payload_data[1] ? 8'h0 : joinedStream_payload_1_data[15 : 8])},(_zz_maskStage_payload_data[0] ? 8'h0 : joinedStream_payload_1_data[7 : 0])} | {{{{_zz_maskStage_payload_data_42,_zz_maskStage_payload_data_79},(_zz_maskStage_payload_data_80 ? _zz_maskStage_payload_data_81 : _zz_maskStage_payload_data_82)},(maskReg[1] ? 8'h0 : joinedStream_payload_2_data[15 : 8])},(maskReg[0] ? 8'h0 : joinedStream_payload_2_data[7 : 0])});
  assign _zz_maskStage_payload_keep = (~ maskReg);
  assign maskStage_payload_keep = ({{{{_zz_maskStage_payload_keep_1,_zz_maskStage_payload_keep_38},(_zz_maskStage_payload_keep_39 ? _zz_maskStage_payload_keep_40 : _zz_maskStage_payload_keep_41)},(_zz_maskStage_payload_keep[1] ? 1'b0 : joinedStream_payload_1_keep[1 : 1])},(_zz_maskStage_payload_keep[0] ? 1'b0 : joinedStream_payload_1_keep[0 : 0])} | {{{{_zz_maskStage_payload_keep_42,_zz_maskStage_payload_keep_79},(_zz_maskStage_payload_keep_80 ? _zz_maskStage_payload_keep_81 : _zz_maskStage_payload_keep_82)},(maskReg[1] ? 1'b0 : joinedStream_payload_2_keep[1 : 1])},(maskReg[0] ? 1'b0 : joinedStream_payload_2_keep[0 : 0])});
  assign maskStage_payload_user = 32'h0;
  assign maskStage_payload_last = transactionCounter_io_last;
  always @(*) begin
    maskStage_ready = maskStage_m2sPipe_ready;
    if(when_Stream_l368_2) begin
      maskStage_ready = 1'b1;
    end
  end

  assign when_Stream_l368_2 = (! maskStage_m2sPipe_valid);
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
    case(shiftLenRegNxt)
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
    case(shiftLenRegNxt)
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
  assign shiftStage_ready = (! shiftStage_rValid);
  assign shiftStage_s2mPipe_valid = (shiftStage_valid || shiftStage_rValid);
  assign _zz_shiftStage_s2mPipe_payload_user = (shiftStage_rValid ? shiftStage_rData_user : shiftStage_payload_user);
  assign shiftStage_s2mPipe_payload_data = (shiftStage_rValid ? shiftStage_rData_data : shiftStage_payload_data);
  assign shiftStage_s2mPipe_payload_keep = (shiftStage_rValid ? shiftStage_rData_keep : shiftStage_payload_keep);
  assign shiftStage_s2mPipe_payload_last = (shiftStage_rValid ? shiftStage_rData_last : shiftStage_payload_last);
  always @(*) begin
    shiftStage_s2mPipe_payload_user[0 : 0] = _zz_shiftStage_s2mPipe_payload_user[0 : 0];
    shiftStage_s2mPipe_payload_user[1 : 1] = _zz_shiftStage_s2mPipe_payload_user[1 : 1];
    shiftStage_s2mPipe_payload_user[2 : 2] = _zz_shiftStage_s2mPipe_payload_user[2 : 2];
    shiftStage_s2mPipe_payload_user[3 : 3] = _zz_shiftStage_s2mPipe_payload_user[3 : 3];
    shiftStage_s2mPipe_payload_user[4 : 4] = _zz_shiftStage_s2mPipe_payload_user[4 : 4];
    shiftStage_s2mPipe_payload_user[5 : 5] = _zz_shiftStage_s2mPipe_payload_user[5 : 5];
    shiftStage_s2mPipe_payload_user[6 : 6] = _zz_shiftStage_s2mPipe_payload_user[6 : 6];
    shiftStage_s2mPipe_payload_user[7 : 7] = _zz_shiftStage_s2mPipe_payload_user[7 : 7];
    shiftStage_s2mPipe_payload_user[8 : 8] = _zz_shiftStage_s2mPipe_payload_user[8 : 8];
    shiftStage_s2mPipe_payload_user[9 : 9] = _zz_shiftStage_s2mPipe_payload_user[9 : 9];
    shiftStage_s2mPipe_payload_user[10 : 10] = _zz_shiftStage_s2mPipe_payload_user[10 : 10];
    shiftStage_s2mPipe_payload_user[11 : 11] = _zz_shiftStage_s2mPipe_payload_user[11 : 11];
    shiftStage_s2mPipe_payload_user[12 : 12] = _zz_shiftStage_s2mPipe_payload_user[12 : 12];
    shiftStage_s2mPipe_payload_user[13 : 13] = _zz_shiftStage_s2mPipe_payload_user[13 : 13];
    shiftStage_s2mPipe_payload_user[14 : 14] = _zz_shiftStage_s2mPipe_payload_user[14 : 14];
    shiftStage_s2mPipe_payload_user[15 : 15] = _zz_shiftStage_s2mPipe_payload_user[15 : 15];
    shiftStage_s2mPipe_payload_user[16 : 16] = _zz_shiftStage_s2mPipe_payload_user[16 : 16];
    shiftStage_s2mPipe_payload_user[17 : 17] = _zz_shiftStage_s2mPipe_payload_user[17 : 17];
    shiftStage_s2mPipe_payload_user[18 : 18] = _zz_shiftStage_s2mPipe_payload_user[18 : 18];
    shiftStage_s2mPipe_payload_user[19 : 19] = _zz_shiftStage_s2mPipe_payload_user[19 : 19];
    shiftStage_s2mPipe_payload_user[20 : 20] = _zz_shiftStage_s2mPipe_payload_user[20 : 20];
    shiftStage_s2mPipe_payload_user[21 : 21] = _zz_shiftStage_s2mPipe_payload_user[21 : 21];
    shiftStage_s2mPipe_payload_user[22 : 22] = _zz_shiftStage_s2mPipe_payload_user[22 : 22];
    shiftStage_s2mPipe_payload_user[23 : 23] = _zz_shiftStage_s2mPipe_payload_user[23 : 23];
    shiftStage_s2mPipe_payload_user[24 : 24] = _zz_shiftStage_s2mPipe_payload_user[24 : 24];
    shiftStage_s2mPipe_payload_user[25 : 25] = _zz_shiftStage_s2mPipe_payload_user[25 : 25];
    shiftStage_s2mPipe_payload_user[26 : 26] = _zz_shiftStage_s2mPipe_payload_user[26 : 26];
    shiftStage_s2mPipe_payload_user[27 : 27] = _zz_shiftStage_s2mPipe_payload_user[27 : 27];
    shiftStage_s2mPipe_payload_user[28 : 28] = _zz_shiftStage_s2mPipe_payload_user[28 : 28];
    shiftStage_s2mPipe_payload_user[29 : 29] = _zz_shiftStage_s2mPipe_payload_user[29 : 29];
    shiftStage_s2mPipe_payload_user[30 : 30] = _zz_shiftStage_s2mPipe_payload_user[30 : 30];
    shiftStage_s2mPipe_payload_user[31 : 31] = _zz_shiftStage_s2mPipe_payload_user[31 : 31];
  end

  always @(*) begin
    shiftStage_s2mPipe_ready = shiftStage_s2mPipe_m2sPipe_ready;
    if(when_Stream_l368_3) begin
      shiftStage_s2mPipe_ready = 1'b1;
    end
  end

  assign when_Stream_l368_3 = (! shiftStage_s2mPipe_m2sPipe_valid);
  assign shiftStage_s2mPipe_m2sPipe_valid = shiftStage_s2mPipe_rValid;
  assign shiftStage_s2mPipe_m2sPipe_payload_data = shiftStage_s2mPipe_rData_data;
  assign shiftStage_s2mPipe_m2sPipe_payload_keep = shiftStage_s2mPipe_rData_keep;
  assign shiftStage_s2mPipe_m2sPipe_payload_last = shiftStage_s2mPipe_rData_last;
  always @(*) begin
    shiftStage_s2mPipe_m2sPipe_payload_user[0 : 0] = shiftStage_s2mPipe_rData_user[0 : 0];
    shiftStage_s2mPipe_m2sPipe_payload_user[1 : 1] = shiftStage_s2mPipe_rData_user[1 : 1];
    shiftStage_s2mPipe_m2sPipe_payload_user[2 : 2] = shiftStage_s2mPipe_rData_user[2 : 2];
    shiftStage_s2mPipe_m2sPipe_payload_user[3 : 3] = shiftStage_s2mPipe_rData_user[3 : 3];
    shiftStage_s2mPipe_m2sPipe_payload_user[4 : 4] = shiftStage_s2mPipe_rData_user[4 : 4];
    shiftStage_s2mPipe_m2sPipe_payload_user[5 : 5] = shiftStage_s2mPipe_rData_user[5 : 5];
    shiftStage_s2mPipe_m2sPipe_payload_user[6 : 6] = shiftStage_s2mPipe_rData_user[6 : 6];
    shiftStage_s2mPipe_m2sPipe_payload_user[7 : 7] = shiftStage_s2mPipe_rData_user[7 : 7];
    shiftStage_s2mPipe_m2sPipe_payload_user[8 : 8] = shiftStage_s2mPipe_rData_user[8 : 8];
    shiftStage_s2mPipe_m2sPipe_payload_user[9 : 9] = shiftStage_s2mPipe_rData_user[9 : 9];
    shiftStage_s2mPipe_m2sPipe_payload_user[10 : 10] = shiftStage_s2mPipe_rData_user[10 : 10];
    shiftStage_s2mPipe_m2sPipe_payload_user[11 : 11] = shiftStage_s2mPipe_rData_user[11 : 11];
    shiftStage_s2mPipe_m2sPipe_payload_user[12 : 12] = shiftStage_s2mPipe_rData_user[12 : 12];
    shiftStage_s2mPipe_m2sPipe_payload_user[13 : 13] = shiftStage_s2mPipe_rData_user[13 : 13];
    shiftStage_s2mPipe_m2sPipe_payload_user[14 : 14] = shiftStage_s2mPipe_rData_user[14 : 14];
    shiftStage_s2mPipe_m2sPipe_payload_user[15 : 15] = shiftStage_s2mPipe_rData_user[15 : 15];
    shiftStage_s2mPipe_m2sPipe_payload_user[16 : 16] = shiftStage_s2mPipe_rData_user[16 : 16];
    shiftStage_s2mPipe_m2sPipe_payload_user[17 : 17] = shiftStage_s2mPipe_rData_user[17 : 17];
    shiftStage_s2mPipe_m2sPipe_payload_user[18 : 18] = shiftStage_s2mPipe_rData_user[18 : 18];
    shiftStage_s2mPipe_m2sPipe_payload_user[19 : 19] = shiftStage_s2mPipe_rData_user[19 : 19];
    shiftStage_s2mPipe_m2sPipe_payload_user[20 : 20] = shiftStage_s2mPipe_rData_user[20 : 20];
    shiftStage_s2mPipe_m2sPipe_payload_user[21 : 21] = shiftStage_s2mPipe_rData_user[21 : 21];
    shiftStage_s2mPipe_m2sPipe_payload_user[22 : 22] = shiftStage_s2mPipe_rData_user[22 : 22];
    shiftStage_s2mPipe_m2sPipe_payload_user[23 : 23] = shiftStage_s2mPipe_rData_user[23 : 23];
    shiftStage_s2mPipe_m2sPipe_payload_user[24 : 24] = shiftStage_s2mPipe_rData_user[24 : 24];
    shiftStage_s2mPipe_m2sPipe_payload_user[25 : 25] = shiftStage_s2mPipe_rData_user[25 : 25];
    shiftStage_s2mPipe_m2sPipe_payload_user[26 : 26] = shiftStage_s2mPipe_rData_user[26 : 26];
    shiftStage_s2mPipe_m2sPipe_payload_user[27 : 27] = shiftStage_s2mPipe_rData_user[27 : 27];
    shiftStage_s2mPipe_m2sPipe_payload_user[28 : 28] = shiftStage_s2mPipe_rData_user[28 : 28];
    shiftStage_s2mPipe_m2sPipe_payload_user[29 : 29] = shiftStage_s2mPipe_rData_user[29 : 29];
    shiftStage_s2mPipe_m2sPipe_payload_user[30 : 30] = shiftStage_s2mPipe_rData_user[30 : 30];
    shiftStage_s2mPipe_m2sPipe_payload_user[31 : 31] = shiftStage_s2mPipe_rData_user[31 : 31];
  end

  assign io_dataAxisOut_valid = shiftStage_s2mPipe_m2sPipe_valid;
  assign shiftStage_s2mPipe_m2sPipe_ready = io_dataAxisOut_ready;
  assign io_dataAxisOut_payload_data = shiftStage_s2mPipe_m2sPipe_payload_data;
  assign io_dataAxisOut_payload_keep = shiftStage_s2mPipe_m2sPipe_payload_keep;
  assign io_dataAxisOut_payload_last = shiftStage_s2mPipe_m2sPipe_payload_last;
  always @(*) begin
    io_dataAxisOut_payload_user[0 : 0] = shiftStage_s2mPipe_m2sPipe_payload_user[0 : 0];
    io_dataAxisOut_payload_user[1 : 1] = shiftStage_s2mPipe_m2sPipe_payload_user[1 : 1];
    io_dataAxisOut_payload_user[2 : 2] = shiftStage_s2mPipe_m2sPipe_payload_user[2 : 2];
    io_dataAxisOut_payload_user[3 : 3] = shiftStage_s2mPipe_m2sPipe_payload_user[3 : 3];
    io_dataAxisOut_payload_user[4 : 4] = shiftStage_s2mPipe_m2sPipe_payload_user[4 : 4];
    io_dataAxisOut_payload_user[5 : 5] = shiftStage_s2mPipe_m2sPipe_payload_user[5 : 5];
    io_dataAxisOut_payload_user[6 : 6] = shiftStage_s2mPipe_m2sPipe_payload_user[6 : 6];
    io_dataAxisOut_payload_user[7 : 7] = shiftStage_s2mPipe_m2sPipe_payload_user[7 : 7];
    io_dataAxisOut_payload_user[8 : 8] = shiftStage_s2mPipe_m2sPipe_payload_user[8 : 8];
    io_dataAxisOut_payload_user[9 : 9] = shiftStage_s2mPipe_m2sPipe_payload_user[9 : 9];
    io_dataAxisOut_payload_user[10 : 10] = shiftStage_s2mPipe_m2sPipe_payload_user[10 : 10];
    io_dataAxisOut_payload_user[11 : 11] = shiftStage_s2mPipe_m2sPipe_payload_user[11 : 11];
    io_dataAxisOut_payload_user[12 : 12] = shiftStage_s2mPipe_m2sPipe_payload_user[12 : 12];
    io_dataAxisOut_payload_user[13 : 13] = shiftStage_s2mPipe_m2sPipe_payload_user[13 : 13];
    io_dataAxisOut_payload_user[14 : 14] = shiftStage_s2mPipe_m2sPipe_payload_user[14 : 14];
    io_dataAxisOut_payload_user[15 : 15] = shiftStage_s2mPipe_m2sPipe_payload_user[15 : 15];
    io_dataAxisOut_payload_user[16 : 16] = shiftStage_s2mPipe_m2sPipe_payload_user[16 : 16];
    io_dataAxisOut_payload_user[17 : 17] = shiftStage_s2mPipe_m2sPipe_payload_user[17 : 17];
    io_dataAxisOut_payload_user[18 : 18] = shiftStage_s2mPipe_m2sPipe_payload_user[18 : 18];
    io_dataAxisOut_payload_user[19 : 19] = shiftStage_s2mPipe_m2sPipe_payload_user[19 : 19];
    io_dataAxisOut_payload_user[20 : 20] = shiftStage_s2mPipe_m2sPipe_payload_user[20 : 20];
    io_dataAxisOut_payload_user[21 : 21] = shiftStage_s2mPipe_m2sPipe_payload_user[21 : 21];
    io_dataAxisOut_payload_user[22 : 22] = shiftStage_s2mPipe_m2sPipe_payload_user[22 : 22];
    io_dataAxisOut_payload_user[23 : 23] = shiftStage_s2mPipe_m2sPipe_payload_user[23 : 23];
    io_dataAxisOut_payload_user[24 : 24] = shiftStage_s2mPipe_m2sPipe_payload_user[24 : 24];
    io_dataAxisOut_payload_user[25 : 25] = shiftStage_s2mPipe_m2sPipe_payload_user[25 : 25];
    io_dataAxisOut_payload_user[26 : 26] = shiftStage_s2mPipe_m2sPipe_payload_user[26 : 26];
    io_dataAxisOut_payload_user[27 : 27] = shiftStage_s2mPipe_m2sPipe_payload_user[27 : 27];
    io_dataAxisOut_payload_user[28 : 28] = shiftStage_s2mPipe_m2sPipe_payload_user[28 : 28];
    io_dataAxisOut_payload_user[29 : 29] = shiftStage_s2mPipe_m2sPipe_payload_user[29 : 29];
    io_dataAxisOut_payload_user[30 : 30] = shiftStage_s2mPipe_m2sPipe_payload_user[30 : 30];
    io_dataAxisOut_payload_user[31 : 31] = shiftStage_s2mPipe_m2sPipe_payload_user[31 : 31];
  end

  always @(posedge clk or posedge reset) begin
    if(reset) begin
      io_dataAxisIn_fifo_io_pop_fork_io_outputs_0_rValid <= 1'b0;
      streamMuxReg <= 1'b0;
      streamJoinReg0 <= 1'b0;
      streamJoinReg1 <= 1'b0;
      streamMux_1_io_output_rValid <= 1'b0;
      _zz_joinedStream_valid <= 1'b0;
      maskReg <= 32'h0;
      shiftLenReg <= 5'h0;
      maskStage_rValid <= 1'b0;
      maskStage_m2sPipe_rValid <= 1'b0;
      shiftLenRegNxt <= 5'h0;
      shiftStage_rValid <= 1'b0;
      shiftStage_s2mPipe_rValid <= 1'b0;
    end else begin
      if(io_dataAxisIn_fifo_io_pop_fork_io_outputs_0_ready) begin
        io_dataAxisIn_fifo_io_pop_fork_io_outputs_0_rValid <= io_dataAxisIn_fifo_io_pop_fork_io_outputs_0_valid;
      end
      if(streamMux_1_io_output_valid) begin
        streamMux_1_io_output_rValid <= 1'b1;
      end
      if(streamMux_1_io_output_s2mPipe_ready) begin
        streamMux_1_io_output_rValid <= 1'b0;
      end
      if(_zz_selectedStream_ready_1) begin
        _zz_joinedStream_valid <= _zz_selectedStream_ready;
      end
      if(when_UDPTx_l64) begin
        streamJoinReg1 <= 1'b0;
      end else begin
        if(when_UDPTx_l66) begin
          streamJoinReg1 <= 1'b1;
        end
      end
      if(when_UDPTx_l70) begin
        streamMuxReg <= 1'b1;
      end else begin
        if(when_UDPTx_l72) begin
          streamMuxReg <= 1'b0;
        end
      end
      if(when_UDPTx_l76) begin
        streamJoinReg0 <= 1'b1;
      end else begin
        if(when_UDPTx_l78) begin
          streamJoinReg0 <= 1'b0;
        end
      end
      if(selectedStream_fire_3) begin
        if(isUserCmd) begin
          maskReg <= _zz_maskReg;
          shiftLenReg <= selectedStream_payload_user[12 : 8];
        end
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
      shiftLenRegNxt <= shiftLenReg;
      if(shiftStage_valid) begin
        shiftStage_rValid <= 1'b1;
      end
      if(shiftStage_s2mPipe_ready) begin
        shiftStage_rValid <= 1'b0;
      end
      if(shiftStage_s2mPipe_ready) begin
        shiftStage_s2mPipe_rValid <= shiftStage_s2mPipe_valid;
      end
    end
  end

  always @(posedge clk) begin
    if(io_dataAxisIn_fifo_io_pop_fork_io_outputs_0_ready) begin
      io_dataAxisIn_fifo_io_pop_fork_io_outputs_0_rData_data <= io_dataAxisIn_fifo_io_pop_fork_io_outputs_0_payload_data;
      io_dataAxisIn_fifo_io_pop_fork_io_outputs_0_rData_keep <= io_dataAxisIn_fifo_io_pop_fork_io_outputs_0_payload_keep;
      io_dataAxisIn_fifo_io_pop_fork_io_outputs_0_rData_last <= io_dataAxisIn_fifo_io_pop_fork_io_outputs_0_payload_last;
      io_dataAxisIn_fifo_io_pop_fork_io_outputs_0_rData_user[0 : 0] <= io_dataAxisIn_fifo_io_pop_fork_io_outputs_0_payload_user[0 : 0];
      io_dataAxisIn_fifo_io_pop_fork_io_outputs_0_rData_user[1 : 1] <= io_dataAxisIn_fifo_io_pop_fork_io_outputs_0_payload_user[1 : 1];
      io_dataAxisIn_fifo_io_pop_fork_io_outputs_0_rData_user[2 : 2] <= io_dataAxisIn_fifo_io_pop_fork_io_outputs_0_payload_user[2 : 2];
      io_dataAxisIn_fifo_io_pop_fork_io_outputs_0_rData_user[3 : 3] <= io_dataAxisIn_fifo_io_pop_fork_io_outputs_0_payload_user[3 : 3];
      io_dataAxisIn_fifo_io_pop_fork_io_outputs_0_rData_user[4 : 4] <= io_dataAxisIn_fifo_io_pop_fork_io_outputs_0_payload_user[4 : 4];
      io_dataAxisIn_fifo_io_pop_fork_io_outputs_0_rData_user[5 : 5] <= io_dataAxisIn_fifo_io_pop_fork_io_outputs_0_payload_user[5 : 5];
      io_dataAxisIn_fifo_io_pop_fork_io_outputs_0_rData_user[6 : 6] <= io_dataAxisIn_fifo_io_pop_fork_io_outputs_0_payload_user[6 : 6];
      io_dataAxisIn_fifo_io_pop_fork_io_outputs_0_rData_user[7 : 7] <= io_dataAxisIn_fifo_io_pop_fork_io_outputs_0_payload_user[7 : 7];
      io_dataAxisIn_fifo_io_pop_fork_io_outputs_0_rData_user[8 : 8] <= io_dataAxisIn_fifo_io_pop_fork_io_outputs_0_payload_user[8 : 8];
      io_dataAxisIn_fifo_io_pop_fork_io_outputs_0_rData_user[9 : 9] <= io_dataAxisIn_fifo_io_pop_fork_io_outputs_0_payload_user[9 : 9];
      io_dataAxisIn_fifo_io_pop_fork_io_outputs_0_rData_user[10 : 10] <= io_dataAxisIn_fifo_io_pop_fork_io_outputs_0_payload_user[10 : 10];
      io_dataAxisIn_fifo_io_pop_fork_io_outputs_0_rData_user[11 : 11] <= io_dataAxisIn_fifo_io_pop_fork_io_outputs_0_payload_user[11 : 11];
      io_dataAxisIn_fifo_io_pop_fork_io_outputs_0_rData_user[12 : 12] <= io_dataAxisIn_fifo_io_pop_fork_io_outputs_0_payload_user[12 : 12];
      io_dataAxisIn_fifo_io_pop_fork_io_outputs_0_rData_user[13 : 13] <= io_dataAxisIn_fifo_io_pop_fork_io_outputs_0_payload_user[13 : 13];
      io_dataAxisIn_fifo_io_pop_fork_io_outputs_0_rData_user[14 : 14] <= io_dataAxisIn_fifo_io_pop_fork_io_outputs_0_payload_user[14 : 14];
      io_dataAxisIn_fifo_io_pop_fork_io_outputs_0_rData_user[15 : 15] <= io_dataAxisIn_fifo_io_pop_fork_io_outputs_0_payload_user[15 : 15];
      io_dataAxisIn_fifo_io_pop_fork_io_outputs_0_rData_user[16 : 16] <= io_dataAxisIn_fifo_io_pop_fork_io_outputs_0_payload_user[16 : 16];
      io_dataAxisIn_fifo_io_pop_fork_io_outputs_0_rData_user[17 : 17] <= io_dataAxisIn_fifo_io_pop_fork_io_outputs_0_payload_user[17 : 17];
      io_dataAxisIn_fifo_io_pop_fork_io_outputs_0_rData_user[18 : 18] <= io_dataAxisIn_fifo_io_pop_fork_io_outputs_0_payload_user[18 : 18];
      io_dataAxisIn_fifo_io_pop_fork_io_outputs_0_rData_user[19 : 19] <= io_dataAxisIn_fifo_io_pop_fork_io_outputs_0_payload_user[19 : 19];
      io_dataAxisIn_fifo_io_pop_fork_io_outputs_0_rData_user[20 : 20] <= io_dataAxisIn_fifo_io_pop_fork_io_outputs_0_payload_user[20 : 20];
      io_dataAxisIn_fifo_io_pop_fork_io_outputs_0_rData_user[21 : 21] <= io_dataAxisIn_fifo_io_pop_fork_io_outputs_0_payload_user[21 : 21];
      io_dataAxisIn_fifo_io_pop_fork_io_outputs_0_rData_user[22 : 22] <= io_dataAxisIn_fifo_io_pop_fork_io_outputs_0_payload_user[22 : 22];
      io_dataAxisIn_fifo_io_pop_fork_io_outputs_0_rData_user[23 : 23] <= io_dataAxisIn_fifo_io_pop_fork_io_outputs_0_payload_user[23 : 23];
      io_dataAxisIn_fifo_io_pop_fork_io_outputs_0_rData_user[24 : 24] <= io_dataAxisIn_fifo_io_pop_fork_io_outputs_0_payload_user[24 : 24];
      io_dataAxisIn_fifo_io_pop_fork_io_outputs_0_rData_user[25 : 25] <= io_dataAxisIn_fifo_io_pop_fork_io_outputs_0_payload_user[25 : 25];
      io_dataAxisIn_fifo_io_pop_fork_io_outputs_0_rData_user[26 : 26] <= io_dataAxisIn_fifo_io_pop_fork_io_outputs_0_payload_user[26 : 26];
      io_dataAxisIn_fifo_io_pop_fork_io_outputs_0_rData_user[27 : 27] <= io_dataAxisIn_fifo_io_pop_fork_io_outputs_0_payload_user[27 : 27];
      io_dataAxisIn_fifo_io_pop_fork_io_outputs_0_rData_user[28 : 28] <= io_dataAxisIn_fifo_io_pop_fork_io_outputs_0_payload_user[28 : 28];
      io_dataAxisIn_fifo_io_pop_fork_io_outputs_0_rData_user[29 : 29] <= io_dataAxisIn_fifo_io_pop_fork_io_outputs_0_payload_user[29 : 29];
      io_dataAxisIn_fifo_io_pop_fork_io_outputs_0_rData_user[30 : 30] <= io_dataAxisIn_fifo_io_pop_fork_io_outputs_0_payload_user[30 : 30];
      io_dataAxisIn_fifo_io_pop_fork_io_outputs_0_rData_user[31 : 31] <= io_dataAxisIn_fifo_io_pop_fork_io_outputs_0_payload_user[31 : 31];
    end
    if(streamMux_1_io_output_ready) begin
      streamMux_1_io_output_rData_data <= streamMux_1_io_output_payload_data;
      streamMux_1_io_output_rData_keep <= streamMux_1_io_output_payload_keep;
      streamMux_1_io_output_rData_last <= streamMux_1_io_output_payload_last;
      streamMux_1_io_output_rData_user[0 : 0] <= streamMux_1_io_output_payload_user[0 : 0];
      streamMux_1_io_output_rData_user[1 : 1] <= streamMux_1_io_output_payload_user[1 : 1];
      streamMux_1_io_output_rData_user[2 : 2] <= streamMux_1_io_output_payload_user[2 : 2];
      streamMux_1_io_output_rData_user[3 : 3] <= streamMux_1_io_output_payload_user[3 : 3];
      streamMux_1_io_output_rData_user[4 : 4] <= streamMux_1_io_output_payload_user[4 : 4];
      streamMux_1_io_output_rData_user[5 : 5] <= streamMux_1_io_output_payload_user[5 : 5];
      streamMux_1_io_output_rData_user[6 : 6] <= streamMux_1_io_output_payload_user[6 : 6];
      streamMux_1_io_output_rData_user[7 : 7] <= streamMux_1_io_output_payload_user[7 : 7];
      streamMux_1_io_output_rData_user[8 : 8] <= streamMux_1_io_output_payload_user[8 : 8];
      streamMux_1_io_output_rData_user[9 : 9] <= streamMux_1_io_output_payload_user[9 : 9];
      streamMux_1_io_output_rData_user[10 : 10] <= streamMux_1_io_output_payload_user[10 : 10];
      streamMux_1_io_output_rData_user[11 : 11] <= streamMux_1_io_output_payload_user[11 : 11];
      streamMux_1_io_output_rData_user[12 : 12] <= streamMux_1_io_output_payload_user[12 : 12];
      streamMux_1_io_output_rData_user[13 : 13] <= streamMux_1_io_output_payload_user[13 : 13];
      streamMux_1_io_output_rData_user[14 : 14] <= streamMux_1_io_output_payload_user[14 : 14];
      streamMux_1_io_output_rData_user[15 : 15] <= streamMux_1_io_output_payload_user[15 : 15];
      streamMux_1_io_output_rData_user[16 : 16] <= streamMux_1_io_output_payload_user[16 : 16];
      streamMux_1_io_output_rData_user[17 : 17] <= streamMux_1_io_output_payload_user[17 : 17];
      streamMux_1_io_output_rData_user[18 : 18] <= streamMux_1_io_output_payload_user[18 : 18];
      streamMux_1_io_output_rData_user[19 : 19] <= streamMux_1_io_output_payload_user[19 : 19];
      streamMux_1_io_output_rData_user[20 : 20] <= streamMux_1_io_output_payload_user[20 : 20];
      streamMux_1_io_output_rData_user[21 : 21] <= streamMux_1_io_output_payload_user[21 : 21];
      streamMux_1_io_output_rData_user[22 : 22] <= streamMux_1_io_output_payload_user[22 : 22];
      streamMux_1_io_output_rData_user[23 : 23] <= streamMux_1_io_output_payload_user[23 : 23];
      streamMux_1_io_output_rData_user[24 : 24] <= streamMux_1_io_output_payload_user[24 : 24];
      streamMux_1_io_output_rData_user[25 : 25] <= streamMux_1_io_output_payload_user[25 : 25];
      streamMux_1_io_output_rData_user[26 : 26] <= streamMux_1_io_output_payload_user[26 : 26];
      streamMux_1_io_output_rData_user[27 : 27] <= streamMux_1_io_output_payload_user[27 : 27];
      streamMux_1_io_output_rData_user[28 : 28] <= streamMux_1_io_output_payload_user[28 : 28];
      streamMux_1_io_output_rData_user[29 : 29] <= streamMux_1_io_output_payload_user[29 : 29];
      streamMux_1_io_output_rData_user[30 : 30] <= streamMux_1_io_output_payload_user[30 : 30];
      streamMux_1_io_output_rData_user[31 : 31] <= streamMux_1_io_output_payload_user[31 : 31];
    end
    if(_zz_selectedStream_ready_1) begin
      _zz_joinedStream_payload_1_data <= selectedStream_payload_data;
      _zz_joinedStream_payload_1_keep <= selectedStream_payload_keep;
      _zz_joinedStream_payload_1_last <= selectedStream_payload_last;
      _zz_joinedStream_payload_1_user_1[0 : 0] <= _zz_joinedStream_payload_1_user[0 : 0];
      _zz_joinedStream_payload_1_user_1[1 : 1] <= _zz_joinedStream_payload_1_user[1 : 1];
      _zz_joinedStream_payload_1_user_1[2 : 2] <= _zz_joinedStream_payload_1_user[2 : 2];
      _zz_joinedStream_payload_1_user_1[3 : 3] <= _zz_joinedStream_payload_1_user[3 : 3];
      _zz_joinedStream_payload_1_user_1[4 : 4] <= _zz_joinedStream_payload_1_user[4 : 4];
      _zz_joinedStream_payload_1_user_1[5 : 5] <= _zz_joinedStream_payload_1_user[5 : 5];
      _zz_joinedStream_payload_1_user_1[6 : 6] <= _zz_joinedStream_payload_1_user[6 : 6];
      _zz_joinedStream_payload_1_user_1[7 : 7] <= _zz_joinedStream_payload_1_user[7 : 7];
      _zz_joinedStream_payload_1_user_1[8 : 8] <= _zz_joinedStream_payload_1_user[8 : 8];
      _zz_joinedStream_payload_1_user_1[9 : 9] <= _zz_joinedStream_payload_1_user[9 : 9];
      _zz_joinedStream_payload_1_user_1[10 : 10] <= _zz_joinedStream_payload_1_user[10 : 10];
      _zz_joinedStream_payload_1_user_1[11 : 11] <= _zz_joinedStream_payload_1_user[11 : 11];
      _zz_joinedStream_payload_1_user_1[12 : 12] <= _zz_joinedStream_payload_1_user[12 : 12];
      _zz_joinedStream_payload_1_user_1[13 : 13] <= _zz_joinedStream_payload_1_user[13 : 13];
      _zz_joinedStream_payload_1_user_1[14 : 14] <= _zz_joinedStream_payload_1_user[14 : 14];
      _zz_joinedStream_payload_1_user_1[15 : 15] <= _zz_joinedStream_payload_1_user[15 : 15];
      _zz_joinedStream_payload_1_user_1[16 : 16] <= _zz_joinedStream_payload_1_user[16 : 16];
      _zz_joinedStream_payload_1_user_1[17 : 17] <= _zz_joinedStream_payload_1_user[17 : 17];
      _zz_joinedStream_payload_1_user_1[18 : 18] <= _zz_joinedStream_payload_1_user[18 : 18];
      _zz_joinedStream_payload_1_user_1[19 : 19] <= _zz_joinedStream_payload_1_user[19 : 19];
      _zz_joinedStream_payload_1_user_1[20 : 20] <= _zz_joinedStream_payload_1_user[20 : 20];
      _zz_joinedStream_payload_1_user_1[21 : 21] <= _zz_joinedStream_payload_1_user[21 : 21];
      _zz_joinedStream_payload_1_user_1[22 : 22] <= _zz_joinedStream_payload_1_user[22 : 22];
      _zz_joinedStream_payload_1_user_1[23 : 23] <= _zz_joinedStream_payload_1_user[23 : 23];
      _zz_joinedStream_payload_1_user_1[24 : 24] <= _zz_joinedStream_payload_1_user[24 : 24];
      _zz_joinedStream_payload_1_user_1[25 : 25] <= _zz_joinedStream_payload_1_user[25 : 25];
      _zz_joinedStream_payload_1_user_1[26 : 26] <= _zz_joinedStream_payload_1_user[26 : 26];
      _zz_joinedStream_payload_1_user_1[27 : 27] <= _zz_joinedStream_payload_1_user[27 : 27];
      _zz_joinedStream_payload_1_user_1[28 : 28] <= _zz_joinedStream_payload_1_user[28 : 28];
      _zz_joinedStream_payload_1_user_1[29 : 29] <= _zz_joinedStream_payload_1_user[29 : 29];
      _zz_joinedStream_payload_1_user_1[30 : 30] <= _zz_joinedStream_payload_1_user[30 : 30];
      _zz_joinedStream_payload_1_user_1[31 : 31] <= _zz_joinedStream_payload_1_user[31 : 31];
      _zz_joinedStream_payload_2_data_1 <= _zz_joinedStream_payload_2_data;
      _zz_joinedStream_payload_2_keep_1 <= _zz_joinedStream_payload_2_keep;
      _zz_joinedStream_payload_2_last_1 <= _zz_joinedStream_payload_2_last;
      _zz_joinedStream_payload_2_user_2[0 : 0] <= _zz_joinedStream_payload_2_user_1[0 : 0];
      _zz_joinedStream_payload_2_user_2[1 : 1] <= _zz_joinedStream_payload_2_user_1[1 : 1];
      _zz_joinedStream_payload_2_user_2[2 : 2] <= _zz_joinedStream_payload_2_user_1[2 : 2];
      _zz_joinedStream_payload_2_user_2[3 : 3] <= _zz_joinedStream_payload_2_user_1[3 : 3];
      _zz_joinedStream_payload_2_user_2[4 : 4] <= _zz_joinedStream_payload_2_user_1[4 : 4];
      _zz_joinedStream_payload_2_user_2[5 : 5] <= _zz_joinedStream_payload_2_user_1[5 : 5];
      _zz_joinedStream_payload_2_user_2[6 : 6] <= _zz_joinedStream_payload_2_user_1[6 : 6];
      _zz_joinedStream_payload_2_user_2[7 : 7] <= _zz_joinedStream_payload_2_user_1[7 : 7];
      _zz_joinedStream_payload_2_user_2[8 : 8] <= _zz_joinedStream_payload_2_user_1[8 : 8];
      _zz_joinedStream_payload_2_user_2[9 : 9] <= _zz_joinedStream_payload_2_user_1[9 : 9];
      _zz_joinedStream_payload_2_user_2[10 : 10] <= _zz_joinedStream_payload_2_user_1[10 : 10];
      _zz_joinedStream_payload_2_user_2[11 : 11] <= _zz_joinedStream_payload_2_user_1[11 : 11];
      _zz_joinedStream_payload_2_user_2[12 : 12] <= _zz_joinedStream_payload_2_user_1[12 : 12];
      _zz_joinedStream_payload_2_user_2[13 : 13] <= _zz_joinedStream_payload_2_user_1[13 : 13];
      _zz_joinedStream_payload_2_user_2[14 : 14] <= _zz_joinedStream_payload_2_user_1[14 : 14];
      _zz_joinedStream_payload_2_user_2[15 : 15] <= _zz_joinedStream_payload_2_user_1[15 : 15];
      _zz_joinedStream_payload_2_user_2[16 : 16] <= _zz_joinedStream_payload_2_user_1[16 : 16];
      _zz_joinedStream_payload_2_user_2[17 : 17] <= _zz_joinedStream_payload_2_user_1[17 : 17];
      _zz_joinedStream_payload_2_user_2[18 : 18] <= _zz_joinedStream_payload_2_user_1[18 : 18];
      _zz_joinedStream_payload_2_user_2[19 : 19] <= _zz_joinedStream_payload_2_user_1[19 : 19];
      _zz_joinedStream_payload_2_user_2[20 : 20] <= _zz_joinedStream_payload_2_user_1[20 : 20];
      _zz_joinedStream_payload_2_user_2[21 : 21] <= _zz_joinedStream_payload_2_user_1[21 : 21];
      _zz_joinedStream_payload_2_user_2[22 : 22] <= _zz_joinedStream_payload_2_user_1[22 : 22];
      _zz_joinedStream_payload_2_user_2[23 : 23] <= _zz_joinedStream_payload_2_user_1[23 : 23];
      _zz_joinedStream_payload_2_user_2[24 : 24] <= _zz_joinedStream_payload_2_user_1[24 : 24];
      _zz_joinedStream_payload_2_user_2[25 : 25] <= _zz_joinedStream_payload_2_user_1[25 : 25];
      _zz_joinedStream_payload_2_user_2[26 : 26] <= _zz_joinedStream_payload_2_user_1[26 : 26];
      _zz_joinedStream_payload_2_user_2[27 : 27] <= _zz_joinedStream_payload_2_user_1[27 : 27];
      _zz_joinedStream_payload_2_user_2[28 : 28] <= _zz_joinedStream_payload_2_user_1[28 : 28];
      _zz_joinedStream_payload_2_user_2[29 : 29] <= _zz_joinedStream_payload_2_user_1[29 : 29];
      _zz_joinedStream_payload_2_user_2[30 : 30] <= _zz_joinedStream_payload_2_user_1[30 : 30];
      _zz_joinedStream_payload_2_user_2[31 : 31] <= _zz_joinedStream_payload_2_user_1[31 : 31];
    end
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
    if(shiftStage_ready) begin
      shiftStage_rData_data <= shiftStage_payload_data;
      shiftStage_rData_keep <= shiftStage_payload_keep;
      shiftStage_rData_last <= shiftStage_payload_last;
      shiftStage_rData_user[0 : 0] <= shiftStage_payload_user[0 : 0];
      shiftStage_rData_user[1 : 1] <= shiftStage_payload_user[1 : 1];
      shiftStage_rData_user[2 : 2] <= shiftStage_payload_user[2 : 2];
      shiftStage_rData_user[3 : 3] <= shiftStage_payload_user[3 : 3];
      shiftStage_rData_user[4 : 4] <= shiftStage_payload_user[4 : 4];
      shiftStage_rData_user[5 : 5] <= shiftStage_payload_user[5 : 5];
      shiftStage_rData_user[6 : 6] <= shiftStage_payload_user[6 : 6];
      shiftStage_rData_user[7 : 7] <= shiftStage_payload_user[7 : 7];
      shiftStage_rData_user[8 : 8] <= shiftStage_payload_user[8 : 8];
      shiftStage_rData_user[9 : 9] <= shiftStage_payload_user[9 : 9];
      shiftStage_rData_user[10 : 10] <= shiftStage_payload_user[10 : 10];
      shiftStage_rData_user[11 : 11] <= shiftStage_payload_user[11 : 11];
      shiftStage_rData_user[12 : 12] <= shiftStage_payload_user[12 : 12];
      shiftStage_rData_user[13 : 13] <= shiftStage_payload_user[13 : 13];
      shiftStage_rData_user[14 : 14] <= shiftStage_payload_user[14 : 14];
      shiftStage_rData_user[15 : 15] <= shiftStage_payload_user[15 : 15];
      shiftStage_rData_user[16 : 16] <= shiftStage_payload_user[16 : 16];
      shiftStage_rData_user[17 : 17] <= shiftStage_payload_user[17 : 17];
      shiftStage_rData_user[18 : 18] <= shiftStage_payload_user[18 : 18];
      shiftStage_rData_user[19 : 19] <= shiftStage_payload_user[19 : 19];
      shiftStage_rData_user[20 : 20] <= shiftStage_payload_user[20 : 20];
      shiftStage_rData_user[21 : 21] <= shiftStage_payload_user[21 : 21];
      shiftStage_rData_user[22 : 22] <= shiftStage_payload_user[22 : 22];
      shiftStage_rData_user[23 : 23] <= shiftStage_payload_user[23 : 23];
      shiftStage_rData_user[24 : 24] <= shiftStage_payload_user[24 : 24];
      shiftStage_rData_user[25 : 25] <= shiftStage_payload_user[25 : 25];
      shiftStage_rData_user[26 : 26] <= shiftStage_payload_user[26 : 26];
      shiftStage_rData_user[27 : 27] <= shiftStage_payload_user[27 : 27];
      shiftStage_rData_user[28 : 28] <= shiftStage_payload_user[28 : 28];
      shiftStage_rData_user[29 : 29] <= shiftStage_payload_user[29 : 29];
      shiftStage_rData_user[30 : 30] <= shiftStage_payload_user[30 : 30];
      shiftStage_rData_user[31 : 31] <= shiftStage_payload_user[31 : 31];
    end
    if(shiftStage_s2mPipe_ready) begin
      shiftStage_s2mPipe_rData_data <= shiftStage_s2mPipe_payload_data;
      shiftStage_s2mPipe_rData_keep <= shiftStage_s2mPipe_payload_keep;
      shiftStage_s2mPipe_rData_last <= shiftStage_s2mPipe_payload_last;
      shiftStage_s2mPipe_rData_user[0 : 0] <= shiftStage_s2mPipe_payload_user[0 : 0];
      shiftStage_s2mPipe_rData_user[1 : 1] <= shiftStage_s2mPipe_payload_user[1 : 1];
      shiftStage_s2mPipe_rData_user[2 : 2] <= shiftStage_s2mPipe_payload_user[2 : 2];
      shiftStage_s2mPipe_rData_user[3 : 3] <= shiftStage_s2mPipe_payload_user[3 : 3];
      shiftStage_s2mPipe_rData_user[4 : 4] <= shiftStage_s2mPipe_payload_user[4 : 4];
      shiftStage_s2mPipe_rData_user[5 : 5] <= shiftStage_s2mPipe_payload_user[5 : 5];
      shiftStage_s2mPipe_rData_user[6 : 6] <= shiftStage_s2mPipe_payload_user[6 : 6];
      shiftStage_s2mPipe_rData_user[7 : 7] <= shiftStage_s2mPipe_payload_user[7 : 7];
      shiftStage_s2mPipe_rData_user[8 : 8] <= shiftStage_s2mPipe_payload_user[8 : 8];
      shiftStage_s2mPipe_rData_user[9 : 9] <= shiftStage_s2mPipe_payload_user[9 : 9];
      shiftStage_s2mPipe_rData_user[10 : 10] <= shiftStage_s2mPipe_payload_user[10 : 10];
      shiftStage_s2mPipe_rData_user[11 : 11] <= shiftStage_s2mPipe_payload_user[11 : 11];
      shiftStage_s2mPipe_rData_user[12 : 12] <= shiftStage_s2mPipe_payload_user[12 : 12];
      shiftStage_s2mPipe_rData_user[13 : 13] <= shiftStage_s2mPipe_payload_user[13 : 13];
      shiftStage_s2mPipe_rData_user[14 : 14] <= shiftStage_s2mPipe_payload_user[14 : 14];
      shiftStage_s2mPipe_rData_user[15 : 15] <= shiftStage_s2mPipe_payload_user[15 : 15];
      shiftStage_s2mPipe_rData_user[16 : 16] <= shiftStage_s2mPipe_payload_user[16 : 16];
      shiftStage_s2mPipe_rData_user[17 : 17] <= shiftStage_s2mPipe_payload_user[17 : 17];
      shiftStage_s2mPipe_rData_user[18 : 18] <= shiftStage_s2mPipe_payload_user[18 : 18];
      shiftStage_s2mPipe_rData_user[19 : 19] <= shiftStage_s2mPipe_payload_user[19 : 19];
      shiftStage_s2mPipe_rData_user[20 : 20] <= shiftStage_s2mPipe_payload_user[20 : 20];
      shiftStage_s2mPipe_rData_user[21 : 21] <= shiftStage_s2mPipe_payload_user[21 : 21];
      shiftStage_s2mPipe_rData_user[22 : 22] <= shiftStage_s2mPipe_payload_user[22 : 22];
      shiftStage_s2mPipe_rData_user[23 : 23] <= shiftStage_s2mPipe_payload_user[23 : 23];
      shiftStage_s2mPipe_rData_user[24 : 24] <= shiftStage_s2mPipe_payload_user[24 : 24];
      shiftStage_s2mPipe_rData_user[25 : 25] <= shiftStage_s2mPipe_payload_user[25 : 25];
      shiftStage_s2mPipe_rData_user[26 : 26] <= shiftStage_s2mPipe_payload_user[26 : 26];
      shiftStage_s2mPipe_rData_user[27 : 27] <= shiftStage_s2mPipe_payload_user[27 : 27];
      shiftStage_s2mPipe_rData_user[28 : 28] <= shiftStage_s2mPipe_payload_user[28 : 28];
      shiftStage_s2mPipe_rData_user[29 : 29] <= shiftStage_s2mPipe_payload_user[29 : 29];
      shiftStage_s2mPipe_rData_user[30 : 30] <= shiftStage_s2mPipe_payload_user[30 : 30];
      shiftStage_s2mPipe_rData_user[31 : 31] <= shiftStage_s2mPipe_payload_user[31 : 31];
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

module StreamMux (
  input      [0:0]    io_select,
  input               io_inputs_0_valid,
  output              io_inputs_0_ready,
  input      [255:0]  io_inputs_0_payload_data,
  input      [31:0]   io_inputs_0_payload_keep,
  input               io_inputs_0_payload_last,
  input      [31:0]   io_inputs_0_payload_user,
  input               io_inputs_1_valid,
  output              io_inputs_1_ready,
  input      [255:0]  io_inputs_1_payload_data,
  input      [31:0]   io_inputs_1_payload_keep,
  input               io_inputs_1_payload_last,
  input      [31:0]   io_inputs_1_payload_user,
  output              io_output_valid,
  input               io_output_ready,
  output     [255:0]  io_output_payload_data,
  output     [31:0]   io_output_payload_keep,
  output              io_output_payload_last,
  output reg [31:0]   io_output_payload_user
);

  reg        [31:0]   _zz__zz_io_output_payload_user;
  reg                 _zz_io_output_valid;
  reg        [255:0]  _zz_io_output_payload_data;
  reg        [31:0]   _zz_io_output_payload_keep;
  reg                 _zz_io_output_payload_last;
  wire       [31:0]   _zz_io_output_payload_user;

  always @(*) begin
    case(io_select)
      1'b0 : begin
        _zz__zz_io_output_payload_user = io_inputs_0_payload_user;
        _zz_io_output_valid = io_inputs_0_valid;
        _zz_io_output_payload_data = io_inputs_0_payload_data;
        _zz_io_output_payload_keep = io_inputs_0_payload_keep;
        _zz_io_output_payload_last = io_inputs_0_payload_last;
      end
      default : begin
        _zz__zz_io_output_payload_user = io_inputs_1_payload_user;
        _zz_io_output_valid = io_inputs_1_valid;
        _zz_io_output_payload_data = io_inputs_1_payload_data;
        _zz_io_output_payload_keep = io_inputs_1_payload_keep;
        _zz_io_output_payload_last = io_inputs_1_payload_last;
      end
    endcase
  end

  assign io_inputs_0_ready = ((io_select == 1'b0) && io_output_ready);
  assign io_inputs_1_ready = ((io_select == 1'b1) && io_output_ready);
  assign _zz_io_output_payload_user = _zz__zz_io_output_payload_user;
  assign io_output_valid = _zz_io_output_valid;
  assign io_output_payload_data = _zz_io_output_payload_data;
  assign io_output_payload_keep = _zz_io_output_payload_keep;
  assign io_output_payload_last = _zz_io_output_payload_last;
  always @(*) begin
    io_output_payload_user[0 : 0] = _zz_io_output_payload_user[0 : 0];
    io_output_payload_user[1 : 1] = _zz_io_output_payload_user[1 : 1];
    io_output_payload_user[2 : 2] = _zz_io_output_payload_user[2 : 2];
    io_output_payload_user[3 : 3] = _zz_io_output_payload_user[3 : 3];
    io_output_payload_user[4 : 4] = _zz_io_output_payload_user[4 : 4];
    io_output_payload_user[5 : 5] = _zz_io_output_payload_user[5 : 5];
    io_output_payload_user[6 : 6] = _zz_io_output_payload_user[6 : 6];
    io_output_payload_user[7 : 7] = _zz_io_output_payload_user[7 : 7];
    io_output_payload_user[8 : 8] = _zz_io_output_payload_user[8 : 8];
    io_output_payload_user[9 : 9] = _zz_io_output_payload_user[9 : 9];
    io_output_payload_user[10 : 10] = _zz_io_output_payload_user[10 : 10];
    io_output_payload_user[11 : 11] = _zz_io_output_payload_user[11 : 11];
    io_output_payload_user[12 : 12] = _zz_io_output_payload_user[12 : 12];
    io_output_payload_user[13 : 13] = _zz_io_output_payload_user[13 : 13];
    io_output_payload_user[14 : 14] = _zz_io_output_payload_user[14 : 14];
    io_output_payload_user[15 : 15] = _zz_io_output_payload_user[15 : 15];
    io_output_payload_user[16 : 16] = _zz_io_output_payload_user[16 : 16];
    io_output_payload_user[17 : 17] = _zz_io_output_payload_user[17 : 17];
    io_output_payload_user[18 : 18] = _zz_io_output_payload_user[18 : 18];
    io_output_payload_user[19 : 19] = _zz_io_output_payload_user[19 : 19];
    io_output_payload_user[20 : 20] = _zz_io_output_payload_user[20 : 20];
    io_output_payload_user[21 : 21] = _zz_io_output_payload_user[21 : 21];
    io_output_payload_user[22 : 22] = _zz_io_output_payload_user[22 : 22];
    io_output_payload_user[23 : 23] = _zz_io_output_payload_user[23 : 23];
    io_output_payload_user[24 : 24] = _zz_io_output_payload_user[24 : 24];
    io_output_payload_user[25 : 25] = _zz_io_output_payload_user[25 : 25];
    io_output_payload_user[26 : 26] = _zz_io_output_payload_user[26 : 26];
    io_output_payload_user[27 : 27] = _zz_io_output_payload_user[27 : 27];
    io_output_payload_user[28 : 28] = _zz_io_output_payload_user[28 : 28];
    io_output_payload_user[29 : 29] = _zz_io_output_payload_user[29 : 29];
    io_output_payload_user[30 : 30] = _zz_io_output_payload_user[30 : 30];
    io_output_payload_user[31 : 31] = _zz_io_output_payload_user[31 : 31];
  end


endmodule

module StreamFork (
  input               io_input_valid,
  output reg          io_input_ready,
  input      [255:0]  io_input_payload_data,
  input      [31:0]   io_input_payload_keep,
  input               io_input_payload_last,
  input      [31:0]   io_input_payload_user,
  output              io_outputs_0_valid,
  input               io_outputs_0_ready,
  output     [255:0]  io_outputs_0_payload_data,
  output     [31:0]   io_outputs_0_payload_keep,
  output              io_outputs_0_payload_last,
  output reg [31:0]   io_outputs_0_payload_user,
  output              io_outputs_1_valid,
  input               io_outputs_1_ready,
  output     [255:0]  io_outputs_1_payload_data,
  output     [31:0]   io_outputs_1_payload_keep,
  output              io_outputs_1_payload_last,
  output reg [31:0]   io_outputs_1_payload_user,
  input               clk,
  input               reset
);

  reg                 _zz_io_outputs_0_valid;
  reg                 _zz_io_outputs_1_valid;
  wire                when_Stream_l948;
  wire                when_Stream_l948_1;
  wire                io_outputs_0_fire;
  wire                io_outputs_1_fire;

  always @(*) begin
    io_input_ready = 1'b1;
    if(when_Stream_l948) begin
      io_input_ready = 1'b0;
    end
    if(when_Stream_l948_1) begin
      io_input_ready = 1'b0;
    end
  end

  assign when_Stream_l948 = ((! io_outputs_0_ready) && _zz_io_outputs_0_valid);
  assign when_Stream_l948_1 = ((! io_outputs_1_ready) && _zz_io_outputs_1_valid);
  assign io_outputs_0_valid = (io_input_valid && _zz_io_outputs_0_valid);
  assign io_outputs_0_payload_data = io_input_payload_data;
  assign io_outputs_0_payload_keep = io_input_payload_keep;
  assign io_outputs_0_payload_last = io_input_payload_last;
  always @(*) begin
    io_outputs_0_payload_user[0 : 0] = io_input_payload_user[0 : 0];
    io_outputs_0_payload_user[1 : 1] = io_input_payload_user[1 : 1];
    io_outputs_0_payload_user[2 : 2] = io_input_payload_user[2 : 2];
    io_outputs_0_payload_user[3 : 3] = io_input_payload_user[3 : 3];
    io_outputs_0_payload_user[4 : 4] = io_input_payload_user[4 : 4];
    io_outputs_0_payload_user[5 : 5] = io_input_payload_user[5 : 5];
    io_outputs_0_payload_user[6 : 6] = io_input_payload_user[6 : 6];
    io_outputs_0_payload_user[7 : 7] = io_input_payload_user[7 : 7];
    io_outputs_0_payload_user[8 : 8] = io_input_payload_user[8 : 8];
    io_outputs_0_payload_user[9 : 9] = io_input_payload_user[9 : 9];
    io_outputs_0_payload_user[10 : 10] = io_input_payload_user[10 : 10];
    io_outputs_0_payload_user[11 : 11] = io_input_payload_user[11 : 11];
    io_outputs_0_payload_user[12 : 12] = io_input_payload_user[12 : 12];
    io_outputs_0_payload_user[13 : 13] = io_input_payload_user[13 : 13];
    io_outputs_0_payload_user[14 : 14] = io_input_payload_user[14 : 14];
    io_outputs_0_payload_user[15 : 15] = io_input_payload_user[15 : 15];
    io_outputs_0_payload_user[16 : 16] = io_input_payload_user[16 : 16];
    io_outputs_0_payload_user[17 : 17] = io_input_payload_user[17 : 17];
    io_outputs_0_payload_user[18 : 18] = io_input_payload_user[18 : 18];
    io_outputs_0_payload_user[19 : 19] = io_input_payload_user[19 : 19];
    io_outputs_0_payload_user[20 : 20] = io_input_payload_user[20 : 20];
    io_outputs_0_payload_user[21 : 21] = io_input_payload_user[21 : 21];
    io_outputs_0_payload_user[22 : 22] = io_input_payload_user[22 : 22];
    io_outputs_0_payload_user[23 : 23] = io_input_payload_user[23 : 23];
    io_outputs_0_payload_user[24 : 24] = io_input_payload_user[24 : 24];
    io_outputs_0_payload_user[25 : 25] = io_input_payload_user[25 : 25];
    io_outputs_0_payload_user[26 : 26] = io_input_payload_user[26 : 26];
    io_outputs_0_payload_user[27 : 27] = io_input_payload_user[27 : 27];
    io_outputs_0_payload_user[28 : 28] = io_input_payload_user[28 : 28];
    io_outputs_0_payload_user[29 : 29] = io_input_payload_user[29 : 29];
    io_outputs_0_payload_user[30 : 30] = io_input_payload_user[30 : 30];
    io_outputs_0_payload_user[31 : 31] = io_input_payload_user[31 : 31];
  end

  assign io_outputs_0_fire = (io_outputs_0_valid && io_outputs_0_ready);
  assign io_outputs_1_valid = (io_input_valid && _zz_io_outputs_1_valid);
  assign io_outputs_1_payload_data = io_input_payload_data;
  assign io_outputs_1_payload_keep = io_input_payload_keep;
  assign io_outputs_1_payload_last = io_input_payload_last;
  always @(*) begin
    io_outputs_1_payload_user[0 : 0] = io_input_payload_user[0 : 0];
    io_outputs_1_payload_user[1 : 1] = io_input_payload_user[1 : 1];
    io_outputs_1_payload_user[2 : 2] = io_input_payload_user[2 : 2];
    io_outputs_1_payload_user[3 : 3] = io_input_payload_user[3 : 3];
    io_outputs_1_payload_user[4 : 4] = io_input_payload_user[4 : 4];
    io_outputs_1_payload_user[5 : 5] = io_input_payload_user[5 : 5];
    io_outputs_1_payload_user[6 : 6] = io_input_payload_user[6 : 6];
    io_outputs_1_payload_user[7 : 7] = io_input_payload_user[7 : 7];
    io_outputs_1_payload_user[8 : 8] = io_input_payload_user[8 : 8];
    io_outputs_1_payload_user[9 : 9] = io_input_payload_user[9 : 9];
    io_outputs_1_payload_user[10 : 10] = io_input_payload_user[10 : 10];
    io_outputs_1_payload_user[11 : 11] = io_input_payload_user[11 : 11];
    io_outputs_1_payload_user[12 : 12] = io_input_payload_user[12 : 12];
    io_outputs_1_payload_user[13 : 13] = io_input_payload_user[13 : 13];
    io_outputs_1_payload_user[14 : 14] = io_input_payload_user[14 : 14];
    io_outputs_1_payload_user[15 : 15] = io_input_payload_user[15 : 15];
    io_outputs_1_payload_user[16 : 16] = io_input_payload_user[16 : 16];
    io_outputs_1_payload_user[17 : 17] = io_input_payload_user[17 : 17];
    io_outputs_1_payload_user[18 : 18] = io_input_payload_user[18 : 18];
    io_outputs_1_payload_user[19 : 19] = io_input_payload_user[19 : 19];
    io_outputs_1_payload_user[20 : 20] = io_input_payload_user[20 : 20];
    io_outputs_1_payload_user[21 : 21] = io_input_payload_user[21 : 21];
    io_outputs_1_payload_user[22 : 22] = io_input_payload_user[22 : 22];
    io_outputs_1_payload_user[23 : 23] = io_input_payload_user[23 : 23];
    io_outputs_1_payload_user[24 : 24] = io_input_payload_user[24 : 24];
    io_outputs_1_payload_user[25 : 25] = io_input_payload_user[25 : 25];
    io_outputs_1_payload_user[26 : 26] = io_input_payload_user[26 : 26];
    io_outputs_1_payload_user[27 : 27] = io_input_payload_user[27 : 27];
    io_outputs_1_payload_user[28 : 28] = io_input_payload_user[28 : 28];
    io_outputs_1_payload_user[29 : 29] = io_input_payload_user[29 : 29];
    io_outputs_1_payload_user[30 : 30] = io_input_payload_user[30 : 30];
    io_outputs_1_payload_user[31 : 31] = io_input_payload_user[31 : 31];
  end

  assign io_outputs_1_fire = (io_outputs_1_valid && io_outputs_1_ready);
  always @(posedge clk or posedge reset) begin
    if(reset) begin
      _zz_io_outputs_0_valid <= 1'b1;
      _zz_io_outputs_1_valid <= 1'b1;
    end else begin
      if(io_outputs_0_fire) begin
        _zz_io_outputs_0_valid <= 1'b0;
      end
      if(io_outputs_1_fire) begin
        _zz_io_outputs_1_valid <= 1'b0;
      end
      if(io_input_ready) begin
        _zz_io_outputs_0_valid <= 1'b1;
        _zz_io_outputs_1_valid <= 1'b1;
      end
    end
  end


endmodule

module StreamFifo_2 (
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
  output     [4:0]    io_occupancy,
  output     [4:0]    io_availability,
  input               clk,
  input               reset
);

  reg        [320:0]  _zz_logic_ram_port0;
  wire       [3:0]    _zz_logic_pushPtr_valueNext;
  wire       [0:0]    _zz_logic_pushPtr_valueNext_1;
  wire       [3:0]    _zz_logic_popPtr_valueNext;
  wire       [0:0]    _zz_logic_popPtr_valueNext_1;
  wire                _zz_logic_ram_port;
  wire                _zz__zz_io_pop_payload_data;
  wire       [320:0]  _zz_logic_ram_port_1;
  wire       [3:0]    _zz_io_availability;
  reg                 _zz_1;
  reg                 logic_pushPtr_willIncrement;
  reg                 logic_pushPtr_willClear;
  reg        [3:0]    logic_pushPtr_valueNext;
  reg        [3:0]    logic_pushPtr_value;
  wire                logic_pushPtr_willOverflowIfInc;
  wire                logic_pushPtr_willOverflow;
  reg                 logic_popPtr_willIncrement;
  reg                 logic_popPtr_willClear;
  reg        [3:0]    logic_popPtr_valueNext;
  reg        [3:0]    logic_popPtr_value;
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
  wire       [3:0]    logic_ptrDif;
  reg [320:0] logic_ram [0:15];

  assign _zz_logic_pushPtr_valueNext_1 = logic_pushPtr_willIncrement;
  assign _zz_logic_pushPtr_valueNext = {3'd0, _zz_logic_pushPtr_valueNext_1};
  assign _zz_logic_popPtr_valueNext_1 = logic_popPtr_willIncrement;
  assign _zz_logic_popPtr_valueNext = {3'd0, _zz_logic_popPtr_valueNext_1};
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

  assign logic_pushPtr_willOverflowIfInc = (logic_pushPtr_value == 4'b1111);
  assign logic_pushPtr_willOverflow = (logic_pushPtr_willOverflowIfInc && logic_pushPtr_willIncrement);
  always @(*) begin
    logic_pushPtr_valueNext = (logic_pushPtr_value + _zz_logic_pushPtr_valueNext);
    if(logic_pushPtr_willClear) begin
      logic_pushPtr_valueNext = 4'b0000;
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

  assign logic_popPtr_willOverflowIfInc = (logic_popPtr_value == 4'b1111);
  assign logic_popPtr_willOverflow = (logic_popPtr_willOverflowIfInc && logic_popPtr_willIncrement);
  always @(*) begin
    logic_popPtr_valueNext = (logic_popPtr_value + _zz_logic_popPtr_valueNext);
    if(logic_popPtr_willClear) begin
      logic_popPtr_valueNext = 4'b0000;
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
      logic_pushPtr_value <= 4'b0000;
      logic_popPtr_value <= 4'b0000;
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

module HeaderGenerator (
  input               io_metaIn_valid,
  output              io_metaIn_ready,
  input      [11:0]   io_metaIn_payload_dataLen,
  input      [47:0]   io_metaIn_payload_dstMacAddr,
  input      [31:0]   io_metaIn_payload_dstIpAddr,
  input      [47:0]   io_metaIn_payload_srcMacAddr,
  input      [31:0]   io_metaIn_payload_srcIpAddr,
  input      [15:0]   io_metaIn_payload_dstPort,
  input      [15:0]   io_metaIn_payload_srcPort,
  output              io_headerAxisOut_valid,
  input               io_headerAxisOut_ready,
  output     [255:0]  io_headerAxisOut_payload_data,
  output     [31:0]   io_headerAxisOut_payload_keep,
  output reg          io_headerAxisOut_payload_last,
  output     [31:0]   io_headerAxisOut_payload_user,
  input               clk,
  input               reset
);

  wire       [15:0]   _zz_ipLenReg;
  wire       [15:0]   _zz_ipLenReg_1;
  wire       [15:0]   _zz_udpLenReg;
  wire       [6:0]    _zz_packetLenReg;
  wire       [15:0]   _zz_ipLenReg_2;
  wire       [15:0]   _zz_ipLenReg_3;
  wire       [15:0]   _zz_udpLenReg_1;
  wire       [6:0]    _zz_packetLenReg_1;
  wire       [115:0]  _zz__zz_ethIpUdpHeader_0;
  wire       [335:0]  _zz__zz_ethIpUdpHeader_0_1;
  wire       [207:0]  _zz__zz_ethIpUdpHeader_0_1_1;
  wire       [79:0]   _zz__zz_ethIpUdpHeader_0_1_2;
  wire       [7:0]    _zz__zz_ethIpUdpHeader_0_1_3;
  wire       [7:0]    _zz__zz_ethIpUdpHeader_0_1_4;
  reg        [255:0]  _zz__zz_io_headerAxisOut_payload_data;
  reg        [15:0]   ipLenReg;
  reg        [15:0]   udpLenReg;
  reg        [15:0]   ipIdReg;
  wire       [15:0]   ipChecksumReg;
  reg                 generateDone;
  reg        [5:0]    packetLenReg;
  reg                 dataLoadedReg;
  reg                 sendingCnt_willIncrement;
  wire                sendingCnt_willClear;
  reg        [0:0]    sendingCnt_valueNext;
  reg        [0:0]    sendingCnt_value;
  wire                sendingCnt_willOverflowIfInc;
  wire                sendingCnt_willOverflow;
  reg                 needFragment;
  reg        [11:0]   metaRegs_dataLen;
  reg        [47:0]   metaRegs_dstMacAddr;
  reg        [31:0]   metaRegs_dstIpAddr;
  reg        [47:0]   metaRegs_srcMacAddr;
  reg        [31:0]   metaRegs_srcIpAddr;
  reg        [15:0]   metaRegs_dstPort;
  reg        [15:0]   metaRegs_srcPort;
  wire                metaReadySet;
  wire                io_metaIn_fire;
  wire                io_headerAxisOut_fire;
  wire                when_HeaderGenerator_l82;
  wire       [11:0]   packetTotalLenFirst;
  wire                needOneMorePacketFirst;
  wire       [11:0]   packetTotalLenFragmented;
  wire                needOneMorePacketFragmented;
  wire                io_metaIn_fire_1;
  wire                io_metaIn_fire_2;
  wire                when_HeaderGenerator_l101;
  wire                when_HeaderGenerator_l115;
  wire                io_headerAxisOut_fire_1;
  wire                when_HeaderGenerator_l114;
  wire       [47:0]   ethHeader_0;
  wire       [47:0]   ethHeader_1;
  wire       [15:0]   ethHeader_2;
  wire       [3:0]    ipv4Header_0;
  wire       [3:0]    ipv4Header_1;
  wire       [5:0]    ipv4Header_2;
  wire       [1:0]    ipv4Header_3;
  wire       [15:0]   ipv4Header_4;
  wire       [15:0]   ipv4Header_5;
  wire       [2:0]    ipv4Header_6;
  wire       [12:0]   ipv4Header_7;
  wire       [7:0]    ipv4Header_8;
  wire       [7:0]    ipv4Header_9;
  wire       [15:0]   ipv4Header_10;
  wire       [31:0]   ipv4Header_11;
  wire       [31:0]   ipv4Header_12;
  wire       [15:0]   udpHeader_0;
  wire       [15:0]   udpHeader_1;
  wire       [15:0]   udpHeader_2;
  wire       [15:0]   udpHeader_3;
  wire       [335:0]  _zz_ethIpUdpHeader_0;
  wire       [511:0]  _zz_ethIpUdpHeader_0_1;
  wire       [255:0]  ethIpUdpHeader_0;
  wire       [255:0]  ethIpUdpHeader_1;
  wire       [255:0]  _zz_io_headerAxisOut_payload_data;
  reg        [255:0]  _zz_io_headerAxisOut_payload_data_1;
  reg        [31:0]   _zz_io_headerAxisOut_payload_keep;
  reg        [31:0]   _zz_io_headerAxisOut_payload_keep_1;
  reg        [31:0]   _zz_io_headerAxisOut_payload_user;
  wire                io_headerAxisOut_fire_2;
  wire                when_HeaderGenerator_l190;
  wire                when_HeaderGenerator_l196;
  wire                when_HeaderGenerator_l198;
  function [31:0] zz__zz_io_headerAxisOut_payload_keep(input dummy);
    begin
      zz__zz_io_headerAxisOut_payload_keep = 32'h0;
      zz__zz_io_headerAxisOut_payload_keep[31 : 22] = 10'h3ff;
    end
  endfunction
  wire [31:0] _zz_1;

  assign _zz_ipLenReg = (_zz_ipLenReg_1 + 16'h0014);
  assign _zz_ipLenReg_1 = {4'd0, io_metaIn_payload_dataLen};
  assign _zz_udpLenReg = {4'd0, io_metaIn_payload_dataLen};
  assign _zz_packetLenReg = (packetTotalLenFirst >>> 5);
  assign _zz_ipLenReg_2 = (_zz_ipLenReg_3 + 16'h0014);
  assign _zz_ipLenReg_3 = {4'd0, metaRegs_dataLen};
  assign _zz_udpLenReg_1 = {4'd0, metaRegs_dataLen};
  assign _zz_packetLenReg_1 = (packetTotalLenFragmented >>> 5);
  assign _zz__zz_ethIpUdpHeader_0_1 = {{{{{{{{{{{{{{{{_zz__zz_ethIpUdpHeader_0_1_1,_zz__zz_ethIpUdpHeader_0_1_4},_zz_ethIpUdpHeader_0[223 : 216]},_zz_ethIpUdpHeader_0[231 : 224]},_zz_ethIpUdpHeader_0[239 : 232]},_zz_ethIpUdpHeader_0[247 : 240]},_zz_ethIpUdpHeader_0[255 : 248]},_zz_ethIpUdpHeader_0[263 : 256]},_zz_ethIpUdpHeader_0[271 : 264]},_zz_ethIpUdpHeader_0[279 : 272]},_zz_ethIpUdpHeader_0[287 : 280]},_zz_ethIpUdpHeader_0[295 : 288]},_zz_ethIpUdpHeader_0[303 : 296]},_zz_ethIpUdpHeader_0[311 : 304]},_zz_ethIpUdpHeader_0[319 : 312]},_zz_ethIpUdpHeader_0[327 : 320]},_zz_ethIpUdpHeader_0[335 : 328]};
  assign _zz__zz_ethIpUdpHeader_0 = {{{ethHeader_0,ethHeader_1},ethHeader_2},ipv4Header_0};
  assign _zz__zz_ethIpUdpHeader_0_1_1 = {{{{{{{{{{{{{{{{_zz__zz_ethIpUdpHeader_0_1_2,_zz__zz_ethIpUdpHeader_0_1_3},_zz_ethIpUdpHeader_0[95 : 88]},_zz_ethIpUdpHeader_0[103 : 96]},_zz_ethIpUdpHeader_0[111 : 104]},_zz_ethIpUdpHeader_0[119 : 112]},_zz_ethIpUdpHeader_0[127 : 120]},_zz_ethIpUdpHeader_0[135 : 128]},_zz_ethIpUdpHeader_0[143 : 136]},_zz_ethIpUdpHeader_0[151 : 144]},_zz_ethIpUdpHeader_0[159 : 152]},_zz_ethIpUdpHeader_0[167 : 160]},_zz_ethIpUdpHeader_0[175 : 168]},_zz_ethIpUdpHeader_0[183 : 176]},_zz_ethIpUdpHeader_0[191 : 184]},_zz_ethIpUdpHeader_0[199 : 192]},_zz_ethIpUdpHeader_0[207 : 200]};
  assign _zz__zz_ethIpUdpHeader_0_1_4 = _zz_ethIpUdpHeader_0[215 : 208];
  assign _zz__zz_ethIpUdpHeader_0_1_2 = {{{{{{{{{_zz_ethIpUdpHeader_0[7 : 0],_zz_ethIpUdpHeader_0[15 : 8]},_zz_ethIpUdpHeader_0[23 : 16]},_zz_ethIpUdpHeader_0[31 : 24]},_zz_ethIpUdpHeader_0[39 : 32]},_zz_ethIpUdpHeader_0[47 : 40]},_zz_ethIpUdpHeader_0[55 : 48]},_zz_ethIpUdpHeader_0[63 : 56]},_zz_ethIpUdpHeader_0[71 : 64]},_zz_ethIpUdpHeader_0[79 : 72]};
  assign _zz__zz_ethIpUdpHeader_0_1_3 = _zz_ethIpUdpHeader_0[87 : 80];
  always @(*) begin
    case(sendingCnt_value)
      1'b0 : _zz__zz_io_headerAxisOut_payload_data = ethIpUdpHeader_0;
      default : _zz__zz_io_headerAxisOut_payload_data = ethIpUdpHeader_1;
    endcase
  end

  assign ipChecksumReg = 16'h0;
  always @(*) begin
    sendingCnt_willIncrement = 1'b0;
    if(io_headerAxisOut_fire_2) begin
      sendingCnt_willIncrement = 1'b1;
    end
  end

  assign sendingCnt_willClear = 1'b0;
  assign sendingCnt_willOverflowIfInc = (sendingCnt_value == 1'b1);
  assign sendingCnt_willOverflow = (sendingCnt_willOverflowIfInc && sendingCnt_willIncrement);
  always @(*) begin
    sendingCnt_valueNext = (sendingCnt_value + sendingCnt_willIncrement);
    if(sendingCnt_willClear) begin
      sendingCnt_valueNext = 1'b0;
    end
  end

  assign metaReadySet = ((! dataLoadedReg) || generateDone);
  assign io_metaIn_ready = metaReadySet;
  assign io_metaIn_fire = (io_metaIn_valid && io_metaIn_ready);
  assign io_headerAxisOut_fire = (io_headerAxisOut_valid && io_headerAxisOut_ready);
  assign when_HeaderGenerator_l82 = (io_headerAxisOut_payload_last && io_headerAxisOut_fire);
  assign packetTotalLenFirst = (io_metaIn_payload_dataLen + 12'h02a);
  assign needOneMorePacketFirst = ((packetTotalLenFirst & 12'h01f) != 12'h0);
  assign packetTotalLenFragmented = (metaRegs_dataLen + 12'h02a);
  assign needOneMorePacketFragmented = ((packetTotalLenFragmented & 12'h01f) != 12'h0);
  assign io_metaIn_fire_1 = (io_metaIn_valid && io_metaIn_ready);
  assign io_metaIn_fire_2 = (io_metaIn_valid && io_metaIn_ready);
  assign when_HeaderGenerator_l101 = (12'h5c0 < io_metaIn_payload_dataLen);
  assign when_HeaderGenerator_l115 = (12'h5c0 < metaRegs_dataLen);
  assign io_headerAxisOut_fire_1 = (io_headerAxisOut_valid && io_headerAxisOut_ready);
  assign when_HeaderGenerator_l114 = ((io_headerAxisOut_payload_last && io_headerAxisOut_fire_1) && needFragment);
  assign ethHeader_0 = metaRegs_dstMacAddr;
  assign ethHeader_1 = metaRegs_srcMacAddr;
  assign ethHeader_2 = 16'h0800;
  assign ipv4Header_0 = 4'b0100;
  assign ipv4Header_1 = 4'b0101;
  assign ipv4Header_2 = 6'h0;
  assign ipv4Header_3 = 2'b00;
  assign ipv4Header_4 = ipLenReg;
  assign ipv4Header_5 = ipIdReg;
  assign ipv4Header_6 = 3'b010;
  assign ipv4Header_7 = 13'h0;
  assign ipv4Header_8 = 8'h40;
  assign ipv4Header_9 = 8'h11;
  assign ipv4Header_10 = ipChecksumReg;
  assign ipv4Header_11 = metaRegs_srcIpAddr;
  assign ipv4Header_12 = metaRegs_dstIpAddr;
  assign udpHeader_0 = metaRegs_srcPort;
  assign udpHeader_1 = metaRegs_dstPort;
  assign udpHeader_2 = udpLenReg;
  assign udpHeader_3 = 16'h0;
  assign _zz_ethIpUdpHeader_0 = {{{{{{{{{{{{{{{{_zz__zz_ethIpUdpHeader_0,ipv4Header_1},ipv4Header_2},ipv4Header_3},ipv4Header_4},ipv4Header_5},ipv4Header_6},ipv4Header_7},ipv4Header_8},ipv4Header_9},ipv4Header_10},ipv4Header_11},ipv4Header_12},udpHeader_0},udpHeader_1},udpHeader_2},udpHeader_3};
  assign _zz_ethIpUdpHeader_0_1 = {176'd0, _zz__zz_ethIpUdpHeader_0_1};
  assign ethIpUdpHeader_0 = _zz_ethIpUdpHeader_0_1[255 : 0];
  assign ethIpUdpHeader_1 = _zz_ethIpUdpHeader_0_1[511 : 256];
  assign _zz_io_headerAxisOut_payload_data = _zz__zz_io_headerAxisOut_payload_data;
  always @(*) begin
    case(sendingCnt_value)
      1'b0 : begin
        _zz_io_headerAxisOut_payload_data_1 = _zz_io_headerAxisOut_payload_data;
      end
      default : begin
        _zz_io_headerAxisOut_payload_data_1 = {_zz_io_headerAxisOut_payload_data[79 : 0],_zz_io_headerAxisOut_payload_data[255 : 80]};
      end
    endcase
  end

  assign io_headerAxisOut_payload_data = _zz_io_headerAxisOut_payload_data_1;
  assign _zz_1 = zz__zz_io_headerAxisOut_payload_keep(1'b0);
  always @(*) _zz_io_headerAxisOut_payload_keep = _zz_1;
  always @(*) begin
    case(sendingCnt_value)
      1'b0 : begin
        _zz_io_headerAxisOut_payload_keep_1 = 32'hffffffff;
      end
      default : begin
        _zz_io_headerAxisOut_payload_keep_1 = _zz_io_headerAxisOut_payload_keep;
      end
    endcase
  end

  assign io_headerAxisOut_payload_keep = _zz_io_headerAxisOut_payload_keep_1;
  always @(*) begin
    case(sendingCnt_value)
      1'b0 : begin
        _zz_io_headerAxisOut_payload_user = {{{{{8'h5a,4'b0000},packetLenReg},1'b1},5'h0},8'ha5};
      end
      default : begin
        _zz_io_headerAxisOut_payload_user = {{{{{8'h5a,4'b0000},packetLenReg},1'b0},5'h0a},8'ha5};
      end
    endcase
  end

  assign io_headerAxisOut_payload_user = _zz_io_headerAxisOut_payload_user;
  assign io_headerAxisOut_valid = dataLoadedReg;
  assign io_headerAxisOut_fire_2 = (io_headerAxisOut_valid && io_headerAxisOut_ready);
  assign when_HeaderGenerator_l190 = sendingCnt_value[0];
  always @(*) begin
    if(io_headerAxisOut_fire_2) begin
      if(when_HeaderGenerator_l190) begin
        io_headerAxisOut_payload_last = 1'b1;
      end else begin
        io_headerAxisOut_payload_last = 1'b0;
      end
    end else begin
      io_headerAxisOut_payload_last = 1'b0;
    end
  end

  assign when_HeaderGenerator_l196 = (sendingCnt_value[0] && needFragment);
  always @(*) begin
    if(io_headerAxisOut_fire_2) begin
      if(when_HeaderGenerator_l196) begin
        generateDone = 1'b0;
      end else begin
        if(when_HeaderGenerator_l198) begin
          generateDone = 1'b1;
        end else begin
          generateDone = 1'b0;
        end
      end
    end else begin
      generateDone = 1'b0;
    end
  end

  assign when_HeaderGenerator_l198 = (sendingCnt_value[0] && (! needFragment));
  always @(posedge clk or posedge reset) begin
    if(reset) begin
      ipLenReg <= 16'h0;
      udpLenReg <= 16'h0;
      ipIdReg <= 16'h0;
      packetLenReg <= 6'h0;
      dataLoadedReg <= 1'b0;
      sendingCnt_value <= 1'b0;
      needFragment <= 1'b0;
    end else begin
      sendingCnt_value <= sendingCnt_valueNext;
      if(io_metaIn_fire) begin
        dataLoadedReg <= 1'b1;
      end else begin
        if(generateDone) begin
          dataLoadedReg <= 1'b0;
        end
      end
      if(when_HeaderGenerator_l82) begin
        ipIdReg <= (ipIdReg + 16'h0001);
      end
      if(io_metaIn_fire_2) begin
        if(when_HeaderGenerator_l101) begin
          needFragment <= 1'b1;
          ipLenReg <= 16'h05dc;
          udpLenReg <= 16'h05c8;
          packetLenReg <= 6'h30;
        end else begin
          needFragment <= 1'b0;
          ipLenReg <= (_zz_ipLenReg + 16'h0008);
          udpLenReg <= (_zz_udpLenReg + 16'h0008);
          packetLenReg <= (_zz_packetLenReg[5 : 0] + (needOneMorePacketFirst ? 6'h01 : 6'h0));
        end
      end else begin
        if(when_HeaderGenerator_l114) begin
          if(when_HeaderGenerator_l115) begin
            needFragment <= 1'b1;
            ipLenReg <= 16'h05dc;
            packetLenReg <= 6'h30;
          end else begin
            needFragment <= 1'b0;
            ipLenReg <= (_zz_ipLenReg_2 + 16'h0008);
            udpLenReg <= (_zz_udpLenReg_1 + 16'h0008);
            packetLenReg <= (_zz_packetLenReg_1[5 : 0] + (needOneMorePacketFragmented ? 6'h01 : 6'h0));
          end
        end
      end
    end
  end

  always @(posedge clk) begin
    if(io_metaIn_fire_1) begin
      metaRegs_srcPort <= io_metaIn_payload_srcPort;
      metaRegs_dstPort <= io_metaIn_payload_dstPort;
      metaRegs_dstIpAddr <= io_metaIn_payload_dstIpAddr;
      metaRegs_dstMacAddr <= io_metaIn_payload_dstMacAddr;
      metaRegs_srcIpAddr <= io_metaIn_payload_srcIpAddr;
      metaRegs_srcMacAddr <= io_metaIn_payload_srcMacAddr;
    end
    if(io_metaIn_fire_2) begin
      if(when_HeaderGenerator_l101) begin
        metaRegs_dataLen <= (io_metaIn_payload_dataLen - 12'h5c0);
      end
    end else begin
      if(when_HeaderGenerator_l114) begin
        if(when_HeaderGenerator_l115) begin
          metaRegs_dataLen <= (metaRegs_dataLen - 12'h5c0);
        end
      end
    end
  end


endmodule

module StreamFifo_1 (
  input               io_push_valid,
  output              io_push_ready,
  input      [11:0]   io_push_payload_dataLen,
  input      [47:0]   io_push_payload_dstMacAddr,
  input      [31:0]   io_push_payload_dstIpAddr,
  input      [47:0]   io_push_payload_srcMacAddr,
  input      [31:0]   io_push_payload_srcIpAddr,
  input      [15:0]   io_push_payload_dstPort,
  input      [15:0]   io_push_payload_srcPort,
  output              io_pop_valid,
  input               io_pop_ready,
  output     [11:0]   io_pop_payload_dataLen,
  output     [47:0]   io_pop_payload_dstMacAddr,
  output     [31:0]   io_pop_payload_dstIpAddr,
  output     [47:0]   io_pop_payload_srcMacAddr,
  output     [31:0]   io_pop_payload_srcIpAddr,
  output     [15:0]   io_pop_payload_dstPort,
  output     [15:0]   io_pop_payload_srcPort,
  input               io_flush,
  output     [2:0]    io_occupancy,
  output     [2:0]    io_availability,
  input               clk,
  input               reset
);

  reg        [203:0]  _zz_logic_ram_port0;
  wire       [1:0]    _zz_logic_pushPtr_valueNext;
  wire       [0:0]    _zz_logic_pushPtr_valueNext_1;
  wire       [1:0]    _zz_logic_popPtr_valueNext;
  wire       [0:0]    _zz_logic_popPtr_valueNext_1;
  wire                _zz_logic_ram_port;
  wire                _zz__zz_io_pop_payload_dataLen;
  wire       [203:0]  _zz_logic_ram_port_1;
  wire       [1:0]    _zz_io_availability;
  reg                 _zz_1;
  reg                 logic_pushPtr_willIncrement;
  reg                 logic_pushPtr_willClear;
  reg        [1:0]    logic_pushPtr_valueNext;
  reg        [1:0]    logic_pushPtr_value;
  wire                logic_pushPtr_willOverflowIfInc;
  wire                logic_pushPtr_willOverflow;
  reg                 logic_popPtr_willIncrement;
  reg                 logic_popPtr_willClear;
  reg        [1:0]    logic_popPtr_valueNext;
  reg        [1:0]    logic_popPtr_value;
  wire                logic_popPtr_willOverflowIfInc;
  wire                logic_popPtr_willOverflow;
  wire                logic_ptrMatch;
  reg                 logic_risingOccupancy;
  wire                logic_pushing;
  wire                logic_popping;
  wire                logic_empty;
  wire                logic_full;
  reg                 _zz_io_pop_valid;
  wire       [203:0]  _zz_io_pop_payload_dataLen;
  wire                when_Stream_l1078;
  wire       [1:0]    logic_ptrDif;
  reg [203:0] logic_ram [0:3];

  assign _zz_logic_pushPtr_valueNext_1 = logic_pushPtr_willIncrement;
  assign _zz_logic_pushPtr_valueNext = {1'd0, _zz_logic_pushPtr_valueNext_1};
  assign _zz_logic_popPtr_valueNext_1 = logic_popPtr_willIncrement;
  assign _zz_logic_popPtr_valueNext = {1'd0, _zz_logic_popPtr_valueNext_1};
  assign _zz_io_availability = (logic_popPtr_value - logic_pushPtr_value);
  assign _zz__zz_io_pop_payload_dataLen = 1'b1;
  assign _zz_logic_ram_port_1 = {io_push_payload_srcPort,{io_push_payload_dstPort,{io_push_payload_srcIpAddr,{io_push_payload_srcMacAddr,{io_push_payload_dstIpAddr,{io_push_payload_dstMacAddr,io_push_payload_dataLen}}}}}};
  always @(posedge clk) begin
    if(_zz__zz_io_pop_payload_dataLen) begin
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

  assign logic_pushPtr_willOverflowIfInc = (logic_pushPtr_value == 2'b11);
  assign logic_pushPtr_willOverflow = (logic_pushPtr_willOverflowIfInc && logic_pushPtr_willIncrement);
  always @(*) begin
    logic_pushPtr_valueNext = (logic_pushPtr_value + _zz_logic_pushPtr_valueNext);
    if(logic_pushPtr_willClear) begin
      logic_pushPtr_valueNext = 2'b00;
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

  assign logic_popPtr_willOverflowIfInc = (logic_popPtr_value == 2'b11);
  assign logic_popPtr_willOverflow = (logic_popPtr_willOverflowIfInc && logic_popPtr_willIncrement);
  always @(*) begin
    logic_popPtr_valueNext = (logic_popPtr_value + _zz_logic_popPtr_valueNext);
    if(logic_popPtr_willClear) begin
      logic_popPtr_valueNext = 2'b00;
    end
  end

  assign logic_ptrMatch = (logic_pushPtr_value == logic_popPtr_value);
  assign logic_pushing = (io_push_valid && io_push_ready);
  assign logic_popping = (io_pop_valid && io_pop_ready);
  assign logic_empty = (logic_ptrMatch && (! logic_risingOccupancy));
  assign logic_full = (logic_ptrMatch && logic_risingOccupancy);
  assign io_push_ready = (! logic_full);
  assign io_pop_valid = ((! logic_empty) && (! (_zz_io_pop_valid && (! logic_full))));
  assign _zz_io_pop_payload_dataLen = _zz_logic_ram_port0;
  assign io_pop_payload_dataLen = _zz_io_pop_payload_dataLen[11 : 0];
  assign io_pop_payload_dstMacAddr = _zz_io_pop_payload_dataLen[59 : 12];
  assign io_pop_payload_dstIpAddr = _zz_io_pop_payload_dataLen[91 : 60];
  assign io_pop_payload_srcMacAddr = _zz_io_pop_payload_dataLen[139 : 92];
  assign io_pop_payload_srcIpAddr = _zz_io_pop_payload_dataLen[171 : 140];
  assign io_pop_payload_dstPort = _zz_io_pop_payload_dataLen[187 : 172];
  assign io_pop_payload_srcPort = _zz_io_pop_payload_dataLen[203 : 188];
  assign when_Stream_l1078 = (logic_pushing != logic_popping);
  assign logic_ptrDif = (logic_pushPtr_value - logic_popPtr_value);
  assign io_occupancy = {(logic_risingOccupancy && logic_ptrMatch),logic_ptrDif};
  assign io_availability = {((! logic_risingOccupancy) && logic_ptrMatch),_zz_io_availability};
  always @(posedge clk or posedge reset) begin
    if(reset) begin
      logic_pushPtr_value <= 2'b00;
      logic_popPtr_value <= 2'b00;
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
