set DEVICE_NAME [lindex $argv 0]
set DEVICE [lindex $argv 1]
set WHICH_DMAC [lindex $argv 2]
set SYNTH_TOP [lindex $argv 3]
set SIM_TOP [lindex $argv 4]
set RUN_SIM [lindex $argv 5]
set ROOTDIR [lindex $argv 6]

set MAX_THREADS 24

set SCRIPTES_VERSION 2022.1
set CURRENT_VERSION [version -short]

if { [string first $SCRIPTES_VERSION $CURRENT_VERSION] == -1 } {
    puts "ERROR: This script was generated using Vivado $SCRIPTES_VERSION and is being run in $CURRENT_VERSION of Vivado.\n"
    exit 1
}

proc reportCriticalPaths { FILENAME DELAYTYPE WLEVLE MAX_PATHS NWORST} {
    # Open the specified output file in write mode
    set FILEHANDLE [open $FILENAME w]
    # Write the current date and CSV format to a file header
    puts $FILEHANDLE "#\n# File created on [clock format [clock seconds]]\n#\n"
    puts $FILEHANDLE "Startpoint,Endpoint,DelayType,Slack,#Levels,#LUTs"
    # The $path variable contains a Timing Path object.
    set ERR 0
    foreach path [get_timing_paths -$DELAYTYPE -max_paths $MAX_PATHS -nworst $NWORST] {
        if { [get_property SLACK $path] < 0 } {
            set LUTS [get_cells -filter {REF_NAME =~ LUT*} -of_object $path]
            set STARTPOINT [get_property STARTPOINT_PIN $path]
            set ENDPOINT [get_property ENDPOINT_PIN $path]
            set SLACK [get_property SLACK $path]
            set LEVELS [get_property LOGIC_LEVELS $path]
            puts $FILEHANDLE "$STARTPOINT,$ENDPOINT,$DELAYTYPE,$SLACK,$LEVELS,[llength $LUTS]"
            if { [string match "WARNING" $WLEVLE] } {
                puts "WARNING: $DELAYTYPE timing violation."
            } else {
                puts "ERROR: $DELAYTYPE timing violation."
                incr ERR
            }
        }
    }
    close $FILEHANDLE
    puts "CSV file $FILENAME has been created.\n"
    if { $ERR > 0 } {
        puts "ERROR: $DELAYTYPE timing closure failed."
        exit 1
    }
    return 0
}; # End PROC

proc readRTLFile { DIR } {
    set FILES [glob -nocomplain -directory $DIR/ *]
    foreach FILE $FILES {
        if {[file isfile $FILE]} {
            set FEXT [file extension $FILE]
            if { [string match $FEXT .v] || [string match $FEXT .vh]} {
                read_verilog -library xil_defaultlib $FILE
                puts $FILE
            }
            if { [string match $FEXT .sv] || [string match $FEXT .svh]} {
                read_verilog -library xil_defaultlib -sv $FILE
                puts $FILE
            }
        }

    }
}

set WORKDIR $ROOTDIR/work
set GENSRCDIR $WORKDIR/src
set GENIPDIR $GENSRCDIR/ip
set GENBDDIR $GENSRCDIR/bd
set LOGDIR $ROOTDIR/work/log

file mkdir $WORKDIR
file mkdir $LOGDIR
file mkdir $GENSRCDIR
file mkdir $GENIPDIR
file mkdir $GENBDDIR

cd $WORKDIR

create_project -in_memory -part $DEVICE
set_param general.maxThreads $MAX_THREADS
set_property XPM_LIBRARIES {XPM_CDC XPM_FIFO XPM_MEMORY} [current_project]
set_property default_lib xil_defaultlib [current_project]

# add source file
readRTLFile $ROOTDIR/src/hdl
readRTLFile $ROOTDIR/src/hdl/$DEVICE_NAME/
readRTLFile $ROOTDIR/src/hdl/$DEVICE_NAME/$WHICH_DMAC/

# rebuild IP
foreach FILE [glob $ROOTDIR/src/ip/$DEVICE_NAME/*.tcl] {
    source $FILE
}
foreach FILE [glob $ROOTDIR/src/ip/$DEVICE_NAME/$WHICH_DMAC/*.tcl] {
    source $FILE
}
generate_target all [get_ips]
synth_ip [get_ips]
# finish rebuild IP

if { $RUN_SIM } {
# start simulation
# add testbench file
    readRTLFile $ROOTDIR/src/tb
    readRTLFile $ROOTDIR/src/tb/$DEVICE_NAME
    readRTLFile $ROOTDIR/src/tb/$DEVICE_NAME/$WHICH_DMAC

    save_project_as sim $WORKDIR -force
    set_property top $SIM_TOP [get_fileset sim_1]
    launch_simulation -simset sim_1 -mode behavioral
    run all
}
# finish simulation

read_xdc [glob $ROOTDIR/src/xdc/$DEVICE_NAME/$WHICH_DMAC/*.xdc]

synth_design -top $SYNTH_TOP -part $DEVICE
write_checkpoint -force $LOGDIR/post_synth
report_utilization -file $LOGDIR/post_synth_util.rpt
report_timing -sort_by group -max_paths 100 -path_type summary -file $LOGDIR/post_synth_timing.rpt

reportCriticalPaths $LOGDIR/post_synth_hold_critpath_report.csv hold WARNING 50 1
reportCriticalPaths $LOGDIR/post_synth_setup_critpath_report.csv setup ERROR 50 1

# tcl check violation
report_qor_assessment -file $LOGDIR/post_synth_qor_assessment.rpt
report_qor_suggestions -file $LOGDIR/post_synth_qor_suggestions.rpt

opt_design
place_design
phys_opt_design
write_checkpoint -force $LOGDIR/post_place

route_design
write_checkpoint -force $LOGDIR/post_route
report_timing_summary -file $LOGDIR/post_route_timing_summary.rpt
report_timing -sort_by group -max_paths 100 -path_type summary -file $LOGDIR/post_route_timing.rpt
report_utilization -file $LOGDIR/post_route_util.rpt

reportCriticalPaths $LOGDIR/post_route_hold_critpath_report.csv hold ERROR 50 1
reportCriticalPaths $LOGDIR/post_route_setup_critpath_report.csv setup ERROR 50 1

report_qor_assessment -file $LOGDIR/post_route_qor_assessment.rpt
report_qor_suggestions -file $LOGDIR/post_route_qor_suggestions.rpt
report_cdc -file $LOGDIR/post_route_cdc.rpt

# write_verilog -force $WORKDIR/imp_netlist.v
# write_xdc -no_fixed_only -force $WORKDIR/imp.xdc

# write_bitstream -file $WORKDIR/bitstream.bit

