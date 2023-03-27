# WEEK 3 AI's

- Three-stage ring oscillator design in Xschem
- Ring Oscillator is very desirable in the VLSI environment because of its integration ability. It is easy to design and easily integrated. Without the need for inductors, the ring oscillator occupies far less die area than a harmonic LC oscillator. It is simple and can be operated at Low-DC level. Unfortunately, the jitter performance of the ring oscillator falls short of the jitter performance of an LC oscillator. CMOS oscillators in today’s technology are typically implemented as ring oscillators or LCOscillators. It is a self-toggling circuit that generates clock-like pulses without any external input, other than the power that it needs. This is created by cascading inverters back to back in odd numbers (so that the next output is different than the previous). Following figure shows the design of a 3-stage ring oscillator created in Xschem.

![correct_ringosc](https://user-images.githubusercontent.com/68071764/222113788-94150e15-3644-41d2-8fa2-cb2a90920d52.png)

- Go to the symbol menu and click on "Make symbol from schematic". Now, we start our testbench schematic by opening a new schematic from file. Once the schematic is open, press the insert key, move to the local directory --> inverter.sym.
- Bring the symbol of our inverter into the new schematic and add all the extra components like voltage sources, gnd terminal and opins for the comparison between vin and vout.
- Once done,your schematic should look like this:
- 
![ring tb](https://user-images.githubusercontent.com/68071764/222115958-bfb77e64-3376-41a8-b267-066623ded5ea.png)

-   Simulate the testbench.
```
* sch_path: /home/ativi07/Desktop/ALIGN-public/week0/inverter/xschem/Ring_osc_tb.sch
**.subckt Ring_osc_tb vdd gnd Y
*.iopin vdd
*.iopin gnd
*.opin Y
x1 vdd Y gnd RingOsc
V1 vdd GND 1.8
.save i(v1)
**** begin user architecture code


.control
save all
tran 1p 3n
plot v(Y)
.endc


.lib /usr/local/share/pdk/sky130A/libs.tech/ngspice/sky130.lib.spice tt

**** end user architecture code
**.ends

* expanding   symbol:  RingOsc.sym # of pins=3
** sym_path: /home/ativi07/Desktop/ALIGN-public/week0/inverter/xschem/RingOsc.sym
** sch_path: /home/ativi07/Desktop/ALIGN-public/week0/inverter/xschem/RingOsc.sch
.subckt RingOsc vdd Y gnd
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
.ends

.GLOBAL GND
.end
```
![updated_tb_wave](https://user-images.githubusercontent.com/68071764/222692050-79a65cd7-6255-4d8f-b761-cc7326f3548d.png)

![wave2](https://user-images.githubusercontent.com/68071764/222692071-36d39d95-8594-4261-a0a3-b7c8b85dfd7c.png)

- we have verified the working of our Ring Oscilator schematic and we need a netist of exclusively that, and not our entire testbench. Open the testbench from the files menu and go to suimulation menu and select "LVS netlist: top lvl is a subsckt" and then tap netlist. Exit xschem.

- we need to import the netlist to magic to create the layout. Open magic by moving to the mag directory and using magic -T sky130A.Tech. Go to file --> Import SPICE and select our netlist from the .xschem/simulation folder.

- Now, just to get a working layout. Select cells by hovering over them and pressing i. Move them to a new location by hovering over the point you want the bottom left corner of the cell to be and pressing m. Once you move the cells around you should have a layout like this.

![layout_magic](https://user-images.githubusercontent.com/68071764/222116745-b6e22a82-538d-4299-8036-9b7ff2aaa9b5.png)

- go to File --> save and select autowrite
- Go to the command window and type the following:
```
extract do local
extract all
ext2spice cthresh 0 rthresh 0
ext2spice
```
- close magic.

-Simulate the spice file extracted from magic after modifications.

```
** sch_path: /home/ativi07/Desktop/ALIGN-public/week0/inverter/xschem/Ring_osc_tb.sch
**.subckt Ring_osc_tb vdd gnd Y
*.iopin vdd
*.iopin gnd
*.opin Y
x1 vdd Y gnd RingOsc
V1 vdd GND 1.8
.save i(v1)
**** begin user architecture code


.control
save all
tran 0.01n 40n
plot v(Y)
.endc


.lib /usr/local/share/pdk/sky130A/libs.tech/ngspice/sky130.lib.spice tt

**** end user architecture code
**.ends

* expanding   symbol:  RingOsc.sym # of pins=3
** sym_path: /home/ativi07/Desktop/ALIGN-public/week0/inverter/xschem/RingOsc.sym
** sch_path: /home/ativi07/Desktop/ALIGN-public/week0/inverter/xschem/RingOsc.sch
*.subckt RingOsc vdd Y gnd
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
*.ends

.GLOBAL GND
.end


* SPICE3 file created from RingOsc.ext - technology: sky130A

.subckt RingOsc Y gnd vdd
X0 m1_724_786# Y vdd XM1/w_n211_n319# sky130_fd_pr__pfet_01v8 ad=2.9e+11p pd=2.58e+06u as=8.7e+11p ps=7.74e+06u w=1e+06u l=150000u
X1 m1_1732_814# m1_724_786# vdd w_1654_652# sky130_fd_pr__pfet_01v8 ad=2.9e+11p pd=2.58e+06u as=0p ps=0u w=1e+06u l=150000u
X2 Y m1_1732_814# vdd XM3/w_n211_n319# sky130_fd_pr__pfet_01v8 ad=2.9e+11p pd=2.58e+06u as=0p ps=0u w=1e+06u l=150000u
X3 m1_724_786# Y gnd VSUBS sky130_fd_pr__nfet_01v8 ad=2.9e+11p pd=2.58e+06u as=8.7e+11p ps=7.74e+06u w=1e+06u l=150000u
X4 XM5/a_15_n100# m1_724_786# gnd VSUBS sky130_fd_pr__nfet_01v8 ad=2.9e+11p pd=2.58e+06u as=0p ps=0u w=1e+06u l=150000u
X5 Y m1_1732_814# gnd VSUBS sky130_fd_pr__nfet_01v8 ad=2.9e+11p pd=2.58e+06u as=0p ps=0u w=1e+06u l=150000u
C0 XM3/w_n211_n319# Y 0.17fF
C1 w_1654_652# XM1/w_n211_n319# 0.02fF
C2 XM1/w_n211_n319# gnd 0.00fF
C3 XM1/w_n211_n319# vdd 0.38fF
C4 m1_1732_814# m1_724_786# 0.15fF
C5 w_1654_652# gnd 0.00fF
C6 w_1654_652# vdd 0.28fF
C7 w_1654_652# XM5/a_15_n100# 0.00fF
C8 m1_1732_814# Y 1.11fF
C9 vdd gnd 0.01fF
C10 XM5/a_15_n100# gnd 0.17fF
C11 w_1654_652# XM3/w_n211_n319# 0.02fF
C12 XM3/w_n211_n319# vdd 0.18fF
C13 Y m1_724_786# 1.23fF
C14 XM1/w_n211_n319# m1_1732_814# 0.00fF
C15 w_1654_652# m1_1732_814# 0.19fF
C16 m1_1732_814# gnd 0.13fF
C17 XM1/w_n211_n319# m1_724_786# 0.17fF
C18 m1_1732_814# vdd 0.29fF
C19 m1_1732_814# XM5/a_15_n100# 0.03fF
C20 XM1/w_n211_n319# Y 0.37fF
C21 w_1654_652# m1_724_786# 0.42fF
C22 XM3/w_n211_n319# m1_1732_814# 0.37fF
C23 w_1654_652# Y 0.03fF
C24 m1_724_786# gnd 0.31fF
C25 vdd m1_724_786# 0.32fF
C26 XM5/a_15_n100# m1_724_786# 0.03fF
C27 Y gnd 0.25fF
C28 Y vdd 0.23fF
C29 Y XM5/a_15_n100# 0.00fF
C30 XM3/w_n211_n319# m1_724_786# 0.00fF
C31 m1_1732_814# VSUBS 0.53fF
**FLOATING
C32 m1_724_786# VSUBS 0.61fF
**FLOATING
C33 Y VSUBS 2.22fF
C34 gnd VSUBS 0.57fF
C35 XM5/a_15_n100# VSUBS 0.08fF
 **FLOATING
C36 vdd VSUBS 0.03fF
C37 XM3/w_n211_n319# VSUBS 1.09fF
**FLOATING
C38 w_1654_652# VSUBS 1.00fF
 **FLOATING
C39 XM1/w_n211_n319# VSUBS 1.09fF
 **FLOATING
.ends
```
![magic_postoutput](https://user-images.githubusercontent.com/68071764/222129561-c3bce623-6e1a-4ed5-867e-ecfc0eb0f620.png)

![magic_post_layout](https://user-images.githubusercontent.com/68071764/222129596-5b90ceaa-aa93-4831-ad11-fa1f6b3943b7.png)
 
# Post-layout simulation of ring oscillator using ALIGN

- Create a python virtualenv
```
python -m venv general
source general/bin/activate
python -m pip install pip --upgrade
mkdir build
cd build
```

- Run Design after modifying the nf value here to get the desired output(use your original inverter spice file generated from xschem as input)

```
.subckt RingOsc Y gnd vdd

XM1 net1 Y vdd vdd sky130_fd_pr__pfet_01v8 L=150e-09 W=10.5e-7 nf=10 m=1
XM2 net2 net1 vdd vdd sky130_fd_pr__pfet_01v8 L=150e-09 W=10.5e-7 nf=10 m=1
XM3 Y net2 vdd vdd sky130_fd_pr__pfet_01v8 L=150e-09 W=10.5e-7 nf=10 m=1
XM4 net1 Y gnd gnd sky130_fd_pr__nfet_01v8 L=150e-09 W=10.5e-7 nf=10 m=1
XM5 net2 net1 gnd gnd sky130_fd_pr__nfet_01v8 L=150e-09 W=10.5e-7 nf=10 m=1
XM6 Y net2 gnd gnd sky130_fd_pr__nfet_01v8 L=150e-09 W=10.5e-7 nf=10 m=1
.ends
```

![gds generated](https://user-images.githubusercontent.com/68071764/222158855-5d21a536-238d-4884-b124-0fd881e110bb.png)

- Now open .gds file using magic tool(Go to options and Read GDS).

![gds_updated](https://user-images.githubusercontent.com/68071764/222697385-8a95c854-130d-4506-8a95-ca24616aaa06.png)

- GDS file loaded, Extract the netlist file. 

![extracted](https://user-images.githubusercontent.com/68071764/222166820-808069a1-0e10-4eac-aee9-522da5f784f4.png)

- New spice netlist will be created. 
```
SPICE3 file created from RINGOSC_0.ext - technology: sky130A

X0 Y m1_828_1568# VDD VDD sky130_fd_pr__pfet_01v8 ad=1.47e+12p pd=1.33e+07u as=5.1975e+12p ps=4.77e+07u w=1.05e+06u l=150000u
X1 VDD m1_828_1568# Y VDD sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X2 VDD m1_828_1568# Y VDD sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X3 Y m1_828_1568# VDD VDD sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X4 Y m1_828_1568# VDD VDD sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X5 VDD m1_828_1568# Y VDD sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X6 Y m1_828_1568# VDD VDD sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X7 VDD m1_828_1568# Y VDD sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X8 VDD m1_828_1568# Y VDD sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X9 Y m1_828_1568# VDD VDD sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X10 Y m1_828_1568# GND GND sky130_fd_pr__nfet_01v8 ad=1.47e+12p pd=1.33e+07u as=5.1975e+12p ps=4.77e+07u w=1.05e+06u l=150000u
X11 Y m1_828_1568# GND GND sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X12 GND m1_828_1568# Y GND sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X13 GND m1_828_1568# Y GND sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X14 Y m1_828_1568# GND GND sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X15 Y m1_828_1568# GND GND sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X16 GND m1_828_1568# Y GND sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X17 Y m1_828_1568# GND GND sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X18 GND m1_828_1568# Y GND sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X19 GND m1_828_1568# Y GND sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X20 m1_828_1568# STAGE2_INV_62673116_0_0_1677840459_0/li_1179_1495# GND GND sky130_fd_pr__nfet_01v8 ad=1.47e+12p pd=1.33e+07u as=0p ps=0u w=1.05e+06u l=150000u
X21 m1_828_1568# STAGE2_INV_62673116_0_0_1677840459_0/li_1179_1495# GND GND sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X22 GND STAGE2_INV_62673116_0_0_1677840459_0/li_1179_1495# m1_828_1568# GND sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X23 GND STAGE2_INV_62673116_0_0_1677840459_0/li_1179_1495# m1_828_1568# GND sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X24 m1_828_1568# STAGE2_INV_62673116_0_0_1677840459_0/li_1179_1495# GND GND sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X25 m1_828_1568# STAGE2_INV_62673116_0_0_1677840459_0/li_1179_1495# GND GND sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X26 GND STAGE2_INV_62673116_0_0_1677840459_0/li_1179_1495# m1_828_1568# GND sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X27 m1_828_1568# STAGE2_INV_62673116_0_0_1677840459_0/li_1179_1495# GND GND sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X28 GND STAGE2_INV_62673116_0_0_1677840459_0/li_1179_1495# m1_828_1568# GND sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X29 GND STAGE2_INV_62673116_0_0_1677840459_0/li_1179_1495# m1_828_1568# GND sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X30 STAGE2_INV_62673116_0_0_1677840459_0/li_1179_1495# Y GND GND sky130_fd_pr__nfet_01v8 ad=1.47e+12p pd=1.33e+07u as=0p ps=0u w=1.05e+06u l=150000u
X31 STAGE2_INV_62673116_0_0_1677840459_0/li_1179_1495# Y GND GND sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X32 GND Y STAGE2_INV_62673116_0_0_1677840459_0/li_1179_1495# GND sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X33 GND Y STAGE2_INV_62673116_0_0_1677840459_0/li_1179_1495# GND sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X34 STAGE2_INV_62673116_0_0_1677840459_0/li_1179_1495# Y GND GND sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X35 STAGE2_INV_62673116_0_0_1677840459_0/li_1179_1495# Y GND GND sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X36 GND Y STAGE2_INV_62673116_0_0_1677840459_0/li_1179_1495# GND sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X37 STAGE2_INV_62673116_0_0_1677840459_0/li_1179_1495# Y GND GND sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X38 GND Y STAGE2_INV_62673116_0_0_1677840459_0/li_1179_1495# GND sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X39 GND Y STAGE2_INV_62673116_0_0_1677840459_0/li_1179_1495# GND sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X40 STAGE2_INV_62673116_0_0_1677840459_0/li_1179_1495# Y VDD VDD sky130_fd_pr__pfet_01v8 ad=1.47e+12p pd=1.33e+07u as=0p ps=0u w=1.05e+06u l=150000u
X41 VDD Y STAGE2_INV_62673116_0_0_1677840459_0/li_1179_1495# VDD sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X42 VDD Y STAGE2_INV_62673116_0_0_1677840459_0/li_1179_1495# VDD sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X43 STAGE2_INV_62673116_0_0_1677840459_0/li_1179_1495# Y VDD VDD sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X44 STAGE2_INV_62673116_0_0_1677840459_0/li_1179_1495# Y VDD VDD sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X45 VDD Y STAGE2_INV_62673116_0_0_1677840459_0/li_1179_1495# VDD sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X46 STAGE2_INV_62673116_0_0_1677840459_0/li_1179_1495# Y VDD VDD sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X47 VDD Y STAGE2_INV_62673116_0_0_1677840459_0/li_1179_1495# VDD sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X48 VDD Y STAGE2_INV_62673116_0_0_1677840459_0/li_1179_1495# VDD sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X49 STAGE2_INV_62673116_0_0_1677840459_0/li_1179_1495# Y VDD VDD sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X50 m1_828_1568# STAGE2_INV_62673116_0_0_1677840459_0/li_1179_1495# VDD VDD sky130_fd_pr__pfet_01v8 ad=1.47e+12p pd=1.33e+07u as=0p ps=0u w=1.05e+06u l=150000u
X51 VDD STAGE2_INV_62673116_0_0_1677840459_0/li_1179_1495# m1_828_1568# VDD sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X52 VDD STAGE2_INV_62673116_0_0_1677840459_0/li_1179_1495# m1_828_1568# VDD sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X53 m1_828_1568# STAGE2_INV_62673116_0_0_1677840459_0/li_1179_1495# VDD VDD sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X54 m1_828_1568# STAGE2_INV_62673116_0_0_1677840459_0/li_1179_1495# VDD VDD sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X55 VDD STAGE2_INV_62673116_0_0_1677840459_0/li_1179_1495# m1_828_1568# VDD sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X56 m1_828_1568# STAGE2_INV_62673116_0_0_1677840459_0/li_1179_1495# VDD VDD sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X57 VDD STAGE2_INV_62673116_0_0_1677840459_0/li_1179_1495# m1_828_1568# VDD sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X58 VDD STAGE2_INV_62673116_0_0_1677840459_0/li_1179_1495# m1_828_1568# VDD sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X59 m1_828_1568# STAGE2_INV_62673116_0_0_1677840459_0/li_1179_1495# VDD VDD sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
C0 VDD Y 8.55fF
C1 VDD STAGE2_INV_62673116_0_0_1677840459_0/li_1179_1495# 8.51fF
C2 Y STAGE2_INV_62673116_0_0_1677840459_0/li_1179_1495# 1.49fF
C3 VDD m1_828_1568# 7.87fF
C4 Y m1_828_1568# 1.84fF
C5 m1_828_1568# STAGE2_INV_62673116_0_0_1677840459_0/li_1179_1495# 1.83fF
C6 m1_828_1568# GND 6.52fF **FLOATING
C7 STAGE2_INV_62673116_0_0_1677840459_0/li_1179_1495# GND 5.34fF **FLOATING
C8 VDD GND 17.11fF **FLOATING
C9 Y GND 6.41fF **FLOATING 
```
- Merged the testbench netlist and the new generated netlist.
```
SPICE3 file created from RINGOSC_0.ext - technology: sky130A
x1 vdd Y gnd RingOsc
V1 vdd GND 1.8
**** end user architecture code
.control
save all
tran 1p 3n
plot v(Y)
.endc
.lib /usr/local/share/pdk/sky130A/libs.tech/ngspice/sky130.lib.spice tt
.subckt RingOsc vdd Y gnd
X0 Y m1_828_1568# VDD VDD sky130_fd_pr__pfet_01v8 ad=1.47e+12p pd=1.33e+07u as=5.1975e+12p ps=4.77e+07u w=1.05e+06u l=150000u
X1 VDD m1_828_1568# Y VDD sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X2 VDD m1_828_1568# Y VDD sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X3 Y m1_828_1568# VDD VDD sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X4 Y m1_828_1568# VDD VDD sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X5 VDD m1_828_1568# Y VDD sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X6 Y m1_828_1568# VDD VDD sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X7 VDD m1_828_1568# Y VDD sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X8 VDD m1_828_1568# Y VDD sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X9 Y m1_828_1568# VDD VDD sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X10 Y m1_828_1568# GND GND sky130_fd_pr__nfet_01v8 ad=1.47e+12p pd=1.33e+07u as=5.1975e+12p ps=4.77e+07u w=1.05e+06u l=150000u
X11 Y m1_828_1568# GND GND sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X12 GND m1_828_1568# Y GND sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X13 GND m1_828_1568# Y GND sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X14 Y m1_828_1568# GND GND sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X15 Y m1_828_1568# GND GND sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X16 GND m1_828_1568# Y GND sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X17 Y m1_828_1568# GND GND sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X18 GND m1_828_1568# Y GND sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X19 GND m1_828_1568# Y GND sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X20 m1_828_1568# STAGE2_INV_62673116_0_0_1677840459_0/li_1179_1495# GND GND sky130_fd_pr__nfet_01v8 ad=1.47e+12p pd=1.33e+07u as=0p ps=0u w=1.05e+06u l=150000u
X21 m1_828_1568# STAGE2_INV_62673116_0_0_1677840459_0/li_1179_1495# GND GND sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X22 GND STAGE2_INV_62673116_0_0_1677840459_0/li_1179_1495# m1_828_1568# GND sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X23 GND STAGE2_INV_62673116_0_0_1677840459_0/li_1179_1495# m1_828_1568# GND sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X24 m1_828_1568# STAGE2_INV_62673116_0_0_1677840459_0/li_1179_1495# GND GND sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X25 m1_828_1568# STAGE2_INV_62673116_0_0_1677840459_0/li_1179_1495# GND GND sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X26 GND STAGE2_INV_62673116_0_0_1677840459_0/li_1179_1495# m1_828_1568# GND sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X27 m1_828_1568# STAGE2_INV_62673116_0_0_1677840459_0/li_1179_1495# GND GND sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X28 GND STAGE2_INV_62673116_0_0_1677840459_0/li_1179_1495# m1_828_1568# GND sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X29 GND STAGE2_INV_62673116_0_0_1677840459_0/li_1179_1495# m1_828_1568# GND sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X30 STAGE2_INV_62673116_0_0_1677840459_0/li_1179_1495# Y GND GND sky130_fd_pr__nfet_01v8 ad=1.47e+12p pd=1.33e+07u as=0p ps=0u w=1.05e+06u l=150000u
X31 STAGE2_INV_62673116_0_0_1677840459_0/li_1179_1495# Y GND GND sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X32 GND Y STAGE2_INV_62673116_0_0_1677840459_0/li_1179_1495# GND sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X33 GND Y STAGE2_INV_62673116_0_0_1677840459_0/li_1179_1495# GND sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X34 STAGE2_INV_62673116_0_0_1677840459_0/li_1179_1495# Y GND GND sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X35 STAGE2_INV_62673116_0_0_1677840459_0/li_1179_1495# Y GND GND sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X36 GND Y STAGE2_INV_62673116_0_0_1677840459_0/li_1179_1495# GND sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X37 STAGE2_INV_62673116_0_0_1677840459_0/li_1179_1495# Y GND GND sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X38 GND Y STAGE2_INV_62673116_0_0_1677840459_0/li_1179_1495# GND sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X39 GND Y STAGE2_INV_62673116_0_0_1677840459_0/li_1179_1495# GND sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X40 STAGE2_INV_62673116_0_0_1677840459_0/li_1179_1495# Y VDD VDD sky130_fd_pr__pfet_01v8 ad=1.47e+12p pd=1.33e+07u as=0p ps=0u w=1.05e+06u l=150000u
X41 VDD Y STAGE2_INV_62673116_0_0_1677840459_0/li_1179_1495# VDD sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X42 VDD Y STAGE2_INV_62673116_0_0_1677840459_0/li_1179_1495# VDD sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X43 STAGE2_INV_62673116_0_0_1677840459_0/li_1179_1495# Y VDD VDD sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X44 STAGE2_INV_62673116_0_0_1677840459_0/li_1179_1495# Y VDD VDD sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X45 VDD Y STAGE2_INV_62673116_0_0_1677840459_0/li_1179_1495# VDD sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X46 STAGE2_INV_62673116_0_0_1677840459_0/li_1179_1495# Y VDD VDD sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X47 VDD Y STAGE2_INV_62673116_0_0_1677840459_0/li_1179_1495# VDD sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X48 VDD Y STAGE2_INV_62673116_0_0_1677840459_0/li_1179_1495# VDD sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X49 STAGE2_INV_62673116_0_0_1677840459_0/li_1179_1495# Y VDD VDD sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X50 m1_828_1568# STAGE2_INV_62673116_0_0_1677840459_0/li_1179_1495# VDD VDD sky130_fd_pr__pfet_01v8 ad=1.47e+12p pd=1.33e+07u as=0p ps=0u w=1.05e+06u l=150000u
X51 VDD STAGE2_INV_62673116_0_0_1677840459_0/li_1179_1495# m1_828_1568# VDD sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X52 VDD STAGE2_INV_62673116_0_0_1677840459_0/li_1179_1495# m1_828_1568# VDD sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X53 m1_828_1568# STAGE2_INV_62673116_0_0_1677840459_0/li_1179_1495# VDD VDD sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X54 m1_828_1568# STAGE2_INV_62673116_0_0_1677840459_0/li_1179_1495# VDD VDD sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X55 VDD STAGE2_INV_62673116_0_0_1677840459_0/li_1179_1495# m1_828_1568# VDD sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X56 m1_828_1568# STAGE2_INV_62673116_0_0_1677840459_0/li_1179_1495# VDD VDD sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X57 VDD STAGE2_INV_62673116_0_0_1677840459_0/li_1179_1495# m1_828_1568# VDD sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X58 VDD STAGE2_INV_62673116_0_0_1677840459_0/li_1179_1495# m1_828_1568# VDD sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X59 m1_828_1568# STAGE2_INV_62673116_0_0_1677840459_0/li_1179_1495# VDD VDD sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
C0 VDD Y 8.55fF
C1 VDD STAGE2_INV_62673116_0_0_1677840459_0/li_1179_1495# 8.51fF
C2 Y STAGE2_INV_62673116_0_0_1677840459_0/li_1179_1495# 1.49fF
C3 VDD m1_828_1568# 7.87fF
C4 Y m1_828_1568# 1.84fF
C5 m1_828_1568# STAGE2_INV_62673116_0_0_1677840459_0/li_1179_1495# 1.83fF
C6 m1_828_1568# GND 6.52fF
 **FLOATING
C7 STAGE2_INV_62673116_0_0_1677840459_0/li_1179_1495# GND 5.34fF
 **FLOATING
C8 VDD GND 17.11fF
**FLOATING
C9 Y GND 6.41fF
**FLOATING
.ends
```
- Output waveform from above post layout simulation using ALIGN

![updated_tb_wave](https://user-images.githubusercontent.com/68071764/222703956-697bb70f-2fb5-4151-9917-5705eb038ff8.png)

![updated_align_waveform](https://user-images.githubusercontent.com/68071764/222704097-343c1b6d-1adf-437f-9df8-be4cad666569.png)

## Conclusion

- The XSchem tool was used to create a schematic for a 3-stage Ring Oscillator, and the desired output was achieved through Ngspice simulation. To convert the netlist into a layout in GDS format, ALIGN was used. Then, the GDS file was converted back into a netlist with parasitics using Magic, and the waveform output was simulated using Ngspice. It was observed that the output of the ALIGN tool remained unchanged, but the time period of the oscillator increased, leading to a reduction in the maximum operating speed.

- After designing a custom layout for the Ring Oscillator, the output of Magic was analyzed using Ngspice, which produced results similar to those obtained with ALIGN, but with a longer time period. Thus, it can be concluded that ALIGN is a suitable tool for the job as it requires less effort and delivers satisfactory results.


