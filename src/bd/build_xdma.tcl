
################################################################
# This is a generated script based on design: dma_ep
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
set design_name xdma_endpoint

# If you do not already have an existing IP Integrator design open,
# you can create a design using the following command:
#    create_bd_design $design_name

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
xilinx.com:ip:versal_cips:*\
xilinx.com:ip:xdma:*\
xilinx.com:ip:util_ds_buf:*\
xilinx.com:ip:xlconstant:*\
xilinx.com:ip:gt_quad_base:*\
xilinx.com:ip:pcie_versal:*\
xilinx.com:ip:pcie_phy_versal:*\
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


# Hierarchical cell: xdma_2_support
proc create_hier_cell_xdma_2_support { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_xdma_2_support() - Empty argument(s)!"}
     return
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

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis_cq

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis_rc

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:pcie4_cfg_control_rtl:1.0 pcie_cfg_control

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:pcie_cfg_fc_rtl:1.1 pcie_cfg_fc

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:pcie3_cfg_interrupt_rtl:1.0 pcie_cfg_interrupt

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:pcie3_cfg_msg_received_rtl:1.0 pcie_cfg_mesg_rcvd

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:pcie3_cfg_mesg_tx_rtl:1.0 pcie_cfg_mesg_tx

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:pcie4_cfg_mgmt_rtl:1.0 pcie_cfg_mgmt

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:pcie3_cfg_msi_rtl:1.0 pcie_cfg_msi

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:pcie4_cfg_status_rtl:1.0 pcie_cfg_status

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:gt_rtl:1.0 pcie_mgt

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:diff_clock_rtl:1.0 pcie_refclk

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:pcie3_transmit_fc_rtl:1.0 pcie_transmit_fc

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:pcie_ext_pipe_rtl:1.0 pipe_ep

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_cc

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_rq


  # Create pins
  create_bd_pin -dir O phy_rdy_out
  create_bd_pin -dir I -type rst sys_reset
  create_bd_pin -dir O -type clk user_clk
  create_bd_pin -dir O user_lnk_up
  create_bd_pin -dir O -type rst user_reset

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

  # Create instance: pcie, and set properties
  set pcie [ create_bd_cell -type ip -vlnv xilinx.com:ip:pcie_versal pcie ]
  set_property -dict [ list \
   CONFIG.AXISTEN_IF_CQ_ALIGNMENT_MODE {Address_Aligned} \
   CONFIG.AXISTEN_IF_RQ_ALIGNMENT_MODE {DWORD_Aligned} \
   CONFIG.MSI_X_OPTIONS {MSI-X_External} \
   CONFIG.PF0_CLASS_CODE {070001} \
   CONFIG.PF0_DEVICE_ID {B048} \
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
   CONFIG.PF1_CLASS_CODE {070001} \
   CONFIG.PF1_DEVICE_ID {1041} \
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
   CONFIG.PF2_CLASS_CODE {058000} \
   CONFIG.PF2_DEVICE_ID {1040} \
   CONFIG.PF2_INTERRUPT_PIN {NONE} \
   CONFIG.PF2_MSI_CAP_MULTIMSGCAP {1_vector} \
   CONFIG.PF2_REVISION_ID {00} \
   CONFIG.PF2_SRIOV_VF_DEVICE_ID {C248} \
   CONFIG.PF2_SUBSYSTEM_ID {0007} \
   CONFIG.PF2_SUBSYSTEM_VENDOR_ID {10EE} \
   CONFIG.PF2_Use_Class_Code_Lookup_Assistant {false} \
   CONFIG.PF3_CLASS_CODE {058000} \
   CONFIG.PF3_DEVICE_ID {1039} \
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
   CONFIG.axisten_if_enable_client_tag {true} \
   CONFIG.axisten_if_enable_msg_route_override {TRUE} \
   CONFIG.axisten_if_width {512_bit} \
   CONFIG.cfg_mgmt_if {true} \
   CONFIG.copy_pf0 {false} \
   CONFIG.coreclk_freq {500} \
   CONFIG.dedicate_perst {false} \
   CONFIG.device_port_type {PCI_Express_Endpoint_device} \
   CONFIG.en_dbg_descramble {false} \
   CONFIG.en_ext_clk {FALSE} \
   CONFIG.en_l23_entry {false} \
   CONFIG.en_parity {false} \
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
   CONFIG.legacy_ext_pcie_cfg_space_enabled {false} \
   CONFIG.mcap_enablement {None} \
   CONFIG.mode_selection {Advanced} \
   CONFIG.pcie_blk_locn {X1Y2} \
   CONFIG.pcie_link_debug {false} \
   CONFIG.pcie_link_debug_axi4_st {false} \
   CONFIG.pf0_ari_enabled {false} \
   CONFIG.pf0_bar0_64bit {false} \
   CONFIG.pf0_bar0_enabled {true} \
   CONFIG.pf0_bar0_prefetchable {false} \
   CONFIG.pf0_bar0_scale {Kilobytes} \
   CONFIG.pf0_bar0_size {64} \
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
   CONFIG.pf0_base_class_menu {Simple_communication_controllers} \
   CONFIG.pf0_class_code_base {07} \
   CONFIG.pf0_class_code_interface {01} \
   CONFIG.pf0_class_code_sub {00} \
   CONFIG.pf0_expansion_rom_enabled {false} \
   CONFIG.pf0_expansion_rom_scale {Kilobytes} \
   CONFIG.pf0_expansion_rom_size {1} \
   CONFIG.pf0_expansion_rom_type {Expansion_ROM} \
   CONFIG.pf0_msi_enabled {true} \
   CONFIG.pf0_msix_enabled {false} \
   CONFIG.pf0_sub_class_interface_menu {16450_compatible_serial_controller} \
   CONFIG.pf1_bar0_64bit {false} \
   CONFIG.pf1_bar0_enabled {true} \
   CONFIG.pf1_bar0_prefetchable {false} \
   CONFIG.pf1_bar0_scale {Megabytes} \
   CONFIG.pf1_bar0_size {32} \
   CONFIG.pf1_bar1_64bit {false} \
   CONFIG.pf1_bar1_enabled {true} \
   CONFIG.pf1_bar1_prefetchable {false} \
   CONFIG.pf1_bar1_scale {Kilobytes} \
   CONFIG.pf1_bar1_size {128} \
   CONFIG.pf1_bar2_64bit {true} \
   CONFIG.pf1_bar2_enabled {true} \
   CONFIG.pf1_bar2_prefetchable {false} \
   CONFIG.pf1_bar2_scale {Kilobytes} \
   CONFIG.pf1_bar2_size {128} \
   CONFIG.pf1_bar3_64bit {false} \
   CONFIG.pf1_bar3_enabled {false} \
   CONFIG.pf1_bar3_prefetchable {false} \
   CONFIG.pf1_bar3_scale {Kilobytes} \
   CONFIG.pf1_bar3_size {128} \
   CONFIG.pf1_bar4_64bit {true} \
   CONFIG.pf1_bar4_enabled {true} \
   CONFIG.pf1_bar4_prefetchable {false} \
   CONFIG.pf1_bar4_scale {Kilobytes} \
   CONFIG.pf1_bar4_size {128} \
   CONFIG.pf1_bar5_enabled {false} \
   CONFIG.pf1_bar5_prefetchable {false} \
   CONFIG.pf1_bar5_scale {Kilobytes} \
   CONFIG.pf1_bar5_size {128} \
   CONFIG.pf1_base_class_menu {Simple_communication_controllers} \
   CONFIG.pf1_class_code_base {07} \
   CONFIG.pf1_class_code_interface {01} \
   CONFIG.pf1_class_code_sub {00} \
   CONFIG.pf1_expansion_rom_enabled {false} \
   CONFIG.pf1_expansion_rom_scale {Kilobytes} \
   CONFIG.pf1_expansion_rom_size {1} \
   CONFIG.pf1_expansion_rom_type {Expansion_ROM} \
   CONFIG.pf1_msi_enabled {false} \
   CONFIG.pf1_msix_enabled {false} \
   CONFIG.pf1_sub_class_interface_menu {16450_compatible_serial_controller} \
   CONFIG.pf1_vendor_id {10EE} \
   CONFIG.pf2_bar0_64bit {false} \
   CONFIG.pf2_bar0_enabled {true} \
   CONFIG.pf2_bar0_prefetchable {false} \
   CONFIG.pf2_bar0_scale {Kilobytes} \
   CONFIG.pf2_bar0_size {128} \
   CONFIG.pf2_bar1_64bit {false} \
   CONFIG.pf2_bar1_enabled {true} \
   CONFIG.pf2_bar1_prefetchable {false} \
   CONFIG.pf2_bar1_scale {Kilobytes} \
   CONFIG.pf2_bar1_size {128} \
   CONFIG.pf2_bar2_64bit {false} \
   CONFIG.pf2_bar2_enabled {true} \
   CONFIG.pf2_bar2_prefetchable {false} \
   CONFIG.pf2_bar2_scale {Kilobytes} \
   CONFIG.pf2_bar2_size {128} \
   CONFIG.pf2_bar3_64bit {false} \
   CONFIG.pf2_bar3_enabled {true} \
   CONFIG.pf2_bar3_prefetchable {false} \
   CONFIG.pf2_bar3_scale {Kilobytes} \
   CONFIG.pf2_bar3_size {128} \
   CONFIG.pf2_bar4_64bit {false} \
   CONFIG.pf2_bar4_enabled {true} \
   CONFIG.pf2_bar4_prefetchable {false} \
   CONFIG.pf2_bar4_scale {Kilobytes} \
   CONFIG.pf2_bar4_size {128} \
   CONFIG.pf2_bar5_enabled {true} \
   CONFIG.pf2_bar5_prefetchable {false} \
   CONFIG.pf2_bar5_scale {Kilobytes} \
   CONFIG.pf2_bar5_size {128} \
   CONFIG.pf2_base_class_menu {Memory_controller} \
   CONFIG.pf2_class_code_base {05} \
   CONFIG.pf2_class_code_interface {00} \
   CONFIG.pf2_class_code_sub {80} \
   CONFIG.pf2_expansion_rom_enabled {false} \
   CONFIG.pf2_expansion_rom_scale {Kilobytes} \
   CONFIG.pf2_expansion_rom_size {1} \
   CONFIG.pf2_expansion_rom_type {Expansion_ROM} \
   CONFIG.pf2_msi_enabled {false} \
   CONFIG.pf2_sub_class_interface_menu {Other_memory_controller} \
   CONFIG.pf3_bar0_64bit {false} \
   CONFIG.pf3_bar0_enabled {true} \
   CONFIG.pf3_bar0_prefetchable {false} \
   CONFIG.pf3_bar0_scale {Kilobytes} \
   CONFIG.pf3_bar0_size {128} \
   CONFIG.pf3_bar1_64bit {false} \
   CONFIG.pf3_bar1_enabled {true} \
   CONFIG.pf3_bar1_prefetchable {false} \
   CONFIG.pf3_bar1_scale {Kilobytes} \
   CONFIG.pf3_bar1_size {128} \
   CONFIG.pf3_bar2_64bit {false} \
   CONFIG.pf3_bar2_enabled {true} \
   CONFIG.pf3_bar2_prefetchable {false} \
   CONFIG.pf3_bar2_scale {Kilobytes} \
   CONFIG.pf3_bar2_size {128} \
   CONFIG.pf3_bar3_64bit {false} \
   CONFIG.pf3_bar3_enabled {true} \
   CONFIG.pf3_bar3_prefetchable {false} \
   CONFIG.pf3_bar3_scale {Kilobytes} \
   CONFIG.pf3_bar3_size {128} \
   CONFIG.pf3_bar4_64bit {false} \
   CONFIG.pf3_bar4_enabled {true} \
   CONFIG.pf3_bar4_prefetchable {false} \
   CONFIG.pf3_bar4_scale {Kilobytes} \
   CONFIG.pf3_bar4_size {128} \
   CONFIG.pf3_bar5_enabled {true} \
   CONFIG.pf3_bar5_prefetchable {false} \
   CONFIG.pf3_bar5_scale {Kilobytes} \
   CONFIG.pf3_bar5_size {128} \
   CONFIG.pf3_base_class_menu {Memory_controller} \
   CONFIG.pf3_class_code_base {05} \
   CONFIG.pf3_class_code_interface {00} \
   CONFIG.pf3_class_code_sub {80} \
   CONFIG.pf3_expansion_rom_enabled {false} \
   CONFIG.pf3_expansion_rom_scale {Kilobytes} \
   CONFIG.pf3_expansion_rom_size {1} \
   CONFIG.pf3_expansion_rom_type {Expansion_ROM} \
   CONFIG.pf3_msi_enabled {false} \
   CONFIG.pf3_sub_class_interface_menu {Other_memory_controller} \
   CONFIG.pipe_sim {true} \
   CONFIG.sys_reset_polarity {ACTIVE_LOW} \
   CONFIG.vendor_id {10EE} \
   CONFIG.xlnx_ref_board {None} \
 ] $pcie

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
   CONFIG.sim_model {NO} \
   CONFIG.tx_preset {4} \
 ] $pcie_phy

  # Create instance: refclk_ibuf, and set properties
  set refclk_ibuf [ create_bd_cell -type ip -vlnv xilinx.com:ip:util_ds_buf refclk_ibuf ]
  set_property -dict [ list \
   CONFIG.C_BUF_TYPE {IBUFDSGTE} \
 ] $refclk_ibuf

  # Create interface connections
  connect_bd_intf_net -intf_net Conn1 [get_bd_intf_pins pcie_refclk] [get_bd_intf_pins refclk_ibuf/CLK_IN_D]
  connect_bd_intf_net -intf_net Conn2 [get_bd_intf_pins pcie_mgt] [get_bd_intf_pins pcie_phy/pcie_mgt]
  connect_bd_intf_net -intf_net Conn3 [get_bd_intf_pins m_axis_cq] [get_bd_intf_pins pcie/m_axis_cq]
  connect_bd_intf_net -intf_net Conn4 [get_bd_intf_pins m_axis_rc] [get_bd_intf_pins pcie/m_axis_rc]
  connect_bd_intf_net -intf_net Conn5 [get_bd_intf_pins pcie_cfg_control] [get_bd_intf_pins pcie/pcie_cfg_control]
  connect_bd_intf_net -intf_net Conn6 [get_bd_intf_pins pcie_cfg_interrupt] [get_bd_intf_pins pcie/pcie_cfg_interrupt]
  connect_bd_intf_net -intf_net Conn7 [get_bd_intf_pins pcie_cfg_mesg_rcvd] [get_bd_intf_pins pcie/pcie_cfg_mesg_rcvd]
  connect_bd_intf_net -intf_net Conn8 [get_bd_intf_pins pcie_cfg_mesg_tx] [get_bd_intf_pins pcie/pcie_cfg_mesg_tx]
  connect_bd_intf_net -intf_net Conn9 [get_bd_intf_pins pcie_cfg_msi] [get_bd_intf_pins pcie/pcie_cfg_msi]
  connect_bd_intf_net -intf_net Conn10 [get_bd_intf_pins pcie_cfg_status] [get_bd_intf_pins pcie/pcie_cfg_status]
  connect_bd_intf_net -intf_net Conn11 [get_bd_intf_pins pcie_cfg_fc] [get_bd_intf_pins pcie/pcie_cfg_fc]
  connect_bd_intf_net -intf_net Conn12 [get_bd_intf_pins pcie_cfg_mgmt] [get_bd_intf_pins pcie/pcie_cfg_mgmt]
  connect_bd_intf_net -intf_net Conn13 [get_bd_intf_pins pcie_transmit_fc] [get_bd_intf_pins pcie/pcie_transmit_fc]
  connect_bd_intf_net -intf_net Conn14 [get_bd_intf_pins s_axis_cc] [get_bd_intf_pins pcie/s_axis_cc]
  connect_bd_intf_net -intf_net Conn15 [get_bd_intf_pins s_axis_rq] [get_bd_intf_pins pcie/s_axis_rq]
  connect_bd_intf_net -intf_net Conn16 [get_bd_intf_pins pipe_ep] [get_bd_intf_pins pcie/pcie_ext_pipe_ep]
  connect_bd_intf_net -intf_net gt_quad_0_GT0_BUFGT [get_bd_intf_pins gt_quad_0/GT0_BUFGT] [get_bd_intf_pins pcie_phy/GT_BUFGT]
  connect_bd_intf_net -intf_net gt_quad_0_GT_Serial [get_bd_intf_pins gt_quad_0/GT_Serial] [get_bd_intf_pins pcie_phy/GT0_Serial]
  connect_bd_intf_net -intf_net gt_quad_1_GT_NORTHIN_SOUTHOUT [get_bd_intf_pins gt_quad_0/GT_NORTHOUT_SOUTHIN] [get_bd_intf_pins gt_quad_1/GT_NORTHIN_SOUTHOUT]
  connect_bd_intf_net -intf_net gt_quad_1_GT_Serial [get_bd_intf_pins gt_quad_1/GT_Serial] [get_bd_intf_pins pcie_phy/GT1_Serial]
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
  connect_bd_intf_net -intf_net pcie_phy_mac_rx [get_bd_intf_pins pcie/phy_mac_rx] [get_bd_intf_pins pcie_phy/phy_mac_rx]
  connect_bd_intf_net -intf_net pcie_phy_mac_tx [get_bd_intf_pins pcie/phy_mac_tx] [get_bd_intf_pins pcie_phy/phy_mac_tx]
  connect_bd_intf_net -intf_net pcie_phy_phy_mac_command [get_bd_intf_pins pcie/phy_mac_command] [get_bd_intf_pins pcie_phy/phy_mac_command]
  connect_bd_intf_net -intf_net pcie_phy_phy_mac_rx_margining [get_bd_intf_pins pcie/phy_mac_rx_margining] [get_bd_intf_pins pcie_phy/phy_mac_rx_margining]
  connect_bd_intf_net -intf_net pcie_phy_phy_mac_status [get_bd_intf_pins pcie/phy_mac_status] [get_bd_intf_pins pcie_phy/phy_mac_status]
  connect_bd_intf_net -intf_net pcie_phy_phy_mac_tx_drive [get_bd_intf_pins pcie/phy_mac_tx_drive] [get_bd_intf_pins pcie_phy/phy_mac_tx_drive]
  connect_bd_intf_net -intf_net pcie_phy_phy_mac_tx_eq [get_bd_intf_pins pcie/phy_mac_tx_eq] [get_bd_intf_pins pcie_phy/phy_mac_tx_eq]

  # Create port connections
  connect_bd_net -net bufg_gt_sysclk_BUFG_GT_O [get_bd_pins bufg_gt_sysclk/BUFG_GT_O] [get_bd_pins gt_quad_0/apb3clk] [get_bd_pins gt_quad_1/apb3clk] [get_bd_pins pcie/sys_clk] [get_bd_pins pcie_phy/phy_refclk]
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
  connect_bd_net -net pcie_pcie_ltssm_state [get_bd_pins pcie/pcie_ltssm_state] [get_bd_pins pcie_phy/pcie_ltssm_state]
  connect_bd_net -net pcie_phy_gt_pcieltssm [get_bd_pins gt_quad_0/pcieltssm] [get_bd_pins gt_quad_1/pcieltssm] [get_bd_pins pcie_phy/gt_pcieltssm]
  connect_bd_net -net pcie_phy_gtrefclk [get_bd_pins gt_quad_0/GT_REFCLK0] [get_bd_pins gt_quad_1/GT_REFCLK0] [get_bd_pins pcie_phy/gtrefclk]
  connect_bd_net -net pcie_phy_pcierstb [get_bd_pins gt_quad_0/ch0_pcierstb] [get_bd_pins gt_quad_0/ch1_pcierstb] [get_bd_pins gt_quad_0/ch2_pcierstb] [get_bd_pins gt_quad_0/ch3_pcierstb] [get_bd_pins gt_quad_1/ch0_pcierstb] [get_bd_pins gt_quad_1/ch1_pcierstb] [get_bd_pins gt_quad_1/ch2_pcierstb] [get_bd_pins gt_quad_1/ch3_pcierstb] [get_bd_pins pcie_phy/pcierstb]
  connect_bd_net -net pcie_phy_phy_coreclk [get_bd_pins pcie/phy_coreclk] [get_bd_pins pcie_phy/phy_coreclk]
  connect_bd_net -net pcie_phy_phy_mcapclk [get_bd_pins pcie/phy_mcapclk] [get_bd_pins pcie_phy/phy_mcapclk]
  connect_bd_net -net pcie_phy_phy_pclk [get_bd_pins gt_quad_0/ch0_rxusrclk] [get_bd_pins gt_quad_0/ch0_txusrclk] [get_bd_pins gt_quad_0/ch1_rxusrclk] [get_bd_pins gt_quad_0/ch1_txusrclk] [get_bd_pins gt_quad_0/ch2_rxusrclk] [get_bd_pins gt_quad_0/ch2_txusrclk] [get_bd_pins gt_quad_0/ch3_rxusrclk] [get_bd_pins gt_quad_0/ch3_txusrclk] [get_bd_pins gt_quad_1/ch0_rxusrclk] [get_bd_pins gt_quad_1/ch0_txusrclk] [get_bd_pins gt_quad_1/ch1_rxusrclk] [get_bd_pins gt_quad_1/ch1_txusrclk] [get_bd_pins gt_quad_1/ch2_rxusrclk] [get_bd_pins gt_quad_1/ch2_txusrclk] [get_bd_pins gt_quad_1/ch3_rxusrclk] [get_bd_pins gt_quad_1/ch3_txusrclk] [get_bd_pins pcie/phy_pclk] [get_bd_pins pcie_phy/phy_pclk]
  connect_bd_net -net pcie_phy_phy_userclk [get_bd_pins pcie/phy_userclk] [get_bd_pins pcie_phy/phy_userclk]
  connect_bd_net -net pcie_phy_phy_userclk2 [get_bd_pins pcie/phy_userclk2] [get_bd_pins pcie_phy/phy_userclk2]
  connect_bd_net -net pcie_phy_rdy_out [get_bd_pins phy_rdy_out] [get_bd_pins pcie/phy_rdy_out]
  connect_bd_net -net pcie_user_clk [get_bd_pins user_clk] [get_bd_pins pcie/user_clk]
  connect_bd_net -net pcie_user_lnk_up [get_bd_pins user_lnk_up] [get_bd_pins pcie/user_lnk_up]
  connect_bd_net -net pcie_user_reset [get_bd_pins user_reset] [get_bd_pins pcie/user_reset]
  connect_bd_net -net refclk_ibuf_IBUF_DS_ODIV2 [get_bd_pins bufg_gt_sysclk/BUFG_GT_I] [get_bd_pins refclk_ibuf/IBUF_DS_ODIV2]
  connect_bd_net -net refclk_ibuf_IBUF_OUT [get_bd_pins pcie/sys_clk_gt] [get_bd_pins pcie_phy/phy_gtrefclk] [get_bd_pins refclk_ibuf/IBUF_OUT]
  connect_bd_net -net sys_reset_1 [get_bd_pins sys_reset] [get_bd_pins pcie/sys_reset] [get_bd_pins pcie_phy/phy_rst_n]

  # Restore current instance
  current_bd_instance $oldCurInst
}


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
  set M_AXIS_H2C_0 [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 M_AXIS_H2C_0 ]
  set_property -dict [ list \
   CONFIG.FREQ_HZ {250000000} \
   ] $M_AXIS_H2C_0

  set S_AXIS_C2H_0 [ create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 S_AXIS_C2H_0 ]
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
   CONFIG.TUSER_WIDTH {0} \
   ] $S_AXIS_C2H_0

  set pcie_mgt [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:gt_rtl:1.0 pcie_mgt ]

  set pcie_refclk [ create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:diff_clock_rtl:1.0 pcie_refclk ]

  set pipe_ep [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:pcie_ext_pipe_rtl:1.0 pipe_ep ]


  # Create ports
  set axi_aclk [ create_bd_port -dir O -type clk axi_aclk ]
  set_property -dict [ list \
   CONFIG.ASSOCIATED_BUSIF {M_AXIS_H2C_0:S_AXIS_C2H_0} \
   CONFIG.FREQ_HZ {250000000} \
 ] $axi_aclk
  set_property CONFIG.ASSOCIATED_BUSIF.VALUE_SRC DEFAULT $axi_aclk

  set axi_aresetn [ create_bd_port -dir O -type rst axi_aresetn ]
  set phy_rdy_out [ create_bd_port -dir O phy_rdy_out ]
  set sys_reset [ create_bd_port -dir I -type rst sys_reset ]
  set user_lnk_up [ create_bd_port -dir O user_lnk_up ]
  set usr_irq_ack [ create_bd_port -dir O -from 0 -to 0 usr_irq_ack ]
  set usr_irq_req [ create_bd_port -dir I -from 0 -to 0 usr_irq_req ]

  # Create instance: cips_0, and set properties
  set cips_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:versal_cips cips_0 ]

  # Create instance: xdma_2, and set properties
  set xdma_2 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xdma xdma_2 ]
  set_property -dict [ list \
   CONFIG.BASEADDR {0x00001000} \
   CONFIG.HIGHADDR {0x00001FFF} \
   CONFIG.INS_LOSS_NYQ {15} \
   CONFIG.MSI_X_OPTIONS {MSI-X_External} \
   CONFIG.PCIE_BOARD_INTERFACE {Custom} \
   CONFIG.PF0_DEVICE_ID_mqdma {B048} \
   CONFIG.PF0_MSIX_CAP_PBA_BIR_mqdma {BAR_0} \
   CONFIG.PF0_MSIX_CAP_PBA_OFFSET_mqdma {00000050} \
   CONFIG.PF0_MSIX_CAP_TABLE_BIR_mqdma {BAR_0} \
   CONFIG.PF0_MSIX_CAP_TABLE_OFFSET_mqdma {00000040} \
   CONFIG.PF0_MSIX_CAP_TABLE_SIZE_mqdma {001} \
   CONFIG.PF0_REVISION_ID_mqdma {00} \
   CONFIG.PF0_SRIOV_CAP_INITIAL_VF {0} \
   CONFIG.PF0_SRIOV_FIRST_VF_OFFSET {0} \
   CONFIG.PF0_SRIOV_FUNC_DEP_LINK {0000} \
   CONFIG.PF0_SRIOV_SUPPORTED_PAGE_SIZE {00000553} \
   CONFIG.PF0_SRIOV_VF_DEVICE_ID {C048} \
   CONFIG.PF0_SUBSYSTEM_ID_mqdma {0007} \
   CONFIG.PF0_SUBSYSTEM_VENDOR_ID_mqdma {10EE} \
   CONFIG.PF1_DEVICE_ID_mqdma {0007} \
   CONFIG.PF1_INTERRUPT_PIN {NONE} \
   CONFIG.PF1_MSIX_CAP_PBA_BIR_mqdma {BAR_0} \
   CONFIG.PF1_MSIX_CAP_PBA_OFFSET_mqdma {00000000} \
   CONFIG.PF1_MSIX_CAP_TABLE_BIR_mqdma {BAR_0} \
   CONFIG.PF1_MSIX_CAP_TABLE_OFFSET_mqdma {00000000} \
   CONFIG.PF1_MSIX_CAP_TABLE_SIZE_mqdma {000} \
   CONFIG.PF1_MSI_CAP_MULTIMSGCAP {1_vector} \
   CONFIG.PF1_REVISION_ID {00} \
   CONFIG.PF1_REVISION_ID_mqdma {00} \
   CONFIG.PF1_SRIOV_CAP_INITIAL_VF {0} \
   CONFIG.PF1_SRIOV_CAP_VER {1} \
   CONFIG.PF1_SRIOV_FIRST_VF_OFFSET {0} \
   CONFIG.PF1_SRIOV_FUNC_DEP_LINK {0001} \
   CONFIG.PF1_SRIOV_SUPPORTED_PAGE_SIZE {00000553} \
   CONFIG.PF1_SRIOV_VF_DEVICE_ID {C148} \
   CONFIG.PF1_SUBSYSTEM_ID {0007} \
   CONFIG.PF1_SUBSYSTEM_ID_mqdma {0007} \
   CONFIG.PF1_SUBSYSTEM_VENDOR_ID {10EE} \
   CONFIG.PF1_SUBSYSTEM_VENDOR_ID_mqdma {10EE} \
   CONFIG.PF1_Use_Class_Code_Lookup_Assistant {false} \
   CONFIG.PF2_DEVICE_ID_mqdma {B248} \
   CONFIG.PF2_INTERRUPT_PIN {NONE} \
   CONFIG.PF2_MSIX_CAP_PBA_BIR_mqdma {BAR_0} \
   CONFIG.PF2_MSIX_CAP_PBA_OFFSET_mqdma {00000000} \
   CONFIG.PF2_MSIX_CAP_TABLE_BIR_mqdma {BAR_0} \
   CONFIG.PF2_MSIX_CAP_TABLE_OFFSET_mqdma {00000000} \
   CONFIG.PF2_MSIX_CAP_TABLE_SIZE_mqdma {000} \
   CONFIG.PF2_MSI_CAP_MULTIMSGCAP {1_vector} \
   CONFIG.PF2_REVISION_ID {00} \
   CONFIG.PF2_REVISION_ID_mqdma {00} \
   CONFIG.PF2_SRIOV_CAP_INITIAL_VF {0} \
   CONFIG.PF2_SRIOV_CAP_VER {1} \
   CONFIG.PF2_SRIOV_FIRST_VF_OFFSET {0} \
   CONFIG.PF2_SRIOV_FUNC_DEP_LINK {0002} \
   CONFIG.PF2_SRIOV_SUPPORTED_PAGE_SIZE {00000553} \
   CONFIG.PF2_SRIOV_VF_DEVICE_ID {C248} \
   CONFIG.PF2_SUBSYSTEM_ID {0007} \
   CONFIG.PF2_SUBSYSTEM_ID_mqdma {0007} \
   CONFIG.PF2_SUBSYSTEM_VENDOR_ID {10EE} \
   CONFIG.PF2_SUBSYSTEM_VENDOR_ID_mqdma {10EE} \
   CONFIG.PF2_Use_Class_Code_Lookup_Assistant {false} \
   CONFIG.PF3_DEVICE_ID_mqdma {B348} \
   CONFIG.PF3_INTERRUPT_PIN {NONE} \
   CONFIG.PF3_MSIX_CAP_PBA_BIR_mqdma {BAR_0} \
   CONFIG.PF3_MSIX_CAP_PBA_OFFSET_mqdma {00000000} \
   CONFIG.PF3_MSIX_CAP_TABLE_BIR_mqdma {BAR_0} \
   CONFIG.PF3_MSIX_CAP_TABLE_OFFSET_mqdma {00000000} \
   CONFIG.PF3_MSIX_CAP_TABLE_SIZE_mqdma {000} \
   CONFIG.PF3_MSI_CAP_MULTIMSGCAP {1_vector} \
   CONFIG.PF3_REVISION_ID {00} \
   CONFIG.PF3_REVISION_ID_mqdma {00} \
   CONFIG.PF3_SRIOV_CAP_INITIAL_VF {0} \
   CONFIG.PF3_SRIOV_CAP_VER {1} \
   CONFIG.PF3_SRIOV_FIRST_VF_OFFSET {0} \
   CONFIG.PF3_SRIOV_FUNC_DEP_LINK {0003} \
   CONFIG.PF3_SRIOV_SUPPORTED_PAGE_SIZE {00000553} \
   CONFIG.PF3_SRIOV_VF_DEVICE_ID {C348} \
   CONFIG.PF3_SUBSYSTEM_ID {0007} \
   CONFIG.PF3_SUBSYSTEM_ID_mqdma {0007} \
   CONFIG.PF3_SUBSYSTEM_VENDOR_ID {10EE} \
   CONFIG.PF3_SUBSYSTEM_VENDOR_ID_mqdma {10EE} \
   CONFIG.PF3_Use_Class_Code_Lookup_Assistant {false} \
   CONFIG.PHY_LP_TXPRESET {4} \
   CONFIG.RX_PPM_OFFSET {0} \
   CONFIG.RX_SSC_PPM {0} \
   CONFIG.SRIOV_CAP_ENABLE {false} \
   CONFIG.SRIOV_FIRST_VF_OFFSET {1} \
   CONFIG.SYS_RST_N_BOARD_INTERFACE {Custom} \
   CONFIG.Shared_Logic {1} \
   CONFIG.Shared_Logic_Both {false} \
   CONFIG.Shared_Logic_Both_7xG2 {false} \
   CONFIG.Shared_Logic_Clk {false} \
   CONFIG.Shared_Logic_Clk_7xG2 {false} \
   CONFIG.Shared_Logic_Gtc {false} \
   CONFIG.Shared_Logic_Gtc_7xG2 {false} \
   CONFIG.acs_ext_cap_enable {false} \
   CONFIG.aspm_support {No_ASPM} \
   CONFIG.axi_aclk_loopback {false} \
   CONFIG.axi_addr_width {64} \
   CONFIG.axi_bypass_64bit_en {false} \
   CONFIG.axi_bypass_prefetchable {false} \
   CONFIG.axi_data_width {512_bit} \
   CONFIG.axi_id_width {4} \
   CONFIG.axi_vip_in_exdes {false} \
   CONFIG.axibar2pciebar_0 {0x0000000000000000} \
   CONFIG.axibar2pciebar_1 {0x0000000000000000} \
   CONFIG.axibar2pciebar_2 {0x0000000000000000} \
   CONFIG.axibar2pciebar_3 {0x0000000000000000} \
   CONFIG.axibar2pciebar_4 {0x0000000000000000} \
   CONFIG.axibar2pciebar_5 {0x0000000000000000} \
   CONFIG.axibar_0 {0x0000000000000000} \
   CONFIG.axibar_1 {0x0000000000000000} \
   CONFIG.axibar_2 {0x0000000000000000} \
   CONFIG.axibar_3 {0x0000000000000000} \
   CONFIG.axibar_4 {0x0000000000000000} \
   CONFIG.axibar_5 {0x0000000000000000} \
   CONFIG.axibar_highaddr_0 {0x0000000000000000} \
   CONFIG.axibar_highaddr_1 {0x0000000000000000} \
   CONFIG.axibar_highaddr_2 {0x0000000000000000} \
   CONFIG.axibar_highaddr_3 {0x0000000000000000} \
   CONFIG.axibar_highaddr_4 {0x0000000000000000} \
   CONFIG.axibar_highaddr_5 {0x0000000000000000} \
   CONFIG.axibar_num {1} \
   CONFIG.axil_master_64bit_en {false} \
   CONFIG.axil_master_prefetchable {false} \
   CONFIG.axilite_master_en {false} \
   CONFIG.axilite_master_scale {Megabytes} \
   CONFIG.axilite_master_size {1} \
   CONFIG.axis_pipe_line_stage {0} \
   CONFIG.axist_bypass_en {false} \
   CONFIG.axist_bypass_scale {Megabytes} \
   CONFIG.axist_bypass_size {1} \
   CONFIG.axisten_freq {250} \
   CONFIG.axisten_if_enable_msg_route {27FFF} \
   CONFIG.axsize_byte_access_en {false} \
   CONFIG.bar0_indicator {1} \
   CONFIG.bar1_indicator {0} \
   CONFIG.bar2_indicator {0} \
   CONFIG.bar3_indicator {0} \
   CONFIG.bar4_indicator {0} \
   CONFIG.bar5_indicator {0} \
   CONFIG.bar_indicator {BAR_0} \
   CONFIG.barlite2 {7} \
   CONFIG.bridge_burst {false} \
   CONFIG.bridge_registers_offset_enable {false} \
   CONFIG.broadcom_sbr_wa {false} \
   CONFIG.c_ats_enable {false} \
   CONFIG.c_ats_switch_unique_bdf {1} \
   CONFIG.c_m_axi_num_read {8} \
   CONFIG.c_m_axi_num_readq {2} \
   CONFIG.c_m_axi_num_write {8} \
   CONFIG.c_pri_enable {false} \
   CONFIG.c_s_axi_num_read {8} \
   CONFIG.c_s_axi_num_write {8} \
   CONFIG.c_s_axi_supports_narrow_burst {false} \
   CONFIG.c_smmu_en {0} \
   CONFIG.cfg_ext_if {false} \
   CONFIG.cfg_mgmt_if {true} \
   CONFIG.cfg_space_enable {false} \
   CONFIG.comp_timeout {50ms} \
   CONFIG.copy_pf0 {false} \
   CONFIG.copy_sriov_pf0 {true} \
   CONFIG.coreclk_freq {500} \
   CONFIG.ctrl_skip_mask {true} \
   CONFIG.dedicate_perst {false} \
   CONFIG.descriptor_bypass_exdes {false} \
   CONFIG.device_port_type {PCI_Express_Endpoint_device} \
   CONFIG.disable_bram_pipeline {false} \
   CONFIG.disable_eq_synchronizer {false} \
   CONFIG.disable_gt_loc {false} \
   CONFIG.disable_user_clock_root {true} \
   CONFIG.dma_2rp {false} \
   CONFIG.dma_reset_source_sel {User_Reset} \
   CONFIG.drp_clk_sel {Internal} \
   CONFIG.dsc_bypass_rd {0000} \
   CONFIG.dsc_bypass_rd_out {0000} \
   CONFIG.dsc_bypass_wr {0000} \
   CONFIG.dsc_bypass_wr_out {0000} \
   CONFIG.ecc_en {false} \
   CONFIG.en_axi_master_if {true} \
   CONFIG.en_axi_mm_mqdma {true} \
   CONFIG.en_axi_slave_if {true} \
   CONFIG.en_axi_st_mqdma {false} \
   CONFIG.en_bridge {false} \
   CONFIG.en_bridge_slv {false} \
   CONFIG.en_coreclk_es1 {false} \
   CONFIG.en_dbg_descramble {false} \
   CONFIG.en_debug_ports {false} \
   CONFIG.en_dma_and_bridge {false} \
   CONFIG.en_ext_ch_gt_drp {false} \
   CONFIG.en_gt_selection {false} \
   CONFIG.en_l23_entry {false} \
   CONFIG.en_mqdma {false} \
   CONFIG.en_pcie_drp {false} \
   CONFIG.en_slot_cap_reg {false} \
   CONFIG.en_transceiver_status_ports {false} \
   CONFIG.enable_ats_switch {FALSE} \
   CONFIG.enable_auto_rxeq {False} \
   CONFIG.enable_ccix {FALSE} \
   CONFIG.enable_clock_delay_grp {true} \
   CONFIG.enable_code {0000} \
   CONFIG.enable_dvsec {FALSE} \
   CONFIG.enable_epyc_chipset_fix {false} \
   CONFIG.enable_error_injection {false} \
   CONFIG.enable_gen4 {true} \
   CONFIG.enable_ibert {false} \
   CONFIG.enable_jtag_dbg {false} \
   CONFIG.enable_lane_reversal {false} \
   CONFIG.enable_ltssm_dbg {false} \
   CONFIG.enable_mark_debug {false} \
   CONFIG.enable_more_clk {false} \
   CONFIG.enable_multi_pcie {false} \
   CONFIG.enable_pcie_debug {False} \
   CONFIG.enable_pcie_debug_axi4_st {False} \
   CONFIG.enable_resource_reduction {false} \
   CONFIG.enable_slave_read_64os {false} \
   CONFIG.example_design_type {RTL} \
   CONFIG.ext_startup_primitive {false} \
   CONFIG.ext_sys_clk_bufg {false} \
   CONFIG.ext_xvc_vsec_enable {false} \
   CONFIG.flr_enable {false} \
   CONFIG.free_run_freq {100_MHz} \
   CONFIG.functional_mode {DMA} \
   CONFIG.gen4_eieos_0s7 {true} \
   CONFIG.gen_pipe_debug {false} \
   CONFIG.gt_loc_num {X99Y99} \
   CONFIG.gtcom_in_core_usp {2} \
   CONFIG.gtwiz_in_core_us {1} \
   CONFIG.gtwiz_in_core_usp {1} \
   CONFIG.include_baroffset_reg {true} \
   CONFIG.ins_loss_profile {Add-in_Card} \
   CONFIG.insert_cips {false} \
   CONFIG.intx_rx_pin_en {true} \
   CONFIG.lane_order {Bottom} \
   CONFIG.legacy_cfg_ext_if {false} \
   CONFIG.local_test {false} \
   CONFIG.m_axib_num_write_scale {1} \
   CONFIG.master_cal_only {false} \
   CONFIG.mcap_enablement {None} \
   CONFIG.mcap_fpga_bitstream_version {00000000} \
   CONFIG.mode_selection {Advanced} \
   CONFIG.mpsoc_pl_rp_enable {false} \
   CONFIG.msi_rx_pin_en {FALSE} \
   CONFIG.msix_pcie_internal {false} \
   CONFIG.msix_rx_decode_en {FALSE} \
   CONFIG.msix_rx_pin_en {TRUE} \
   CONFIG.msix_type {HARD} \
   CONFIG.mult_pf_des {false} \
   CONFIG.num_queues {1} \
   CONFIG.old_bridge_timeout {false} \
   CONFIG.parity_settings {None} \
   CONFIG.pcie_blk_locn {X1Y2} \
   CONFIG.pcie_extended_tag {true} \
   CONFIG.pcie_id_if {FALSE} \
   CONFIG.pciebar2axibar_0 {0x0000000000000000} \
   CONFIG.pciebar2axibar_1 {0x0000000000000000} \
   CONFIG.pciebar2axibar_2 {0x0000000000000000} \
   CONFIG.pciebar2axibar_3 {0x0000000000000000} \
   CONFIG.pciebar2axibar_4 {0x0000000000000000} \
   CONFIG.pciebar2axibar_5 {0x0000000000000000} \
   CONFIG.pciebar2axibar_6 {0x0000000000000000} \
   CONFIG.pciebar2axibar_axil_master {0x00000000} \
   CONFIG.pciebar2axibar_axist_bypass {0x0000000000000000} \
   CONFIG.pciebar2axibar_xdma {0x0000000000000000} \
   CONFIG.performance {false} \
   CONFIG.performance_exdes {false} \
   CONFIG.pf0_Use_Class_Code_Lookup_Assistant {false} \
   CONFIG.pf0_Use_Class_Code_Lookup_Assistant_mqdma {false} \
   CONFIG.pf0_aer_cap_ecrc_gen_and_check_capable {false} \
   CONFIG.pf0_ari_enabled {false} \
   CONFIG.pf0_ats_enabled {false} \
   CONFIG.pf0_bar0_64bit {false} \
   CONFIG.pf0_bar0_64bit_mqdma {false} \
   CONFIG.pf0_bar0_enabled {true} \
   CONFIG.pf0_bar0_enabled_mqdma {true} \
   CONFIG.pf0_bar0_index {0} \
   CONFIG.pf0_bar0_prefetchable {false} \
   CONFIG.pf0_bar0_prefetchable_mqdma {false} \
   CONFIG.pf0_bar0_scale {Kilobytes} \
   CONFIG.pf0_bar0_scale_mqdma {Kilobytes} \
   CONFIG.pf0_bar0_size {128} \
   CONFIG.pf0_bar0_size_mqdma {128} \
   CONFIG.pf0_bar0_type {Memory} \
   CONFIG.pf0_bar0_type_mqdma {DMA} \
   CONFIG.pf0_bar1_64bit {false} \
   CONFIG.pf0_bar1_64bit_mqdma {false} \
   CONFIG.pf0_bar1_enabled {false} \
   CONFIG.pf0_bar1_enabled_mqdma {false} \
   CONFIG.pf0_bar1_index {7} \
   CONFIG.pf0_bar1_prefetchable {false} \
   CONFIG.pf0_bar1_prefetchable_mqdma {false} \
   CONFIG.pf0_bar1_scale {Kilobytes} \
   CONFIG.pf0_bar1_scale_mqdma {Kilobytes} \
   CONFIG.pf0_bar1_size {4} \
   CONFIG.pf0_bar1_size_mqdma {128} \
   CONFIG.pf0_bar1_type {Memory} \
   CONFIG.pf0_bar1_type_mqdma {N/A} \
   CONFIG.pf0_bar2_64bit {false} \
   CONFIG.pf0_bar2_64bit_mqdma {false} \
   CONFIG.pf0_bar2_enabled {false} \
   CONFIG.pf0_bar2_enabled_mqdma {false} \
   CONFIG.pf0_bar2_index {7} \
   CONFIG.pf0_bar2_prefetchable {false} \
   CONFIG.pf0_bar2_prefetchable_mqdma {false} \
   CONFIG.pf0_bar2_scale {Kilobytes} \
   CONFIG.pf0_bar2_scale_mqdma {Kilobytes} \
   CONFIG.pf0_bar2_size {4} \
   CONFIG.pf0_bar2_size_mqdma {128} \
   CONFIG.pf0_bar2_type {Memory} \
   CONFIG.pf0_bar2_type_mqdma {N/A} \
   CONFIG.pf0_bar3_64bit {false} \
   CONFIG.pf0_bar3_64bit_mqdma {false} \
   CONFIG.pf0_bar3_enabled {false} \
   CONFIG.pf0_bar3_enabled_mqdma {false} \
   CONFIG.pf0_bar3_index {7} \
   CONFIG.pf0_bar3_prefetchable {false} \
   CONFIG.pf0_bar3_prefetchable_mqdma {false} \
   CONFIG.pf0_bar3_scale {Kilobytes} \
   CONFIG.pf0_bar3_scale_mqdma {Kilobytes} \
   CONFIG.pf0_bar3_size {4} \
   CONFIG.pf0_bar3_size_mqdma {128} \
   CONFIG.pf0_bar3_type {Memory} \
   CONFIG.pf0_bar3_type_mqdma {N/A} \
   CONFIG.pf0_bar4_64bit {false} \
   CONFIG.pf0_bar4_64bit_mqdma {false} \
   CONFIG.pf0_bar4_enabled {false} \
   CONFIG.pf0_bar4_enabled_mqdma {false} \
   CONFIG.pf0_bar4_index {7} \
   CONFIG.pf0_bar4_prefetchable {false} \
   CONFIG.pf0_bar4_prefetchable_mqdma {false} \
   CONFIG.pf0_bar4_scale {Kilobytes} \
   CONFIG.pf0_bar4_scale_mqdma {Kilobytes} \
   CONFIG.pf0_bar4_size {4} \
   CONFIG.pf0_bar4_size_mqdma {128} \
   CONFIG.pf0_bar4_type {Memory} \
   CONFIG.pf0_bar4_type_mqdma {N/A} \
   CONFIG.pf0_bar5_64bit {false} \
   CONFIG.pf0_bar5_enabled {false} \
   CONFIG.pf0_bar5_enabled_mqdma {false} \
   CONFIG.pf0_bar5_index {7} \
   CONFIG.pf0_bar5_prefetchable {false} \
   CONFIG.pf0_bar5_prefetchable_mqdma {false} \
   CONFIG.pf0_bar5_scale {Kilobytes} \
   CONFIG.pf0_bar5_scale_mqdma {Kilobytes} \
   CONFIG.pf0_bar5_size {4} \
   CONFIG.pf0_bar5_size_mqdma {128} \
   CONFIG.pf0_bar5_type {Memory} \
   CONFIG.pf0_bar5_type_mqdma {N/A} \
   CONFIG.pf0_base_class_menu {Simple_communication_controllers} \
   CONFIG.pf0_base_class_menu_mqdma {Memory_controller} \
   CONFIG.pf0_class_code {070001} \
   CONFIG.pf0_class_code_base {07} \
   CONFIG.pf0_class_code_base_mqdma {05} \
   CONFIG.pf0_class_code_interface {01} \
   CONFIG.pf0_class_code_interface_mqdma {00} \
   CONFIG.pf0_class_code_mqdma {058000} \
   CONFIG.pf0_class_code_sub {00} \
   CONFIG.pf0_class_code_sub_mqdma {80} \
   CONFIG.pf0_device_id {B048} \
   CONFIG.pf0_expansion_rom_enabled {false} \
   CONFIG.pf0_expansion_rom_scale {Kilobytes} \
   CONFIG.pf0_expansion_rom_size {4} \
   CONFIG.pf0_expansion_rom_type {N/A} \
   CONFIG.pf0_interrupt_pin {INTA} \
   CONFIG.pf0_link_status_slot_clock_config {true} \
   CONFIG.pf0_msi_cap_multimsgcap {1_vector} \
   CONFIG.pf0_msi_enabled {true} \
   CONFIG.pf0_msix_cap_pba_bir {BAR_0} \
   CONFIG.pf0_msix_cap_pba_offset {00000000} \
   CONFIG.pf0_msix_cap_table_bir {BAR_0} \
   CONFIG.pf0_msix_cap_table_offset {00000000} \
   CONFIG.pf0_msix_cap_table_size {000} \
   CONFIG.pf0_msix_enabled {false} \
   CONFIG.pf0_msix_enabled_mqdma {true} \
   CONFIG.pf0_msix_impl_locn {Internal} \
   CONFIG.pf0_pri_enabled {false} \
   CONFIG.pf0_rbar_cap_bar0 {0x00000000fff0} \
   CONFIG.pf0_rbar_cap_bar1 {0x000000000000} \
   CONFIG.pf0_rbar_cap_bar2 {0x000000000000} \
   CONFIG.pf0_rbar_cap_bar3 {0x000000000000} \
   CONFIG.pf0_rbar_cap_bar4 {0x000000000000} \
   CONFIG.pf0_rbar_cap_bar5 {0x000000000000} \
   CONFIG.pf0_rbar_num {1} \
   CONFIG.pf0_revision_id {00} \
   CONFIG.pf0_sriov_bar0_64bit {false} \
   CONFIG.pf0_sriov_bar0_enabled {true} \
   CONFIG.pf0_sriov_bar0_prefetchable {false} \
   CONFIG.pf0_sriov_bar0_scale {Kilobytes} \
   CONFIG.pf0_sriov_bar0_size {2} \
   CONFIG.pf0_sriov_bar0_type {DMA} \
   CONFIG.pf0_sriov_bar1_64bit {false} \
   CONFIG.pf0_sriov_bar1_enabled {false} \
   CONFIG.pf0_sriov_bar1_prefetchable {false} \
   CONFIG.pf0_sriov_bar1_scale {Kilobytes} \
   CONFIG.pf0_sriov_bar1_size {2} \
   CONFIG.pf0_sriov_bar1_type {N/A} \
   CONFIG.pf0_sriov_bar2_64bit {false} \
   CONFIG.pf0_sriov_bar2_enabled {false} \
   CONFIG.pf0_sriov_bar2_prefetchable {false} \
   CONFIG.pf0_sriov_bar2_scale {Kilobytes} \
   CONFIG.pf0_sriov_bar2_size {2} \
   CONFIG.pf0_sriov_bar2_type {N/A} \
   CONFIG.pf0_sriov_bar3_64bit {false} \
   CONFIG.pf0_sriov_bar3_enabled {false} \
   CONFIG.pf0_sriov_bar3_prefetchable {false} \
   CONFIG.pf0_sriov_bar3_scale {Kilobytes} \
   CONFIG.pf0_sriov_bar3_size {2} \
   CONFIG.pf0_sriov_bar3_type {N/A} \
   CONFIG.pf0_sriov_bar4_64bit {false} \
   CONFIG.pf0_sriov_bar4_enabled {false} \
   CONFIG.pf0_sriov_bar4_prefetchable {false} \
   CONFIG.pf0_sriov_bar4_scale {Kilobytes} \
   CONFIG.pf0_sriov_bar4_size {2} \
   CONFIG.pf0_sriov_bar4_type {N/A} \
   CONFIG.pf0_sriov_bar5_64bit {false} \
   CONFIG.pf0_sriov_bar5_enabled {false} \
   CONFIG.pf0_sriov_bar5_prefetchable {false} \
   CONFIG.pf0_sriov_bar5_scale {Kilobytes} \
   CONFIG.pf0_sriov_bar5_size {2} \
   CONFIG.pf0_sriov_bar5_type {N/A} \
   CONFIG.pf0_sriov_cap_ver {1} \
   CONFIG.pf0_sub_class_interface_menu {16450_compatible_serial_controller} \
   CONFIG.pf0_sub_class_interface_menu_mqdma {Other_memory_controller} \
   CONFIG.pf0_subsystem_id {0007} \
   CONFIG.pf0_subsystem_vendor_id {10EE} \
   CONFIG.pf0_vendor_id_mqdma {10EE} \
   CONFIG.pf1_Use_Class_Code_Lookup_Assistant_mqdma {false} \
   CONFIG.pf1_bar0_64bit {false} \
   CONFIG.pf1_bar0_64bit_mqdma {false} \
   CONFIG.pf1_bar0_enabled {true} \
   CONFIG.pf1_bar0_enabled_mqdma {true} \
   CONFIG.pf1_bar0_index {0} \
   CONFIG.pf1_bar0_prefetchable {false} \
   CONFIG.pf1_bar0_prefetchable_mqdma {false} \
   CONFIG.pf1_bar0_scale {Megabytes} \
   CONFIG.pf1_bar0_scale_mqdma {Kilobytes} \
   CONFIG.pf1_bar0_size {32} \
   CONFIG.pf1_bar0_size_mqdma {128} \
   CONFIG.pf1_bar0_type {Memory} \
   CONFIG.pf1_bar0_type_mqdma {DMA} \
   CONFIG.pf1_bar1_64bit {false} \
   CONFIG.pf1_bar1_64bit_mqdma {false} \
   CONFIG.pf1_bar1_enabled {true} \
   CONFIG.pf1_bar1_enabled_mqdma {false} \
   CONFIG.pf1_bar1_index {7} \
   CONFIG.pf1_bar1_prefetchable {false} \
   CONFIG.pf1_bar1_prefetchable_mqdma {false} \
   CONFIG.pf1_bar1_scale {Kilobytes} \
   CONFIG.pf1_bar1_scale_mqdma {Kilobytes} \
   CONFIG.pf1_bar1_size {128} \
   CONFIG.pf1_bar1_size_mqdma {128} \
   CONFIG.pf1_bar1_type {Memory} \
   CONFIG.pf1_bar1_type_mqdma {N/A} \
   CONFIG.pf1_bar2_64bit {true} \
   CONFIG.pf1_bar2_64bit_mqdma {false} \
   CONFIG.pf1_bar2_enabled {true} \
   CONFIG.pf1_bar2_enabled_mqdma {false} \
   CONFIG.pf1_bar2_index {7} \
   CONFIG.pf1_bar2_prefetchable {false} \
   CONFIG.pf1_bar2_prefetchable_mqdma {false} \
   CONFIG.pf1_bar2_scale {Kilobytes} \
   CONFIG.pf1_bar2_scale_mqdma {Kilobytes} \
   CONFIG.pf1_bar2_size {128} \
   CONFIG.pf1_bar2_size_mqdma {128} \
   CONFIG.pf1_bar2_type {Memory} \
   CONFIG.pf1_bar2_type_mqdma {N/A} \
   CONFIG.pf1_bar3_64bit {false} \
   CONFIG.pf1_bar3_64bit_mqdma {false} \
   CONFIG.pf1_bar3_enabled {false} \
   CONFIG.pf1_bar3_enabled_mqdma {false} \
   CONFIG.pf1_bar3_index {7} \
   CONFIG.pf1_bar3_prefetchable {false} \
   CONFIG.pf1_bar3_prefetchable_mqdma {false} \
   CONFIG.pf1_bar3_scale {Kilobytes} \
   CONFIG.pf1_bar3_scale_mqdma {Kilobytes} \
   CONFIG.pf1_bar3_size {128} \
   CONFIG.pf1_bar3_size_mqdma {128} \
   CONFIG.pf1_bar3_type {Memory} \
   CONFIG.pf1_bar3_type_mqdma {N/A} \
   CONFIG.pf1_bar4_64bit {true} \
   CONFIG.pf1_bar4_64bit_mqdma {false} \
   CONFIG.pf1_bar4_enabled {true} \
   CONFIG.pf1_bar4_enabled_mqdma {false} \
   CONFIG.pf1_bar4_index {7} \
   CONFIG.pf1_bar4_prefetchable {false} \
   CONFIG.pf1_bar4_prefetchable_mqdma {false} \
   CONFIG.pf1_bar4_scale {Kilobytes} \
   CONFIG.pf1_bar4_scale_mqdma {Kilobytes} \
   CONFIG.pf1_bar4_size {128} \
   CONFIG.pf1_bar4_size_mqdma {128} \
   CONFIG.pf1_bar4_type {Memory} \
   CONFIG.pf1_bar4_type_mqdma {N/A} \
   CONFIG.pf1_bar5_enabled {false} \
   CONFIG.pf1_bar5_enabled_mqdma {false} \
   CONFIG.pf1_bar5_index {7} \
   CONFIG.pf1_bar5_prefetchable {false} \
   CONFIG.pf1_bar5_prefetchable_mqdma {false} \
   CONFIG.pf1_bar5_scale {Kilobytes} \
   CONFIG.pf1_bar5_scale_mqdma {Kilobytes} \
   CONFIG.pf1_bar5_size {128} \
   CONFIG.pf1_bar5_size_mqdma {128} \
   CONFIG.pf1_bar5_type {Memory} \
   CONFIG.pf1_bar5_type_mqdma {N/A} \
   CONFIG.pf1_base_class_menu {Simple_communication_controllers} \
   CONFIG.pf1_base_class_menu_mqdma {Memory_controller} \
   CONFIG.pf1_class_code {070001} \
   CONFIG.pf1_class_code_base {07} \
   CONFIG.pf1_class_code_base_mqdma {05} \
   CONFIG.pf1_class_code_interface {01} \
   CONFIG.pf1_class_code_interface_mqdma {00} \
   CONFIG.pf1_class_code_mqdma {058000} \
   CONFIG.pf1_class_code_sub {00} \
   CONFIG.pf1_class_code_sub_mqdma {80} \
   CONFIG.pf1_device_id {1041} \
   CONFIG.pf1_expansion_rom_enabled {false} \
   CONFIG.pf1_expansion_rom_scale {Kilobytes} \
   CONFIG.pf1_expansion_rom_size {4} \
   CONFIG.pf1_expansion_rom_type {N/A} \
   CONFIG.pf1_msi_enabled {false} \
   CONFIG.pf1_msix_cap_pba_bir {BAR_0} \
   CONFIG.pf1_msix_cap_pba_offset {00000000} \
   CONFIG.pf1_msix_cap_table_bir {BAR_0} \
   CONFIG.pf1_msix_cap_table_offset {00000000} \
   CONFIG.pf1_msix_cap_table_size {000} \
   CONFIG.pf1_msix_enabled {false} \
   CONFIG.pf1_msix_enabled_mqdma {false} \
   CONFIG.pf1_pciebar2axibar_0 {0x0000000000000000} \
   CONFIG.pf1_pciebar2axibar_1 {0x0000000000000000} \
   CONFIG.pf1_pciebar2axibar_2 {0x0000000000000000} \
   CONFIG.pf1_pciebar2axibar_3 {0x0000000000000000} \
   CONFIG.pf1_pciebar2axibar_4 {0x0000000000000000} \
   CONFIG.pf1_pciebar2axibar_5 {0x0000000000000000} \
   CONFIG.pf1_pciebar2axibar_6 {0x0000000000000000} \
   CONFIG.pf1_rbar_cap_bar0 {0x00000000fff0} \
   CONFIG.pf1_rbar_cap_bar1 {0x000000000000} \
   CONFIG.pf1_rbar_cap_bar2 {0x000000000000} \
   CONFIG.pf1_rbar_cap_bar3 {0x000000000000} \
   CONFIG.pf1_rbar_cap_bar4 {0x000000000000} \
   CONFIG.pf1_rbar_cap_bar5 {0x000000000000} \
   CONFIG.pf1_rbar_num {1} \
   CONFIG.pf1_sriov_bar0_64bit {false} \
   CONFIG.pf1_sriov_bar0_enabled {true} \
   CONFIG.pf1_sriov_bar0_prefetchable {false} \
   CONFIG.pf1_sriov_bar0_scale {Kilobytes} \
   CONFIG.pf1_sriov_bar0_size {2} \
   CONFIG.pf1_sriov_bar0_type {DMA} \
   CONFIG.pf1_sriov_bar1_64bit {false} \
   CONFIG.pf1_sriov_bar1_enabled {false} \
   CONFIG.pf1_sriov_bar1_prefetchable {false} \
   CONFIG.pf1_sriov_bar1_scale {Kilobytes} \
   CONFIG.pf1_sriov_bar1_size {2} \
   CONFIG.pf1_sriov_bar1_type {N/A} \
   CONFIG.pf1_sriov_bar2_64bit {false} \
   CONFIG.pf1_sriov_bar2_enabled {false} \
   CONFIG.pf1_sriov_bar2_prefetchable {false} \
   CONFIG.pf1_sriov_bar2_scale {Kilobytes} \
   CONFIG.pf1_sriov_bar2_size {2} \
   CONFIG.pf1_sriov_bar2_type {N/A} \
   CONFIG.pf1_sriov_bar3_64bit {false} \
   CONFIG.pf1_sriov_bar3_enabled {false} \
   CONFIG.pf1_sriov_bar3_prefetchable {false} \
   CONFIG.pf1_sriov_bar3_scale {Kilobytes} \
   CONFIG.pf1_sriov_bar3_size {2} \
   CONFIG.pf1_sriov_bar3_type {N/A} \
   CONFIG.pf1_sriov_bar4_64bit {false} \
   CONFIG.pf1_sriov_bar4_enabled {false} \
   CONFIG.pf1_sriov_bar4_prefetchable {false} \
   CONFIG.pf1_sriov_bar4_scale {Kilobytes} \
   CONFIG.pf1_sriov_bar4_size {2} \
   CONFIG.pf1_sriov_bar4_type {N/A} \
   CONFIG.pf1_sriov_bar5_64bit {false} \
   CONFIG.pf1_sriov_bar5_enabled {false} \
   CONFIG.pf1_sriov_bar5_prefetchable {false} \
   CONFIG.pf1_sriov_bar5_scale {Kilobytes} \
   CONFIG.pf1_sriov_bar5_size {2} \
   CONFIG.pf1_sriov_bar5_type {N/A} \
   CONFIG.pf1_sub_class_interface_menu {16450_compatible_serial_controller} \
   CONFIG.pf1_sub_class_interface_menu_mqdma {Other_memory_controller} \
   CONFIG.pf1_vendor_id {10EE} \
   CONFIG.pf1_vendor_id_mqdma {10EE} \
   CONFIG.pf2_Use_Class_Code_Lookup_Assistant_mqdma {false} \
   CONFIG.pf2_bar0_64bit {false} \
   CONFIG.pf2_bar0_64bit_mqdma {false} \
   CONFIG.pf2_bar0_enabled {true} \
   CONFIG.pf2_bar0_enabled_mqdma {true} \
   CONFIG.pf2_bar0_index {0} \
   CONFIG.pf2_bar0_prefetchable {false} \
   CONFIG.pf2_bar0_prefetchable_mqdma {false} \
   CONFIG.pf2_bar0_scale {Kilobytes} \
   CONFIG.pf2_bar0_scale_mqdma {Kilobytes} \
   CONFIG.pf2_bar0_size {128} \
   CONFIG.pf2_bar0_size_mqdma {128} \
   CONFIG.pf2_bar0_type {Memory} \
   CONFIG.pf2_bar0_type_mqdma {DMA} \
   CONFIG.pf2_bar1_64bit {false} \
   CONFIG.pf2_bar1_64bit_mqdma {false} \
   CONFIG.pf2_bar1_enabled {true} \
   CONFIG.pf2_bar1_enabled_mqdma {false} \
   CONFIG.pf2_bar1_index {7} \
   CONFIG.pf2_bar1_prefetchable {false} \
   CONFIG.pf2_bar1_prefetchable_mqdma {false} \
   CONFIG.pf2_bar1_scale {Kilobytes} \
   CONFIG.pf2_bar1_scale_mqdma {Kilobytes} \
   CONFIG.pf2_bar1_size {128} \
   CONFIG.pf2_bar1_size_mqdma {128} \
   CONFIG.pf2_bar1_type {Memory} \
   CONFIG.pf2_bar1_type_mqdma {N/A} \
   CONFIG.pf2_bar2_64bit {false} \
   CONFIG.pf2_bar2_64bit_mqdma {false} \
   CONFIG.pf2_bar2_enabled {true} \
   CONFIG.pf2_bar2_enabled_mqdma {false} \
   CONFIG.pf2_bar2_index {7} \
   CONFIG.pf2_bar2_prefetchable {false} \
   CONFIG.pf2_bar2_prefetchable_mqdma {false} \
   CONFIG.pf2_bar2_scale {Kilobytes} \
   CONFIG.pf2_bar2_scale_mqdma {Kilobytes} \
   CONFIG.pf2_bar2_size {128} \
   CONFIG.pf2_bar2_size_mqdma {128} \
   CONFIG.pf2_bar2_type {Memory} \
   CONFIG.pf2_bar2_type_mqdma {N/A} \
   CONFIG.pf2_bar3_64bit {false} \
   CONFIG.pf2_bar3_64bit_mqdma {false} \
   CONFIG.pf2_bar3_enabled {true} \
   CONFIG.pf2_bar3_enabled_mqdma {false} \
   CONFIG.pf2_bar3_index {7} \
   CONFIG.pf2_bar3_prefetchable {false} \
   CONFIG.pf2_bar3_prefetchable_mqdma {false} \
   CONFIG.pf2_bar3_scale {Kilobytes} \
   CONFIG.pf2_bar3_scale_mqdma {Kilobytes} \
   CONFIG.pf2_bar3_size {128} \
   CONFIG.pf2_bar3_size_mqdma {128} \
   CONFIG.pf2_bar3_type {Memory} \
   CONFIG.pf2_bar3_type_mqdma {N/A} \
   CONFIG.pf2_bar4_64bit {false} \
   CONFIG.pf2_bar4_64bit_mqdma {false} \
   CONFIG.pf2_bar4_enabled {true} \
   CONFIG.pf2_bar4_enabled_mqdma {false} \
   CONFIG.pf2_bar4_index {7} \
   CONFIG.pf2_bar4_prefetchable {false} \
   CONFIG.pf2_bar4_prefetchable_mqdma {false} \
   CONFIG.pf2_bar4_scale {Kilobytes} \
   CONFIG.pf2_bar4_scale_mqdma {Kilobytes} \
   CONFIG.pf2_bar4_size {128} \
   CONFIG.pf2_bar4_size_mqdma {128} \
   CONFIG.pf2_bar4_type {Memory} \
   CONFIG.pf2_bar4_type_mqdma {N/A} \
   CONFIG.pf2_bar5_enabled {true} \
   CONFIG.pf2_bar5_enabled_mqdma {false} \
   CONFIG.pf2_bar5_index {7} \
   CONFIG.pf2_bar5_prefetchable {false} \
   CONFIG.pf2_bar5_prefetchable_mqdma {false} \
   CONFIG.pf2_bar5_scale {Kilobytes} \
   CONFIG.pf2_bar5_scale_mqdma {Kilobytes} \
   CONFIG.pf2_bar5_size {128} \
   CONFIG.pf2_bar5_size_mqdma {128} \
   CONFIG.pf2_bar5_type {Memory} \
   CONFIG.pf2_bar5_type_mqdma {N/A} \
   CONFIG.pf2_base_class_menu {Memory_controller} \
   CONFIG.pf2_base_class_menu_mqdma {Memory_controller} \
   CONFIG.pf2_class_code {058000} \
   CONFIG.pf2_class_code_base {05} \
   CONFIG.pf2_class_code_base_mqdma {05} \
   CONFIG.pf2_class_code_interface {00} \
   CONFIG.pf2_class_code_interface_mqdma {00} \
   CONFIG.pf2_class_code_mqdma {058000} \
   CONFIG.pf2_class_code_sub {80} \
   CONFIG.pf2_class_code_sub_mqdma {80} \
   CONFIG.pf2_device_id {1040} \
   CONFIG.pf2_expansion_rom_enabled {false} \
   CONFIG.pf2_expansion_rom_scale {Kilobytes} \
   CONFIG.pf2_expansion_rom_size {4} \
   CONFIG.pf2_expansion_rom_type {N/A} \
   CONFIG.pf2_msi_enabled {false} \
   CONFIG.pf2_msix_enabled_mqdma {false} \
   CONFIG.pf2_pciebar2axibar_0 {0x0000000000000000} \
   CONFIG.pf2_pciebar2axibar_1 {0x0000000000000000} \
   CONFIG.pf2_pciebar2axibar_2 {0x0000000000000000} \
   CONFIG.pf2_pciebar2axibar_3 {0x0000000000000000} \
   CONFIG.pf2_pciebar2axibar_4 {0x0000000000000000} \
   CONFIG.pf2_pciebar2axibar_5 {0x0000000000000000} \
   CONFIG.pf2_rbar_cap_bar0 {0x00000000fff0} \
   CONFIG.pf2_rbar_cap_bar1 {0x000000000000} \
   CONFIG.pf2_rbar_cap_bar2 {0x000000000000} \
   CONFIG.pf2_rbar_cap_bar3 {0x000000000000} \
   CONFIG.pf2_rbar_cap_bar4 {0x000000000000} \
   CONFIG.pf2_rbar_cap_bar5 {0x000000000000} \
   CONFIG.pf2_rbar_num {1} \
   CONFIG.pf2_sriov_bar0_64bit {false} \
   CONFIG.pf2_sriov_bar0_enabled {true} \
   CONFIG.pf2_sriov_bar0_prefetchable {false} \
   CONFIG.pf2_sriov_bar0_scale {Kilobytes} \
   CONFIG.pf2_sriov_bar0_size {2} \
   CONFIG.pf2_sriov_bar0_type {DMA} \
   CONFIG.pf2_sriov_bar1_64bit {false} \
   CONFIG.pf2_sriov_bar1_enabled {false} \
   CONFIG.pf2_sriov_bar1_prefetchable {false} \
   CONFIG.pf2_sriov_bar1_scale {Kilobytes} \
   CONFIG.pf2_sriov_bar1_size {2} \
   CONFIG.pf2_sriov_bar1_type {N/A} \
   CONFIG.pf2_sriov_bar2_64bit {false} \
   CONFIG.pf2_sriov_bar2_enabled {false} \
   CONFIG.pf2_sriov_bar2_prefetchable {false} \
   CONFIG.pf2_sriov_bar2_scale {Kilobytes} \
   CONFIG.pf2_sriov_bar2_size {2} \
   CONFIG.pf2_sriov_bar2_type {N/A} \
   CONFIG.pf2_sriov_bar3_64bit {false} \
   CONFIG.pf2_sriov_bar3_enabled {false} \
   CONFIG.pf2_sriov_bar3_prefetchable {false} \
   CONFIG.pf2_sriov_bar3_scale {Kilobytes} \
   CONFIG.pf2_sriov_bar3_size {2} \
   CONFIG.pf2_sriov_bar3_type {N/A} \
   CONFIG.pf2_sriov_bar4_64bit {false} \
   CONFIG.pf2_sriov_bar4_enabled {false} \
   CONFIG.pf2_sriov_bar4_prefetchable {false} \
   CONFIG.pf2_sriov_bar4_scale {Kilobytes} \
   CONFIG.pf2_sriov_bar4_size {2} \
   CONFIG.pf2_sriov_bar4_type {N/A} \
   CONFIG.pf2_sriov_bar5_64bit {false} \
   CONFIG.pf2_sriov_bar5_enabled {false} \
   CONFIG.pf2_sriov_bar5_prefetchable {false} \
   CONFIG.pf2_sriov_bar5_scale {Kilobytes} \
   CONFIG.pf2_sriov_bar5_size {2} \
   CONFIG.pf2_sriov_bar5_type {N/A} \
   CONFIG.pf2_sub_class_interface_menu {Other_memory_controller} \
   CONFIG.pf2_sub_class_interface_menu_mqdma {Other_memory_controller} \
   CONFIG.pf2_vendor_id_mqdma {10EE} \
   CONFIG.pf3_Use_Class_Code_Lookup_Assistant_mqdma {false} \
   CONFIG.pf3_bar0_64bit {false} \
   CONFIG.pf3_bar0_64bit_mqdma {false} \
   CONFIG.pf3_bar0_enabled {true} \
   CONFIG.pf3_bar0_enabled_mqdma {true} \
   CONFIG.pf3_bar0_index {0} \
   CONFIG.pf3_bar0_prefetchable {false} \
   CONFIG.pf3_bar0_prefetchable_mqdma {false} \
   CONFIG.pf3_bar0_scale {Kilobytes} \
   CONFIG.pf3_bar0_scale_mqdma {Kilobytes} \
   CONFIG.pf3_bar0_size {128} \
   CONFIG.pf3_bar0_size_mqdma {128} \
   CONFIG.pf3_bar0_type {Memory} \
   CONFIG.pf3_bar0_type_mqdma {DMA} \
   CONFIG.pf3_bar1_64bit {false} \
   CONFIG.pf3_bar1_64bit_mqdma {false} \
   CONFIG.pf3_bar1_enabled {true} \
   CONFIG.pf3_bar1_enabled_mqdma {false} \
   CONFIG.pf3_bar1_index {7} \
   CONFIG.pf3_bar1_prefetchable {false} \
   CONFIG.pf3_bar1_prefetchable_mqdma {false} \
   CONFIG.pf3_bar1_scale {Kilobytes} \
   CONFIG.pf3_bar1_scale_mqdma {Kilobytes} \
   CONFIG.pf3_bar1_size {128} \
   CONFIG.pf3_bar1_size_mqdma {128} \
   CONFIG.pf3_bar1_type {Memory} \
   CONFIG.pf3_bar1_type_mqdma {N/A} \
   CONFIG.pf3_bar2_64bit {false} \
   CONFIG.pf3_bar2_64bit_mqdma {false} \
   CONFIG.pf3_bar2_enabled {true} \
   CONFIG.pf3_bar2_enabled_mqdma {false} \
   CONFIG.pf3_bar2_index {7} \
   CONFIG.pf3_bar2_prefetchable {false} \
   CONFIG.pf3_bar2_prefetchable_mqdma {false} \
   CONFIG.pf3_bar2_scale {Kilobytes} \
   CONFIG.pf3_bar2_scale_mqdma {Kilobytes} \
   CONFIG.pf3_bar2_size {128} \
   CONFIG.pf3_bar2_size_mqdma {128} \
   CONFIG.pf3_bar2_type {Memory} \
   CONFIG.pf3_bar2_type_mqdma {N/A} \
   CONFIG.pf3_bar3_64bit {false} \
   CONFIG.pf3_bar3_64bit_mqdma {false} \
   CONFIG.pf3_bar3_enabled {true} \
   CONFIG.pf3_bar3_enabled_mqdma {false} \
   CONFIG.pf3_bar3_index {7} \
   CONFIG.pf3_bar3_prefetchable {false} \
   CONFIG.pf3_bar3_prefetchable_mqdma {false} \
   CONFIG.pf3_bar3_scale {Kilobytes} \
   CONFIG.pf3_bar3_scale_mqdma {Kilobytes} \
   CONFIG.pf3_bar3_size {128} \
   CONFIG.pf3_bar3_size_mqdma {128} \
   CONFIG.pf3_bar3_type {Memory} \
   CONFIG.pf3_bar3_type_mqdma {N/A} \
   CONFIG.pf3_bar4_64bit {false} \
   CONFIG.pf3_bar4_64bit_mqdma {false} \
   CONFIG.pf3_bar4_enabled {true} \
   CONFIG.pf3_bar4_enabled_mqdma {false} \
   CONFIG.pf3_bar4_index {7} \
   CONFIG.pf3_bar4_prefetchable {false} \
   CONFIG.pf3_bar4_prefetchable_mqdma {false} \
   CONFIG.pf3_bar4_scale {Kilobytes} \
   CONFIG.pf3_bar4_scale_mqdma {Kilobytes} \
   CONFIG.pf3_bar4_size {128} \
   CONFIG.pf3_bar4_size_mqdma {128} \
   CONFIG.pf3_bar4_type {Memory} \
   CONFIG.pf3_bar4_type_mqdma {N/A} \
   CONFIG.pf3_bar5_enabled {true} \
   CONFIG.pf3_bar5_enabled_mqdma {false} \
   CONFIG.pf3_bar5_index {7} \
   CONFIG.pf3_bar5_prefetchable {false} \
   CONFIG.pf3_bar5_prefetchable_mqdma {false} \
   CONFIG.pf3_bar5_scale {Kilobytes} \
   CONFIG.pf3_bar5_scale_mqdma {Kilobytes} \
   CONFIG.pf3_bar5_size {128} \
   CONFIG.pf3_bar5_size_mqdma {128} \
   CONFIG.pf3_bar5_type {Memory} \
   CONFIG.pf3_bar5_type_mqdma {N/A} \
   CONFIG.pf3_base_class_menu {Memory_controller} \
   CONFIG.pf3_base_class_menu_mqdma {Memory_controller} \
   CONFIG.pf3_class_code {058000} \
   CONFIG.pf3_class_code_base {05} \
   CONFIG.pf3_class_code_base_mqdma {05} \
   CONFIG.pf3_class_code_interface {00} \
   CONFIG.pf3_class_code_interface_mqdma {00} \
   CONFIG.pf3_class_code_mqdma {058000} \
   CONFIG.pf3_class_code_sub {80} \
   CONFIG.pf3_class_code_sub_mqdma {80} \
   CONFIG.pf3_device_id {1039} \
   CONFIG.pf3_expansion_rom_enabled {false} \
   CONFIG.pf3_expansion_rom_scale {Kilobytes} \
   CONFIG.pf3_expansion_rom_size {4} \
   CONFIG.pf3_expansion_rom_type {N/A} \
   CONFIG.pf3_msi_enabled {false} \
   CONFIG.pf3_msix_enabled_mqdma {false} \
   CONFIG.pf3_pciebar2axibar_0 {0x0000000000000000} \
   CONFIG.pf3_pciebar2axibar_1 {0x0000000000000000} \
   CONFIG.pf3_pciebar2axibar_2 {0x0000000000000000} \
   CONFIG.pf3_pciebar2axibar_3 {0x0000000000000000} \
   CONFIG.pf3_pciebar2axibar_4 {0x0000000000000000} \
   CONFIG.pf3_pciebar2axibar_5 {0x0000000000000000} \
   CONFIG.pf3_rbar_cap_bar0 {0x00000000fff0} \
   CONFIG.pf3_rbar_cap_bar1 {0x000000000000} \
   CONFIG.pf3_rbar_cap_bar2 {0x000000000000} \
   CONFIG.pf3_rbar_cap_bar3 {0x000000000000} \
   CONFIG.pf3_rbar_cap_bar4 {0x000000000000} \
   CONFIG.pf3_rbar_cap_bar5 {0x000000000000} \
   CONFIG.pf3_rbar_num {1} \
   CONFIG.pf3_sriov_bar0_64bit {false} \
   CONFIG.pf3_sriov_bar0_enabled {true} \
   CONFIG.pf3_sriov_bar0_prefetchable {false} \
   CONFIG.pf3_sriov_bar0_scale {Kilobytes} \
   CONFIG.pf3_sriov_bar0_size {2} \
   CONFIG.pf3_sriov_bar0_type {DMA} \
   CONFIG.pf3_sriov_bar1_64bit {false} \
   CONFIG.pf3_sriov_bar1_enabled {false} \
   CONFIG.pf3_sriov_bar1_prefetchable {false} \
   CONFIG.pf3_sriov_bar1_scale {Kilobytes} \
   CONFIG.pf3_sriov_bar1_size {2} \
   CONFIG.pf3_sriov_bar1_type {N/A} \
   CONFIG.pf3_sriov_bar2_64bit {false} \
   CONFIG.pf3_sriov_bar2_enabled {false} \
   CONFIG.pf3_sriov_bar2_prefetchable {false} \
   CONFIG.pf3_sriov_bar2_scale {Kilobytes} \
   CONFIG.pf3_sriov_bar2_size {2} \
   CONFIG.pf3_sriov_bar2_type {N/A} \
   CONFIG.pf3_sriov_bar3_64bit {false} \
   CONFIG.pf3_sriov_bar3_enabled {false} \
   CONFIG.pf3_sriov_bar3_prefetchable {false} \
   CONFIG.pf3_sriov_bar3_scale {Kilobytes} \
   CONFIG.pf3_sriov_bar3_size {2} \
   CONFIG.pf3_sriov_bar3_type {N/A} \
   CONFIG.pf3_sriov_bar4_64bit {false} \
   CONFIG.pf3_sriov_bar4_enabled {false} \
   CONFIG.pf3_sriov_bar4_prefetchable {false} \
   CONFIG.pf3_sriov_bar4_scale {Kilobytes} \
   CONFIG.pf3_sriov_bar4_size {2} \
   CONFIG.pf3_sriov_bar4_type {N/A} \
   CONFIG.pf3_sriov_bar5_64bit {false} \
   CONFIG.pf3_sriov_bar5_enabled {false} \
   CONFIG.pf3_sriov_bar5_prefetchable {false} \
   CONFIG.pf3_sriov_bar5_scale {Kilobytes} \
   CONFIG.pf3_sriov_bar5_size {2} \
   CONFIG.pf3_sriov_bar5_type {N/A} \
   CONFIG.pf3_sub_class_interface_menu {Other_memory_controller} \
   CONFIG.pf3_sub_class_interface_menu_mqdma {Other_memory_controller} \
   CONFIG.pf3_vendor_id_mqdma {10EE} \
   CONFIG.pf_swap {false} \
   CONFIG.pipe_line_stage {2} \
   CONFIG.pipe_sim {true} \
   CONFIG.pl_link_cap_max_link_speed {16.0_GT/s} \
   CONFIG.pl_link_cap_max_link_width {X8} \
   CONFIG.plltype {QPLL0} \
   CONFIG.post_synth_sim_en {false} \
   CONFIG.prog_usr_irq_vec_map {false} \
   CONFIG.rbar_enable {false} \
   CONFIG.rcfg_nph_fix_en {false} \
   CONFIG.ref_clk_freq {100_MHz} \
   CONFIG.runbit_fix {false} \
   CONFIG.rx_detect {Default} \
   CONFIG.select_quad {GTH_Quad_128} \
   CONFIG.set_finite_credit {false} \
   CONFIG.shell_bridge {false} \
   CONFIG.silicon_rev {Pre-Production} \
   CONFIG.sim_model {NO} \
   CONFIG.slot_cap_reg {00000040} \
   CONFIG.soft_reset_en {false} \
   CONFIG.split_dma {true} \
   CONFIG.split_dma_single_pf {false} \
   CONFIG.sys_reset_polarity {ACTIVE_LOW} \
   CONFIG.tandem_enable_rfsoc {false} \
   CONFIG.timeout0_sel {14} \
   CONFIG.timeout1_sel {15} \
   CONFIG.timeout_mult {3} \
   CONFIG.tl_credits_cd {15} \
   CONFIG.tl_credits_ch {15} \
   CONFIG.tl_pf_enable_reg {1} \
   CONFIG.tl_tx_mux_strict_priority {false} \
   CONFIG.two_bypass_bar {false} \
   CONFIG.type1_membase_memlimit_enable {Disabled} \
   CONFIG.type1_prefetchable_membase_memlimit {Disabled} \
   CONFIG.use_standard_interfaces {true} \
   CONFIG.user_pf_two_axilite_bar_en {false} \
   CONFIG.usplus_es1_seqnum_bypass {false} \
   CONFIG.usr_irq_exdes {false} \
   CONFIG.usrint_expn {false} \
   CONFIG.vcu118_board {false} \
   CONFIG.vcu1525_ddr_ex {false} \
   CONFIG.vdm_en {false} \
   CONFIG.vendor_id {10EE} \
   CONFIG.versal {true} \
   CONFIG.virtio_exdes {false} \
   CONFIG.virtio_perf_exdes {false} \
   CONFIG.vu9p_board {false} \
   CONFIG.vu9p_tul_ex {false} \
   CONFIG.xdma_axi_intf_mm {AXI_Stream} \
   CONFIG.xdma_axilite_slave {false} \
   CONFIG.xdma_dsc_bypass {false} \
   CONFIG.xdma_en {true} \
   CONFIG.xdma_non_incremental_exdes {false} \
   CONFIG.xdma_num_usr_irq {1} \
   CONFIG.xdma_pcie_64bit_en {false} \
   CONFIG.xdma_pcie_prefetchable {false} \
   CONFIG.xdma_rnum_chnl {1} \
   CONFIG.xdma_rnum_rids {32} \
   CONFIG.xdma_scale {Kilobytes} \
   CONFIG.xdma_size {64} \
   CONFIG.xdma_st_infinite_desc_exdes {false} \
   CONFIG.xdma_sts_ports {false} \
   CONFIG.xdma_wnum_chnl {1} \
   CONFIG.xdma_wnum_rids {16} \
   CONFIG.xlnx_ref_board {None} \
 ] $xdma_2

  # Create instance: xdma_2_support
  create_hier_cell_xdma_2_support [current_bd_instance .] xdma_2_support

  # Create interface connections
  connect_bd_intf_net -intf_net S_AXIS_C2H_0_1 [get_bd_intf_ports S_AXIS_C2H_0] [get_bd_intf_pins xdma_2/S_AXIS_C2H_0]
  connect_bd_intf_net -intf_net pcie_refclk_1 [get_bd_intf_ports pcie_refclk] [get_bd_intf_pins xdma_2_support/pcie_refclk]
  connect_bd_intf_net -intf_net xdma_2_M_AXIS_H2C_0 [get_bd_intf_ports M_AXIS_H2C_0] [get_bd_intf_pins xdma_2/M_AXIS_H2C_0]
  connect_bd_intf_net -intf_net xdma_2_pcie4_cfg_control_if [get_bd_intf_pins xdma_2/pcie4_cfg_control_if] [get_bd_intf_pins xdma_2_support/pcie_cfg_control]
  connect_bd_intf_net -intf_net xdma_2_pcie4_cfg_interrupt [get_bd_intf_pins xdma_2/pcie4_cfg_interrupt] [get_bd_intf_pins xdma_2_support/pcie_cfg_interrupt]
  connect_bd_intf_net -intf_net xdma_2_pcie4_cfg_msi [get_bd_intf_pins xdma_2/pcie4_cfg_msi] [get_bd_intf_pins xdma_2_support/pcie_cfg_msi]
  connect_bd_intf_net -intf_net xdma_2_pcie_cfg_mgmt_if [get_bd_intf_pins xdma_2/pcie_cfg_mgmt_if] [get_bd_intf_pins xdma_2_support/pcie_cfg_mgmt]
  connect_bd_intf_net -intf_net xdma_2_s_axis_cc [get_bd_intf_pins xdma_2/s_axis_cc] [get_bd_intf_pins xdma_2_support/s_axis_cc]
  connect_bd_intf_net -intf_net xdma_2_s_axis_rq [get_bd_intf_pins xdma_2/s_axis_rq] [get_bd_intf_pins xdma_2_support/s_axis_rq]
  connect_bd_intf_net -intf_net xdma_2_support_m_axis_cq [get_bd_intf_pins xdma_2/m_axis_cq] [get_bd_intf_pins xdma_2_support/m_axis_cq]
  connect_bd_intf_net -intf_net xdma_2_support_m_axis_rc [get_bd_intf_pins xdma_2/m_axis_rc] [get_bd_intf_pins xdma_2_support/m_axis_rc]
  connect_bd_intf_net -intf_net xdma_2_support_pcie_cfg_fc [get_bd_intf_pins xdma_2/pcie_cfg_fc] [get_bd_intf_pins xdma_2_support/pcie_cfg_fc]
  connect_bd_intf_net -intf_net xdma_2_support_pcie_cfg_mesg_rcvd [get_bd_intf_pins xdma_2/pcie4_cfg_mesg_rcvd] [get_bd_intf_pins xdma_2_support/pcie_cfg_mesg_rcvd]
  connect_bd_intf_net -intf_net xdma_2_support_pcie_cfg_mesg_tx [get_bd_intf_pins xdma_2/pcie4_cfg_mesg_tx] [get_bd_intf_pins xdma_2_support/pcie_cfg_mesg_tx]
  connect_bd_intf_net -intf_net xdma_2_support_pcie_cfg_status [get_bd_intf_pins xdma_2/pcie4_cfg_status_if] [get_bd_intf_pins xdma_2_support/pcie_cfg_status]
  connect_bd_intf_net -intf_net xdma_2_support_pcie_mgt [get_bd_intf_ports pcie_mgt] [get_bd_intf_pins xdma_2_support/pcie_mgt]
  connect_bd_intf_net -intf_net xdma_2_support_pcie_transmit_fc [get_bd_intf_pins xdma_2/pcie_transmit_fc] [get_bd_intf_pins xdma_2_support/pcie_transmit_fc]
  connect_bd_intf_net -intf_net xdma_2_support_pipe_ep [get_bd_intf_ports pipe_ep] [get_bd_intf_pins xdma_2_support/pipe_ep]

  # Create port connections
  connect_bd_net -net sys_reset_1 [get_bd_ports sys_reset] [get_bd_pins xdma_2_support/sys_reset]
  connect_bd_net -net usr_irq_req_1 [get_bd_ports usr_irq_req] [get_bd_pins xdma_2/usr_irq_req]
  connect_bd_net -net xdma_2_axi_aclk [get_bd_ports axi_aclk] [get_bd_pins xdma_2/axi_aclk]
  connect_bd_net -net xdma_2_axi_aresetn [get_bd_ports axi_aresetn] [get_bd_pins xdma_2/axi_aresetn]
  connect_bd_net -net xdma_2_support_phy_rdy_out [get_bd_ports phy_rdy_out] [get_bd_pins xdma_2/phy_rdy_out_sd] [get_bd_pins xdma_2_support/phy_rdy_out]
  connect_bd_net -net xdma_2_support_user_clk [get_bd_pins xdma_2/user_clk_sd] [get_bd_pins xdma_2_support/user_clk]
  connect_bd_net -net xdma_2_support_user_lnk_up [get_bd_ports user_lnk_up] [get_bd_pins xdma_2/user_lnk_up_sd] [get_bd_pins xdma_2_support/user_lnk_up]
  connect_bd_net -net xdma_2_support_user_reset [get_bd_pins xdma_2/user_reset_sd] [get_bd_pins xdma_2_support/user_reset]
  connect_bd_net -net xdma_2_usr_irq_ack [get_bd_ports usr_irq_ack] [get_bd_pins xdma_2/usr_irq_ack]

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


