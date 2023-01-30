SHELL = /bin/bash
VIVADO_ENV = /opt/xilinx/Vivado/2021.2/settings64.sh

DEVICE_NAME = xcku040 #	xcku040 / xcvu9p															
DEVICE = xcku040-ffva1156-2-e #	xcku040-ffva1156-2-e / xcvu9p-flga2104-2L-e							
WHICH_DMA = xdma #	xdma	/ qdma	
SYNTH_TOP = xilinx_dma_pcie_ep #	xilinx_dma_pcie_ep	/  xilinx_qdma_pcie_ep							
SIM_TOP = board	#	board											
RUN_SIM = false	#	false	 /  true			

.PHONY: all
all: clean build

.PHONY: build
build:
	$(SHELL) $(VIVADO_ENV)
	echo "Start building project."
	vivado -mode batch -source ./script/build_prj.tcl -tclargs $(DEVICE_NAME) $(DEVICE) $(WHICH_DMA) $(SYNTH_TOP) $(SIM_TOP) $(RUN_SIM) 2>&1 | tee ./run.log
	echo "Finish building Vivado project, please check the run.log for details."

.PHONY: clean
clean:
	rm -rf ./work/* ./*.log ./*.jou