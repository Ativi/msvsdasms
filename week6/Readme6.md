# WEEK 6 AI's

####  Design And Align Simulation Of  window Comparator using AVSD_OPAMP
- A window comparator is an electronic circuit that compares an input signal with two reference voltages and provides an output signal based on whether the input signal is within or outside of the voltage range defined by the reference voltages. It is often used in analog-to-digital converters, sensor interfaces, and other applications where it is necessary to determine whether a signal is above or below a certain threshold.


#### AVSD_OPAMP

![avsd_opamp](https://user-images.githubusercontent.com/68071764/229117508-3b3c27ee-d8fe-40f5-93d6-4f76a20115ed.png)

- In the context of an AVSD op-amp, level shift refers to the process of changing the voltage level of a signal from one domain to another. For example, if an AVSD op-amp is used to shift a signal from a low-voltage domain to a high-voltage domain, the op-amp will shift the voltage levels of the signal by a certain amount, known as the level shift.The level shift provided by an AVSD op-amp is determined by the circuit's feedback network and the op-amp's gain. The feedback network is designed to provide a specific gain for the op-amp, which determines the amount of voltage shift applied to the input signal. For example, if the op-amp has a gain of 2 and the input signal is 1V, the output signal will be shifted by 2V.
- The level shift provided by an AVSD op-amp can be positive or negative, depending on the circuit design. A positive level shift increases the voltage level of the input signal, while a negative level shift decreases the voltage level of the input signal. The level shift is important because it allows signals to be properly interfaced between circuits that operate at different voltage levels, enabling communication and data transfer between them.

![VirtualBox_opensource_eda_ubuntu Clone_31_03_2023_18_10_14](https://user-images.githubusercontent.com/68071764/229122593-3176e733-f0e8-43a9-a249-2f619edf0e7c.png)


![AVSD_OUT2](https://user-images.githubusercontent.com/68071764/229121792-da52138e-d788-4eb9-9035-75314dcc54cf.png)

![OUTPUT_AVSD](https://user-images.githubusercontent.com/68071764/229122311-0dc0211f-21e0-4cd5-9b4c-320c4e0e6709.png)

#### WINDOW_COMPARATOR

![W_C](https://user-images.githubusercontent.com/68071764/229284478-6d98227b-b20f-41fc-a9ce-af15465a0db1.png)

![wc_output](https://user-images.githubusercontent.com/68071764/229284810-cf1fd1b7-66bd-4622-ae9d-37a800aeb932.png)

![image](https://user-images.githubusercontent.com/68071764/229285065-1fd8168b-54af-4859-b9c7-95302f784efb.png)

##### Netlist

```
** sch_path: /home/ativi07/Downloads/window_comparator.sch
**.subckt window_comparator IN3 IN2 IN1 IN2
*.ipin IN3
*.ipin IN2
*.ipin IN1
*.ipin IN2
XM1 net1 net1 VDD VDD sky130_fd_pr__pfet_01v8 L=0.15 W=1 nf=1 ad='int((nf+1)/2) * W/nf * 0.29' as='int((nf+2)/2) * W/nf * 0.29'
+ pd='2*int((nf+1)/2) * (W/nf + 0.29)' ps='2*int((nf+2)/2) * (W/nf + 0.29)' nrd='0.29 / W' nrs='0.29 / W'
+ sa=0 sb=0 sd=0 mult=1 m=1
XM2 via1 net1 VDD VDD sky130_fd_pr__pfet_01v8 L=0.15 W=1 nf=1 ad='int((nf+1)/2) * W/nf * 0.29' as='int((nf+2)/2) * W/nf * 0.29'
+ pd='2*int((nf+1)/2) * (W/nf + 0.29)' ps='2*int((nf+2)/2) * (W/nf + 0.29)' nrd='0.29 / W' nrs='0.29 / W'
+ sa=0 sb=0 sd=0 mult=1 m=1
XM4 OUT1 via1 VDD VDD sky130_fd_pr__pfet_01v8 L=0.15 W=1 nf=1 ad='int((nf+1)/2) * W/nf * 0.29' as='int((nf+2)/2) * W/nf * 0.29'
+ pd='2*int((nf+1)/2) * (W/nf + 0.29)' ps='2*int((nf+2)/2) * (W/nf + 0.29)' nrd='0.29 / W' nrs='0.29 / W'
+ sa=0 sb=0 sd=0 mult=1 m=1
XM5 net1 IN1 net2 net2 sky130_fd_pr__nfet_01v8 L=0.15 W=1 nf=1 ad='int((nf+1)/2) * W/nf * 0.29' as='int((nf+2)/2) * W/nf * 0.29'
+ pd='2*int((nf+1)/2) * (W/nf + 0.29)' ps='2*int((nf+2)/2) * (W/nf + 0.29)' nrd='0.29 / W' nrs='0.29 / W'
+ sa=0 sb=0 sd=0 mult=1 m=1
XM6 via1 IN2 net2 net2 sky130_fd_pr__nfet_01v8 L=0.15 W=1 nf=1 ad='int((nf+1)/2) * W/nf * 0.29' as='int((nf+2)/2) * W/nf * 0.29'
+ pd='2*int((nf+1)/2) * (W/nf + 0.29)' ps='2*int((nf+2)/2) * (W/nf + 0.29)' nrd='0.29 / W' nrs='0.29 / W'
+ sa=0 sb=0 sd=0 mult=1 m=1
XM7 net2 REF VSS VSS sky130_fd_pr__nfet_01v8 L=0.15 W=1 nf=1 ad='int((nf+1)/2) * W/nf * 0.29' as='int((nf+2)/2) * W/nf * 0.29'
+ pd='2*int((nf+1)/2) * (W/nf + 0.29)' ps='2*int((nf+2)/2) * (W/nf + 0.29)' nrd='0.29 / W' nrs='0.29 / W'
+ sa=0 sb=0 sd=0 mult=1 m=1
XM8 OUT1 REF VSS VSS sky130_fd_pr__nfet_01v8 L=0.15 W=1 nf=1 ad='int((nf+1)/2) * W/nf * 0.29' as='int((nf+2)/2) * W/nf * 0.29'
+ pd='2*int((nf+1)/2) * (W/nf + 0.29)' ps='2*int((nf+2)/2) * (W/nf + 0.29)' nrd='0.29 / W' nrs='0.29 / W'
+ sa=0 sb=0 sd=0 mult=1 m=1
XR1 REF VDD VSS sky130_fd_pr__res_high_po_0p69 L=100 mult=1 m=1
V1 VDD GND 1.8
.save i(v1)
V2 VSS GND 0
.save i(v2)
V4 IN2 GND sine (1.2 1m 1k)
.save i(v4)
XM3 REF REF VSS VSS sky130_fd_pr__nfet_01v8 L=0.15 W=1 nf=1 ad='int((nf+1)/2) * W/nf * 0.29' as='int((nf+2)/2) * W/nf * 0.29'
+ pd='2*int((nf+1)/2) * (W/nf + 0.29)' ps='2*int((nf+2)/2) * (W/nf + 0.29)' nrd='0.29 / W' nrs='0.29 / W'
+ sa=0 sb=0 sd=0 mult=1 m=1
XM9 net3 net3 VDD VDD sky130_fd_pr__pfet_01v8 L=0.15 W=1 nf=1 ad='int((nf+1)/2) * W/nf * 0.29' as='int((nf+2)/2) * W/nf * 0.29'
+ pd='2*int((nf+1)/2) * (W/nf + 0.29)' ps='2*int((nf+2)/2) * (W/nf + 0.29)' nrd='0.29 / W' nrs='0.29 / W'
+ sa=0 sb=0 sd=0 mult=1 m=1
XM10 via2 net3 VDD VDD sky130_fd_pr__pfet_01v8 L=0.15 W=1 nf=1 ad='int((nf+1)/2) * W/nf * 0.29' as='int((nf+2)/2) * W/nf * 0.29'
+ pd='2*int((nf+1)/2) * (W/nf + 0.29)' ps='2*int((nf+2)/2) * (W/nf + 0.29)' nrd='0.29 / W' nrs='0.29 / W'
+ sa=0 sb=0 sd=0 mult=1 m=1
XM11 OUT2 via2 VDD VDD sky130_fd_pr__pfet_01v8 L=0.15 W=1 nf=1 ad='int((nf+1)/2) * W/nf * 0.29' as='int((nf+2)/2) * W/nf * 0.29'
+ pd='2*int((nf+1)/2) * (W/nf + 0.29)' ps='2*int((nf+2)/2) * (W/nf + 0.29)' nrd='0.29 / W' nrs='0.29 / W'
+ sa=0 sb=0 sd=0 mult=1 m=1
XM12 net3 IN2 net4 net4 sky130_fd_pr__nfet_01v8 L=0.15 W=1 nf=1 ad='int((nf+1)/2) * W/nf * 0.29' as='int((nf+2)/2) * W/nf * 0.29'
+ pd='2*int((nf+1)/2) * (W/nf + 0.29)' ps='2*int((nf+2)/2) * (W/nf + 0.29)' nrd='0.29 / W' nrs='0.29 / W'
+ sa=0 sb=0 sd=0 mult=1 m=1
XM13 via2 IN3 net4 net4 sky130_fd_pr__nfet_01v8 L=0.15 W=1 nf=1 ad='int((nf+1)/2) * W/nf * 0.29' as='int((nf+2)/2) * W/nf * 0.29'
+ pd='2*int((nf+1)/2) * (W/nf + 0.29)' ps='2*int((nf+2)/2) * (W/nf + 0.29)' nrd='0.29 / W' nrs='0.29 / W'
+ sa=0 sb=0 sd=0 mult=1 m=1
XM14 net4 REF VSS VSS sky130_fd_pr__nfet_01v8 L=0.15 W=1 nf=1 ad='int((nf+1)/2) * W/nf * 0.29' as='int((nf+2)/2) * W/nf * 0.29'
+ pd='2*int((nf+1)/2) * (W/nf + 0.29)' ps='2*int((nf+2)/2) * (W/nf + 0.29)' nrd='0.29 / W' nrs='0.29 / W'
+ sa=0 sb=0 sd=0 mult=1 m=1
XM15 OUT2 REF VSS VSS sky130_fd_pr__nfet_01v8 L=0.15 W=1 nf=1 ad='int((nf+1)/2) * W/nf * 0.29' as='int((nf+2)/2) * W/nf * 0.29'
+ pd='2*int((nf+1)/2) * (W/nf + 0.29)' ps='2*int((nf+2)/2) * (W/nf + 0.29)' nrd='0.29 / W' nrs='0.29 / W'
+ sa=0 sb=0 sd=0 mult=1 m=1
XR2 REF VDD VSS sky130_fd_pr__res_high_po_0p69 L=100 mult=1 m=1
XM16 REF REF VSS VSS sky130_fd_pr__nfet_01v8 L=0.15 W=1 nf=1 ad='int((nf+1)/2) * W/nf * 0.29' as='int((nf+2)/2) * W/nf * 0.29'
+ pd='2*int((nf+1)/2) * (W/nf + 0.29)' ps='2*int((nf+2)/2) * (W/nf + 0.29)' nrd='0.29 / W' nrs='0.29 / W'
+ sa=0 sb=0 sd=0 mult=1 m=1
XR3 GND IN3 GND sky130_fd_pr__res_generic_nd W=1 L=100 mult=1 m=1
XR4 IN3 IN1 GND sky130_fd_pr__res_generic_nd W=1 L=100 mult=1 m=1
XR5 IN1 VDD GND sky130_fd_pr__res_generic_nd W=1 L=100 mult=1 m=1
**** begin user architecture code
.control
save all
tran 1m 5m
plot OUT1 OUT2
.endc
.lib /usr/local/share/pdk/sky130A/libs.tech/ngspice/sky130.lib.spice tt
**** end user architecture code
**.ends
.GLOBAL GND
.end
```

- NEW CIRCUIT FOR ALIGN 

![schematic](https://user-images.githubusercontent.com/68071764/230721499-5ef15d14-f6ef-4de7-8e46-609c72d280c8.png)
![output3](https://user-images.githubusercontent.com/68071764/230721505-943db3d5-9f8a-43fe-aade-577d9c8b137f.png)
