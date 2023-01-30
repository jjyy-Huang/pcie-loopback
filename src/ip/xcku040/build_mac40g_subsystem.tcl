##################################################################
# CHECK IPs
##################################################################

set bCheckIPs 1
set bCheckIPsPassed 1
if { $bCheckIPs == 1 } {
  set list_check_ips { xilinx.com:ip:l_ethernet:* }
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
# CREATE IP mac40g_subsystem
##################################################################

set mac40g_subsystem [create_ip -name l_ethernet -vendor xilinx.com -library ip -module_name mac40g_subsystem -dir ./src/ip/]

set_property -dict { 
  CONFIG.DATA_PATH_INTERFACE {256-bit Regular AXI4-Stream}
  CONFIG.GT_GROUP_SELECT {Quad_X0Y2}
  CONFIG.LANE1_GT_LOC {X0Y8}
  CONFIG.LANE2_GT_LOC {X0Y9}
  CONFIG.LANE3_GT_LOC {X0Y10}
  CONFIG.LANE4_GT_LOC {X0Y11}
} [get_ips mac40g_subsystem]

set_property -dict { 
  GENERATE_SYNTH_CHECKPOINT {1}
} $mac40g_subsystem

##################################################################

