# VSD Mixed-signal PD Research Program

# WEEK 6 AI's

#### 1. Design And Align Simulation Of  window Comparator
- A window comparator is an electronic circuit that compares an input signal with two reference voltages and provides an output signal based on whether the input signal is within or outside of the voltage range defined by the reference voltages. It is often used in analog-to-digital converters, sensor interfaces, and other applications where it is necessary to determine whether a signal is above or below a certain threshold.


#### AVSD_OPAMP

![avsd_opamp](https://user-images.githubusercontent.com/68071764/229117508-3b3c27ee-d8fe-40f5-93d6-4f76a20115ed.png)

- In the context of an AVSD op-amp, level shift refers to the process of changing the voltage level of a signal from one domain to another. For example, if an AVSD op-amp is used to shift a signal from a low-voltage domain to a high-voltage domain, the op-amp will shift the voltage levels of the signal by a certain amount, known as the level shift.The level shift provided by an AVSD op-amp is determined by the circuit's feedback network and the op-amp's gain. The feedback network is designed to provide a specific gain for the op-amp, which determines the amount of voltage shift applied to the input signal. For example, if the op-amp has a gain of 2 and the input signal is 1V, the output signal will be shifted by 2V.
- The level shift provided by an AVSD op-amp can be positive or negative, depending on the circuit design. A positive level shift increases the voltage level of the input signal, while a negative level shift decreases the voltage level of the input signal. The level shift is important because it allows signals to be properly interfaced between circuits that operate at different voltage levels, enabling communication and data transfer between them.

![VirtualBox_opensource_eda_ubuntu Clone_31_03_2023_18_10_14](https://user-images.githubusercontent.com/68071764/229122593-3176e733-f0e8-43a9-a249-2f619edf0e7c.png)


![AVSD_OUT2](https://user-images.githubusercontent.com/68071764/229121792-da52138e-d788-4eb9-9035-75314dcc54cf.png)

![OUTPUT_AVSD](https://user-images.githubusercontent.com/68071764/229122311-0dc0211f-21e0-4cd5-9b4c-320c4e0e6709.png)






Weekly AI's 

|S. No. | Week 0 AI's |Status|
|:---:| :---:| :---:| 
|1.| Install Oracle virtual box with Ubuntu 20.04| Completed|
|2.| Installation of Tools and SKY130 PDKs|Completed|
|3.| Create inverter and perform pre-layout using xschem or ngspice|Completed|
|4.| Inverter Post-layout characterization using ( step.2)|Completed|
|5.| Enroll in FREE VSD-custom layout course|completed|
|6.| Create the design shown in section 7 of the course and perform pre-layout using xschem or ngspice with general pdks|Completed(Week1)|
|7.| Post layout characterization using ngspice with general pdks|Completed|
|8.| Update your findings on your GitHub repo with the title “Week 0”| Updated|

|S. No. | Week 1 AI's |Status|
|:---:| :---:| :---:| 
|9.| Install ALIGN tool|Completed|
|10.| Inverter post-layout characterization using (step.9)|completed|
|11.| Compare 10 and 4|completed|
|12.| Enroll in FREE VSD-custom layout course |completed|
|13.|Create the design shown in section 7 of the course and perform pre-layout using xschem/ngspice using SKY130 PDKS|Completed|
|14.| Post layout characterization using magic/ngspice and SKY130 PDKs|completed|
|15.|Post layout characterization using ALIGN |completed|
|16.| Compare 14 and 15|completed|
|17.| Update your findings on your GitHub repo with the title “Week 1” |updated|
     
|S. No.   |    Week 2 AI's    |   Status  | 
|  :------------:  | :----------:  |  :----------:  |
| 18. | Install Klayout | completed |
| 19. | Install Yosys and OpenROAD using OpenROAD-flow-scripts | completed |
| 20. | Install OpenRoad | completed|
| 21. | Install OpenFASoc |completed |
| 22.| Temperature Sensor Auxiliary Cells | completed|
| 23. | Temperature Sensor Generation using OpenFASOC |completed|
|24. |  Update your findings on your GitHub repo with the title “Week 2”| updated |
     
|S. No.   |    Week 3 AI's    |   Status  | 
|  :------------:  | :----------:  |  :----------:  |
| 25. | Three-stage ring oscillator design in Xschem | completed |
| 26. | Layout for the ring oscillator using Magic | completed |
| 27. | Generating layout for ring oscillator using ALIGN | completed|
| 28. | Post layout characterization using ALIGN |completed |
|29. |  Update your findings on your GitHub repo with the title “Week 3”| updated |
