
################################################################
# This is a generated script based on design: mrmac_0_exdes_support
#
# Though there are limitations about the generated script,
# the main purpose of this utility is to make learning
# IP Integrator Tcl commands easier.
################################################################

namespace eval _tcl {
proc get_script_folder {} {
   set script_path [file normalize [info script]]
   set script_folder [file dirname $script_path]
   return $script_folder
}
}
variable script_folder
set script_folder [_tcl::get_script_folder]

# CHANGE DESIGN NAME HERE
variable design_name
set design_name mrmac_subsystem
create_bd_design $design_name -dir ./src/bd/

# Creating design if needed
set errMsg ""
set nRet 0

set cur_design [current_bd_design -quiet]
set list_cells [get_bd_cells -quiet]

if { ${design_name} eq "" } {
   # USE CASES:
   #    1) Design_name not set

   set errMsg "Please set the variable <design_name> to a non-empty value."
   set nRet 1

} elseif { ${cur_design} ne "" && ${list_cells} eq "" } {
   # USE CASES:
   #    2): Current design opened AND is empty AND names same.
   #    3): Current design opened AND is empty AND names diff; design_name NOT in project.
   #    4): Current design opened AND is empty AND names diff; design_name exists in project.

   if { $cur_design ne $design_name } {
      common::send_gid_msg -ssname BD::TCL -id 2001 -severity "INFO" "Changing value of <design_name> from <$design_name> to <$cur_design> since current design is empty."
      set design_name [get_property NAME $cur_design]
   }
   common::send_gid_msg -ssname BD::TCL -id 2002 -severity "INFO" "Constructing design in IPI design <$cur_design>..."

} elseif { ${cur_design} ne "" && $list_cells ne "" && $cur_design eq $design_name } {
   # USE CASES:
   #    5) Current design opened AND has components AND same names.

   set errMsg "Design <$design_name> already exists in your project, please set the variable <design_name> to another value."
   set nRet 1
} elseif { [get_files -quiet ${design_name}.bd] ne "" } {
   # USE CASES: 
   #    6) Current opened design, has components, but diff names, design_name exists in project.
   #    7) No opened design, design_name exists in project.

   set errMsg "Design <$design_name> already exists in your project, please set the variable <design_name> to another value."
   set nRet 2

} else {
   # USE CASES:
   #    8) No opened design, design_name not in project.
   #    9) Current opened design, has components, but diff names, design_name not in project.

   common::send_gid_msg -ssname BD::TCL -id 2003 -severity "INFO" "Currently there is no design <$design_name> in project, so creating one..."

   create_bd_design $design_name

   common::send_gid_msg -ssname BD::TCL -id 2004 -severity "INFO" "Making design <$design_name> as current_bd_design."
   current_bd_design $design_name

}

common::send_gid_msg -ssname BD::TCL -id 2005 -severity "INFO" "Currently the variable <design_name> is equal to \"$design_name\"."

if { $nRet != 0 } {
   catch {common::send_gid_msg -ssname BD::TCL -id 2006 -severity "ERROR" $errMsg}
   return $nRet
}

set bCheckIPsPassed 1
##################################################################
# CHECK IPs
##################################################################
set bCheckIPs 1
if { $bCheckIPs == 1 } {
   set list_check_ips "\ 
xilinx.com:ip:bufg_gt:*\
xilinx.com:ip:gt_quad_base:*\
xilinx.com:ip:mrmac:*\
xilinx.com:ip:util_ds_buf:*\
xilinx.com:ip:xlconstant:*\
"

   set list_ips_missing ""
   common::send_gid_msg -ssname BD::TCL -id 2011 -severity "INFO" "Checking if the following IPs exist in the project's IP catalog: $list_check_ips ."

   foreach ip_vlnv $list_check_ips {
      set ip_obj [get_ipdefs -all $ip_vlnv]
      if { $ip_obj eq "" } {
         lappend list_ips_missing $ip_vlnv
      }
   }

   if { $list_ips_missing ne "" } {
      catch {common::send_gid_msg -ssname BD::TCL -id 2012 -severity "ERROR" "The following IPs are not found in the IP Catalog:\n  $list_ips_missing\n\nResolution: Please add the repository containing the IP(s) to the project." }
      set bCheckIPsPassed 0
   }

}

if { $bCheckIPsPassed != 1 } {
  common::send_gid_msg -ssname BD::TCL -id 2023 -severity "WARNING" "Will not continue with creation of design due to the error(s) above."
  return 3
}

##################################################################
# DESIGN PROCs
##################################################################



# Procedure to create entire design; Provide argument to make
# procedure reusable. If parentCell is "", will use root.
proc create_root_design { parentCell } {

  variable script_folder
  variable design_name

  if { $parentCell eq "" } {
     set parentCell [get_bd_cells /]
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj


  # Create interface ports
  set APB3_INTF [ create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:apb_rtl:1.0 APB3_INTF ]

  set CLK_IN_D [ create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:diff_clock_rtl:1.0 CLK_IN_D ]
  set_property -dict [ list \
   CONFIG.FREQ_HZ {161132812} \
   ] $CLK_IN_D

  set GT_Serial [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:gt_rtl:1.0 GT_Serial ]

  set ctl_tx_port0 [ create_bd_intf_port -mode Slave -vlnv xilinx.com:display_mrmac:mrmac_ctrl_ports:2.0 ctl_tx_port0 ]

  set ctl_tx_port1 [ create_bd_intf_port -mode Slave -vlnv xilinx.com:display_mrmac:mrmac_ctrl_ports:2.0 ctl_tx_port1 ]

  set ctl_tx_port2 [ create_bd_intf_port -mode Slave -vlnv xilinx.com:display_mrmac:mrmac_ctrl_ports:2.0 ctl_tx_port2 ]

  set ctl_tx_port3 [ create_bd_intf_port -mode Slave -vlnv xilinx.com:display_mrmac:mrmac_ctrl_ports:2.0 ctl_tx_port3 ]

  set rx_preambleout [ create_bd_intf_port -mode Master -vlnv xilinx.com:display_mrmac:mrmac_statistics_ports:2.0 rx_preambleout ]

  set s_axi [ create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 s_axi ]
  set_property -dict [ list \
   CONFIG.ADDR_WIDTH {32} \
   CONFIG.ARUSER_WIDTH {0} \
   CONFIG.AWUSER_WIDTH {0} \
   CONFIG.BUSER_WIDTH {0} \
   CONFIG.DATA_WIDTH {32} \
   CONFIG.HAS_BRESP {1} \
   CONFIG.HAS_BURST {0} \
   CONFIG.HAS_CACHE {0} \
   CONFIG.HAS_LOCK {0} \
   CONFIG.HAS_PROT {0} \
   CONFIG.HAS_QOS {0} \
   CONFIG.HAS_REGION {0} \
   CONFIG.HAS_RRESP {1} \
   CONFIG.HAS_WSTRB {0} \
   CONFIG.ID_WIDTH {0} \
   CONFIG.MAX_BURST_LENGTH {1} \
   CONFIG.NUM_READ_OUTSTANDING {1} \
   CONFIG.NUM_READ_THREADS {1} \
   CONFIG.NUM_WRITE_OUTSTANDING {1} \
   CONFIG.NUM_WRITE_THREADS {1} \
   CONFIG.PROTOCOL {AXI4LITE} \
   CONFIG.READ_WRITE_MODE {READ_WRITE} \
   CONFIG.RUSER_BITS_PER_BYTE {0} \
   CONFIG.RUSER_WIDTH {0} \
   CONFIG.SUPPORTS_NARROW_BURST {0} \
   CONFIG.WUSER_BITS_PER_BYTE {0} \
   CONFIG.WUSER_WIDTH {0} \
   ] $s_axi

  set stat_rx_port0 [ create_bd_intf_port -mode Master -vlnv xilinx.com:display_mrmac:mrmac_statistics_ports:2.0 stat_rx_port0 ]

  set stat_rx_port1 [ create_bd_intf_port -mode Master -vlnv xilinx.com:display_mrmac:mrmac_statistics_ports:2.0 stat_rx_port1 ]

  set stat_rx_port2 [ create_bd_intf_port -mode Master -vlnv xilinx.com:display_mrmac:mrmac_statistics_ports:2.0 stat_rx_port2 ]

  set stat_rx_port3 [ create_bd_intf_port -mode Master -vlnv xilinx.com:display_mrmac:mrmac_statistics_ports:2.0 stat_rx_port3 ]

  set stat_tx_port0 [ create_bd_intf_port -mode Master -vlnv xilinx.com:display_mrmac:mrmac_statistics_ports:2.0 stat_tx_port0 ]

  set stat_tx_port1 [ create_bd_intf_port -mode Master -vlnv xilinx.com:display_mrmac:mrmac_statistics_ports:2.0 stat_tx_port1 ]

  set stat_tx_port2 [ create_bd_intf_port -mode Master -vlnv xilinx.com:display_mrmac:mrmac_statistics_ports:2.0 stat_tx_port2 ]

  set stat_tx_port3 [ create_bd_intf_port -mode Master -vlnv xilinx.com:display_mrmac:mrmac_statistics_ports:2.0 stat_tx_port3 ]

  set tx_preamblein [ create_bd_intf_port -mode Slave -vlnv xilinx.com:display_mrmac:mrmac_statistics_ports:2.0 tx_preamblein ]


  # Create ports
  set apb3clk_quad [ create_bd_port -dir I apb3clk_quad ]
  set ch0_loopback [ create_bd_port -dir I -from 2 -to 0 ch0_loopback ]
  set ch0_rx_usr_clk [ create_bd_port -dir O -type gt_usrclk ch0_rx_usr_clk ]
  set ch0_rx_usr_clk2 [ create_bd_port -dir O -type gt_usrclk ch0_rx_usr_clk2 ]
  set ch0_rxrate [ create_bd_port -dir I -from 7 -to 0 ch0_rxrate ]
  set ch0_rxusrclk [ create_bd_port -dir I -type gt_usrclk ch0_rxusrclk ]
  set_property -dict [ list \
   CONFIG.FREQ_HZ {322266000} \
 ] $ch0_rxusrclk
  set ch0_tx_usr_clk [ create_bd_port -dir O -type gt_usrclk ch0_tx_usr_clk ]
  set ch0_tx_usr_clk2 [ create_bd_port -dir O -type gt_usrclk ch0_tx_usr_clk2 ]
  set ch0_txrate [ create_bd_port -dir I -from 7 -to 0 ch0_txrate ]
  set ch0_txusrclk [ create_bd_port -dir I -type gt_usrclk ch0_txusrclk ]
  set_property -dict [ list \
   CONFIG.FREQ_HZ {322266000} \
 ] $ch0_txusrclk
  set ch1_loopback [ create_bd_port -dir I -from 2 -to 0 ch1_loopback ]
  set ch1_rx_usr_clk [ create_bd_port -dir O -type gt_usrclk ch1_rx_usr_clk ]
  set ch1_rx_usr_clk2 [ create_bd_port -dir O -type gt_usrclk ch1_rx_usr_clk2 ]
  set ch1_rxrate [ create_bd_port -dir I -from 7 -to 0 ch1_rxrate ]
  set ch1_rxusrclk [ create_bd_port -dir I -type gt_usrclk ch1_rxusrclk ]
  set_property -dict [ list \
   CONFIG.FREQ_HZ {322266000} \
 ] $ch1_rxusrclk
  set ch1_txrate [ create_bd_port -dir I -from 7 -to 0 ch1_txrate ]
  set ch1_txusrclk [ create_bd_port -dir I -type gt_usrclk ch1_txusrclk ]
  set_property -dict [ list \
   CONFIG.FREQ_HZ {322266000} \
 ] $ch1_txusrclk
  set ch2_loopback [ create_bd_port -dir I -from 2 -to 0 ch2_loopback ]
  set ch2_rx_usr_clk [ create_bd_port -dir O -type gt_usrclk ch2_rx_usr_clk ]
  set ch2_rx_usr_clk2 [ create_bd_port -dir O -type gt_usrclk ch2_rx_usr_clk2 ]
  set ch2_rxrate [ create_bd_port -dir I -from 7 -to 0 ch2_rxrate ]
  set ch2_rxusrclk [ create_bd_port -dir I -type gt_usrclk ch2_rxusrclk ]
  set_property -dict [ list \
   CONFIG.FREQ_HZ {322266000} \
 ] $ch2_rxusrclk
  set ch2_txrate [ create_bd_port -dir I -from 7 -to 0 ch2_txrate ]
  set ch2_txusrclk [ create_bd_port -dir I -type gt_usrclk ch2_txusrclk ]
  set_property -dict [ list \
   CONFIG.FREQ_HZ {322266000} \
 ] $ch2_txusrclk
  set ch3_loopback [ create_bd_port -dir I -from 2 -to 0 ch3_loopback ]
  set ch3_rx_usr_clk [ create_bd_port -dir O -type gt_usrclk ch3_rx_usr_clk ]
  set ch3_rx_usr_clk2 [ create_bd_port -dir O -type gt_usrclk ch3_rx_usr_clk2 ]
  set ch3_rxrate [ create_bd_port -dir I -from 7 -to 0 ch3_rxrate ]
  set ch3_rxusrclk [ create_bd_port -dir I -type gt_usrclk ch3_rxusrclk ]
  set_property -dict [ list \
   CONFIG.FREQ_HZ {322266000} \
 ] $ch3_rxusrclk
  set ch3_txrate [ create_bd_port -dir I -from 7 -to 0 ch3_txrate ]
  set ch3_txusrclk [ create_bd_port -dir I -type gt_usrclk ch3_txusrclk ]
  set_property -dict [ list \
   CONFIG.FREQ_HZ {322266000} \
 ] $ch3_txusrclk
  set gt_reset_all_in [ create_bd_port -dir I -from 3 -to 0 gt_reset_all_in ]
  set gt_reset_rx_datapath_in [ create_bd_port -dir I -from 3 -to 0 gt_reset_rx_datapath_in ]
  set gt_reset_tx_datapath_in [ create_bd_port -dir I -from 3 -to 0 gt_reset_tx_datapath_in ]
  set gt_rx_reset_done_out [ create_bd_port -dir O -from 3 -to 0 gt_rx_reset_done_out ]
  set gt_rxn_in_0 [ create_bd_port -dir I -from 3 -to 0 gt_rxn_in_0 ]
  set gt_rxp_in_0 [ create_bd_port -dir I -from 3 -to 0 gt_rxp_in_0 ]
  set gt_tx_reset_done_out [ create_bd_port -dir O -from 3 -to 0 gt_tx_reset_done_out ]
  set gt_txn_out_0 [ create_bd_port -dir O -from 3 -to 0 gt_txn_out_0 ]
  set gt_txp_out_0 [ create_bd_port -dir O -from 3 -to 0 gt_txp_out_0 ]
  set gtpowergood [ create_bd_port -dir O gtpowergood ]
  set gtpowergood_in [ create_bd_port -dir I gtpowergood_in ]
  set pm_rdy [ create_bd_port -dir O -from 3 -to 0 pm_rdy ]
  set pm_tick [ create_bd_port -dir I -from 3 -to 0 pm_tick ]
  set rx_alt_serdes_clk [ create_bd_port -dir I -from 3 -to 0 -type gt_usrclk rx_alt_serdes_clk ]
  set_property -dict [ list \
   CONFIG.FREQ_HZ {322266000} \
 ] $rx_alt_serdes_clk
  set rx_axi_clk [ create_bd_port -dir I -from 3 -to 0 -type clk -freq_hz 390625000 rx_axi_clk ]
  set rx_axis_tdata0 [ create_bd_port -dir O -from 63 -to 0 rx_axis_tdata0 ]
  set rx_axis_tdata1 [ create_bd_port -dir O -from 63 -to 0 rx_axis_tdata1 ]
  set rx_axis_tdata2 [ create_bd_port -dir O -from 63 -to 0 rx_axis_tdata2 ]
  set rx_axis_tdata3 [ create_bd_port -dir O -from 63 -to 0 rx_axis_tdata3 ]
  set rx_axis_tdata4 [ create_bd_port -dir O -from 63 -to 0 rx_axis_tdata4 ]
  set rx_axis_tdata5 [ create_bd_port -dir O -from 63 -to 0 rx_axis_tdata5 ]
  set rx_axis_tdata6 [ create_bd_port -dir O -from 63 -to 0 rx_axis_tdata6 ]
  set rx_axis_tdata7 [ create_bd_port -dir O -from 63 -to 0 rx_axis_tdata7 ]
  set rx_axis_tkeep_user0 [ create_bd_port -dir O -from 10 -to 0 rx_axis_tkeep_user0 ]
  set rx_axis_tkeep_user1 [ create_bd_port -dir O -from 10 -to 0 rx_axis_tkeep_user1 ]
  set rx_axis_tkeep_user2 [ create_bd_port -dir O -from 10 -to 0 rx_axis_tkeep_user2 ]
  set rx_axis_tkeep_user3 [ create_bd_port -dir O -from 10 -to 0 rx_axis_tkeep_user3 ]
  set rx_axis_tkeep_user4 [ create_bd_port -dir O -from 10 -to 0 rx_axis_tkeep_user4 ]
  set rx_axis_tkeep_user5 [ create_bd_port -dir O -from 10 -to 0 rx_axis_tkeep_user5 ]
  set rx_axis_tkeep_user6 [ create_bd_port -dir O -from 10 -to 0 rx_axis_tkeep_user6 ]
  set rx_axis_tkeep_user7 [ create_bd_port -dir O -from 10 -to 0 rx_axis_tkeep_user7 ]
  set rx_axis_tlast_0 [ create_bd_port -dir O rx_axis_tlast_0 ]
  set rx_axis_tlast_1 [ create_bd_port -dir O rx_axis_tlast_1 ]
  set rx_axis_tlast_2 [ create_bd_port -dir O rx_axis_tlast_2 ]
  set rx_axis_tlast_3 [ create_bd_port -dir O rx_axis_tlast_3 ]
  set rx_axis_tvalid_0 [ create_bd_port -dir O rx_axis_tvalid_0 ]
  set rx_axis_tvalid_1 [ create_bd_port -dir O rx_axis_tvalid_1 ]
  set rx_axis_tvalid_2 [ create_bd_port -dir O rx_axis_tvalid_2 ]
  set rx_axis_tvalid_3 [ create_bd_port -dir O rx_axis_tvalid_3 ]
  set rx_core_clk [ create_bd_port -dir I -from 3 -to 0 -type gt_usrclk rx_core_clk ]
  set_property -dict [ list \
   CONFIG.FREQ_HZ {644531000} \
 ] $rx_core_clk
  set rx_core_reset [ create_bd_port -dir I -from 3 -to 0 -type rst rx_core_reset ]
  set_property -dict [ list \
   CONFIG.POLARITY {ACTIVE_HIGH} \
 ] $rx_core_reset
  set rx_flexif_clk [ create_bd_port -dir I -from 3 -to 0 -type clk rx_flexif_clk ]
  set rx_flexif_reset [ create_bd_port -dir I -from 3 -to 0 -type rst rx_flexif_reset ]
  set_property -dict [ list \
   CONFIG.POLARITY {ACTIVE_HIGH} \
 ] $rx_flexif_reset
  set rx_serdes_clk [ create_bd_port -dir I -from 3 -to 0 -type gt_usrclk rx_serdes_clk ]
  set_property -dict [ list \
   CONFIG.FREQ_HZ {644531000} \
 ] $rx_serdes_clk
  set rx_serdes_reset [ create_bd_port -dir I -from 3 -to 0 -type rst rx_serdes_reset ]
  set_property -dict [ list \
   CONFIG.POLARITY {ACTIVE_HIGH} \
 ] $rx_serdes_reset
  set rx_ts_clk [ create_bd_port -dir I -from 3 -to 0 -type clk rx_ts_clk ]
  set s_axi_aclk [ create_bd_port -dir I -type clk s_axi_aclk ]
  set_property -dict [ list \
   CONFIG.ASSOCIATED_BUSIF {APB3_INTF:s_axi} \
 ] $s_axi_aclk
  set s_axi_aresetn [ create_bd_port -dir I -type rst s_axi_aresetn ]
  set tx_alt_serdes_clk [ create_bd_port -dir I -from 3 -to 0 -type gt_usrclk tx_alt_serdes_clk ]
  set_property -dict [ list \
   CONFIG.FREQ_HZ {322266000} \
 ] $tx_alt_serdes_clk
  set tx_axi_clk [ create_bd_port -dir I -from 3 -to 0 -type clk -freq_hz 390625000 tx_axi_clk ]
  set tx_axis_tdata0 [ create_bd_port -dir I -from 63 -to 0 tx_axis_tdata0 ]
  set tx_axis_tdata1 [ create_bd_port -dir I -from 63 -to 0 tx_axis_tdata1 ]
  set tx_axis_tdata2 [ create_bd_port -dir I -from 63 -to 0 tx_axis_tdata2 ]
  set tx_axis_tdata3 [ create_bd_port -dir I -from 63 -to 0 tx_axis_tdata3 ]
  set tx_axis_tdata4 [ create_bd_port -dir I -from 63 -to 0 tx_axis_tdata4 ]
  set tx_axis_tdata5 [ create_bd_port -dir I -from 63 -to 0 tx_axis_tdata5 ]
  set tx_axis_tdata6 [ create_bd_port -dir I -from 63 -to 0 tx_axis_tdata6 ]
  set tx_axis_tdata7 [ create_bd_port -dir I -from 63 -to 0 tx_axis_tdata7 ]
  set tx_axis_tkeep_user0 [ create_bd_port -dir I -from 10 -to 0 tx_axis_tkeep_user0 ]
  set tx_axis_tkeep_user1 [ create_bd_port -dir I -from 10 -to 0 tx_axis_tkeep_user1 ]
  set tx_axis_tkeep_user2 [ create_bd_port -dir I -from 10 -to 0 tx_axis_tkeep_user2 ]
  set tx_axis_tkeep_user3 [ create_bd_port -dir I -from 10 -to 0 tx_axis_tkeep_user3 ]
  set tx_axis_tkeep_user4 [ create_bd_port -dir I -from 10 -to 0 tx_axis_tkeep_user4 ]
  set tx_axis_tkeep_user5 [ create_bd_port -dir I -from 10 -to 0 tx_axis_tkeep_user5 ]
  set tx_axis_tkeep_user6 [ create_bd_port -dir I -from 10 -to 0 tx_axis_tkeep_user6 ]
  set tx_axis_tkeep_user7 [ create_bd_port -dir I -from 10 -to 0 tx_axis_tkeep_user7 ]
  set tx_axis_tlast_0 [ create_bd_port -dir I tx_axis_tlast_0 ]
  set tx_axis_tlast_1 [ create_bd_port -dir I tx_axis_tlast_1 ]
  set tx_axis_tlast_2 [ create_bd_port -dir I tx_axis_tlast_2 ]
  set tx_axis_tlast_3 [ create_bd_port -dir I tx_axis_tlast_3 ]
  set tx_axis_tready_0 [ create_bd_port -dir O tx_axis_tready_0 ]
  set tx_axis_tready_1 [ create_bd_port -dir O tx_axis_tready_1 ]
  set tx_axis_tready_2 [ create_bd_port -dir O tx_axis_tready_2 ]
  set tx_axis_tready_3 [ create_bd_port -dir O tx_axis_tready_3 ]
  set tx_axis_tvalid_0 [ create_bd_port -dir I tx_axis_tvalid_0 ]
  set tx_axis_tvalid_1 [ create_bd_port -dir I tx_axis_tvalid_1 ]
  set tx_axis_tvalid_2 [ create_bd_port -dir I tx_axis_tvalid_2 ]
  set tx_axis_tvalid_3 [ create_bd_port -dir I tx_axis_tvalid_3 ]
  set tx_core_clk [ create_bd_port -dir I -from 3 -to 0 -type gt_usrclk tx_core_clk ]
  set_property -dict [ list \
   CONFIG.FREQ_HZ {644531000} \
 ] $tx_core_clk
  set tx_core_reset [ create_bd_port -dir I -from 3 -to 0 -type rst tx_core_reset ]
  set_property -dict [ list \
   CONFIG.POLARITY {ACTIVE_HIGH} \
 ] $tx_core_reset
  set tx_flexif_clk [ create_bd_port -dir I -from 3 -to 0 -type clk tx_flexif_clk ]
  set tx_serdes_reset [ create_bd_port -dir I -from 3 -to 0 -type rst tx_serdes_reset ]
  set_property -dict [ list \
   CONFIG.POLARITY {ACTIVE_HIGH} \
 ] $tx_serdes_reset
  set tx_ts_clk [ create_bd_port -dir I -from 3 -to 0 -type clk tx_ts_clk ]

  # Create instance: bufg_gt_0, and set properties
  set bufg_gt_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:bufg_gt bufg_gt_0 ]

  # Create instance: bufg_gt_1, and set properties
  set bufg_gt_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:bufg_gt bufg_gt_1 ]

  # Create instance: bufg_gt_1_1, and set properties
  set bufg_gt_1_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:bufg_gt bufg_gt_1_1 ]

  # Create instance: bufg_gt_1_2, and set properties
  set bufg_gt_1_2 [ create_bd_cell -type ip -vlnv xilinx.com:ip:bufg_gt bufg_gt_1_2 ]

  # Create instance: bufg_gt_1_3, and set properties
  set bufg_gt_1_3 [ create_bd_cell -type ip -vlnv xilinx.com:ip:bufg_gt bufg_gt_1_3 ]

  # Create instance: bufg_gt_2, and set properties
  set bufg_gt_2 [ create_bd_cell -type ip -vlnv xilinx.com:ip:bufg_gt bufg_gt_2 ]

  # Create instance: bufg_gt_3, and set properties
  set bufg_gt_3 [ create_bd_cell -type ip -vlnv xilinx.com:ip:bufg_gt bufg_gt_3 ]

  # Create instance: bufg_gt_3_1, and set properties
  set bufg_gt_3_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:bufg_gt bufg_gt_3_1 ]

  # Create instance: bufg_gt_3_2, and set properties
  set bufg_gt_3_2 [ create_bd_cell -type ip -vlnv xilinx.com:ip:bufg_gt bufg_gt_3_2 ]

  # Create instance: bufg_gt_3_3, and set properties
  set bufg_gt_3_3 [ create_bd_cell -type ip -vlnv xilinx.com:ip:bufg_gt bufg_gt_3_3 ]

  # Create instance: gt_quad_base, and set properties
  set gt_quad_base [ create_bd_cell -type ip -vlnv xilinx.com:ip:gt_quad_base gt_quad_base ]
  set_property -dict [ list \
   CONFIG.PORTS_INFO_DICT {\
     LANE_SEL_DICT {PROT0 {RX0 RX1 RX2 RX3 TX0 TX1 TX2 TX3}}\
     GT_TYPE {GTY}\
     REG_CONF_INTF {APB3_INTF}\
     BOARD_PARAMETER {}\
   } \
   CONFIG.QUAD_USAGE {\
     TX_QUAD_CH {TXQuad_0_/gt_quad_base {/gt_quad_base\
mrmac_0_exdes_support_mrmac_0_2_0.IP_CH0,mrmac_0_exdes_support_mrmac_0_2_0.IP_CH1,mrmac_0_exdes_support_mrmac_0_2_0.IP_CH2,mrmac_0_exdes_support_mrmac_0_2_0.IP_CH3\
MSTRCLK 1,0,0,0 IS_CURRENT_QUAD 1}}\
     RX_QUAD_CH {RXQuad_0_/gt_quad_base {/gt_quad_base\
mrmac_0_exdes_support_mrmac_0_2_0.IP_CH0,mrmac_0_exdes_support_mrmac_0_2_0.IP_CH1,mrmac_0_exdes_support_mrmac_0_2_0.IP_CH2,mrmac_0_exdes_support_mrmac_0_2_0.IP_CH3\
MSTRCLK 1,0,0,0 IS_CURRENT_QUAD 1}}\
   } \
   CONFIG.REFCLK_STRING {\
HSCLK0_LCPLLGTREFCLK0 refclk_PROT0_R0_161.1328125_MHz_unique1\
HSCLK1_LCPLLGTREFCLK0 refclk_PROT0_R0_161.1328125_MHz_unique1} \
 ] $gt_quad_base

  # Create instance: mrmac_0, and set properties
  set mrmac_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:mrmac mrmac_0 ]
  set_property -dict [ list \
   CONFIG.GT_CH0_RX_REFCLK_FREQUENCY_C0 {161.1328125} \
   CONFIG.GT_CH0_TX_REFCLK_FREQUENCY_C0 {161.1328125} \
   CONFIG.GT_CH1_RX_REFCLK_FREQUENCY_C0 {161.1328125} \
   CONFIG.GT_CH1_TX_REFCLK_FREQUENCY_C0 {161.1328125} \
   CONFIG.GT_CH2_RX_REFCLK_FREQUENCY_C0 {161.1328125} \
   CONFIG.GT_CH2_TX_REFCLK_FREQUENCY_C0 {161.1328125} \
   CONFIG.GT_CH3_RX_REFCLK_FREQUENCY_C0 {161.1328125} \
   CONFIG.GT_CH3_TX_REFCLK_FREQUENCY_C0 {161.1328125} \
   CONFIG.GT_REF_CLK_FREQ_C0 {161.1328125} \
   CONFIG.MRMAC_DATA_PATH_INTERFACE_C0 {256b Non-Segmented} \
 ] $mrmac_0

  # Create instance: util_ds_buf_0, and set properties
  set util_ds_buf_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:util_ds_buf util_ds_buf_0 ]
  set_property -dict [ list \
   CONFIG.C_BUF_TYPE {IBUFDSGTE} \
 ] $util_ds_buf_0

  # Create instance: xlconstant_0, and set properties
  set xlconstant_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant xlconstant_0 ]
  set_property -dict [ list \
   CONFIG.CONST_VAL {1} \
   CONFIG.CONST_WIDTH {3} \
 ] $xlconstant_0

  # Create interface connections
  connect_bd_intf_net -intf_net APB3_INTF_1 [get_bd_intf_ports APB3_INTF] [get_bd_intf_pins gt_quad_base/APB3_INTF]
  connect_bd_intf_net -intf_net CLK_IN_D_1 [get_bd_intf_ports CLK_IN_D] [get_bd_intf_pins util_ds_buf_0/CLK_IN_D]
  connect_bd_intf_net -intf_net ctl_tx_port0_1 [get_bd_intf_ports ctl_tx_port0] [get_bd_intf_pins mrmac_0/ctl_tx_port0]
  connect_bd_intf_net -intf_net ctl_tx_port1_1 [get_bd_intf_ports ctl_tx_port1] [get_bd_intf_pins mrmac_0/ctl_tx_port1]
  connect_bd_intf_net -intf_net ctl_tx_port2_1 [get_bd_intf_ports ctl_tx_port2] [get_bd_intf_pins mrmac_0/ctl_tx_port2]
  connect_bd_intf_net -intf_net ctl_tx_port3_1 [get_bd_intf_ports ctl_tx_port3] [get_bd_intf_pins mrmac_0/ctl_tx_port3]
  connect_bd_intf_net -intf_net gt_quad_base_GT_Serial [get_bd_intf_ports GT_Serial] [get_bd_intf_pins gt_quad_base/GT_Serial]
  connect_bd_intf_net -intf_net mrmac_0_gt_rx_serdes_interface_0 [get_bd_intf_pins gt_quad_base/RX0_GT_IP_Interface] [get_bd_intf_pins mrmac_0/gt_rx_serdes_interface_0]
  connect_bd_intf_net -intf_net mrmac_0_gt_rx_serdes_interface_1 [get_bd_intf_pins gt_quad_base/RX1_GT_IP_Interface] [get_bd_intf_pins mrmac_0/gt_rx_serdes_interface_1]
  connect_bd_intf_net -intf_net mrmac_0_gt_rx_serdes_interface_2 [get_bd_intf_pins gt_quad_base/RX2_GT_IP_Interface] [get_bd_intf_pins mrmac_0/gt_rx_serdes_interface_2]
  connect_bd_intf_net -intf_net mrmac_0_gt_rx_serdes_interface_3 [get_bd_intf_pins gt_quad_base/RX3_GT_IP_Interface] [get_bd_intf_pins mrmac_0/gt_rx_serdes_interface_3]
  connect_bd_intf_net -intf_net mrmac_0_gt_tx_serdes_interface_0 [get_bd_intf_pins gt_quad_base/TX0_GT_IP_Interface] [get_bd_intf_pins mrmac_0/gt_tx_serdes_interface_0]
  connect_bd_intf_net -intf_net mrmac_0_gt_tx_serdes_interface_1 [get_bd_intf_pins gt_quad_base/TX1_GT_IP_Interface] [get_bd_intf_pins mrmac_0/gt_tx_serdes_interface_1]
  connect_bd_intf_net -intf_net mrmac_0_gt_tx_serdes_interface_2 [get_bd_intf_pins gt_quad_base/TX2_GT_IP_Interface] [get_bd_intf_pins mrmac_0/gt_tx_serdes_interface_2]
  connect_bd_intf_net -intf_net mrmac_0_gt_tx_serdes_interface_3 [get_bd_intf_pins gt_quad_base/TX3_GT_IP_Interface] [get_bd_intf_pins mrmac_0/gt_tx_serdes_interface_3]
  connect_bd_intf_net -intf_net mrmac_0_rx_preambleout [get_bd_intf_ports rx_preambleout] [get_bd_intf_pins mrmac_0/rx_preambleout]
  connect_bd_intf_net -intf_net mrmac_0_stat_rx_port0 [get_bd_intf_ports stat_rx_port0] [get_bd_intf_pins mrmac_0/stat_rx_port0]
  connect_bd_intf_net -intf_net mrmac_0_stat_rx_port1 [get_bd_intf_ports stat_rx_port1] [get_bd_intf_pins mrmac_0/stat_rx_port1]
  connect_bd_intf_net -intf_net mrmac_0_stat_rx_port2 [get_bd_intf_ports stat_rx_port2] [get_bd_intf_pins mrmac_0/stat_rx_port2]
  connect_bd_intf_net -intf_net mrmac_0_stat_rx_port3 [get_bd_intf_ports stat_rx_port3] [get_bd_intf_pins mrmac_0/stat_rx_port3]
  connect_bd_intf_net -intf_net mrmac_0_stat_tx_port0 [get_bd_intf_ports stat_tx_port0] [get_bd_intf_pins mrmac_0/stat_tx_port0]
  connect_bd_intf_net -intf_net mrmac_0_stat_tx_port1 [get_bd_intf_ports stat_tx_port1] [get_bd_intf_pins mrmac_0/stat_tx_port1]
  connect_bd_intf_net -intf_net mrmac_0_stat_tx_port2 [get_bd_intf_ports stat_tx_port2] [get_bd_intf_pins mrmac_0/stat_tx_port2]
  connect_bd_intf_net -intf_net mrmac_0_stat_tx_port3 [get_bd_intf_ports stat_tx_port3] [get_bd_intf_pins mrmac_0/stat_tx_port3]
  connect_bd_intf_net -intf_net s_axi_1 [get_bd_intf_ports s_axi] [get_bd_intf_pins mrmac_0/s_axi]
  connect_bd_intf_net -intf_net tx_preamblein_1 [get_bd_intf_ports tx_preamblein] [get_bd_intf_pins mrmac_0/tx_preamblein]

  # Create port connections
  connect_bd_net -net apb3clk_quad_1 [get_bd_ports apb3clk_quad] [get_bd_pins gt_quad_base/apb3clk]
  connect_bd_net -net bufg_gt_0_usrclk [get_bd_ports ch0_tx_usr_clk] [get_bd_pins bufg_gt_0/usrclk]
  connect_bd_net -net bufg_gt_1_1_usrclk [get_bd_ports ch1_rx_usr_clk] [get_bd_pins bufg_gt_1_1/usrclk]
  connect_bd_net -net bufg_gt_1_2_usrclk [get_bd_ports ch2_rx_usr_clk] [get_bd_pins bufg_gt_1_2/usrclk]
  connect_bd_net -net bufg_gt_1_3_usrclk [get_bd_ports ch3_rx_usr_clk] [get_bd_pins bufg_gt_1_3/usrclk]
  connect_bd_net -net bufg_gt_1_usrclk [get_bd_ports ch0_rx_usr_clk] [get_bd_pins bufg_gt_1/usrclk]
  connect_bd_net -net bufg_gt_2_usrclk [get_bd_ports ch0_tx_usr_clk2] [get_bd_pins bufg_gt_2/usrclk]
  connect_bd_net -net bufg_gt_3_1_usrclk [get_bd_ports ch1_rx_usr_clk2] [get_bd_pins bufg_gt_3_1/usrclk]
  connect_bd_net -net bufg_gt_3_2_usrclk [get_bd_ports ch2_rx_usr_clk2] [get_bd_pins bufg_gt_3_2/usrclk]
  connect_bd_net -net bufg_gt_3_3_usrclk [get_bd_ports ch3_rx_usr_clk2] [get_bd_pins bufg_gt_3_3/usrclk]
  connect_bd_net -net bufg_gt_3_usrclk [get_bd_ports ch0_rx_usr_clk2] [get_bd_pins bufg_gt_3/usrclk]
  connect_bd_net -net ch0_loopback_1 [get_bd_ports ch0_loopback] [get_bd_pins gt_quad_base/ch0_loopback]
  connect_bd_net -net ch0_rxrate_1 [get_bd_ports ch0_rxrate] [get_bd_pins gt_quad_base/ch0_rxrate]
  connect_bd_net -net ch0_rxusrclk_1 [get_bd_ports ch0_rxusrclk] [get_bd_pins gt_quad_base/ch0_rxusrclk]
  connect_bd_net -net ch0_txrate_1 [get_bd_ports ch0_txrate] [get_bd_pins gt_quad_base/ch0_txrate]
  connect_bd_net -net ch0_txusrclk_1 [get_bd_ports ch0_txusrclk] [get_bd_pins gt_quad_base/ch0_txusrclk]
  connect_bd_net -net ch1_loopback_1 [get_bd_ports ch1_loopback] [get_bd_pins gt_quad_base/ch1_loopback]
  connect_bd_net -net ch1_rxrate_1 [get_bd_ports ch1_rxrate] [get_bd_pins gt_quad_base/ch1_rxrate]
  connect_bd_net -net ch1_rxusrclk_1 [get_bd_ports ch1_rxusrclk] [get_bd_pins gt_quad_base/ch1_rxusrclk]
  connect_bd_net -net ch1_txrate_1 [get_bd_ports ch1_txrate] [get_bd_pins gt_quad_base/ch1_txrate]
  connect_bd_net -net ch1_txusrclk_1 [get_bd_ports ch1_txusrclk] [get_bd_pins gt_quad_base/ch1_txusrclk]
  connect_bd_net -net ch2_loopback_1 [get_bd_ports ch2_loopback] [get_bd_pins gt_quad_base/ch2_loopback]
  connect_bd_net -net ch2_rxrate_1 [get_bd_ports ch2_rxrate] [get_bd_pins gt_quad_base/ch2_rxrate]
  connect_bd_net -net ch2_rxusrclk_1 [get_bd_ports ch2_rxusrclk] [get_bd_pins gt_quad_base/ch2_rxusrclk]
  connect_bd_net -net ch2_txrate_1 [get_bd_ports ch2_txrate] [get_bd_pins gt_quad_base/ch2_txrate]
  connect_bd_net -net ch2_txusrclk_1 [get_bd_ports ch2_txusrclk] [get_bd_pins gt_quad_base/ch2_txusrclk]
  connect_bd_net -net ch3_loopback_1 [get_bd_ports ch3_loopback] [get_bd_pins gt_quad_base/ch3_loopback]
  connect_bd_net -net ch3_rxrate_1 [get_bd_ports ch3_rxrate] [get_bd_pins gt_quad_base/ch3_rxrate]
  connect_bd_net -net ch3_rxusrclk_1 [get_bd_ports ch3_rxusrclk] [get_bd_pins gt_quad_base/ch3_rxusrclk]
  connect_bd_net -net ch3_txrate_1 [get_bd_ports ch3_txrate] [get_bd_pins gt_quad_base/ch3_txrate]
  connect_bd_net -net ch3_txusrclk_1 [get_bd_ports ch3_txusrclk] [get_bd_pins gt_quad_base/ch3_txusrclk]
  connect_bd_net -net gt_quad_base_ch0_rxoutclk [get_bd_pins bufg_gt_1/outclk] [get_bd_pins bufg_gt_3/outclk] [get_bd_pins gt_quad_base/ch0_rxoutclk]
  connect_bd_net -net gt_quad_base_ch0_txoutclk [get_bd_pins bufg_gt_0/outclk] [get_bd_pins bufg_gt_2/outclk] [get_bd_pins gt_quad_base/ch0_txoutclk]
  connect_bd_net -net gt_quad_base_ch1_rxoutclk [get_bd_pins bufg_gt_1_1/outclk] [get_bd_pins bufg_gt_3_1/outclk] [get_bd_pins gt_quad_base/ch1_rxoutclk]
  connect_bd_net -net gt_quad_base_ch2_rxoutclk [get_bd_pins bufg_gt_1_2/outclk] [get_bd_pins bufg_gt_3_2/outclk] [get_bd_pins gt_quad_base/ch2_rxoutclk]
  connect_bd_net -net gt_quad_base_ch3_rxoutclk [get_bd_pins bufg_gt_1_3/outclk] [get_bd_pins bufg_gt_3_3/outclk] [get_bd_pins gt_quad_base/ch3_rxoutclk]
  connect_bd_net -net gt_quad_base_gtpowergood [get_bd_ports gtpowergood] [get_bd_pins gt_quad_base/gtpowergood]
  connect_bd_net -net gt_quad_base_txn [get_bd_ports gt_txn_out_0] [get_bd_pins gt_quad_base/txn]
  connect_bd_net -net gt_quad_base_txp [get_bd_ports gt_txp_out_0] [get_bd_pins gt_quad_base/txp]
  connect_bd_net -net gt_reset_all_in_1 [get_bd_ports gt_reset_all_in] [get_bd_pins mrmac_0/gt_reset_all_in]
  connect_bd_net -net gt_reset_rx_datapath_in_1 [get_bd_ports gt_reset_rx_datapath_in] [get_bd_pins mrmac_0/gt_reset_rx_datapath_in]
  connect_bd_net -net gt_reset_tx_datapath_in_1 [get_bd_ports gt_reset_tx_datapath_in] [get_bd_pins mrmac_0/gt_reset_tx_datapath_in]
  connect_bd_net -net gt_rxn_in_0_1 [get_bd_ports gt_rxn_in_0] [get_bd_pins gt_quad_base/rxn]
  connect_bd_net -net gt_rxp_in_0_1 [get_bd_ports gt_rxp_in_0] [get_bd_pins gt_quad_base/rxp]
  connect_bd_net -net gtpowergood_in_1 [get_bd_ports gtpowergood_in] [get_bd_pins mrmac_0/gtpowergood_in]
  connect_bd_net -net mrmac_0_gt_rx_reset_done_out [get_bd_ports gt_rx_reset_done_out] [get_bd_pins mrmac_0/gt_rx_reset_done_out]
  connect_bd_net -net mrmac_0_gt_tx_reset_done_out [get_bd_ports gt_tx_reset_done_out] [get_bd_pins mrmac_0/gt_tx_reset_done_out]
  connect_bd_net -net mrmac_0_pm_rdy [get_bd_ports pm_rdy] [get_bd_pins mrmac_0/pm_rdy]
  connect_bd_net -net mrmac_0_rx_axis_tdata0 [get_bd_ports rx_axis_tdata0] [get_bd_pins mrmac_0/rx_axis_tdata0]
  connect_bd_net -net mrmac_0_rx_axis_tdata1 [get_bd_ports rx_axis_tdata1] [get_bd_pins mrmac_0/rx_axis_tdata1]
  connect_bd_net -net mrmac_0_rx_axis_tdata2 [get_bd_ports rx_axis_tdata2] [get_bd_pins mrmac_0/rx_axis_tdata2]
  connect_bd_net -net mrmac_0_rx_axis_tdata3 [get_bd_ports rx_axis_tdata3] [get_bd_pins mrmac_0/rx_axis_tdata3]
  connect_bd_net -net mrmac_0_rx_axis_tdata4 [get_bd_ports rx_axis_tdata4] [get_bd_pins mrmac_0/rx_axis_tdata4]
  connect_bd_net -net mrmac_0_rx_axis_tdata5 [get_bd_ports rx_axis_tdata5] [get_bd_pins mrmac_0/rx_axis_tdata5]
  connect_bd_net -net mrmac_0_rx_axis_tdata6 [get_bd_ports rx_axis_tdata6] [get_bd_pins mrmac_0/rx_axis_tdata6]
  connect_bd_net -net mrmac_0_rx_axis_tdata7 [get_bd_ports rx_axis_tdata7] [get_bd_pins mrmac_0/rx_axis_tdata7]
  connect_bd_net -net mrmac_0_rx_axis_tkeep_user0 [get_bd_ports rx_axis_tkeep_user0] [get_bd_pins mrmac_0/rx_axis_tkeep_user0]
  connect_bd_net -net mrmac_0_rx_axis_tkeep_user1 [get_bd_ports rx_axis_tkeep_user1] [get_bd_pins mrmac_0/rx_axis_tkeep_user1]
  connect_bd_net -net mrmac_0_rx_axis_tkeep_user2 [get_bd_ports rx_axis_tkeep_user2] [get_bd_pins mrmac_0/rx_axis_tkeep_user2]
  connect_bd_net -net mrmac_0_rx_axis_tkeep_user3 [get_bd_ports rx_axis_tkeep_user3] [get_bd_pins mrmac_0/rx_axis_tkeep_user3]
  connect_bd_net -net mrmac_0_rx_axis_tkeep_user4 [get_bd_ports rx_axis_tkeep_user4] [get_bd_pins mrmac_0/rx_axis_tkeep_user4]
  connect_bd_net -net mrmac_0_rx_axis_tkeep_user5 [get_bd_ports rx_axis_tkeep_user5] [get_bd_pins mrmac_0/rx_axis_tkeep_user5]
  connect_bd_net -net mrmac_0_rx_axis_tkeep_user6 [get_bd_ports rx_axis_tkeep_user6] [get_bd_pins mrmac_0/rx_axis_tkeep_user6]
  connect_bd_net -net mrmac_0_rx_axis_tkeep_user7 [get_bd_ports rx_axis_tkeep_user7] [get_bd_pins mrmac_0/rx_axis_tkeep_user7]
  connect_bd_net -net mrmac_0_rx_axis_tlast_0 [get_bd_ports rx_axis_tlast_0] [get_bd_pins mrmac_0/rx_axis_tlast_0]
  connect_bd_net -net mrmac_0_rx_axis_tlast_1 [get_bd_ports rx_axis_tlast_1] [get_bd_pins mrmac_0/rx_axis_tlast_1]
  connect_bd_net -net mrmac_0_rx_axis_tlast_2 [get_bd_ports rx_axis_tlast_2] [get_bd_pins mrmac_0/rx_axis_tlast_2]
  connect_bd_net -net mrmac_0_rx_axis_tlast_3 [get_bd_ports rx_axis_tlast_3] [get_bd_pins mrmac_0/rx_axis_tlast_3]
  connect_bd_net -net mrmac_0_rx_axis_tvalid_0 [get_bd_ports rx_axis_tvalid_0] [get_bd_pins mrmac_0/rx_axis_tvalid_0]
  connect_bd_net -net mrmac_0_rx_axis_tvalid_1 [get_bd_ports rx_axis_tvalid_1] [get_bd_pins mrmac_0/rx_axis_tvalid_1]
  connect_bd_net -net mrmac_0_rx_axis_tvalid_2 [get_bd_ports rx_axis_tvalid_2] [get_bd_pins mrmac_0/rx_axis_tvalid_2]
  connect_bd_net -net mrmac_0_rx_axis_tvalid_3 [get_bd_ports rx_axis_tvalid_3] [get_bd_pins mrmac_0/rx_axis_tvalid_3]
  connect_bd_net -net mrmac_0_tx_axis_tready_0 [get_bd_ports tx_axis_tready_0] [get_bd_pins mrmac_0/tx_axis_tready_0]
  connect_bd_net -net mrmac_0_tx_axis_tready_1 [get_bd_ports tx_axis_tready_1] [get_bd_pins mrmac_0/tx_axis_tready_1]
  connect_bd_net -net mrmac_0_tx_axis_tready_2 [get_bd_ports tx_axis_tready_2] [get_bd_pins mrmac_0/tx_axis_tready_2]
  connect_bd_net -net mrmac_0_tx_axis_tready_3 [get_bd_ports tx_axis_tready_3] [get_bd_pins mrmac_0/tx_axis_tready_3]
  connect_bd_net -net pm_tick_1 [get_bd_ports pm_tick] [get_bd_pins mrmac_0/pm_tick]
  connect_bd_net -net rx_alt_serdes_clk_1 [get_bd_ports rx_alt_serdes_clk] [get_bd_pins mrmac_0/rx_alt_serdes_clk]
  connect_bd_net -net rx_axi_clk_1 [get_bd_ports rx_axi_clk] [get_bd_pins mrmac_0/rx_axi_clk]
  connect_bd_net -net rx_core_clk_1 [get_bd_ports rx_core_clk] [get_bd_pins mrmac_0/rx_core_clk]
  connect_bd_net -net rx_core_reset_1 [get_bd_ports rx_core_reset] [get_bd_pins mrmac_0/rx_core_reset]
  connect_bd_net -net rx_flexif_clk_1 [get_bd_ports rx_flexif_clk] [get_bd_pins mrmac_0/rx_flexif_clk]
  connect_bd_net -net rx_flexif_reset_1 [get_bd_ports rx_flexif_reset] [get_bd_pins mrmac_0/rx_flexif_reset]
  connect_bd_net -net rx_serdes_clk_1 [get_bd_ports rx_serdes_clk] [get_bd_pins mrmac_0/rx_serdes_clk]
  connect_bd_net -net rx_serdes_reset_1 [get_bd_ports rx_serdes_reset] [get_bd_pins mrmac_0/rx_serdes_reset]
  connect_bd_net -net rx_ts_clk_1 [get_bd_ports rx_ts_clk] [get_bd_pins mrmac_0/rx_ts_clk]
  connect_bd_net -net s_axi_aclk_1 [get_bd_ports s_axi_aclk] [get_bd_pins mrmac_0/s_axi_aclk]
  connect_bd_net -net s_axi_aresetn_1 [get_bd_ports s_axi_aresetn] [get_bd_pins gt_quad_base/apb3presetn] [get_bd_pins mrmac_0/s_axi_aresetn]
  connect_bd_net -net tx_alt_serdes_clk_1 [get_bd_ports tx_alt_serdes_clk] [get_bd_pins mrmac_0/tx_alt_serdes_clk]
  connect_bd_net -net tx_axi_clk_1 [get_bd_ports tx_axi_clk] [get_bd_pins mrmac_0/tx_axi_clk]
  connect_bd_net -net tx_axis_tdata0_1 [get_bd_ports tx_axis_tdata0] [get_bd_pins mrmac_0/tx_axis_tdata0]
  connect_bd_net -net tx_axis_tdata1_1 [get_bd_ports tx_axis_tdata1] [get_bd_pins mrmac_0/tx_axis_tdata1]
  connect_bd_net -net tx_axis_tdata2_1 [get_bd_ports tx_axis_tdata2] [get_bd_pins mrmac_0/tx_axis_tdata2]
  connect_bd_net -net tx_axis_tdata3_1 [get_bd_ports tx_axis_tdata3] [get_bd_pins mrmac_0/tx_axis_tdata3]
  connect_bd_net -net tx_axis_tdata4_1 [get_bd_ports tx_axis_tdata4] [get_bd_pins mrmac_0/tx_axis_tdata4]
  connect_bd_net -net tx_axis_tdata5_1 [get_bd_ports tx_axis_tdata5] [get_bd_pins mrmac_0/tx_axis_tdata5]
  connect_bd_net -net tx_axis_tdata6_1 [get_bd_ports tx_axis_tdata6] [get_bd_pins mrmac_0/tx_axis_tdata6]
  connect_bd_net -net tx_axis_tdata7_1 [get_bd_ports tx_axis_tdata7] [get_bd_pins mrmac_0/tx_axis_tdata7]
  connect_bd_net -net tx_axis_tkeep_user0_1 [get_bd_ports tx_axis_tkeep_user0] [get_bd_pins mrmac_0/tx_axis_tkeep_user0]
  connect_bd_net -net tx_axis_tkeep_user1_1 [get_bd_ports tx_axis_tkeep_user1] [get_bd_pins mrmac_0/tx_axis_tkeep_user1]
  connect_bd_net -net tx_axis_tkeep_user2_1 [get_bd_ports tx_axis_tkeep_user2] [get_bd_pins mrmac_0/tx_axis_tkeep_user2]
  connect_bd_net -net tx_axis_tkeep_user3_1 [get_bd_ports tx_axis_tkeep_user3] [get_bd_pins mrmac_0/tx_axis_tkeep_user3]
  connect_bd_net -net tx_axis_tkeep_user4_1 [get_bd_ports tx_axis_tkeep_user4] [get_bd_pins mrmac_0/tx_axis_tkeep_user4]
  connect_bd_net -net tx_axis_tkeep_user5_1 [get_bd_ports tx_axis_tkeep_user5] [get_bd_pins mrmac_0/tx_axis_tkeep_user5]
  connect_bd_net -net tx_axis_tkeep_user6_1 [get_bd_ports tx_axis_tkeep_user6] [get_bd_pins mrmac_0/tx_axis_tkeep_user6]
  connect_bd_net -net tx_axis_tkeep_user7_1 [get_bd_ports tx_axis_tkeep_user7] [get_bd_pins mrmac_0/tx_axis_tkeep_user7]
  connect_bd_net -net tx_axis_tlast_0_1 [get_bd_ports tx_axis_tlast_0] [get_bd_pins mrmac_0/tx_axis_tlast_0]
  connect_bd_net -net tx_axis_tlast_1_1 [get_bd_ports tx_axis_tlast_1] [get_bd_pins mrmac_0/tx_axis_tlast_1]
  connect_bd_net -net tx_axis_tlast_2_1 [get_bd_ports tx_axis_tlast_2] [get_bd_pins mrmac_0/tx_axis_tlast_2]
  connect_bd_net -net tx_axis_tlast_3_1 [get_bd_ports tx_axis_tlast_3] [get_bd_pins mrmac_0/tx_axis_tlast_3]
  connect_bd_net -net tx_axis_tvalid_0_1 [get_bd_ports tx_axis_tvalid_0] [get_bd_pins mrmac_0/tx_axis_tvalid_0]
  connect_bd_net -net tx_axis_tvalid_1_1 [get_bd_ports tx_axis_tvalid_1] [get_bd_pins mrmac_0/tx_axis_tvalid_1]
  connect_bd_net -net tx_axis_tvalid_2_1 [get_bd_ports tx_axis_tvalid_2] [get_bd_pins mrmac_0/tx_axis_tvalid_2]
  connect_bd_net -net tx_axis_tvalid_3_1 [get_bd_ports tx_axis_tvalid_3] [get_bd_pins mrmac_0/tx_axis_tvalid_3]
  connect_bd_net -net tx_core_clk_1 [get_bd_ports tx_core_clk] [get_bd_pins mrmac_0/tx_core_clk]
  connect_bd_net -net tx_core_reset_1 [get_bd_ports tx_core_reset] [get_bd_pins mrmac_0/tx_core_reset]
  connect_bd_net -net tx_flexif_clk_1 [get_bd_ports tx_flexif_clk] [get_bd_pins mrmac_0/tx_flexif_clk]
  connect_bd_net -net tx_serdes_reset_1 [get_bd_ports tx_serdes_reset] [get_bd_pins mrmac_0/tx_serdes_reset]
  connect_bd_net -net tx_ts_clk_1 [get_bd_ports tx_ts_clk] [get_bd_pins mrmac_0/tx_ts_clk]
  connect_bd_net -net util_ds_buf_0_IBUF_OUT [get_bd_pins gt_quad_base/GT_REFCLK0] [get_bd_pins util_ds_buf_0/IBUF_OUT]
  connect_bd_net -net xlconstant_0_dout [get_bd_pins bufg_gt_2/gt_bufgtdiv] [get_bd_pins bufg_gt_3/gt_bufgtdiv] [get_bd_pins bufg_gt_3_1/gt_bufgtdiv] [get_bd_pins bufg_gt_3_2/gt_bufgtdiv] [get_bd_pins bufg_gt_3_3/gt_bufgtdiv] [get_bd_pins xlconstant_0/dout]

  # Create address segments


  # Restore current instance
  current_bd_instance $oldCurInst

  validate_bd_design
  save_bd_design
}
# End of create_root_design()


##################################################################
# MAIN FLOW
##################################################################

create_root_design ""


