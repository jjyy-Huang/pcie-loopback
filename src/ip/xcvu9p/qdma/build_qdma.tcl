##################################################################
# CHECK IPs
##################################################################

set bCheckIPs 1
set bCheckIPsPassed 1
if { $bCheckIPs == 1 } {
  set list_check_ips { xilinx.com:ip:qdma:* }
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
# CREATE IP qdma
##################################################################

set qdma [create_ip -name qdma -vendor xilinx.com -library ip -module_name qdma -dir ./src/ip/]

set_property -dict { 
  CONFIG.mode_selection {Advanced}
  CONFIG.pl_link_cap_max_link_speed {8.0_GT/s}
  CONFIG.pipe_sim {true}
  CONFIG.dsc_byp_mode {Descriptor_bypass_and_internal}
  CONFIG.testname {st}
  CONFIG.dma_intf_sel_qdma {AXI_Stream_with_Completion}
  CONFIG.en_axi_mm_qdma {false}
} [get_ips qdma]

set_property -dict { 
  GENERATE_SYNTH_CHECKPOINT {1}
} $qdma

##################################################################

