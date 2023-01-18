##################################################################
# START
##################################################################

##################################################################
# CHECK IPs
##################################################################

set bCheckIPs 1
set bCheckIPsPassed 1
if { $bCheckIPs == 1 } {
  set list_check_ips { xilinx.com:ip:clk_wizard:* }
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
# CREATE IP clk_wizard_mrmac
##################################################################

set clk_wizard_mrmac [create_ip -name clk_wizard -vendor xilinx.com -library ip -module_name clk_wizard_mrmac]

set_property -dict { 
  CONFIG.CLKOUT_USED {true,false,false,false,false,false,false}
  CONFIG.CLKOUT_PORT {clk_out1,clk_out2,clk_out3,clk_out4,clk_out5,clk_out6,clk_out7}
  CONFIG.CLKOUT_REQUESTED_OUT_FREQUENCY {644.53125,100.000,100.000,100.000,100.000,100.000,100.000}
  CONFIG.CLKOUT_REQUESTED_PHASE {0.000,0.000,0.000,0.000,0.000,0.000,0.000}
  CONFIG.CLKOUT_REQUESTED_DUTY_CYCLE {50.000,50.000,50.000,50.000,50.000,50.000,50.000}
  CONFIG.CLKOUT_DRIVES {BUFG,BUFG,BUFG,BUFG,BUFG,BUFG,BUFG}
  CONFIG.CLKOUT_GROUPING {Auto,Auto,Auto,Auto,Auto,Auto,Auto}
  CONFIG.CLKOUT_DYN_PS {None,None,None,None,None,None,None}
  CONFIG.CLKOUT_MATCHED_ROUTING {false,false,false,false,false,false,false}
  CONFIG.BANDWIDTH {LOW}
  CONFIG.CLKFBOUT_MULT {64.453125}
  CONFIG.DIVCLK_DIVIDE {2}
  CONFIG.CLKOUT1_DIVIDE {5.000000}
} [get_ips clk_wizard_mrmac]

set_property -dict { 
  GENERATE_SYNTH_CHECKPOINT {1}
} $clk_wizard_mrmac

##################################################################

