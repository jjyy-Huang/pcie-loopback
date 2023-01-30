##################################################################
# CHECK IPs
##################################################################

set bCheckIPs 1
set bCheckIPsPassed 1
if { $bCheckIPs == 1 } {
  set list_check_ips { xilinx.com:ip:axis_data_fifo:* }
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
# CREATE IP axis_data_fifo_256b_128
##################################################################

set axis_data_fifo_256b_128 [create_ip -name axis_data_fifo -vendor xilinx.com -library ip -module_name axis_data_fifo_256b_128 -dir ./src/ip/]

set_property -dict { 
  CONFIG.TDATA_NUM_BYTES {32}
  CONFIG.FIFO_DEPTH {128}
  CONFIG.IS_ACLK_ASYNC {1}
  CONFIG.HAS_TKEEP {1}
  CONFIG.HAS_TLAST {1}
} [get_ips axis_data_fifo_256b_128]

set_property -dict { 
  GENERATE_SYNTH_CHECKPOINT {1}
} $axis_data_fifo_256b_128

##################################################################

