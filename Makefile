SHELL = /bin/bash
VIVADO_ENV = /opt/xilinx/Vivado/2022.1/settings64.sh

VIVADO_CMD = vivado -mode batch -source ./script/build_prj.tcl -tclargs
SET_VIVADO_ENV = source $(VIVADO_ENV)

SIM_TOP=board	#	board
RUN_SIM=false	#	false	/ true
ROOTFIR=$(PWD)


.PHONY: build
.ONESHELL:
build:
	@$(SET_VIVADO_ENV)
	@echo "Start building project."
	@$(VIVADO_CMD) $(DEVICE_NAME) $(DEVICE) $(WHICH_DMAC) $(SYNTH_TOP) $(SIM_TOP) $(RUN_SIM) $(ROOTFIR) 2>&1 | tee ./run.log
	@echo "Finish building Vivado project, please check the run.log for details."

.PHONY: clean
clean:
	@rm -rf ./work/* ./*.log ./*.jou

.PHONY: build-udp-module
build-udp-module:
	cd SpinalHDL-ethernet
	sbt "run"
	cp -rf ./src/hdl/* ../src/hdl
	cd ..

.PHONY: build-xcku040-xdma-40gmac
.ONESHELL:
build-xcku040-xdma-40gmac: clean build-udp-module
	export DEVICE_NAME=xcku040
	export DEVICE=xcku040-ffva1156-2-e
	export WHICH_DMAC=xdma
	export SYNTH_TOP=xilinx_dma_pcie_ep
	@make build

.PHONY: build-xcvu9p-xdma-cmac
.ONESHELL:
build-xcvu9p-xdma-cmac: clean build-udp-module
	export DEVICE_NAME=xcvu9p
	export DEVICE=xcvu9p-flga2104-2L-e
	export WHICH_DMAC=xdma
	export SYNTH_TOP=xilinx_dma_pcie_ep
	@make build

.PHONY: build-xcvu9p-qdma-cmac
.ONESHELL:
build-xcvu9p-qdma-cmac: clean build-udp-module
	export DEVICE_NAME=xcvu9p
	export DEVICE=xcvu9p-flga2104-2L-e
	export WHICH_DMAC=qdma
	export SYNTH_TOP=xilinx_qdma_pcie_ep
	@make build

.PHONY: build-vck5000-xdma-mrmac
build-vck5000-xdma-mrmac: clean build-udp-module
