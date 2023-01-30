##################################################################
# CHECK IPs
##################################################################

set bCheckIPs 1
set bCheckIPsPassed 1
if { $bCheckIPs == 1 } {
  set list_check_ips { xilinx.com:ip:xdma:* }
  set list_ips_missing ""
  common::send_msg_id "IPS_TCL-1001" "INFO" "Checking if the following IPs exist in the project's IP catalog: $list_check_ips ."

  foreach ip_vlnv $list_check_ips {
  set ip_obj [get_ipdefs -all $ip_vlnv]
  if { $ip_obj eq "" } {
    lappend list_ips_missing $ip_vlnv
    }
  }

  if { $list_ips_missing ne "" } {
    catch {common::send_msg_id "IPS_TCL-105" "ERROR" "The following IPs are not found in the IP Catalog:\n  $list_ips_missing\n\nResolution: Please add the repository containing the IP(s) to the project." }
    set bCheckIPsPassed 0
  }
}

if { $bCheckIPsPassed != 1 } {
  common::send_msg_id "IPS_TCL-102" "WARNING" "Will not continue with creation of design due to the error(s) above."
  return 1
}

##################################################################
# CREATE IP xdma
##################################################################

set xdma [create_ip -name xdma -vendor xilinx.com -library ip -module_name xdma -dir ./src/ip/]

set_property -dict { 
  CONFIG.mode_selection {Basic}
  CONFIG.pcie_blk_locn {X1Y2}
  CONFIG.pl_link_cap_max_link_width {X16}
  CONFIG.pl_link_cap_max_link_speed {8.0_GT/s}
  CONFIG.axi_data_width {512_bit}
  CONFIG.axisten_freq {250}
  CONFIG.pipe_sim {true}
  CONFIG.pf0_device_id {903F}
  CONFIG.PCIE_BOARD_INTERFACE {Custom}
  CONFIG.en_gt_selection {true}
  CONFIG.select_quad {GTY_Quad_227}
  CONFIG.coreclk_freq {500}
  CONFIG.plltype {QPLL1}
  CONFIG.xdma_axi_intf_mm {AXI_Stream}
  CONFIG.PF0_DEVICE_ID_mqdma {903F}
  CONFIG.PF2_DEVICE_ID_mqdma {923F}
  CONFIG.PF3_DEVICE_ID_mqdma {933F}
  CONFIG.PF0_SRIOV_VF_DEVICE_ID {A03F}
  CONFIG.PF1_SRIOV_VF_DEVICE_ID {A13F}
  CONFIG.PF2_SRIOV_VF_DEVICE_ID {A23F}
  CONFIG.PF3_SRIOV_VF_DEVICE_ID {A33F}
} [get_ips xdma]

set_property -dict { 
  GENERATE_SYNTH_CHECKPOINT {1}
} $xdma

##################################################################

