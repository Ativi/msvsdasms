# WEEK 4 AI's

- A one-bit analog-to-digital converter (ADC) is the simplest form of ADC, which is capable of converting an analog signal into a digital signal with only one bit of resolution. This means that the output of the ADC can only take on one of two possible values, typically represented as "0" or "1".

- In a one-bit ADC, the analog signal is compared to a fixed reference voltage, and the output of the ADC is determined by whether the analog signal is greater or less than the reference voltage. This process is repeated multiple times per second to generate a digital output that represents the amplitude of the analog signal over time.

![adc_schematic](https://user-images.githubusercontent.com/68071764/224414868-b0a06317-d1a3-4cf8-96d7-d5e6d6a539d1.png)

- Netlist Generated from Xschem.
```
** sch_path: /home/ativi07/Desktop/ALIGN-public/week0/inverter/xschem/onebitADC.sch
**.subckt onebitADC vref Vin out VDD
*.ipin vref
*.ipin Vin
*.opin out
*.iopin VDD
XM1 net2 net1 VDD VDD sky130_fd_pr__pfet_01v8 L=0.15 W=1 nf=1 ad='int((nf+1)/2) * W/nf * 0.29' as='int((nf+2)/2) * W/nf * 0.29'
+ pd='2*int((nf+1)/2) * (W/nf + 0.29)' ps='2*int((nf+2)/2) * (W/nf + 0.29)' nrd='0.29 / W' nrs='0.29 / W'
+ sa=0 sb=0 sd=0 mult=1 m=1
XM4 net1 vref net3 net3 sky130_fd_pr__nfet_01v8 L=0.15 W=1 nf=1 ad='int((nf+1)/2) * W/nf * 0.29' as='int((nf+2)/2) * W/nf * 0.29'
+ pd='2*int((nf+1)/2) * (W/nf + 0.29)' ps='2*int((nf+2)/2) * (W/nf + 0.29)' nrd='0.29 / W' nrs='0.29 / W'
+ sa=0 sb=0 sd=0 mult=1 m=1
XM5 out net4 GND GND sky130_fd_pr__nfet_01v8 L=0.15 W=1 nf=1 ad='int((nf+1)/2) * W/nf * 0.29' as='int((nf+2)/2) * W/nf * 0.29'
+ pd='2*int((nf+1)/2) * (W/nf + 0.29)' ps='2*int((nf+2)/2) * (W/nf + 0.29)' nrd='0.29 / W' nrs='0.29 / W'
+ sa=0 sb=0 sd=0 mult=1 m=1
XM6 out net2 VDD VDD sky130_fd_pr__pfet_01v8 L=0.15 W=1 nf=1 ad='int((nf+1)/2) * W/nf * 0.29' as='int((nf+2)/2) * W/nf * 0.29'
+ pd='2*int((nf+1)/2) * (W/nf + 0.29)' ps='2*int((nf+2)/2) * (W/nf + 0.29)' nrd='0.29 / W' nrs='0.29 / W'
+ sa=0 sb=0 sd=0 mult=1 m=1
XM7 net3 net4 GND GND sky130_fd_pr__nfet_01v8 L=0.15 W=1 nf=1 ad='int((nf+1)/2) * W/nf * 0.29' as='int((nf+2)/2) * W/nf * 0.29'
+ pd='2*int((nf+1)/2) * (W/nf + 0.29)' ps='2*int((nf+2)/2) * (W/nf + 0.29)' nrd='0.29 / W' nrs='0.29 / W'
+ sa=0 sb=0 sd=0 mult=1 m=1
V1 VDD GND 1.8
.save i(v1)
V2 vref GND 0.9
.save i(v2)
V3 Vin GND sin (0.9 0.9 50Meg 0 0 0)
.save i(v3)
XM2 net1 net1 VDD VDD sky130_fd_pr__pfet_01v8 L=0.15 W=1 nf=1 ad='int((nf+1)/2) * W/nf * 0.29' as='int((nf+2)/2) * W/nf * 0.29'
+ pd='2*int((nf+1)/2) * (W/nf + 0.29)' ps='2*int((nf+2)/2) * (W/nf + 0.29)' nrd='0.29 / W' nrs='0.29 / W'
+ sa=0 sb=0 sd=0 mult=1 m=1
XM9 net4 net4 VDD VDD sky130_fd_pr__pfet_01v8 L=0.15 W=1 nf=1 ad='int((nf+1)/2) * W/nf * 0.29' as='int((nf+2)/2) * W/nf * 0.29'
+ pd='2*int((nf+1)/2) * (W/nf + 0.29)' ps='2*int((nf+2)/2) * (W/nf + 0.29)' nrd='0.29 / W' nrs='0.29 / W'
+ sa=0 sb=0 sd=0 mult=1 m=1
XM3 net2 Vin net3 net3 sky130_fd_pr__nfet_01v8 L=0.15 W=1 nf=1 ad='int((nf+1)/2) * W/nf * 0.29' as='int((nf+2)/2) * W/nf * 0.29'
+ pd='2*int((nf+1)/2) * (W/nf + 0.29)' ps='2*int((nf+2)/2) * (W/nf + 0.29)' nrd='0.29 / W' nrs='0.29 / W'
+ sa=0 sb=0 sd=0 mult=1 m=1
XM8 net4 net4 GND GND sky130_fd_pr__nfet_01v8 L=0.15 W=1 nf=1 ad='int((nf+1)/2) * W/nf * 0.29' as='int((nf+2)/2) * W/nf * 0.29'
+ pd='2*int((nf+1)/2) * (W/nf + 0.29)' ps='2*int((nf+2)/2) * (W/nf + 0.29)' nrd='0.29 / W' nrs='0.29 / W'
+ sa=0 sb=0 sd=0 mult=1 m=1
**** begin user architecture code

.lib /usr/local/share/pdk/sky130A/libs.tech/ngspice/sky130.lib.spice tt


.control
save all
tran 0.01n 100n
plot vin out vref
.endc

**** end user architecture code
**.ends
.GLOBAL GND
.end
```

![ADC_out](https://user-images.githubusercontent.com/68071764/224414916-08bfd55b-c213-48f6-8aea-39fc0fb6669d.png)

## Post-layout simulation using ALIGN

![align](https://user-images.githubusercontent.com/68071764/224415448-3c82684b-0d30-42bf-bcd2-12de728504f1.png)

- Generated .lef and .gds

![image](https://user-images.githubusercontent.com/68071764/224415636-443c7540-743b-41ac-8a6c-6520ec68379b.png)

![K_lef_onebitadc](https://user-images.githubusercontent.com/68071764/224645329-1fe632c6-50d1-4905-ab9f-aa42ddd3aaaa.png)

![VirtualBox_opensource_eda_ubuntu Clone_13_03_2023_13_56_04](https://user-images.githubusercontent.com/68071764/224646542-2b3fbf33-2277-4f59-860c-21d91ecca97f.png)

![VirtualBox_opensource_eda_ubuntu Clone_11_03_2023_01_34_18](https://user-images.githubusercontent.com/68071764/224417186-035915a5-d690-4bca-9444-ca9e9cbf018a.png)

- GDS file loaded, Extract the netlist file.
```
extract do local
extract all
ext2spice lvs
ext2spice cthresh 0 rthresh 0
ext2spice
```

- New spice netlist will be created. 

```
NGSPICE file created from ONEBITADC_0.ext - technology: sky130A

.subckt PMOS_S_59912959_X4_Y1_1678477369 a_230_462# a_200_252# w_0_0# VSUBS
X0 a_230_462# a_200_252# w_0_0# w_0_0# sky130_fd_pr__pfet_01v8 ad=1.176e+12p pd=1.064e+07u as=1.4385e+12p ps=1.324e+07u w=1.05e+06u l=150000u
X1 w_0_0# a_200_252# a_230_462# w_0_0# sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X2 w_0_0# a_200_252# a_230_462# w_0_0# sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X3 a_230_462# a_200_252# w_0_0# w_0_0# sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X4 a_230_462# a_200_252# w_0_0# w_0_0# sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X5 w_0_0# a_200_252# a_230_462# w_0_0# sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X6 w_0_0# a_200_252# a_230_462# w_0_0# sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X7 a_230_462# a_200_252# w_0_0# w_0_0# sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
C0 a_200_252# a_230_462# 0.44fF
C1 w_0_0# a_230_462# 3.18fF
C2 w_0_0# a_200_252# 2.34fF
C3 a_230_462# VSUBS -0.19fF
C4 a_200_252# VSUBS 0.18fF
C5 w_0_0# VSUBS 4.83fF
.ends

.subckt SCM_NMOS_38434623_X4_Y1_1678477365_1678477365 a_200_252# a_402_462# a_147_462#
X0 a_402_462# a_200_252# a_147_462# a_147_462# sky130_fd_pr__nfet_01v8 ad=1.176e+12p pd=1.064e+07u as=2.6145e+12p ps=2.388e+07u w=1.05e+06u l=150000u
X1 a_200_252# a_200_252# a_147_462# a_147_462# sky130_fd_pr__nfet_01v8 ad=1.176e+12p pd=1.064e+07u as=0p ps=0u w=1.05e+06u l=150000u
X2 a_147_462# a_200_252# a_200_252# a_147_462# sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X3 a_402_462# a_200_252# a_147_462# a_147_462# sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X4 a_200_252# a_200_252# a_147_462# a_147_462# sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X5 a_147_462# a_200_252# a_402_462# a_147_462# sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X6 a_147_462# a_200_252# a_402_462# a_147_462# sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X7 a_147_462# a_200_252# a_200_252# a_147_462# sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X8 a_200_252# a_200_252# a_147_462# a_147_462# sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X9 a_402_462# a_200_252# a_147_462# a_147_462# sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X10 a_402_462# a_200_252# a_147_462# a_147_462# sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X11 a_147_462# a_200_252# a_200_252# a_147_462# sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X12 a_147_462# a_200_252# a_402_462# a_147_462# sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X13 a_200_252# a_200_252# a_147_462# a_147_462# sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X14 a_147_462# a_200_252# a_200_252# a_147_462# sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X15 a_147_462# a_200_252# a_402_462# a_147_462# sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
C0 a_200_252# a_402_462# 1.47fF
C1 a_402_462# a_147_462# 3.23fF
C2 a_200_252# a_147_462# 7.61fF
.ends

.subckt NMOS_S_93094360_X4_Y1_1678477364_1678477365 a_230_462# a_200_252# a_147_462#
X0 a_230_462# a_200_252# a_147_462# a_147_462# sky130_fd_pr__nfet_01v8 ad=1.176e+12p pd=1.064e+07u as=1.4385e+12p ps=1.324e+07u w=1.05e+06u l=150000u
X1 a_230_462# a_200_252# a_147_462# a_147_462# sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X2 a_147_462# a_200_252# a_230_462# a_147_462# sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X3 a_147_462# a_200_252# a_230_462# a_147_462# sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X4 a_230_462# a_200_252# a_147_462# a_147_462# sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X5 a_230_462# a_200_252# a_147_462# a_147_462# sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X6 a_147_462# a_200_252# a_230_462# a_147_462# sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X7 a_147_462# a_200_252# a_230_462# a_147_462# sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
C0 a_200_252# a_230_462# 0.44fF
C1 a_230_462# a_147_462# 2.99fF
C2 a_200_252# a_147_462# 2.52fF
.ends

.subckt CMB_NMOS_2_93363889_0_0_1678477365 m1_774_896# SCM_NMOS_38434623_X4_Y1_1678477365_1678477365_0/a_402_462#
+ NMOS_S_93094360_X4_Y1_1678477364_1678477365_0/a_230_462# VSUBS
XSCM_NMOS_38434623_X4_Y1_1678477365_1678477365_0 m1_774_896# SCM_NMOS_38434623_X4_Y1_1678477365_1678477365_0/a_402_462#
+ VSUBS SCM_NMOS_38434623_X4_Y1_1678477365_1678477365
XNMOS_S_93094360_X4_Y1_1678477364_1678477365_0 NMOS_S_93094360_X4_Y1_1678477364_1678477365_0/a_230_462#
+ m1_774_896# VSUBS NMOS_S_93094360_X4_Y1_1678477364_1678477365
C0 NMOS_S_93094360_X4_Y1_1678477364_1678477365_0/a_230_462# SCM_NMOS_38434623_X4_Y1_1678477365_1678477365_0/a_402_462# 0.00fF
C1 m1_774_896# NMOS_S_93094360_X4_Y1_1678477364_1678477365_0/a_230_462# -0.00fF
C2 m1_774_896# SCM_NMOS_38434623_X4_Y1_1678477365_1678477365_0/a_402_462# 0.03fF
C3 NMOS_S_93094360_X4_Y1_1678477364_1678477365_0/a_230_462# VSUBS 3.04fF
C4 SCM_NMOS_38434623_X4_Y1_1678477365_1678477365_0/a_402_462# VSUBS 3.32fF
C5 m1_774_896# VSUBS 10.44fF
.ends

.subckt NMOS_S_78993529_X4_Y1_1678477367 a_230_462# a_147_462#
X0 a_230_462# a_200_252# a_147_462# a_147_462# sky130_fd_pr__nfet_01v8 ad=1.176e+12p pd=1.064e+07u as=1.4385e+12p ps=1.324e+07u w=1.05e+06u l=150000u
X1 a_230_462# a_200_252# a_147_462# a_147_462# sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X2 a_147_462# a_200_252# a_230_462# a_147_462# sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X3 a_147_462# a_200_252# a_230_462# a_147_462# sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X4 a_230_462# a_200_252# a_147_462# a_147_462# sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X5 a_230_462# a_200_252# a_147_462# a_147_462# sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X6 a_147_462# a_200_252# a_230_462# a_147_462# sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X7 a_147_462# a_200_252# a_230_462# a_147_462# sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
C0 a_200_252# a_230_462# 0.44fF
C1 a_230_462# a_147_462# 2.99fF
C2 a_200_252# a_147_462# 2.52fF
.ends

.subckt SCM_PMOS_25290471_X4_Y1_1678477370 a_200_252# a_402_462# w_0_0# VSUBS
X0 a_200_252# a_200_252# w_0_0# w_0_0# sky130_fd_pr__pfet_01v8 ad=1.176e+12p pd=1.064e+07u as=2.6145e+12p ps=2.388e+07u w=1.05e+06u l=150000u
X1 w_0_0# a_200_252# a_402_462# w_0_0# sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=1.176e+12p ps=1.064e+07u w=1.05e+06u l=150000u
X2 w_0_0# a_200_252# a_402_462# w_0_0# sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X3 w_0_0# a_200_252# a_200_252# w_0_0# sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X4 a_200_252# a_200_252# w_0_0# w_0_0# sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X5 a_402_462# a_200_252# w_0_0# w_0_0# sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X6 a_402_462# a_200_252# w_0_0# w_0_0# sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X7 w_0_0# a_200_252# a_200_252# w_0_0# sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X8 w_0_0# a_200_252# a_402_462# w_0_0# sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X9 a_200_252# a_200_252# w_0_0# w_0_0# sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X10 w_0_0# a_200_252# a_200_252# w_0_0# sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X11 w_0_0# a_200_252# a_402_462# w_0_0# sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X12 a_402_462# a_200_252# w_0_0# w_0_0# sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X13 a_200_252# a_200_252# w_0_0# w_0_0# sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X14 w_0_0# a_200_252# a_200_252# w_0_0# sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X15 a_402_462# a_200_252# w_0_0# w_0_0# sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
C0 a_200_252# a_402_462# 1.47fF
C1 w_0_0# a_402_462# 3.52fF
C2 w_0_0# a_200_252# 7.84fF
C3 a_402_462# VSUBS -0.29fF
C4 a_200_252# VSUBS -0.24fF
C5 w_0_0# VSUBS 7.01fF
.ends

.subckt DCL_PMOS_S_3785225_X4_Y1_1678477366 a_200_252# w_0_0# VSUBS
X0 a_200_252# a_200_252# w_0_0# w_0_0# sky130_fd_pr__pfet_01v8 ad=1.176e+12p pd=1.064e+07u as=1.4385e+12p ps=1.324e+07u w=1.05e+06u l=150000u
X1 w_0_0# a_200_252# a_200_252# w_0_0# sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X2 w_0_0# a_200_252# a_200_252# w_0_0# sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X3 a_200_252# a_200_252# w_0_0# w_0_0# sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X4 a_200_252# a_200_252# w_0_0# w_0_0# sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X5 w_0_0# a_200_252# a_200_252# w_0_0# sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X6 w_0_0# a_200_252# a_200_252# w_0_0# sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X7 a_200_252# a_200_252# w_0_0# w_0_0# sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
C0 w_0_0# a_200_252# 6.09fF
C1 a_200_252# VSUBS 0.09fF
C2 w_0_0# VSUBS 4.72fF
.ends

.subckt NMOS_S_93094360_X4_Y1_1678477368 a_230_462# a_147_462#
X0 a_230_462# a_200_252# a_147_462# a_147_462# sky130_fd_pr__nfet_01v8 ad=1.176e+12p pd=1.064e+07u as=1.4385e+12p ps=1.324e+07u w=1.05e+06u l=150000u
X1 a_230_462# a_200_252# a_147_462# a_147_462# sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X2 a_147_462# a_200_252# a_230_462# a_147_462# sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X3 a_147_462# a_200_252# a_230_462# a_147_462# sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X4 a_230_462# a_200_252# a_147_462# a_147_462# sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X5 a_230_462# a_200_252# a_147_462# a_147_462# sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X6 a_147_462# a_200_252# a_230_462# a_147_462# sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X7 a_147_462# a_200_252# a_230_462# a_147_462# sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
C0 a_200_252# a_230_462# 0.44fF
C1 a_230_462# a_147_462# 2.99fF
C2 a_200_252# a_147_462# 2.52fF
.ends

.subckt ONEBITADC_0
XPMOS_S_59912959_X4_Y1_1678477369_0 m1_2376_2912# m1_774_1568# m1_1602_1568# VSUBS
+ PMOS_S_59912959_X4_Y1_1678477369
XCMB_NMOS_2_93363889_0_0_1678477365_0 m1_1516_2996# m1_2376_2912# VSUBS VSUBS CMB_NMOS_2_93363889_0_0_1678477365
XNMOS_S_78993529_X4_Y1_1678477367_0 m1_774_1400# VSUBS NMOS_S_78993529_X4_Y1_1678477367
XSCM_PMOS_25290471_X4_Y1_1678477370_0 m1_774_1400# m1_774_1568# m1_1602_1568# VSUBS
+ SCM_PMOS_25290471_X4_Y1_1678477370
XDCL_PMOS_S_3785225_X4_Y1_1678477366_0 m1_1516_2996# m1_1602_1568# VSUBS DCL_PMOS_S_3785225_X4_Y1_1678477366
XNMOS_S_93094360_X4_Y1_1678477368_0 m1_774_1568# VSUBS NMOS_S_93094360_X4_Y1_1678477368
C0 m1_1602_1568# m1_1516_2996# 0.57fF
C1 m1_774_1568# m1_774_1400# 0.64fF
C2 VDD VIN 0.07fF
C3 m1_2376_2912# m1_1516_2996# 0.02fF
C4 m1_2376_2912# m1_1602_1568# 0.00fF
C5 VIN m1_1516_2996# 0.02fF
C6 OUT m1_774_1400# 0.00fF
C7 m1_774_1568# OUT 0.01fF
C8 VDD m1_774_1400# 1.01fF
C9 m1_774_1568# VDD 1.27fF
C10 VREF VIN 0.01fF
C11 m1_774_1400# m1_1516_2996# 0.03fF
C12 m1_774_1568# m1_1516_2996# 0.06fF
C13 OUT VDD 0.00fF
C14 m1_1602_1568# m1_774_1400# 0.03fF
C15 m1_774_1568# m1_1602_1568# 0.26fF
C16 VREF m1_774_1400# 0.04fF
C17 m1_774_1568# VREF 0.00fF
C18 OUT m1_1516_2996# 0.31fF
C19 m1_1602_1568# OUT 0.09fF
C20 VDD m1_1516_2996# 0.33fF
C21 VIN m1_774_1400# 0.00fF
C22 m1_774_1568# VIN 0.00fF
C23 VREF VDD 0.03fF
C24 OUT VIN 0.00fF
C25 VREF VSUBS 0.02fF $ **FLOATING
C26 VIN VSUBS 0.02fF $ **FLOATING
C27 VDD VSUBS 0.45fF $ **FLOATING
C28 OUT VSUBS 0.02fF $ **FLOATING
C29 m1_774_1568# VSUBS 1.73fF
C30 NMOS_S_93094360_X4_Y1_1678477368_0/a_200_252# VSUBS 2.52fF $ **FLOATING
C31 m1_774_1400# VSUBS 2.27fF
C32 NMOS_S_78993529_X4_Y1_1678477367_0/a_200_252# VSUBS 2.52fF $ **FLOATING
C33 m1_2376_2912# VSUBS 3.24fF
C34 m1_1516_2996# VSUBS 7.85fF
C35 m1_1602_1568# VSUBS 16.86fF
.ends
```

- Merged the testbench netlist and the new generated netlist.
- Run the updated spice netlist(the extracted netlist which you get from magic does not contain the control statements(plots, sources, etc). It's just a bare subckt(black box or an IC). You must add the .control statements(power it) by pasting them from the pre-layout and get a similar results

![merged_align_output](https://user-images.githubusercontent.com/68071764/224702458-50ef47f2-5608-428e-9435-8ba8ea43f932.png)

![merged_output](https://user-images.githubusercontent.com/68071764/224702498-021a2b68-fb0e-4602-83e1-d9cfaa16d206.png)

## Pre-Layout Simulation of Ring oscillator with One bit ADC 

![schematic_adc_ring](https://user-images.githubusercontent.com/68071764/224703321-7a5aa207-1f00-40f6-9b37-29621112e59a.png)

- Netlist

```
** sch_path: /home/ativi07/Desktop/ALIGN-public/week0/inverter/xschem/onebitADC_test.sch
**.subckt onebitADC_test vref Vin out VDD VDD Vin
*.ipin vref
*.ipin Vin
*.opin out
*.iopin VDD
*.iopin VDD
*.ipin Vin
XM1 net2 net1 VDD VDD sky130_fd_pr__pfet_01v8 L=0.15 W=1 nf=1 ad='int((nf+1)/2) * W/nf * 0.29' as='int((nf+2)/2) * W/nf * 0.29'
+ pd='2*int((nf+1)/2) * (W/nf + 0.29)' ps='2*int((nf+2)/2) * (W/nf + 0.29)' nrd='0.29 / W' nrs='0.29 / W'
+ sa=0 sb=0 sd=0 mult=1 m=1
XM4 net1 vref net3 net3 sky130_fd_pr__nfet_01v8 L=0.15 W=1 nf=1 ad='int((nf+1)/2) * W/nf * 0.29' as='int((nf+2)/2) * W/nf * 0.29'
+ pd='2*int((nf+1)/2) * (W/nf + 0.29)' ps='2*int((nf+2)/2) * (W/nf + 0.29)' nrd='0.29 / W' nrs='0.29 / W'
+ sa=0 sb=0 sd=0 mult=1 m=1
XM5 out net4 GND GND sky130_fd_pr__nfet_01v8 L=0.15 W=1 nf=1 ad='int((nf+1)/2) * W/nf * 0.29' as='int((nf+2)/2) * W/nf * 0.29'
+ pd='2*int((nf+1)/2) * (W/nf + 0.29)' ps='2*int((nf+2)/2) * (W/nf + 0.29)' nrd='0.29 / W' nrs='0.29 / W'
+ sa=0 sb=0 sd=0 mult=1 m=1
XM6 out net2 VDD VDD sky130_fd_pr__pfet_01v8 L=0.15 W=1 nf=1 ad='int((nf+1)/2) * W/nf * 0.29' as='int((nf+2)/2) * W/nf * 0.29'
+ pd='2*int((nf+1)/2) * (W/nf + 0.29)' ps='2*int((nf+2)/2) * (W/nf + 0.29)' nrd='0.29 / W' nrs='0.29 / W'
+ sa=0 sb=0 sd=0 mult=1 m=1
XM7 net3 net4 GND GND sky130_fd_pr__nfet_01v8 L=0.15 W=1 nf=1 ad='int((nf+1)/2) * W/nf * 0.29' as='int((nf+2)/2) * W/nf * 0.29'
+ pd='2*int((nf+1)/2) * (W/nf + 0.29)' ps='2*int((nf+2)/2) * (W/nf + 0.29)' nrd='0.29 / W' nrs='0.29 / W'
+ sa=0 sb=0 sd=0 mult=1 m=1
V1 VDD GND 1.8
.save i(v1)
V2 vref GND 0.9
.save i(v2)
XM2 net1 net1 VDD VDD sky130_fd_pr__pfet_01v8 L=0.15 W=1 nf=1 ad='int((nf+1)/2) * W/nf * 0.29' as='int((nf+2)/2) * W/nf * 0.29'
+ pd='2*int((nf+1)/2) * (W/nf + 0.29)' ps='2*int((nf+2)/2) * (W/nf + 0.29)' nrd='0.29 / W' nrs='0.29 / W'
+ sa=0 sb=0 sd=0 mult=1 m=1
XM9 net4 net4 VDD VDD sky130_fd_pr__pfet_01v8 L=0.15 W=1 nf=1 ad='int((nf+1)/2) * W/nf * 0.29' as='int((nf+2)/2) * W/nf * 0.29'
+ pd='2*int((nf+1)/2) * (W/nf + 0.29)' ps='2*int((nf+2)/2) * (W/nf + 0.29)' nrd='0.29 / W' nrs='0.29 / W'
+ sa=0 sb=0 sd=0 mult=1 m=1
XM3 net2 Vin net3 net3 sky130_fd_pr__nfet_01v8 L=0.15 W=1 nf=1 ad='int((nf+1)/2) * W/nf * 0.29' as='int((nf+2)/2) * W/nf * 0.29'
+ pd='2*int((nf+1)/2) * (W/nf + 0.29)' ps='2*int((nf+2)/2) * (W/nf + 0.29)' nrd='0.29 / W' nrs='0.29 / W'
+ sa=0 sb=0 sd=0 mult=1 m=1
XM8 net4 net4 GND GND sky130_fd_pr__nfet_01v8 L=0.15 W=1 nf=1 ad='int((nf+1)/2) * W/nf * 0.29' as='int((nf+2)/2) * W/nf * 0.29'
+ pd='2*int((nf+1)/2) * (W/nf + 0.29)' ps='2*int((nf+2)/2) * (W/nf + 0.29)' nrd='0.29 / W' nrs='0.29 / W'
+ sa=0 sb=0 sd=0 mult=1 m=1
x1 VDD Vin GND RingOsc_cap
**** begin user architecture code

.lib /usr/local/share/pdk/sky130A/libs.tech/ngspice/sky130.lib.spice tt


.control
save all
tran 0.1n 100n
plot vin out vref
.endc

**** end user architecture code
**.ends

* expanding   symbol:  RING/RingOsc_cap.sym # of pins=3
** sym_path: /home/ativi07/Desktop/ALIGN-public/week0/inverter/xschem/RING/RingOsc_cap.sym
** sch_path: /home/ativi07/Desktop/ALIGN-public/week0/inverter/xschem/RING/RingOsc_cap.sch
.subckt RingOsc_cap vdd Y gnd
*.opin Y
*.iopin gnd
*.iopin vdd
XM1 net1 Y vdd vdd sky130_fd_pr__pfet_01v8 L=0.15 W=1 nf=1 ad='int((nf+1)/2) * W/nf * 0.29' as='int((nf+2)/2) * W/nf * 0.29'
+ pd='2*int((nf+1)/2) * (W/nf + 0.29)' ps='2*int((nf+2)/2) * (W/nf + 0.29)' nrd='0.29 / W' nrs='0.29 / W'
+ sa=0 sb=0 sd=0 mult=1 m=1
XM2 net2 net1 vdd vdd sky130_fd_pr__pfet_01v8 L=0.15 W=1 nf=1 ad='int((nf+1)/2) * W/nf * 0.29' as='int((nf+2)/2) * W/nf * 0.29'
+ pd='2*int((nf+1)/2) * (W/nf + 0.29)' ps='2*int((nf+2)/2) * (W/nf + 0.29)' nrd='0.29 / W' nrs='0.29 / W'
+ sa=0 sb=0 sd=0 mult=1 m=1
XM3 Y net2 vdd vdd sky130_fd_pr__pfet_01v8 L=0.15 W=1 nf=1 ad='int((nf+1)/2) * W/nf * 0.29' as='int((nf+2)/2) * W/nf * 0.29'
+ pd='2*int((nf+1)/2) * (W/nf + 0.29)' ps='2*int((nf+2)/2) * (W/nf + 0.29)' nrd='0.29 / W' nrs='0.29 / W'
+ sa=0 sb=0 sd=0 mult=1 m=1
XM4 net1 Y gnd gnd sky130_fd_pr__nfet_01v8 L=0.15 W=1 nf=1 ad='int((nf+1)/2) * W/nf * 0.29' as='int((nf+2)/2) * W/nf * 0.29'
+ pd='2*int((nf+1)/2) * (W/nf + 0.29)' ps='2*int((nf+2)/2) * (W/nf + 0.29)' nrd='0.29 / W' nrs='0.29 / W'
+ sa=0 sb=0 sd=0 mult=1 m=1
XM5 net2 net1 gnd gnd sky130_fd_pr__nfet_01v8 L=0.15 W=1 nf=1 ad='int((nf+1)/2) * W/nf * 0.29' as='int((nf+2)/2) * W/nf * 0.29'
+ pd='2*int((nf+1)/2) * (W/nf + 0.29)' ps='2*int((nf+2)/2) * (W/nf + 0.29)' nrd='0.29 / W' nrs='0.29 / W'
+ sa=0 sb=0 sd=0 mult=1 m=1
XM6 Y net2 gnd gnd sky130_fd_pr__nfet_01v8 L=0.15 W=1 nf=1 ad='int((nf+1)/2) * W/nf * 0.29' as='int((nf+2)/2) * W/nf * 0.29'
+ pd='2*int((nf+1)/2) * (W/nf + 0.29)' ps='2*int((nf+2)/2) * (W/nf + 0.29)' nrd='0.29 / W' nrs='0.29 / W'
+ sa=0 sb=0 sd=0 mult=1 m=1
XC1 net1 gnd sky130_fd_pr__cap_mim_m3_1 W=1 L=1 MF=10 m=10
XC2 net2 gnd sky130_fd_pr__cap_mim_m3_1 W=1 L=1 MF=10 m=10
XC3 Y gnd sky130_fd_pr__cap_mim_m3_1 W=1 L=1 MF=10 m=10
.ends

.GLOBAL GND
.end
```
![ring_adc_out](https://user-images.githubusercontent.com/68071764/224703366-5aa0f63b-4c4c-4d6e-8795-e605cd67edde.png)

![align_out_ringadc](https://user-images.githubusercontent.com/68071764/224703385-29cf5c97-8f23-4ce5-b1d5-1ed2df669c78.png)

### Top Module of Verilog Code for asynchronous up/down counter

```
module analog_async_up_down(
      input vin
      input VDD
      output out
);

wire ring_osc_out;

// Instantiate the RingOsc_cap module
RingOsc_cap RingOsc_cap_inst(
        .out(ring_osc_out)
);

// Instantiate the adc module
adc onebitADC_test_inst(
      .vin(ring_osc_out),
      .vref(vref),
      .out(out)
);

endmodule
```

### // Define the RingOsc_cap module
```
module RingOsc_cap(
       output Y
);

```

### // Define the adc module
```
module onebitADC_test(
       input vin,
       input vref,

       output out

);
```
