
################################################################
# This is a generated script based on design: design_rp
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
set design_name xdma_rootcomplex
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
xilinx.com:ip:util_ds_buf:*\
xilinx.com:ip:xlconstant:*\
xilinx.com:ip:gt_quad_base:*\
xilinx.com:ip:pcie_phy_versal:*\
xilinx.com:ip:pcie_versal:*\
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
  set m_axis_cq [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis_cq ]
  set_property -dict [ list \
   CONFIG.FREQ_HZ {250000000} \
   ] $m_axis_cq

  set m_axis_rc [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis_rc ]
  set_property -dict [ list \
   CONFIG.FREQ_HZ {250000000} \
   ] $m_axis_rc

  set pcie_cfg_control [ create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:pcie4_cfg_control_rtl:1.0 pcie_cfg_control ]

  set pcie_cfg_fc [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:pcie_cfg_fc_rtl:1.1 pcie_cfg_fc ]

  set pcie_cfg_interrupt [ create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:pcie3_cfg_interrupt_rtl:1.0 pcie_cfg_interrupt ]

  set pcie_cfg_mesg_rcvd [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:pcie3_cfg_msg_received_rtl:1.0 pcie_cfg_mesg_rcvd ]

  set pcie_cfg_mesg_tx [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:pcie3_cfg_mesg_tx_rtl:1.0 pcie_cfg_mesg_tx ]

  set pcie_cfg_mgmt [ create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:pcie4_cfg_mgmt_rtl:1.0 pcie_cfg_mgmt ]

  set pcie_cfg_msi [ create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:pcie3_cfg_msi_rtl:1.0 pcie_cfg_msi ]

  set pcie_cfg_status [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:pcie4_cfg_status_rtl:1.0 pcie_cfg_status ]

  set pcie_mgt [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:gt_rtl:1.0 pcie_mgt ]

  set pcie_refclk [ create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:diff_clock_rtl:1.0 pcie_refclk ]

  set pcie_transmit_fc [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:pcie3_transmit_fc_rtl:1.0 pcie_transmit_fc ]

  set pipe_rp [ create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:pcie_ext_pipe_rtl:1.0 pipe_rp ]

  set s_axis_cc [ create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_cc ]
  set_property -dict [ list \
   CONFIG.FREQ_HZ {250000000} \
   CONFIG.HAS_TKEEP {1} \
   CONFIG.HAS_TLAST {1} \
   CONFIG.HAS_TREADY {1} \
   CONFIG.HAS_TSTRB {0} \
   CONFIG.LAYERED_METADATA {undef} \
   CONFIG.TDATA_NUM_BYTES {64} \
   CONFIG.TDEST_WIDTH {0} \
   CONFIG.TID_WIDTH {0} \
   CONFIG.TUSER_WIDTH {81} \
   ] $s_axis_cc

  set s_axis_rq [ create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_rq ]
  set_property -dict [ list \
   CONFIG.FREQ_HZ {250000000} \
   CONFIG.HAS_TKEEP {1} \
   CONFIG.HAS_TLAST {1} \
   CONFIG.HAS_TREADY {1} \
   CONFIG.HAS_TSTRB {0} \
   CONFIG.LAYERED_METADATA {undef} \
   CONFIG.TDATA_NUM_BYTES {64} \
   CONFIG.TDEST_WIDTH {0} \
   CONFIG.TID_WIDTH {0} \
   CONFIG.TUSER_WIDTH {183} \
   ] $s_axis_rq


  # Create ports
  set core_clk [ create_bd_port -dir O -type clk core_clk ]
  set phy_rdy_out [ create_bd_port -dir O phy_rdy_out ]
  set sys_reset [ create_bd_port -dir I -type rst sys_reset ]
  set user_clk [ create_bd_port -dir O -type clk user_clk ]
  set_property -dict [ list \
   CONFIG.ASSOCIATED_BUSIF {m_axis_cq:m_axis_rc:s_axis_cc:s_axis_rq} \
   CONFIG.FREQ_HZ {250000000} \
 ] $user_clk
  set_property CONFIG.ASSOCIATED_BUSIF.VALUE_SRC DEFAULT $user_clk

  set user_lnk_up [ create_bd_port -dir O user_lnk_up ]
  set user_reset [ create_bd_port -dir O -type rst user_reset ]
  set_property -dict [ list \
   CONFIG.POLARITY {ACTIVE_HIGH} \
 ] $user_reset

  # Create instance: bufg_gt_sysclk, and set properties
  set bufg_gt_sysclk [ create_bd_cell -type ip -vlnv xilinx.com:ip:util_ds_buf bufg_gt_sysclk ]
  set_property -dict [ list \
   CONFIG.C_BUFG_GT_SYNC {true} \
   CONFIG.C_BUF_TYPE {BUFG_GT} \
 ] $bufg_gt_sysclk

  # Create instance: const_1b1, and set properties
  set const_1b1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant const_1b1 ]
  set_property -dict [ list \
   CONFIG.CONST_VAL {1} \
   CONFIG.CONST_WIDTH {1} \
 ] $const_1b1

  # Create instance: gt_quad_0, and set properties
  set gt_quad_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:gt_quad_base gt_quad_0 ]
  set_property -dict [ list \
   CONFIG.PORTS_INFO_DICT {\
     LANE_SEL_DICT {PROT0 {RX0 RX1 RX2 RX3 TX0 TX1 TX2 TX3}}\
     GT_TYPE {GTY}\
     REG_CONF_INTF {APB3_INTF}\
     BOARD_PARAMETER {}\
   } \
   CONFIG.REFCLK_STRING {\
HSCLK0_LCPLLGTREFCLK0 refclk_PROT0_R0_100_MHz_unique1 HSCLK0_RPLLGTREFCLK0\
refclk_PROT0_R0_100_MHz_unique1 HSCLK1_LCPLLGTREFCLK0\
refclk_PROT0_R0_100_MHz_unique1 HSCLK1_RPLLGTREFCLK0\
refclk_PROT0_R0_100_MHz_unique1} \
 ] $gt_quad_0

  # Create instance: gt_quad_1, and set properties
  set gt_quad_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:gt_quad_base gt_quad_1 ]
  set_property -dict [ list \
   CONFIG.PORTS_INFO_DICT {\
     LANE_SEL_DICT {PROT0 {RX0 RX1 RX2 RX3 TX0 TX1 TX2 TX3}}\
     GT_TYPE {GTY}\
     REG_CONF_INTF {APB3_INTF}\
     BOARD_PARAMETER {}\
   } \
   CONFIG.REFCLK_STRING {\
HSCLK0_LCPLLGTREFCLK0 refclk_PROT0_R0_100_MHz_unique1 HSCLK0_RPLLGTREFCLK0\
refclk_PROT0_R0_100_MHz_unique1 HSCLK1_LCPLLGTREFCLK0\
refclk_PROT0_R0_100_MHz_unique1 HSCLK1_RPLLGTREFCLK0\
refclk_PROT0_R0_100_MHz_unique1} \
 ] $gt_quad_1

  # Create instance: pcie_phy, and set properties
  set pcie_phy [ create_bd_cell -type ip -vlnv xilinx.com:ip:pcie_phy_versal pcie_phy ]
  set_property -dict [ list \
   CONFIG.PL_LINK_CAP_MAX_LINK_SPEED {16.0_GT/s} \
   CONFIG.PL_LINK_CAP_MAX_LINK_WIDTH {X8} \
   CONFIG.aspm {No_ASPM} \
   CONFIG.async_mode {SRNS} \
   CONFIG.disable_double_pipe {YES} \
   CONFIG.en_gt_pclk {false} \
   CONFIG.ins_loss_profile {Add-in_Card} \
   CONFIG.lane_order {Bottom} \
   CONFIG.lane_reversal {false} \
   CONFIG.phy_async_en {true} \
   CONFIG.phy_coreclk_freq {500_MHz} \
   CONFIG.phy_refclk_freq {100_MHz} \
   CONFIG.phy_userclk_freq {250_MHz} \
   CONFIG.pipeline_stages {1} \
   CONFIG.sim_model {YES} \
   CONFIG.tx_preset {4} \
 ] $pcie_phy

  # Create instance: pcie_versal_0, and set properties
  set pcie_versal_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:pcie_versal pcie_versal_0 ]
  set_property -dict [ list \
   CONFIG.AXISTEN_IF_EXT_512_RQ_STRADDLE {false} \
   CONFIG.MSI_X_OPTIONS {None} \
   CONFIG.PF0_CLASS_CODE {060A00} \
   CONFIG.PF0_DEVICE_ID {B0C8} \
   CONFIG.PF0_INTERRUPT_PIN {INTA} \
   CONFIG.PF0_LINK_STATUS_SLOT_CLOCK_CONFIG {true} \
   CONFIG.PF0_MSIX_CAP_PBA_BIR {BAR_0} \
   CONFIG.PF0_MSIX_CAP_PBA_OFFSET {00000000} \
   CONFIG.PF0_MSIX_CAP_TABLE_BIR {BAR_0} \
   CONFIG.PF0_MSIX_CAP_TABLE_OFFSET {00000000} \
   CONFIG.PF0_MSIX_CAP_TABLE_SIZE {000} \
   CONFIG.PF0_MSI_CAP_MULTIMSGCAP {1_vector} \
   CONFIG.PF0_REVISION_ID {00} \
   CONFIG.PF0_SRIOV_VF_DEVICE_ID {C048} \
   CONFIG.PF0_SUBSYSTEM_ID {0007} \
   CONFIG.PF0_SUBSYSTEM_VENDOR_ID {10EE} \
   CONFIG.PF0_Use_Class_Code_Lookup_Assistant {false} \
   CONFIG.PF1_CLASS_CODE {060A00} \
   CONFIG.PF1_DEVICE_ID {9011} \
   CONFIG.PF1_INTERRUPT_PIN {NONE} \
   CONFIG.PF1_MSIX_CAP_PBA_BIR {BAR_0} \
   CONFIG.PF1_MSIX_CAP_PBA_OFFSET {00000000} \
   CONFIG.PF1_MSIX_CAP_TABLE_BIR {BAR_0} \
   CONFIG.PF1_MSIX_CAP_TABLE_OFFSET {00000000} \
   CONFIG.PF1_MSIX_CAP_TABLE_SIZE {000} \
   CONFIG.PF1_MSI_CAP_MULTIMSGCAP {1_vector} \
   CONFIG.PF1_REVISION_ID {00} \
   CONFIG.PF1_SRIOV_VF_DEVICE_ID {C148} \
   CONFIG.PF1_SUBSYSTEM_ID {0007} \
   CONFIG.PF1_SUBSYSTEM_VENDOR_ID {10EE} \
   CONFIG.PF1_Use_Class_Code_Lookup_Assistant {false} \
   CONFIG.PF2_CLASS_CODE {060A00} \
   CONFIG.PF2_DEVICE_ID {B2C8} \
   CONFIG.PF2_INTERRUPT_PIN {NONE} \
   CONFIG.PF2_MSI_CAP_MULTIMSGCAP {1_vector} \
   CONFIG.PF2_REVISION_ID {00} \
   CONFIG.PF2_SRIOV_VF_DEVICE_ID {C248} \
   CONFIG.PF2_SUBSYSTEM_ID {0007} \
   CONFIG.PF2_SUBSYSTEM_VENDOR_ID {10EE} \
   CONFIG.PF2_Use_Class_Code_Lookup_Assistant {false} \
   CONFIG.PF3_CLASS_CODE {060A00} \
   CONFIG.PF3_DEVICE_ID {B3C8} \
   CONFIG.PF3_INTERRUPT_PIN {NONE} \
   CONFIG.PF3_MSI_CAP_MULTIMSGCAP {1_vector} \
   CONFIG.PF3_REVISION_ID {00} \
   CONFIG.PF3_SRIOV_VF_DEVICE_ID {C348} \
   CONFIG.PF3_SUBSYSTEM_ID {0007} \
   CONFIG.PF3_SUBSYSTEM_VENDOR_ID {10EE} \
   CONFIG.PF3_Use_Class_Code_Lookup_Assistant {false} \
   CONFIG.PL_LINK_CAP_MAX_LINK_SPEED {16.0_GT/s} \
   CONFIG.PL_LINK_CAP_MAX_LINK_WIDTH {X8} \
   CONFIG.REF_CLK_FREQ {100_MHz} \
   CONFIG.TL_PF_ENABLE_REG {1} \
   CONFIG.acs_ext_cap_enable {false} \
   CONFIG.axisten_freq {250} \
   CONFIG.axisten_if_width {512_bit} \
   CONFIG.cfg_mgmt_if {true} \
   CONFIG.copy_pf0 {false} \
   CONFIG.coreclk_freq {500} \
   CONFIG.dedicate_perst {false} \
   CONFIG.device_port_type {Root_Port_of_PCI_Express_Root_Complex} \
   CONFIG.en_dbg_descramble {false} \
   CONFIG.en_l23_entry {false} \
   CONFIG.en_transceiver_status_ports {false} \
   CONFIG.enable_auto_rxeq {False} \
   CONFIG.enable_ccix {FALSE} \
   CONFIG.enable_code {0000} \
   CONFIG.enable_dvsec {FALSE} \
   CONFIG.enable_gen4 {true} \
   CONFIG.enable_ibert {false} \
   CONFIG.enable_jtag_dbg {false} \
   CONFIG.enable_more_clk {false} \
   CONFIG.ext_pcie_cfg_space_enabled {false} \
   CONFIG.ext_xvc_vsec_enable {false} \
   CONFIG.extended_tag_field {true} \
   CONFIG.insert_cips {false} \
   CONFIG.lane_order {Bottom} \
   CONFIG.mcap_enablement {None} \
   CONFIG.mode_selection {Advanced} \
   CONFIG.pcie_blk_locn {X0Y1} \
   CONFIG.pcie_link_debug {false} \
   CONFIG.pcie_link_debug_axi4_st {false} \
   CONFIG.pf0_ari_enabled {false} \
   CONFIG.pf0_bar0_64bit {false} \
   CONFIG.pf0_bar0_enabled {true} \
   CONFIG.pf0_bar0_prefetchable {false} \
   CONFIG.pf0_bar0_scale {Kilobytes} \
   CONFIG.pf0_bar0_size {128} \
   CONFIG.pf0_bar1_64bit {false} \
   CONFIG.pf0_bar1_enabled {false} \
   CONFIG.pf0_bar1_prefetchable {false} \
   CONFIG.pf0_bar1_scale {Kilobytes} \
   CONFIG.pf0_bar1_size {128} \
   CONFIG.pf0_bar2_64bit {false} \
   CONFIG.pf0_bar2_enabled {false} \
   CONFIG.pf0_bar2_prefetchable {false} \
   CONFIG.pf0_bar2_scale {Kilobytes} \
   CONFIG.pf0_bar2_size {128} \
   CONFIG.pf0_bar3_64bit {false} \
   CONFIG.pf0_bar3_enabled {false} \
   CONFIG.pf0_bar3_prefetchable {false} \
   CONFIG.pf0_bar3_scale {Kilobytes} \
   CONFIG.pf0_bar3_size {128} \
   CONFIG.pf0_bar4_64bit {false} \
   CONFIG.pf0_bar4_enabled {false} \
   CONFIG.pf0_bar4_prefetchable {false} \
   CONFIG.pf0_bar4_scale {Kilobytes} \
   CONFIG.pf0_bar4_size {128} \
   CONFIG.pf0_bar5_enabled {false} \
   CONFIG.pf0_bar5_prefetchable {false} \
   CONFIG.pf0_bar5_scale {Kilobytes} \
   CONFIG.pf0_bar5_size {128} \
   CONFIG.pf0_base_class_menu {Bridge_device} \
   CONFIG.pf0_class_code_base {06} \
   CONFIG.pf0_class_code_interface {00} \
   CONFIG.pf0_class_code_sub {0A} \
   CONFIG.pf0_expansion_rom_enabled {false} \
   CONFIG.pf0_expansion_rom_scale {Kilobytes} \
   CONFIG.pf0_expansion_rom_size {1} \
   CONFIG.pf0_expansion_rom_type {Expansion_ROM} \
   CONFIG.pf0_msi_enabled {true} \
   CONFIG.pf0_msix_enabled {false} \
   CONFIG.pf0_sub_class_interface_menu {InfiniBand_to_PCI_host_bridge} \
   CONFIG.pf1_bar0_64bit {false} \
   CONFIG.pf1_bar0_enabled {true} \
   CONFIG.pf1_bar0_prefetchable {false} \
   CONFIG.pf1_bar0_scale {Kilobytes} \
   CONFIG.pf1_bar0_size {128} \
   CONFIG.pf1_bar1_64bit {false} \
   CONFIG.pf1_bar1_enabled {false} \
   CONFIG.pf1_bar1_prefetchable {false} \
   CONFIG.pf1_bar1_scale {Kilobytes} \
   CONFIG.pf1_bar1_size {128} \
   CONFIG.pf1_bar2_64bit {false} \
   CONFIG.pf1_bar2_enabled {true} \
   CONFIG.pf1_bar2_prefetchable {false} \
   CONFIG.pf1_bar2_scale {Kilobytes} \
   CONFIG.pf1_bar2_size {128} \
   CONFIG.pf1_bar3_64bit {false} \
   CONFIG.pf1_bar3_enabled {false} \
   CONFIG.pf1_bar3_prefetchable {false} \
   CONFIG.pf1_bar3_scale {Kilobytes} \
   CONFIG.pf1_bar3_size {128} \
   CONFIG.pf1_bar4_64bit {false} \
   CONFIG.pf1_bar4_enabled {true} \
   CONFIG.pf1_bar4_prefetchable {false} \
   CONFIG.pf1_bar4_scale {Kilobytes} \
   CONFIG.pf1_bar4_size {128} \
   CONFIG.pf1_bar5_enabled {false} \
   CONFIG.pf1_bar5_prefetchable {false} \
   CONFIG.pf1_bar5_scale {Kilobytes} \
   CONFIG.pf1_bar5_size {128} \
   CONFIG.pf1_base_class_menu {Bridge_device} \
   CONFIG.pf1_class_code_base {06} \
   CONFIG.pf1_class_code_interface {00} \
   CONFIG.pf1_class_code_sub {0A} \
   CONFIG.pf1_expansion_rom_enabled {false} \
   CONFIG.pf1_expansion_rom_scale {Kilobytes} \
   CONFIG.pf1_expansion_rom_size {1} \
   CONFIG.pf1_expansion_rom_type {Expansion_ROM} \
   CONFIG.pf1_msi_enabled {false} \
   CONFIG.pf1_msix_enabled {false} \
   CONFIG.pf1_sub_class_interface_menu {InfiniBand_to_PCI_host_bridge} \
   CONFIG.pf1_vendor_id {10EE} \
   CONFIG.pf2_bar0_64bit {false} \
   CONFIG.pf2_bar0_enabled {true} \
   CONFIG.pf2_bar0_prefetchable {false} \
   CONFIG.pf2_bar0_scale {Kilobytes} \
   CONFIG.pf2_bar0_size {128} \
   CONFIG.pf2_bar1_64bit {false} \
   CONFIG.pf2_bar1_enabled {false} \
   CONFIG.pf2_bar1_prefetchable {false} \
   CONFIG.pf2_bar1_scale {Kilobytes} \
   CONFIG.pf2_bar1_size {128} \
   CONFIG.pf2_bar2_64bit {false} \
   CONFIG.pf2_bar2_enabled {true} \
   CONFIG.pf2_bar2_prefetchable {false} \
   CONFIG.pf2_bar2_scale {Kilobytes} \
   CONFIG.pf2_bar2_size {128} \
   CONFIG.pf2_bar3_64bit {false} \
   CONFIG.pf2_bar3_enabled {false} \
   CONFIG.pf2_bar3_prefetchable {false} \
   CONFIG.pf2_bar3_scale {Kilobytes} \
   CONFIG.pf2_bar3_size {128} \
   CONFIG.pf2_bar4_64bit {false} \
   CONFIG.pf2_bar4_enabled {true} \
   CONFIG.pf2_bar4_prefetchable {false} \
   CONFIG.pf2_bar4_scale {Kilobytes} \
   CONFIG.pf2_bar4_size {128} \
   CONFIG.pf2_bar5_enabled {false} \
   CONFIG.pf2_bar5_prefetchable {false} \
   CONFIG.pf2_bar5_scale {Kilobytes} \
   CONFIG.pf2_bar5_size {128} \
   CONFIG.pf2_base_class_menu {Bridge_device} \
   CONFIG.pf2_class_code_base {06} \
   CONFIG.pf2_class_code_interface {00} \
   CONFIG.pf2_class_code_sub {0A} \
   CONFIG.pf2_expansion_rom_enabled {false} \
   CONFIG.pf2_expansion_rom_scale {Kilobytes} \
   CONFIG.pf2_expansion_rom_size {1} \
   CONFIG.pf2_expansion_rom_type {Expansion_ROM} \
   CONFIG.pf2_msi_enabled {false} \
   CONFIG.pf2_sub_class_interface_menu {InfiniBand_to_PCI_host_bridge} \
   CONFIG.pf3_bar0_64bit {false} \
   CONFIG.pf3_bar0_enabled {true} \
   CONFIG.pf3_bar0_prefetchable {false} \
   CONFIG.pf3_bar0_scale {Kilobytes} \
   CONFIG.pf3_bar0_size {128} \
   CONFIG.pf3_bar1_64bit {false} \
   CONFIG.pf3_bar1_enabled {false} \
   CONFIG.pf3_bar1_prefetchable {false} \
   CONFIG.pf3_bar1_scale {Kilobytes} \
   CONFIG.pf3_bar1_size {128} \
   CONFIG.pf3_bar2_64bit {false} \
   CONFIG.pf3_bar2_enabled {true} \
   CONFIG.pf3_bar2_prefetchable {false} \
   CONFIG.pf3_bar2_scale {Kilobytes} \
   CONFIG.pf3_bar2_size {128} \
   CONFIG.pf3_bar3_64bit {false} \
   CONFIG.pf3_bar3_enabled {false} \
   CONFIG.pf3_bar3_prefetchable {false} \
   CONFIG.pf3_bar3_scale {Kilobytes} \
   CONFIG.pf3_bar3_size {128} \
   CONFIG.pf3_bar4_64bit {false} \
   CONFIG.pf3_bar4_enabled {true} \
   CONFIG.pf3_bar4_prefetchable {false} \
   CONFIG.pf3_bar4_scale {Kilobytes} \
   CONFIG.pf3_bar4_size {128} \
   CONFIG.pf3_bar5_enabled {false} \
   CONFIG.pf3_bar5_prefetchable {false} \
   CONFIG.pf3_bar5_scale {Kilobytes} \
   CONFIG.pf3_bar5_size {128} \
   CONFIG.pf3_base_class_menu {Bridge_device} \
   CONFIG.pf3_class_code_base {06} \
   CONFIG.pf3_class_code_interface {00} \
   CONFIG.pf3_class_code_sub {0A} \
   CONFIG.pf3_expansion_rom_enabled {false} \
   CONFIG.pf3_expansion_rom_scale {Kilobytes} \
   CONFIG.pf3_expansion_rom_size {1} \
   CONFIG.pf3_expansion_rom_type {Expansion_ROM} \
   CONFIG.pf3_msi_enabled {false} \
   CONFIG.pf3_sub_class_interface_menu {InfiniBand_to_PCI_host_bridge} \
   CONFIG.pipe_sim {true} \
   CONFIG.sim_model {YES} \
   CONFIG.sys_reset_polarity {ACTIVE_LOW} \
   CONFIG.vendor_id {10EE} \
   CONFIG.xlnx_ref_board {None} \
 ] $pcie_versal_0

  # Create instance: refclk_ibuf, and set properties
  set refclk_ibuf [ create_bd_cell -type ip -vlnv xilinx.com:ip:util_ds_buf refclk_ibuf ]
  set_property -dict [ list \
   CONFIG.C_BUF_TYPE {IBUFDSGTE} \
 ] $refclk_ibuf

  # Create interface connections
  connect_bd_intf_net -intf_net gt_quad_0_GT0_BUFGT [get_bd_intf_pins gt_quad_0/GT0_BUFGT] [get_bd_intf_pins pcie_phy/GT_BUFGT]
  connect_bd_intf_net -intf_net gt_quad_0_GT_Serial [get_bd_intf_pins gt_quad_0/GT_Serial] [get_bd_intf_pins pcie_phy/GT0_Serial]
  connect_bd_intf_net -intf_net gt_quad_1_GT_NORTHIN_SOUTHOUT [get_bd_intf_pins gt_quad_0/GT_NORTHOUT_SOUTHIN] [get_bd_intf_pins gt_quad_1/GT_NORTHIN_SOUTHOUT]
  connect_bd_intf_net -intf_net gt_quad_1_GT_Serial [get_bd_intf_pins gt_quad_1/GT_Serial] [get_bd_intf_pins pcie_phy/GT1_Serial]
  connect_bd_intf_net -intf_net pcie_cfg_control_1 [get_bd_intf_ports pcie_cfg_control] [get_bd_intf_pins pcie_versal_0/pcie_cfg_control]
  connect_bd_intf_net -intf_net pcie_cfg_interrupt_1 [get_bd_intf_ports pcie_cfg_interrupt] [get_bd_intf_pins pcie_versal_0/pcie_cfg_interrupt]
  connect_bd_intf_net -intf_net pcie_cfg_mgmt_1 [get_bd_intf_ports pcie_cfg_mgmt] [get_bd_intf_pins pcie_versal_0/pcie_cfg_mgmt]
  connect_bd_intf_net -intf_net pcie_cfg_msi_1 [get_bd_intf_ports pcie_cfg_msi] [get_bd_intf_pins pcie_versal_0/pcie_cfg_msi]
  connect_bd_intf_net -intf_net pcie_phy_GT_RX0 [get_bd_intf_pins gt_quad_0/RX0_GT_IP_Interface] [get_bd_intf_pins pcie_phy/GT_RX0]
  connect_bd_intf_net -intf_net pcie_phy_GT_RX1 [get_bd_intf_pins gt_quad_0/RX1_GT_IP_Interface] [get_bd_intf_pins pcie_phy/GT_RX1]
  connect_bd_intf_net -intf_net pcie_phy_GT_RX2 [get_bd_intf_pins gt_quad_0/RX2_GT_IP_Interface] [get_bd_intf_pins pcie_phy/GT_RX2]
  connect_bd_intf_net -intf_net pcie_phy_GT_RX3 [get_bd_intf_pins gt_quad_0/RX3_GT_IP_Interface] [get_bd_intf_pins pcie_phy/GT_RX3]
  connect_bd_intf_net -intf_net pcie_phy_GT_RX4 [get_bd_intf_pins gt_quad_1/RX0_GT_IP_Interface] [get_bd_intf_pins pcie_phy/GT_RX4]
  connect_bd_intf_net -intf_net pcie_phy_GT_RX5 [get_bd_intf_pins gt_quad_1/RX1_GT_IP_Interface] [get_bd_intf_pins pcie_phy/GT_RX5]
  connect_bd_intf_net -intf_net pcie_phy_GT_RX6 [get_bd_intf_pins gt_quad_1/RX2_GT_IP_Interface] [get_bd_intf_pins pcie_phy/GT_RX6]
  connect_bd_intf_net -intf_net pcie_phy_GT_RX7 [get_bd_intf_pins gt_quad_1/RX3_GT_IP_Interface] [get_bd_intf_pins pcie_phy/GT_RX7]
  connect_bd_intf_net -intf_net pcie_phy_GT_TX0 [get_bd_intf_pins gt_quad_0/TX0_GT_IP_Interface] [get_bd_intf_pins pcie_phy/GT_TX0]
  connect_bd_intf_net -intf_net pcie_phy_GT_TX1 [get_bd_intf_pins gt_quad_0/TX1_GT_IP_Interface] [get_bd_intf_pins pcie_phy/GT_TX1]
  connect_bd_intf_net -intf_net pcie_phy_GT_TX2 [get_bd_intf_pins gt_quad_0/TX2_GT_IP_Interface] [get_bd_intf_pins pcie_phy/GT_TX2]
  connect_bd_intf_net -intf_net pcie_phy_GT_TX3 [get_bd_intf_pins gt_quad_0/TX3_GT_IP_Interface] [get_bd_intf_pins pcie_phy/GT_TX3]
  connect_bd_intf_net -intf_net pcie_phy_GT_TX4 [get_bd_intf_pins gt_quad_1/TX0_GT_IP_Interface] [get_bd_intf_pins pcie_phy/GT_TX4]
  connect_bd_intf_net -intf_net pcie_phy_GT_TX5 [get_bd_intf_pins gt_quad_1/TX1_GT_IP_Interface] [get_bd_intf_pins pcie_phy/GT_TX5]
  connect_bd_intf_net -intf_net pcie_phy_GT_TX6 [get_bd_intf_pins gt_quad_1/TX2_GT_IP_Interface] [get_bd_intf_pins pcie_phy/GT_TX6]
  connect_bd_intf_net -intf_net pcie_phy_GT_TX7 [get_bd_intf_pins gt_quad_1/TX3_GT_IP_Interface] [get_bd_intf_pins pcie_phy/GT_TX7]
  connect_bd_intf_net -intf_net pcie_phy_gt_rxmargin_q0 [get_bd_intf_pins gt_quad_0/gt_rxmargin_intf] [get_bd_intf_pins pcie_phy/gt_rxmargin_q0]
  connect_bd_intf_net -intf_net pcie_phy_gt_rxmargin_q1 [get_bd_intf_pins gt_quad_1/gt_rxmargin_intf] [get_bd_intf_pins pcie_phy/gt_rxmargin_q1]
  connect_bd_intf_net -intf_net pcie_phy_pcie_mgt [get_bd_intf_ports pcie_mgt] [get_bd_intf_pins pcie_phy/pcie_mgt]
  connect_bd_intf_net -intf_net pcie_phy_phy_mac_command [get_bd_intf_pins pcie_phy/phy_mac_command] [get_bd_intf_pins pcie_versal_0/phy_mac_command]
  connect_bd_intf_net -intf_net pcie_phy_phy_mac_rx_margining [get_bd_intf_pins pcie_phy/phy_mac_rx_margining] [get_bd_intf_pins pcie_versal_0/phy_mac_rx_margining]
  connect_bd_intf_net -intf_net pcie_phy_phy_mac_status [get_bd_intf_pins pcie_phy/phy_mac_status] [get_bd_intf_pins pcie_versal_0/phy_mac_status]
  connect_bd_intf_net -intf_net pcie_phy_phy_mac_tx_drive [get_bd_intf_pins pcie_phy/phy_mac_tx_drive] [get_bd_intf_pins pcie_versal_0/phy_mac_tx_drive]
  connect_bd_intf_net -intf_net pcie_phy_phy_mac_tx_eq [get_bd_intf_pins pcie_phy/phy_mac_tx_eq] [get_bd_intf_pins pcie_versal_0/phy_mac_tx_eq]
  connect_bd_intf_net -intf_net pcie_refclk_1 [get_bd_intf_ports pcie_refclk] [get_bd_intf_pins refclk_ibuf/CLK_IN_D]
  connect_bd_intf_net -intf_net pcie_versal_0_m_axis_cq [get_bd_intf_ports m_axis_cq] [get_bd_intf_pins pcie_versal_0/m_axis_cq]
  connect_bd_intf_net -intf_net pcie_versal_0_m_axis_rc [get_bd_intf_ports m_axis_rc] [get_bd_intf_pins pcie_versal_0/m_axis_rc]
  connect_bd_intf_net -intf_net pcie_versal_0_pcie_cfg_fc [get_bd_intf_ports pcie_cfg_fc] [get_bd_intf_pins pcie_versal_0/pcie_cfg_fc]
  connect_bd_intf_net -intf_net pcie_versal_0_pcie_cfg_mesg_rcvd [get_bd_intf_ports pcie_cfg_mesg_rcvd] [get_bd_intf_pins pcie_versal_0/pcie_cfg_mesg_rcvd]
  connect_bd_intf_net -intf_net pcie_versal_0_pcie_cfg_mesg_tx [get_bd_intf_ports pcie_cfg_mesg_tx] [get_bd_intf_pins pcie_versal_0/pcie_cfg_mesg_tx]
  connect_bd_intf_net -intf_net pcie_versal_0_pcie_cfg_status [get_bd_intf_ports pcie_cfg_status] [get_bd_intf_pins pcie_versal_0/pcie_cfg_status]
  connect_bd_intf_net -intf_net pcie_versal_0_pcie_transmit_fc [get_bd_intf_ports pcie_transmit_fc] [get_bd_intf_pins pcie_versal_0/pcie_transmit_fc]
  connect_bd_intf_net -intf_net pcie_versal_0_phy_mac_rx [get_bd_intf_pins pcie_phy/phy_mac_rx] [get_bd_intf_pins pcie_versal_0/phy_mac_rx]
  connect_bd_intf_net -intf_net pcie_versal_0_phy_mac_tx [get_bd_intf_pins pcie_phy/phy_mac_tx] [get_bd_intf_pins pcie_versal_0/phy_mac_tx]
  connect_bd_intf_net -intf_net pipe_rp_1 [get_bd_intf_ports pipe_rp] [get_bd_intf_pins pcie_versal_0/pcie_ext_pipe_rp]
  connect_bd_intf_net -intf_net s_axis_cc_1 [get_bd_intf_ports s_axis_cc] [get_bd_intf_pins pcie_versal_0/s_axis_cc]
  connect_bd_intf_net -intf_net s_axis_rq_1 [get_bd_intf_ports s_axis_rq] [get_bd_intf_pins pcie_versal_0/s_axis_rq]

  # Create port connections
  connect_bd_net -net bufg_gt_sysclk_BUFG_GT_O [get_bd_pins bufg_gt_sysclk/BUFG_GT_O] [get_bd_pins gt_quad_0/apb3clk] [get_bd_pins gt_quad_1/apb3clk] [get_bd_pins pcie_phy/phy_refclk] [get_bd_pins pcie_versal_0/sys_clk]
  connect_bd_net -net const_1b1_dout [get_bd_pins bufg_gt_sysclk/BUFG_GT_CE] [get_bd_pins const_1b1/dout]
  connect_bd_net -net gt_quad_0_ch0_phyready [get_bd_pins gt_quad_0/ch0_phyready] [get_bd_pins pcie_phy/ch0_phyready]
  connect_bd_net -net gt_quad_0_ch0_phystatus [get_bd_pins gt_quad_0/ch0_phystatus] [get_bd_pins pcie_phy/ch0_phystatus]
  connect_bd_net -net gt_quad_0_ch0_rxoutclk [get_bd_pins gt_quad_0/ch0_rxoutclk] [get_bd_pins pcie_phy/gt_rxoutclk]
  connect_bd_net -net gt_quad_0_ch0_txoutclk [get_bd_pins gt_quad_0/ch0_txoutclk] [get_bd_pins pcie_phy/gt_txoutclk]
  connect_bd_net -net gt_quad_0_ch1_phyready [get_bd_pins gt_quad_0/ch1_phyready] [get_bd_pins pcie_phy/ch1_phyready]
  connect_bd_net -net gt_quad_0_ch1_phystatus [get_bd_pins gt_quad_0/ch1_phystatus] [get_bd_pins pcie_phy/ch1_phystatus]
  connect_bd_net -net gt_quad_0_ch2_phyready [get_bd_pins gt_quad_0/ch2_phyready] [get_bd_pins pcie_phy/ch2_phyready]
  connect_bd_net -net gt_quad_0_ch2_phystatus [get_bd_pins gt_quad_0/ch2_phystatus] [get_bd_pins pcie_phy/ch2_phystatus]
  connect_bd_net -net gt_quad_0_ch3_phyready [get_bd_pins gt_quad_0/ch3_phyready] [get_bd_pins pcie_phy/ch3_phyready]
  connect_bd_net -net gt_quad_0_ch3_phystatus [get_bd_pins gt_quad_0/ch3_phystatus] [get_bd_pins pcie_phy/ch3_phystatus]
  connect_bd_net -net gt_quad_1_ch0_phyready [get_bd_pins gt_quad_1/ch0_phyready] [get_bd_pins pcie_phy/ch4_phyready]
  connect_bd_net -net gt_quad_1_ch0_phystatus [get_bd_pins gt_quad_1/ch0_phystatus] [get_bd_pins pcie_phy/ch4_phystatus]
  connect_bd_net -net gt_quad_1_ch1_phyready [get_bd_pins gt_quad_1/ch1_phyready] [get_bd_pins pcie_phy/ch5_phyready]
  connect_bd_net -net gt_quad_1_ch1_phystatus [get_bd_pins gt_quad_1/ch1_phystatus] [get_bd_pins pcie_phy/ch5_phystatus]
  connect_bd_net -net gt_quad_1_ch2_phyready [get_bd_pins gt_quad_1/ch2_phyready] [get_bd_pins pcie_phy/ch6_phyready]
  connect_bd_net -net gt_quad_1_ch2_phystatus [get_bd_pins gt_quad_1/ch2_phystatus] [get_bd_pins pcie_phy/ch6_phystatus]
  connect_bd_net -net gt_quad_1_ch3_phyready [get_bd_pins gt_quad_1/ch3_phyready] [get_bd_pins pcie_phy/ch7_phyready]
  connect_bd_net -net gt_quad_1_ch3_phystatus [get_bd_pins gt_quad_1/ch3_phystatus] [get_bd_pins pcie_phy/ch7_phystatus]
  connect_bd_net -net pcie_phy_gt_pcieltssm [get_bd_pins gt_quad_0/pcieltssm] [get_bd_pins gt_quad_1/pcieltssm] [get_bd_pins pcie_phy/gt_pcieltssm]
  connect_bd_net -net pcie_phy_gtrefclk [get_bd_pins gt_quad_0/GT_REFCLK0] [get_bd_pins gt_quad_1/GT_REFCLK0] [get_bd_pins pcie_phy/gtrefclk]
  connect_bd_net -net pcie_phy_pcierstb [get_bd_pins gt_quad_0/ch0_pcierstb] [get_bd_pins gt_quad_0/ch1_pcierstb] [get_bd_pins gt_quad_0/ch2_pcierstb] [get_bd_pins gt_quad_0/ch3_pcierstb] [get_bd_pins gt_quad_1/ch0_pcierstb] [get_bd_pins gt_quad_1/ch1_pcierstb] [get_bd_pins gt_quad_1/ch2_pcierstb] [get_bd_pins gt_quad_1/ch3_pcierstb] [get_bd_pins pcie_phy/pcierstb]
  connect_bd_net -net pcie_phy_phy_coreclk [get_bd_pins pcie_phy/phy_coreclk] [get_bd_pins pcie_versal_0/phy_coreclk]
  connect_bd_net -net pcie_phy_phy_mcapclk [get_bd_pins pcie_phy/phy_mcapclk] [get_bd_pins pcie_versal_0/phy_mcapclk]
  connect_bd_net -net pcie_phy_phy_pclk [get_bd_pins gt_quad_0/ch0_rxusrclk] [get_bd_pins gt_quad_0/ch0_txusrclk] [get_bd_pins gt_quad_0/ch1_rxusrclk] [get_bd_pins gt_quad_0/ch1_txusrclk] [get_bd_pins gt_quad_0/ch2_rxusrclk] [get_bd_pins gt_quad_0/ch2_txusrclk] [get_bd_pins gt_quad_0/ch3_rxusrclk] [get_bd_pins gt_quad_0/ch3_txusrclk] [get_bd_pins gt_quad_1/ch0_rxusrclk] [get_bd_pins gt_quad_1/ch0_txusrclk] [get_bd_pins gt_quad_1/ch1_rxusrclk] [get_bd_pins gt_quad_1/ch1_txusrclk] [get_bd_pins gt_quad_1/ch2_rxusrclk] [get_bd_pins gt_quad_1/ch2_txusrclk] [get_bd_pins gt_quad_1/ch3_rxusrclk] [get_bd_pins gt_quad_1/ch3_txusrclk] [get_bd_pins pcie_phy/phy_pclk] [get_bd_pins pcie_versal_0/phy_pclk]
  connect_bd_net -net pcie_phy_phy_userclk [get_bd_pins pcie_phy/phy_userclk] [get_bd_pins pcie_versal_0/phy_userclk]
  connect_bd_net -net pcie_phy_phy_userclk2 [get_bd_pins pcie_phy/phy_userclk2] [get_bd_pins pcie_versal_0/phy_userclk2]
  connect_bd_net -net pcie_versal_0_core_clk [get_bd_ports core_clk] [get_bd_pins pcie_versal_0/core_clk]
  connect_bd_net -net pcie_versal_0_pcie_ltssm_state [get_bd_pins pcie_phy/pcie_ltssm_state] [get_bd_pins pcie_versal_0/pcie_ltssm_state]
  connect_bd_net -net pcie_versal_0_phy_rdy_out [get_bd_ports phy_rdy_out] [get_bd_pins pcie_versal_0/phy_rdy_out]
  connect_bd_net -net pcie_versal_0_user_clk [get_bd_ports user_clk] [get_bd_pins pcie_versal_0/user_clk]
  connect_bd_net -net pcie_versal_0_user_lnk_up [get_bd_ports user_lnk_up] [get_bd_pins pcie_versal_0/user_lnk_up]
  connect_bd_net -net pcie_versal_0_user_reset [get_bd_ports user_reset] [get_bd_pins pcie_versal_0/user_reset]
  connect_bd_net -net refclk_ibuf_IBUF_DS_ODIV2 [get_bd_pins bufg_gt_sysclk/BUFG_GT_I] [get_bd_pins refclk_ibuf/IBUF_DS_ODIV2]
  connect_bd_net -net refclk_ibuf_IBUF_OUT [get_bd_pins pcie_phy/phy_gtrefclk] [get_bd_pins pcie_versal_0/sys_clk_gt] [get_bd_pins refclk_ibuf/IBUF_OUT]
  connect_bd_net -net sys_reset_1 [get_bd_ports sys_reset] [get_bd_pins pcie_phy/phy_rst_n] [get_bd_pins pcie_versal_0/sys_reset]

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


