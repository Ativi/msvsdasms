# WEEK 0 AI's

###  Install Oracle virtual box with Ubuntu 22.04 LTS

- Install Oracle virtual box with Ubuntu 20.04 - RAM at least 4GB, hard-disk atleast 120GB. 
        -   https://www.virtualbox.org/wiki/Downloads , https://ubuntu.com/download/desktop

###   Install Magic, ngspice and SKY130 PDKs

#### MAGIC
- Magic is an open-source VLSI layout tool.
- Handles GDS DEF and LEF, Does extraction and layouts are created and managed.
- Mainly used to check DRCs and the violations can be fixed by following the design rules.
- The layout is drawn based on the parameters used.

Install steps:
```
$  git clone git://opencircuitdesign.com/magic
$  cd magic
$	 ./configure
$  make
$  sudo make install
```

More info can be found at http://opencircuitdesign.com/magic/index.html

- To check for the functionality of the tool: Type Magic

![magic ](https://user-images.githubusercontent.com/68071764/218156955-1b4ae709-8cfd-493d-92c9-ca8e9f6152c8.png)

Two windows pop-up

  - tkcon console

  - Layout window


#### NETGEN

- Netgen is a tool for comparing netlists, a process known as LVS, which stands for "Layout vs. Schematic"
- It is completely command driven and has no graphics interface.

Install steps:
```
$  git clone git://opencircuitdesign.com/netgen
$  cd netgen
$	./configure
$  make
$  sudo make install
```
![netgentest](https://user-images.githubusercontent.com/68071764/218159486-3c71b97c-777d-4df2-b1c6-09f632683c76.png)

#### NGSPICE

- ngspice is the open-source spice simulator for electric and electronic circuits. 
- Download ngspice-37 tarball ngspice-37.tar.gz
- https://ngspice.sourceforge.io/download.html

Install steps:
```

 $ tar -zxvf ngspice-37.tar.gz
 $ cd ngspice-37
 $ mkdir release
 $ cd release
 $ ../configure  --with-x --with-readline=yes --disable-debug
 $ make
 $ sudo make install
 ```
 ![ngspicetest](https://user-images.githubusercontent.com/68071764/218160453-51420eb2-0fe2-40c1-8940-5dc4ab7791aa.png)

 #### XSCHEM
 
 - Xschem is a schematic capture program.
 - Third repository for Schematic Editor that is used to create new schematics or can be used to import the schematics and generate nelists out of that.
 - Xschem has symbol libraries to create schematics. It supports both ngspice for analog simulation and gaw for waveform viewing.

Install steps:
```
$  git clone https://github.com/StefanSchippers/xschem.git xschem_git
$  cd xschem_git
$	./configure
$  make
$  sudo make install
```

![xschem](https://user-images.githubusercontent.com/68071764/218161496-85894dbb-56be-4712-9c14-d768dbce0517.png)


#### OPENPDKS

Open_PDKs is distributed with files that support the Google/SkyWater sky130 open process description [github link](https://github.com/google/skywater-pdk). Open_PDKs will set up an environment for using the SkyWater sky130 process with open-source EDA tools and tool flows such as magic, qflow, openlane, netgen, klayout, etc.

Install steps:

```
$  git clone git://opencircuitdesign.com/open_pdks
$  cd open_pdks
$	./configure --enable-sky130-pdk
$  make
$  sudo make install
```

- Verifiying the open_pdk installation 
    - An initial working directory can be made by copying the required files as follows: 

```
$ mkdir week0
$ cd week0
$ mkdir inverter
$ cd inverter
$ mkdir mag
$ mkdir netgen
$ mkdir xschem
$ cd xschem
$ cp /usr/local/share/pdk/sky130A/libs.tech/xschem/xschemrc .
$ cp /usr/local/share/pdk/sky130A/libs.tech/ngspice/spinit .spiceinit
$ cd ../mag
$ cp /usr/local/share/pdk/sky130A/libs.tech/magic/sky130A.magicrc .magicrc
$ cd ../netgen
$ cp /usr/local/share/pdk/sky130A/libs.tech/netgen//sky130A_setup.tcl .
```


## Creating an inverter schematic in Xschem

- Open xschem and after resizing the window to your comfort, open a new schematic from the file menu and press the insert key.
- Go over to the sky130 directory and select the skky130_fd_pr option for primitive cells, since we need nfet and pfet to build our inverter.
- A mosfet is a 4 terminal device and it is easier to avoid the fet3 options since they need us to specify the bulk pin as a parameter every time. However here, we will choose the nfet and pfet3, both with 01v8.sym types for demonstration purposes. 
- Go to the xschem library and then to devices.
- we need a ipin, opin and an iopin.
- Once you have all your components on the schematic, use the w button and mouse cursor to connect all wirings and use the q key to change names of the labels.
- Move over to the pfet and tap q to see the parameters.
- Change the length to 0.18 since anything below 0.18 is only allowed for SRAM cells.
- Change width to 3 and nF to 3. Width is counted as total width and is w x nF so that means each finger's width is 1um.
- For the nfet change length to 0.18 again and change width to 4.5 and nF to 3 since this time we want a width of 1.5u per finger.

![nfet_para](https://user-images.githubusercontent.com/68071764/218169977-64019c5e-faeb-463e-baa8-55700898bbfc.png)
![inverter 1](https://user-images.githubusercontent.com/68071764/218170015-d181b981-5aea-4d8e-9847-513902e068f0.png)

Once your connections are done your schematic is ready.

![inverter created](https://user-images.githubusercontent.com/68071764/218170364-4638a768-1323-4ef5-9805-e2e5f85cda02.png)

- Go to file --> "Save as" and save as inverter.sch and click on OK. 

![inverter sch](https://user-images.githubusercontent.com/68071764/218171186-22160a30-2d04-4c4d-9c3a-7190fac05005.png)

- To create a layout of this circuit but first, we need to functionally validate it and for that we need to create an independent testbench with the schematic as a symbol.
-  Go to the symbol menu and click on "Make symbol from schematic". Now, we start our testbench schematic by opening a new schematic from file. Once the schematic is open, press the insert key, move to the local directory --> inverter.sym.

![inv_sym](https://user-images.githubusercontent.com/68071764/218171882-5e164860-fc6f-4f94-aff2-77a20030ba16.png)

- Bring the symbol of our inverter into the new schematic and add all the extra components like voltage sources, gnd terminal and opins for the comparison between vin and vout.
- Now, we need to add the parameters. Go to V2 and set the value to 1.8. Go to V1 and set the value to a PWL sweep as shown.

![source inv](https://user-images.githubusercontent.com/68071764/218172283-4d6108c6-9422-4e59-8c33-fed328394054.png)

- Press insert again and search and add code_shown.sym 2 times to the schematic. s1 will tell ngspice where to find the device models for the devices used in the schematic.
![blabla](https://user-images.githubusercontent.com/68071764/218172570-51239ca7-abce-4b57-9247-5c362c479728.png)

- s2 will run a transient analysis for 1 microsecond and plot the values for Vin and Vout. 

![code shown](https://user-images.githubusercontent.com/68071764/218172697-62b4711d-a96e-414e-ab1c-a86510ef6b59.png)

-  Once done, your schematic should look like this:

![inv_tbsch](https://user-images.githubusercontent.com/68071764/218172045-c57b4665-41ac-46f2-818e-cf8f904a743c.png)

- Simulating the testbench

![simulation](https://user-images.githubusercontent.com/68071764/218276575-657e42e4-8aed-4b1f-8dc3-109cdeedfb44.png)
![graph1](https://user-images.githubusercontent.com/68071764/218276579-459dd06f-ea8a-4534-b173-b02e234e4dc2.png)

- we have verified the working of our inverter schematic and we need a netist of exclusively that, and not our entire testbench. Open the inverter from the files menu and go to suimulation menu and select<b> "LVS netlist: top lvl is a subsckt" </b>and then tap netlist. Exit xschem.

- we need to import the netlist to magic to create the layout. Open magic by moving to the mag directory and using magic -T sky130A.Tech. Go to file --> Import SPICE and select our netlist from the .xschem/simulation folder.

- Once celected, click OK and the tap v on the layout window and you should see this:

![magic_l1](https://user-images.githubusercontent.com/68071764/218327298-a3ff7d7d-64cc-4ba2-9475-63f787bf3722.png)

- Now, just to get a working layout. Select cells by hovering over them and pressing i. Move them to a new location by hovering over the point you want the bottom left corner of the cell to be and pressing m. Once you move the cells around you should have a layout like this.

![layout_mag](https://user-images.githubusercontent.com/68071764/218327350-7aa2089f-4001-4deb-9726-6e9be1f7e6c3.png)

![layoutt](https://user-images.githubusercontent.com/68071764/218327447-940f6758-8fdb-4e81-9156-5c17c20021be.png)

![drczero](https://user-images.githubusercontent.com/68071764/218402486-4d37a7c5-c903-4abe-96e0-77d5db53c2cb.png)

- go to File --> save and select autowrite.
- Go to the command window and type the following:

```
extract do local
extract all
```

- Extract do local is an instruction to perform all extractions to the local directory and extract all does the actual extraction. We want our extraction for lvs to be in the spice format, so run the following commands.

```
ext2spice lvs
ext2spice
```

![extract commands](https://user-images.githubusercontent.com/68071764/218426473-a6cce187-49ec-41c4-ba7d-68cfab8d33a0.png)
-  close magic.

-Simulate the spice file extracted from magic after modifications.
```
* NGSPICE file created from inverter1.ext - technology: sky130A

.subckt sky130_fd_pr__nfet_01v8_ATLS57 a_15_n200# a_n175_n374# a_n73_n200# a_n33_n288#
X0 a_15_n200# a_n33_n288# a_n73_n200# a_n175_n374# sky130_fd_pr__nfet_01v8 ad=5.8e+11p pd=4.58e+06u as=5.8e+11p ps=4.58e+06u w=2e+06u l=150000u
C0 a_15_n200# a_n73_n200# 0.32fF
C1 a_n73_n200# a_n33_n288# 0.03fF
C2 a_15_n200# a_n33_n288# 0.03fF
C3 a_15_n200# a_n175_n374# 0.16fF
C4 a_n73_n200# a_n175_n374# 0.21fF
C5 a_n33_n288# a_n175_n374# 0.30fF
.ends

.subckt sky130_fd_pr__pfet_01v8_XGASDL a_n73_n400# a_15_n400# w_n211_n619# a_n33_n497#
+ VSUBS
X0 a_15_n400# a_n33_n497# a_n73_n400# w_n211_n619# sky130_fd_pr__pfet_01v8 ad=1.16e+12p pd=8.58e+06u as=1.16e+12p ps=8.58e+06u w=4e+06u l=150000u
C0 a_15_n400# w_n211_n619# 0.17fF
C1 a_n73_n400# a_n33_n497# 0.04fF
C2 a_n33_n497# w_n211_n619# 0.26fF
C3 a_n73_n400# w_n211_n619# 0.27fF
C4 a_15_n400# a_n33_n497# 0.04fF
C5 a_n73_n400# a_15_n400# 0.64fF
C6 a_15_n400# VSUBS 0.14fF
C7 a_n73_n400# VSUBS 0.14fF
C8 a_n33_n497# VSUBS 0.06fF
C9 w_n211_n619# VSUBS 2.02fF
.ends

.subckt inverter1 vdd vss vin vout
XXM1 vout VSUBS vss m1_504_60# sky130_fd_pr__nfet_01v8_ATLS57
XXM2 vdd vout XM2/w_n211_n619# vin VSUBS sky130_fd_pr__pfet_01v8_XGASDL
C0 m1_504_60# XM2/w_n211_n619# 0.01fF
C1 m1_504_60# vdd 0.00fF
C2 vdd XM2/w_n211_n619# 0.19fF
C3 vss vin 0.03fF
C4 vout vss 0.07fF
C5 vout vin 0.02fF
C6 m1_504_60# vss 0.05fF
C7 m1_504_60# vin 0.01fF
C8 vss XM2/w_n211_n619# 0.00fF
C9 XM2/w_n211_n619# vin 0.11fF
C10 m1_504_60# vout 0.01fF
C11 vout XM2/w_n211_n619# 0.12fF
C12 vdd vin 0.15fF
C13 vout vdd 0.05fF
C14 vin VSUBS 0.24fF
C15 m1_504_60# VSUBS 0.28fF
C16 vdd VSUBS 1.12fF
C17 XM2/w_n211_n619# VSUBS 2.06fF
C18 vout VSUBS 1.19fF
C19 vss VSUBS 0.99fF
.ends

```

- Check the spice file to view the capacitances being included.

![inv_spice](https://user-images.githubusercontent.com/68071764/218427006-eda35ec3-e97b-4503-a417-257ce128bd51.png)

- The schematic netlist and layout netlist can be compared using LVS by netgen.
```
netgen -batch lvs "../mag/inverter.spice inverter" "/home/ativi07/.xschem/simulation/testbench.spice"
```
![lvs done](https://user-images.githubusercontent.com/68071764/218435409-c7ddb76a-8bd9-4634-a2f7-ae0b608210fa.png)

![lcheck](https://user-images.githubusercontent.com/68071764/218447629-76933644-eafe-419d-8afb-4c4a731e4777.png)

![display image](https://user-images.githubusercontent.com/68071764/218505076-85bef618-8848-4eff-a00e-13daf14d2a9a.png)
- plot vout vs vin is generated as below :
![graph](https://user-images.githubusercontent.com/68071764/218505097-48afe1b1-b707-48ac-be9d-715ab3466ba4.png)

![extended graph](https://user-images.githubusercontent.com/68071764/218505119-1fe127c7-1d9e-4294-9b7a-3baf2e8225c7.png)

![values](https://user-images.githubusercontent.com/68071764/218505164-bd436eb0-db58-4998-9cd6-f47d3e19a56a.png)
![0 9graph](https://user-images.githubusercontent.com/68071764/218505468-40b48b4d-f546-4cc9-8c08-bb863916fd2c.png)

The timing parameters are calculated as

Rise time = time(80 % of Vout) - time(20% of Vout)

Fall time = time(20 % of Vout) - time(80% of Vout)

Cell Rise Delay =time taken by output to rise to its 50% value - time taken by the input to fall to its 50% value

Cell Rise Delay =time taken by output to fall to its 50% value - time taken by the input to rise to its 50% value

## Enroll in FREE VSD-custom layout course- Completed

### Create the design shown in section 7 of the course and perform pre-layout using xschem or ngspice with general pdks

## Pre-layout simulation of a function Fn using ngspice

- Implement the following circuit using CMOS logic design style
- ![art_layout](https://user-images.githubusercontent.com/68071764/219786913-07540b10-5ccd-4e5e-b70c-5840d3a57cc3.png)

- The netlist ```fn_prelayout.spice``` for the function Fn given can be written as 
```
***Netlist description for prelayout simulation***
M1 3 a vdd vdd pmos W=2.125u L=0.25u
M2 2 b vdd vdd pmos W=2.125u L=0.25u
M3 4 d 2 2 pmos W=2.125u L=0.25u
M4 4 c 3 3 pmos W=2.125u L=0.25u
M5 out e 4 4 pmos W=2.125u L=0.25u
M6 out f 4 4 pmos W=2.125u L=0.25u

M7 out a 6 6 nmos W=2.125u L=0.25u
M8 out c 6 6 nmos W=2.125u L=0.25u
M9 out e 7 7 nmos W=2.125u L=0.25u
M10 6 b 0 0 nmos W=2.125u L=0.25u
M11 6 d 0 0 nmos W=2.125u L=0.25u
M12 7 f 0 0 nmos W=2.125u L=0.25u

cload out 0 10f

Vdd vdd 0 2.5
V1 a 0 0 pulse 0 2.5 0.1n 10p 10p 1n 2n
V2 b 0 0 pulse 0 2.5 0.2n 10p 10p 1n 2n
V3 c 0 0 pulse 0 2.5 0.3n 10p 10p 1n 2n
V4 d 0 0 pulse 0 2.5 0.4n 10p 10p 1n 2n
V5 e 0 0 pulse 0 2.5 0.5n 10p 10p 1n 2n
V6 f 0 0 pulse 0 2.5 0.6n 10p 10p 1n 2n

***Simulation commands***
.op
.tran 10p 4n

*** .include model file ***
.include my_model_file.tech
.end
```

- To measure Rise and Fall time of the output, following lines are added to the fn_prelayout.spice netlist.
```
.MEAS TRAN rise_time TRIG V(out) VAL=0.25 RISE=1 TARG V(out) VAL=2.25 RISE=1
.MEAS TRAN FALL_time TRIG V(out) VAL=2.25 FALL=1 TARG V(out) VAL=0.25 FALL=1
.save all
```

- Run the ngspice simulation

```
$ngspice fn_prelayout.spice
```   
```
 ngspice 2 -> run
 ngspice 3 -> setplot
```

![ng_spice fn_prelayout](https://user-images.githubusercontent.com/68071764/219788259-28f9a16c-3f78-4784-99d3-5d847e5604da.png)

![ng_fn_prelayout](https://user-images.githubusercontent.com/68071764/219788266-25595ef5-3fd7-4266-bbc1-1de35d83acd3.png)

![ngspice_fn_pre-output](https://user-images.githubusercontent.com/68071764/219788313-228e70ba-3e20-4af9-b7ca-74a1f428f768.png)

![rise and fall pre_layout](https://user-images.githubusercontent.com/68071764/219788325-f4b76534-131e-4353-b387-fbbbbd22b7b2.png)

## Post-layout simulation of a function Fn using Magic

- Layout of function Fn is created in Magic with the help of Euler path and stick diagram.
![post layout mag](https://user-images.githubusercontent.com/68071764/219789069-2ec0018a-c112-43b9-b787-7e50cf0048c0.png)

- Extract the netlist from magic layout
 ```
extract do local
extract all
ext2spice cthresh 0 rthresh 0
ext2spice
```

- The netlist ```fn_postlayout.spice``` generated is as shown. The netlist shows the parasitic capacitances also. Model file is same as the one used for pre-layout simulation. 
```
* SPICE3 file created from Fn_.ext - technology: min2

.option scale=0.09u

M1000 a_46_38# d a_22_38# vdd pmos w=17 l=2
+  ad=102 pd=46 as=204 ps=92
M1001 out c a_14_9# gnd nmos w=17 l=2
+  ad=204 pd=92 as=204 ps=92
M1002 vdd b a_46_38# vdd pmos w=17 l=2
+  ad=204 pd=92 as=0 ps=0
M1003 gnd f a_30_9# gnd nmos w=17 l=2
+  ad=204 pd=92 as=102 ps=46
M1004 gnd b a_14_9# gnd nmos w=17 l=2
+  ad=0 pd=0 as=0 ps=0
M1005 out e a_22_38# vdd pmos w=17 l=2
+  ad=102 pd=46 as=0 ps=0
M1006 a_14_38# a vdd vdd pmos w=17 l=2
+  ad=102 pd=46 as=0 ps=0
M1007 a_14_9# a out gnd nmos w=17 l=2
+  ad=0 pd=0 as=0 ps=0
M1008 a_30_9# e out gnd nmos w=17 l=2
+  ad=0 pd=0 as=0 ps=0
M1009 a_22_38# f out vdd pmos w=17 l=2
+  ad=0 pd=0 as=0 ps=0
M1010 a_22_38# c a_14_38# vdd pmos w=17 l=2
+  ad=0 pd=0 as=0 ps=0
M1011 a_14_9# d gnd gnd nmos w=17 l=2
+  ad=0 pd=0 as=0 ps=0
C0 a_30_9# gnd 3.37fF
C1 a_14_9# gnd 6.82fF
C2 out gnd 8.40fF
C3 a_22_38# gnd 3.02fF
C4 vdd gnd 9.58fF


Vdd vdd 0 2.5
V1 a 0 0 pulse 0 2.5 0.1n 10p 10p 1n 2n
V2 b 0 0 pulse 0 2.5 0.2n 10p 10p 1n 2n
V3 c 0 0 pulse 0 2.5 0.3n 10p 10p 1n 2n
V4 d 0 0 pulse 0 2.5 0.4n 10p 10p 1n 2n
V5 e 0 0 pulse 0 2.5 0.5n 10p 10p 1n 2n
V6 f 0 0 pulse 0 2.5 0.6n 10p 10p 1n 2n
***Simulation commands***
.op
.tran 10p 4n

```

- Run the ngspice simulation. 

```
    $ngspice fn_prelayout.spice
```
```
 ngspice 2 -> run
 ngspice 3 -> setplot
 ```
 ![post_layout custom](https://user-images.githubusercontent.com/68071764/219789771-0891073d-f57e-4f3a-a1f6-cbae63e2a6d4.png)

