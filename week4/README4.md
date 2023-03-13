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

![image](https://user-images.githubusercontent.com/68071764/224415636-443c7540-743b-41ac-8a6c-6520ec68379b.png)

![VirtualBox_opensource_eda_ubuntu Clone_11_03_2023_01_34_18](https://user-images.githubusercontent.com/68071764/224417186-035915a5-d690-4bca-9444-ca9e9cbf018a.png)

![K_lef_onebitadc](https://user-images.githubusercontent.com/68071764/224645329-1fe632c6-50d1-4905-ab9f-aa42ddd3aaaa.png)

![VirtualBox_opensource_eda_ubuntu Clone_13_03_2023_13_56_04](https://user-images.githubusercontent.com/68071764/224646542-2b3fbf33-2277-4f59-860c-21d91ecca97f.png)
