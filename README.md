# Build Step 

## 1. set your vivado path in run.sh
```bash
source ${WHERE_XILINXTOOLS_INSTALLED}/xilinx/Vivado/2021.2/settings64.sh
```

## 2. synth, P&R
```bash
source ./run.sh
```

## 3. run simulation (option)
need to modify ./script/build_prj.tcl 
```tcl
set RUN_SIM true
```
