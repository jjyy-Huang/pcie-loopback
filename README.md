# Build Step 

## 0. Performance & Utilizations
| Device               | PCI-E     | DMA              | MAC                       | LUT           |   LUTRAM    | FF           | BRAM         | URAM      | DSP      | GT         | BUFG      | PCIe      |
| :------------------- | :-------- | :--------------- | :------------------------ | :------------ | :---------: | :----------- | :----------- | :-------- | :------- | :--------- | :-------- | :-------- |
| XCKU040-FFVA1156-2-E | Gen3 x 8  | XDMA 256b@250MHz | 40G MAC 256b@312.5MHz     | 32412(13.37%) | 2359(2.09%) | 37834(7.80%) | 59.50(9.92%) | -         | -        | 12(60%)    | 8(1.67%)  | 1(33.33%) |
| XCVU9P-FLGA2104-2L-E | Gen3 x 16 | XDMA 512b@250MHz | 100G CMAC 512b@322.266MHz | 51098(4.32%)  | 3572(0.60%) | 56380(2.38%) | 93(4.30%)    | -         | -        | 20(38.46%) | 25(1.39%) | 1(16.67%) |
| XCVU9P-FLGA2104-2L-E | Gen3 x 16 | QDMA 512b@250MHz | 100G CMAC 512b@322.266MHz | 80828(6.84%)  | 9390(1.59%) | 85088(3.60%) | 119(5.51%)   | 10(1.04%) | 2(0.03%) | 20(38.46%) | 11(0.61%) | 1(16.67%) |


## 1. set your vivado path in Makefile
```bash
VIVADO_ENV = ${WHERE_XILINXTOOLS_INSTALLED}/xilinx/Vivado/${VERSION}/settings64.sh
```

## 2. synth, P&R
Default: vck5000 + xdma + mrmac
```bash
make all
```

using other device
```bash
make {xcku040/xcvu9p/xcvu9p-qdma}
```

## 3. run simulation (option)
need to modify ./script/build_prj.tcl 
```tcl
set RUN_SIM true
```
