##################################################################
# CHECK IPs
##################################################################

set bCheckIPs 1
set bCheckIPsPassed 1
if { $bCheckIPs == 1 } {
  set list_check_ips { xilinx.com:ip:cmac_usplus:* }
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
# CREATE IP cmac_subsystem
##################################################################

set cmac_subsystem [create_ip -name cmac_usplus -vendor xilinx.com -library ip -module_name cmac_subsystem -dir ./src/ip/]

set_property -dict { 
  CONFIG.CMAC_CAUI4_MODE {1}
  CONFIG.NUM_LANES {4x25}
  CONFIG.GT_REF_CLK_FREQ {161.1328125}
  CONFIG.USER_INTERFACE {AXIS}
  CONFIG.TX_FLOW_CONTROL {0}
  CONFIG.RX_FLOW_CONTROL {0}
  CONFIG.GT_GROUP_SELECT {X1Y48~X1Y51}
  CONFIG.LANE5_GT_LOC {NA}
  CONFIG.LANE6_GT_LOC {NA}
  CONFIG.LANE7_GT_LOC {NA}
  CONFIG.LANE8_GT_LOC {NA}
  CONFIG.LANE9_GT_LOC {NA}
  CONFIG.LANE10_GT_LOC {NA}
  CONFIG.ETHERNET_BOARD_INTERFACE {Custom}
  CONFIG.DIFFCLK_BOARD_INTERFACE {Custom}
} [get_ips cmac_subsystem]

set_property -dict { 
  GENERATE_SYNTH_CHECKPOINT {1}
} $cmac_subsystem

##################################################################

