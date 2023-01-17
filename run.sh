#!/usr/bin/env bash
set -o errexit
set -o nounset
set -o xtrace

source /opt/xilinx/Vivado/2021.2/settings64.sh

echo "Start building project."
vivado -mode batch -source ./script/build_prj.tcl 2>&1 | tee ./run.log
echo "Finish building Vivado project, please check the run.log for details."