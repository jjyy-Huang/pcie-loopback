SHELL = /bin/bash
VIVADO_ENV = /opt/xilinx/Vivado/2021.2/settings64.sh

.PHONY: all
all: clean build

.PHONY: build
build:
	$(SHELL) $(VIVADO_ENV)
	echo "Start building project."
	vivado -mode batch -source ./script/build_prj.tcl 2>&1 | tee ./run.log
	echo "Finish building Vivado project, please check the run.log for details."

.PHONY: xcku040
xcku040:
	git checkout xcku040
	make all

.PHONY: xcvu9p
xcvu9p:
	git checkout xcvu9p
	make all

.PHONY: xcvu9p-qdma
xcvu9p-qdma:
	git checkout xcvu9p-qdma
	make all

.PHONY: clean
clean:
	rm -rf ./work/* ./*.log ./*.jou