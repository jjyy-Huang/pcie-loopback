# Build Step 

## 1. set your vivado path in Makefile
```bash
VIVADO_ENV = ${WHERE_XILINXTOOLS_INSTALLED}/xilinx/Vivado/${VERSION}/settings64.sh
```

## 2. synth, P&R
```bash
make all
```

## 3. run simulation (option)
need to modify ./script/build_prj.tcl 
```tcl
set RUN_SIM true
```
