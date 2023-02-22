# msvsdasms

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
|11.| Compare 10 and 4||
|12.| Enroll in FREE VSD-custom layout course |completed|
|13.|Create the design shown in section 7 of the course and perform pre-layout using xschem/ngspice using SKY130 PDKS|Completed|
|14.| Post layout characterization using magic/ngspice and SKY130 PDKs|completed|
|15.|Post layout characterization using ALIGN |In progress|
|16.| Compare 14 and 15|In progress|
|17.| Update your findings on your GitHub repo with the title “Week 1” |In progress|
     
|S. No. | Week 2 AI's |Status|    
|18.| Install Klayout| |
|19.|||
     
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

# Week 1 AI's

### ALIGN TOOL

Installing ALIGN
```
# Clone the ALIGN source
git clone https://github.com/ALIGN-analoglayout/ALIGN-public

cd ALIGN-public

# Install virtual environment for python
sudo apt -y install python3.8-venv

# Install the latest pip
sudo apt-get -y install python3-pip

# Create python virtual envronment
python3 -m venv general

source general/bin/activate

python3 -m pip install pip --upgrade

pip install pandas
pip install scipy
pip install nltk
pip install gensim

pip install setuptools wheel pybind11 scikit-build cmake ninja

# Install Boost using
sudo apt-get install libboost-all-dev
# Installing lp_slove
sudo apt-get update
sudo apt-get install lp-solve

# Install ALIGN as a user
pip install -v .

# Install ALIGN  as a developer
pip install -e .

pip install -v -e .[test] --no-build-isolation
pip install -v --no-build-isolation -e . --no-deps --install-option='-DBUILD_TESTING=ON'

```

### Making ALIGN Portable to Sky130 tehnology

- Clone the following Repository inside ALIGN-public directory.
```
git clone https://github.com/ALIGN-analoglayout/ALIGN-pdk-sky130
```

Move SKY130_PDK folder to ~/Desktop/ALIGN-public/pdks

Everytime we start the tool in new terminal, run the following commands.
```
# Running ALIGN TOOL
    $python -m venv general
    $source general/bin/activate
```
Commands to run ALIGN (goto ALIGN-public directory)

```
    $mkdir work
    $cd work
```

General syntax to give inputs
```
schematic2layout.py <NETLIST_DIR> -p <PDK_DIR> -c
```

EXAMPLE:

schematic2layout.py ../examples/telescopic_ota -p ../pdks/FinFET14nm_Mock_PDK/

![schematic example](https://user-images.githubusercontent.com/68071764/218166479-44909a20-9ed1-43e2-8de3-3b7db150f814.png)

FLOW 

- Create a python virtualenv
```
python -m venv general
source general/bin/activate
python -m pip install pip --upgrade
mkdir build
cd build
```

- Running Design(use your original inverter spice file generated from xschem as input)
  ![image](https://user-images.githubusercontent.com/68071764/219765567-dbbd47e1-6e08-4924-af06-d90ad0add687.png)
- Once you run this netlist, below error will be pop up
  ![image](https://user-images.githubusercontent.com/68071764/219765812-bd5c7dc3-0329-4cef-9ceb-732ee6dd62cf.png)
- Make changes as per error, in my case:
![image](https://user-images.githubusercontent.com/68071764/219766105-8560b034-0c2c-4d3a-ad63-6c760a81249f.png)

- NOTE!! ( The first path should be netlist directory)(Rename the spice file netlist with <b>.sp</b> instead of <b>.spice</b> tool understands .sp format)

- Now run the design(location of your spice file and the pdk)
![align command](https://user-images.githubusercontent.com/68071764/219766476-fadae437-294d-47cc-831c-d684b61de55b.png)
![align run inverter](https://user-images.githubusercontent.com/68071764/219767811-00257d14-71a5-4007-a290-225a281a5d4d.png)

- Generated .lef and .gds 
- ![gds created](https://user-images.githubusercontent.com/68071764/219767974-463791db-cd18-40ed-99f5-affedb7bb9d8.png)

- Now open .gds file using magic tool(Go to options and Read GDS).
- ![gds_magic](https://user-images.githubusercontent.com/68071764/219768141-2efb6df9-a973-4947-8973-00d1f603a0b8.png)

- GDS file loaded, Extract the netlist file.
```
extract do local
extract all
ext2spice cthresh 0 rthresh 0
ext2spice
```

- New spice netlist will be created.
 ```
 * SPICE3 file created from INVERTER1_0.ext - technology: sky130A
X0 VOUT VIN VSS VSS sky130_fd_pr__nfet_01v8 ad=2.352e+11p pd=2.24e+06u as=4.452e+11p ps=4.42e+06u w=840000u l=150000u
X1 VSS VIN VOUT VSS sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=840000u l=150000u
X2 VOUT VIN INV_40258334_0_0_1676456961_0/PMOS_S_17800817_X1_Y1_1676456962_1676456961_0/w_0_0# INV_40258334_0_0_1676456961_0/PMOS_S_17800817_X1_Y1_1676456962_1676456961_0/w_0_0# sky130_fd_pr__pfet_01v8 ad=2.352e+11p pd=2.24e+06u as=4.452e+11p ps=4.42e+06u w=840000u l=150000u
X3 INV_40258334_0_0_1676456961_0/PMOS_S_17800817_X1_Y1_1676456962_1676456961_0/w_0_0# VIN VOUT INV_40258334_0_0_1676456961_0/PMOS_S_17800817_X1_Y1_1676456962_1676456961_0/w_0_0# sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=840000u l=150000u
C0 INV_40258334_0_0_1676456961_0/PMOS_S_17800817_X1_Y1_1676456962_1676456961_0/w_0_0# VOUT 0.79fF
C1 VIN VOUT 0.31fF
C2 INV_40258334_0_0_1676456961_0/PMOS_S_17800817_X1_Y1_1676456962_1676456961_0/w_0_0# VIN 1.14fF
C3 VOUT VSS 0.69fF **FLOATING
C4 VIN VSS 1.51fF **FLOATING
C5 INV_40258334_0_0_1676456961_0/PMOS_S_17800817_X1_Y1_1676456962_1676456961_0/w_0_0# VSS 3.02fF **FLOATING
```
- Merged the testbench netlist and the new generated netlist(Just keep one subckt there are two subckts)

```
** sch_path: /home/ativi07/Desktop/ALIGN-public/week0/inverter/xschem/testbench1.sch
.subckt testbench1
V1 in GND pulse(0 1.8 1n 1n 1n 4n 10n)
.save i(v1)
V2 net1 GND 1.8
.save i(v2)
x1 net1 in out GND inverter1
**** begin user architecture code

.lib /usr/local/share/pdk/sky130A/libs.tech/ngspice/sky130.lib.spice tt


.control
save all
tran 0.01n 40n
plot v(in) v(out)
.endc

**** end user architecture code
**.ends

* expanding   symbol:  inverter1.sym # of pins=4
** sym_path: /home/ativi07/Desktop/ALIGN-public/week0/inverter/xschem/inverter1.sym
** sch_path: /home/ativi07/Desktop/ALIGN-public/week0/inverter/xschem/inverter1.sch
.subckt inverter1 vdd vin vout vss
*.iopin vdd
*.iopin vss
*.ipin vin
*.opin vout
XM1 vout vin vss vss sky130_fd_pr__nfet_01v8
XM2 vout vin vdd vdd sky130_fd_pr__pfet_01v8
.ends

.GLOBAL GND
.end

* SPICE3 file created from INVERTER1_0.ext - technology: sky130A

X0 VOUT VIN VSS VSS sky130_fd_pr__nfet_01v8 ad=2.352e+11p pd=2.24e+06u as=4.452e+11p ps=4.42e+06u w=840000u l=150000u
X1 VSS VIN VOUT VSS sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=840000u l=150000u
X2 VOUT VIN INV_40258334_0_0_1676456961_0/PMOS_S_17800817_X1_Y1_1676456962_1676456961_0/w_0_0# INV_40258334_0_0_1676456961_0/PMOS_S_17800817_X1_Y1_1676456962_1676456961_0/w_0_0# sky130_fd_pr__pfet_01v8 ad=2.352e+11p pd=2.24e+06u as=4.452e+11p ps=4.42e+06u w=840000u l=150000u
X3 INV_40258334_0_0_1676456961_0/PMOS_S_17800817_X1_Y1_1676456962_1676456961_0/w_0_0# VIN VOUT INV_40258334_0_0_1676456961_0/PMOS_S_17800817_X1_Y1_1676456962_1676456961_0/w_0_0# sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=840000u l=150000u
C0 INV_40258334_0_0_1676456961_0/PMOS_S_17800817_X1_Y1_1676456962_1676456961_0/w_0_0# VOUT 0.79fF
C1 VIN VOUT 0.31fF
C2 INV_40258334_0_0_1676456961_0/PMOS_S_17800817_X1_Y1_1676456962_1676456961_0/w_0_0# VIN 1.14fF
C3 VOUT VSS 0.69fF **FLOATING
C4 VIN VSS 1.51fF **FLOATING
C5 INV_40258334_0_0_1676456961_0/PMOS_S_17800817_X1_Y1_1676456962_1676456961_0/w_0_0# VSS 3.02fF**FLOATING
```
  - Run the updated spice netlist(the extracted netlist which you get from magic does not contain the control statements(plots, sources, etc). It's just a bare subckt(black box or an IC). You must add the .control statements(power it) by pasting them from the pre-layout and get a similar results.
  - ![align post output](https://user-images.githubusercontent.com/68071764/219775960-a36a1de2-5718-4e9a-adf6-89d3193363e5.png)
![graph postlayout of align](https://user-images.githubusercontent.com/68071764/219776057-233a49da-abaf-46a1-ad96-88e3f8de4065.png)

## Create the design shown in section 7 of the course and perform pre-layout using xschem/ngspice using SKY130 PDKS

#### Pre-layout of function using xschem and ngspice using SKY130 PDKS
1. Create the schematic diagram using <b>xschem tool</b>.

![final one schem](https://user-images.githubusercontent.com/68071764/220571480-f2c88c22-7ff7-4605-9f19-0d0dcdc93c00.png)

2. Create the test bench and simulate to get the waveform.

![final one](https://user-images.githubusercontent.com/68071764/220571939-4783dcec-4088-442a-b689-b8ffeb3c7c17.png)
![output final](https://user-images.githubusercontent.com/68071764/220572054-d09e7ba7-ad74-4453-ac58-40c673ebb575.png)
![wave_output](https://user-images.githubusercontent.com/68071764/220572108-92e23891-821c-4fb7-ae1e-cd25ba265e5d.png)

 ### PreNetlist:
 
 ```
 ** sch_path: /home/ativi07/Desktop/ALIGN-public/week0/inverter/xschem/function_testbench.sch
**.subckt function_testbench A B C D E F Fn
*.ipin A
*.ipin B
*.ipin C
*.ipin D
*.ipin E
*.ipin F
*.opin Fn
x1 VDD B A C D E F Fn GND function
V1 A GND pulse(0 1.8 0.1n 10p 10p 1n 2n)
.save i(v1)
V2 B GND pulse(0 1.8 0.2n 10p 10p 1n 2n)
.save i(v2)
V3 C GND pulse(0 1.8 0.3n 10p 10p 1n 2n)
.save i(v3)
V4 D GND pulse(0 1.8 0.4n 10p 10p 1n 2n)
.save i(v4)
V5 E GND pulse(0 1.8 0.5n 10p 10p 1n 2n)
.save i(v5)
V6 F GND pulse(0 1.8 0.6n 10p 10p 1n 2n)
.save i(v6)
V7 VDD GND 1.8
.save i(v7)
**** begin user architecture code


.tran 10p 4n
.save all


.lib /usr/local/share/pdk/sky130A/libs.tech/ngspice/sky130.lib.spice tt

**** end user architecture code
**.ends

* expanding   symbol:  function.sym # of pins=9
** sym_path: /home/ativi07/Desktop/ALIGN-public/week0/inverter/xschem/function.sym
** sch_path: /home/ativi07/Desktop/ALIGN-public/week0/inverter/xschem/function.sch
.subckt function vp B A C D E F Fn vn
*.ipin A
*.ipin C
*.ipin E
*.ipin F
*.ipin D
*.ipin B
*.opin Fn
*.ipin vp
*.ipin vn
XM1 net2 A vp vp sky130_fd_pr__pfet_01v8 L=0.15 W=1 nf=1 ad='int((nf+1)/2) * W/nf * 0.29' as='int((nf+2)/2) * W/nf * 0.29'
+ pd='2*int((nf+1)/2) * (W/nf + 0.29)' ps='2*int((nf+2)/2) * (W/nf + 0.29)' nrd='0.29 / W' nrs='0.29 / W'
+ sa=0 sb=0 sd=0 mult=1 m=1
XM2 net3 B vp vp sky130_fd_pr__pfet_01v8 L=0.15 W=1 nf=1 ad='int((nf+1)/2) * W/nf * 0.29' as='int((nf+2)/2) * W/nf * 0.29'
+ pd='2*int((nf+1)/2) * (W/nf + 0.29)' ps='2*int((nf+2)/2) * (W/nf + 0.29)' nrd='0.29 / W' nrs='0.29 / W'
+ sa=0 sb=0 sd=0 mult=1 m=1
XM3 net1 D net3 vp sky130_fd_pr__pfet_01v8 L=0.15 W=1 nf=1 ad='int((nf+1)/2) * W/nf * 0.29' as='int((nf+2)/2) * W/nf * 0.29'
+ pd='2*int((nf+1)/2) * (W/nf + 0.29)' ps='2*int((nf+2)/2) * (W/nf + 0.29)' nrd='0.29 / W' nrs='0.29 / W'
+ sa=0 sb=0 sd=0 mult=1 m=1
XM4 net1 C net2 vp sky130_fd_pr__pfet_01v8 L=0.15 W=1 nf=1 ad='int((nf+1)/2) * W/nf * 0.29' as='int((nf+2)/2) * W/nf * 0.29'
+ pd='2*int((nf+1)/2) * (W/nf + 0.29)' ps='2*int((nf+2)/2) * (W/nf + 0.29)' nrd='0.29 / W' nrs='0.29 / W'
+ sa=0 sb=0 sd=0 mult=1 m=1
XM5 Fn F net1 vp sky130_fd_pr__pfet_01v8 L=0.15 W=1 nf=1 ad='int((nf+1)/2) * W/nf * 0.29' as='int((nf+2)/2) * W/nf * 0.29'
+ pd='2*int((nf+1)/2) * (W/nf + 0.29)' ps='2*int((nf+2)/2) * (W/nf + 0.29)' nrd='0.29 / W' nrs='0.29 / W'
+ sa=0 sb=0 sd=0 mult=1 m=1
XM6 Fn E net1 vp sky130_fd_pr__pfet_01v8 L=0.15 W=1 nf=1 ad='int((nf+1)/2) * W/nf * 0.29' as='int((nf+2)/2) * W/nf * 0.29'
+ pd='2*int((nf+1)/2) * (W/nf + 0.29)' ps='2*int((nf+2)/2) * (W/nf + 0.29)' nrd='0.29 / W' nrs='0.29 / W'
+ sa=0 sb=0 sd=0 mult=1 m=1
XM7 Fn A net4 vn sky130_fd_pr__nfet_01v8 L=0.15 W=1 nf=1 ad='int((nf+1)/2) * W/nf * 0.29' as='int((nf+2)/2) * W/nf * 0.29'
+ pd='2*int((nf+1)/2) * (W/nf + 0.29)' ps='2*int((nf+2)/2) * (W/nf + 0.29)' nrd='0.29 / W' nrs='0.29 / W'
+ sa=0 sb=0 sd=0 mult=1 m=1
XM8 net4 B vn vn sky130_fd_pr__nfet_01v8 L=0.15 W=1 nf=1 ad='int((nf+1)/2) * W/nf * 0.29' as='int((nf+2)/2) * W/nf * 0.29'
+ pd='2*int((nf+1)/2) * (W/nf + 0.29)' ps='2*int((nf+2)/2) * (W/nf + 0.29)' nrd='0.29 / W' nrs='0.29 / W'
+ sa=0 sb=0 sd=0 mult=1 m=1
XM9 Fn C net4 vn sky130_fd_pr__nfet_01v8 L=0.15 W=1 nf=1 ad='int((nf+1)/2) * W/nf * 0.29' as='int((nf+2)/2) * W/nf * 0.29'
+ pd='2*int((nf+1)/2) * (W/nf + 0.29)' ps='2*int((nf+2)/2) * (W/nf + 0.29)' nrd='0.29 / W' nrs='0.29 / W'
+ sa=0 sb=0 sd=0 mult=1 m=1
XM10 Fn E net5 vn sky130_fd_pr__nfet_01v8 L=0.15 W=1 nf=1 ad='int((nf+1)/2) * W/nf * 0.29' as='int((nf+2)/2) * W/nf * 0.29'
+ pd='2*int((nf+1)/2) * (W/nf + 0.29)' ps='2*int((nf+2)/2) * (W/nf + 0.29)' nrd='0.29 / W' nrs='0.29 / W'
+ sa=0 sb=0 sd=0 mult=1 m=1
XM11 net4 D vn vn sky130_fd_pr__nfet_01v8 L=0.15 W=1 nf=1 ad='int((nf+1)/2) * W/nf * 0.29' as='int((nf+2)/2) * W/nf * 0.29'
+ pd='2*int((nf+1)/2) * (W/nf + 0.29)' ps='2*int((nf+2)/2) * (W/nf + 0.29)' nrd='0.29 / W' nrs='0.29 / W'
+ sa=0 sb=0 sd=0 mult=1 m=1
XM12 net6 F vn vn sky130_fd_pr__nfet_01v8 L=0.15 W=1 nf=1 ad='int((nf+1)/2) * W/nf * 0.29' as='int((nf+2)/2) * W/nf * 0.29'
+ pd='2*int((nf+1)/2) * (W/nf + 0.29)' ps='2*int((nf+2)/2) * (W/nf + 0.29)' nrd='0.29 / W' nrs='0.29 / W'
+ sa=0 sb=0 sd=0 mult=1 m=1
.ends

.GLOBAL GND
.GLOBAL VDD
.end
```
3. we have verified the working of our inverter schematic and we need a netist of exclusively that, and not our entire testbench. Open the inverter from the files menu and go to suimulation menu and select "LVS netlist: top lvl is a subsckt" and then tap netlist. Exit xschem. 

4. we need to import the netlist to magic to create the layout. Open magic by moving to the mag directory and using magic -T sky130A.Tech. Go to file --> Import SPICE and select our netlist from the .xschem/simulation folder.

5. Once celected, click OK and the tap v on the layout window and you should see this:

![image](https://user-images.githubusercontent.com/68071764/220572678-e6aad34e-318f-436f-8be4-8aa9d77f8733.png)

6. Now, just to get a working layout. Select cells by hovering over them and pressing i. Move them to a new location by hovering over the point you want the bottom left corner of the cell to be and pressing m. Once you move the cells around you should have a layout like this. 
![my_layout](https://user-images.githubusercontent.com/68071764/220572928-b365a45c-5ad5-4367-90d3-520b721ce90c.png)

![postlay1](https://user-images.githubusercontent.com/68071764/220605618-1e937a33-e2ba-460f-91fb-91603c35f740.png)

![post_layout output of function](https://user-images.githubusercontent.com/68071764/220605703-5507eefc-446a-4906-920c-25081f7a1d11.png)

![post_layout output waveform function](https://user-images.githubusercontent.com/68071764/220605775-6477fa8a-9563-4097-a042-e79cae729d89.png)


### PostNetlist
```
* SPICE3 file created from function.ext - technology: sky130A

.subckt function vp B A C D E F vn
X0 vn m1_3860_n1652# m1_3134_n1514# VSUBS sky130_fd_pr__nfet_01v8 ad=8.7e+11p pd=7.74e+06u as=5.8e+11p ps=5.16e+06u w=1e+06u l=150000u
X1 vp m1_n336_50# m1_n668_n500# XM1/w_n211_n319# sky130_fd_pr__pfet_01v8 ad=5.8e+11p pd=5.16e+06u as=5.8e+11p ps=5.16e+06u w=1e+06u l=150000u
X2 m1_630_n148# m1_540_40# vp XM2/w_n211_n319# sky130_fd_pr__pfet_01v8 ad=5.8e+11p pd=5.16e+06u as=0p ps=0u w=1e+06u l=150000u
X3 m1_1514_n134# m1_1416_60# m1_n668_n500# XM3/w_n211_n319# sky130_fd_pr__pfet_01v8 ad=1.16e+12p pd=1.032e+07u as=0p ps=0u w=1e+06u l=150000u
X4 m1_630_n148# m1_2182_64# m1_1514_n134# XM4/w_n211_n319# sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=1e+06u l=150000u
X5 m1_1514_n134# m1_3050_20# m1_n654_n1596# XM5/w_n211_n319# sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=5.8e+11p ps=5.16e+06u w=1e+06u l=150000u
X6 m1_n654_n1596# m1_3852_24# m1_1514_n134# XM6/w_n211_n319# sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=1e+06u l=150000u
X7 m1_n246_n1566# m1_n342_n1718# m1_n654_n1596# VSUBS sky130_fd_pr__nfet_01v8 ad=1.16e+12p pd=1.032e+07u as=8.7e+11p ps=7.74e+06u w=1e+06u l=150000u
X8 vn m1_536_n1694# m1_n246_n1566# VSUBS sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=1e+06u l=150000u
X9 m1_n246_n1566# m1_1402_n1672# m1_n654_n1596# VSUBS sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=1e+06u l=150000u
X10 vn m1_2210_n1670# m1_n246_n1566# VSUBS sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=1e+06u l=150000u
X11 m1_3134_n1514# m1_3034_n1672# m1_n654_n1596# VSUBS sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=1e+06u l=150000u
C0 m1_n668_n500# m1_1514_n134# 0.16fF
C1 B m1_1402_n1672# 0.00fF
C2 m1_3860_n1652# F 0.08fF
C3 m1_n336_50# m1_n246_n1566# 0.00fF
C4 m1_3852_24# F 0.06fF
C5 E m1_2210_n1670# 0.00fF
C6 D m1_3034_n1672# 0.00fF
C7 m1_n668_n500# m1_n336_50# 0.06fF
C8 vn XM6/w_n211_n319# 0.00fF
C9 XM5/w_n211_n319# C 0.00fF
C10 m1_3134_n1514# m1_n654_n1596# 0.18fF
C11 XM3/w_n211_n319# m1_630_n148# 0.11fF
C12 m1_3050_20# XM4/w_n211_n319# 0.00fF
C13 F m1_n654_n1596# 0.38fF
C14 XM3/w_n211_n319# XM1/w_n211_n319# 0.00fF
C15 m1_3852_24# m1_1514_n134# 0.04fF
C16 m1_n246_n1566# vp 0.00fF
C17 A m1_n654_n1596# 0.41fF
C18 B XM4/w_n211_n319# 0.00fF
C19 D vn 0.10fF
C20 vn m1_n246_n1566# 1.20fF
C21 m1_n668_n500# vp 0.31fF
C22 m1_2182_64# XM3/w_n211_n319# 0.01fF
C23 m1_3860_n1652# m1_3034_n1672# 0.01fF
C24 XM5/w_n211_n319# XM6/w_n211_n319# 0.04fF
C25 m1_630_n148# F 0.00fF
C26 m1_1514_n134# m1_n654_n1596# 0.53fF
C27 XM3/w_n211_n319# XM2/w_n211_n319# 0.03fF
C28 m1_2210_n1670# m1_1402_n1672# 0.01fF
C29 m1_n336_50# m1_n654_n1596# 0.00fF
C30 m1_1416_60# XM3/w_n211_n319# 0.35fF
C31 m1_630_n148# A 0.00fF
C32 C m1_536_n1694# 0.00fF
C33 m1_3034_n1672# m1_n654_n1596# 0.04fF
C34 m1_540_40# XM3/w_n211_n319# 0.00fF
C35 m1_3860_n1652# vn 0.05fF
C36 XM1/w_n211_n319# A 0.05fF
C37 E XM3/w_n211_n319# 0.00fF
C38 D XM5/w_n211_n319# 0.01fF
C39 m1_630_n148# m1_1514_n134# 1.24fF
C40 m1_n336_50# m1_630_n148# 0.00fF
C41 m1_2210_n1670# XM4/w_n211_n319# 0.00fF
C42 vn m1_n654_n1596# 0.16fF
C43 E m1_3134_n1514# 0.11fF
C44 XM2/w_n211_n319# A 0.01fF
C45 m1_n336_50# XM1/w_n211_n319# 0.32fF
C46 m1_2182_64# m1_1514_n134# 0.06fF
C47 m1_3050_20# XM3/w_n211_n319# 0.00fF
C48 E F 0.11fF
C49 XM5/w_n211_n319# m1_3852_24# 0.01fF
C50 m1_540_40# A 0.00fF
C51 XM3/w_n211_n319# B 0.00fF
C52 XM2/w_n211_n319# m1_1514_n134# 0.00fF
C53 m1_630_n148# vp 0.16fF
C54 vn m1_630_n148# 0.00fF
C55 XM3/w_n211_n319# m1_1402_n1672# 0.00fF
C56 m1_1416_60# m1_1514_n134# 0.04fF
C57 m1_n336_50# XM2/w_n211_n319# 0.00fF
C58 m1_n246_n1566# m1_536_n1694# 0.04fF
C59 XM1/w_n211_n319# vp 0.16fF
C60 m1_n668_n500# m1_536_n1694# 0.00fF
C61 m1_540_40# m1_1514_n134# 0.00fF
C62 m1_3050_20# m1_3134_n1514# 0.00fF
C63 XM5/w_n211_n319# m1_n654_n1596# 0.28fF
C64 E m1_1514_n134# 0.05fF
C65 m1_n342_n1718# A 0.06fF
C66 m1_540_40# m1_n336_50# 0.00fF
C67 m1_3050_20# F 0.00fF
C68 E m1_3034_n1672# 0.07fF
C69 XM3/w_n211_n319# XM4/w_n211_n319# 0.04fF
C70 XM2/w_n211_n319# vp 0.18fF
C71 vn XM2/w_n211_n319# 0.00fF
C72 XM5/w_n211_n319# m1_630_n148# 0.01fF
C73 A B 0.08fF
C74 m1_1416_60# vp 0.00fF
C75 m1_n336_50# m1_n342_n1718# 0.00fF
C76 m1_3050_20# m1_1514_n134# 0.05fF
C77 m1_540_40# vp 0.04fF
C78 m1_540_40# vn 0.00fF
C79 D C 0.13fF
C80 C m1_n246_n1566# 0.12fF
C81 E vn 0.00fF
C82 B m1_1514_n134# 0.00fF
C83 m1_n668_n500# C 0.09fF
C84 m1_536_n1694# m1_n654_n1596# 0.01fF
C85 m1_3050_20# m1_3034_n1672# 0.00fF
C86 m1_2182_64# XM5/w_n211_n319# 0.00fF
C87 m1_n336_50# B 0.00fF
C88 F XM4/w_n211_n319# 0.00fF
C89 m1_2210_n1670# m1_3134_n1514# 0.00fF
C90 vn m1_n342_n1718# 0.00fF
C91 XM5/w_n211_n319# m1_1416_60# 0.00fF
C92 D XM6/w_n211_n319# 0.00fF
C93 XM4/w_n211_n319# m1_1514_n134# 0.34fF
C94 vp B 0.10fF
C95 E XM5/w_n211_n319# 0.05fF
C96 vn B 0.05fF
C97 vn m1_1402_n1672# 0.02fF
C98 C m1_n654_n1596# 0.43fF
C99 D m1_n246_n1566# 0.06fF
C100 m1_n668_n500# m1_n246_n1566# 0.00fF
C101 m1_n668_n500# D 0.00fF
C102 m1_2210_n1670# m1_3034_n1672# 0.00fF
C103 m1_3860_n1652# XM6/w_n211_n319# 0.00fF
C104 XM6/w_n211_n319# m1_3852_24# 0.32fF
C105 XM2/w_n211_n319# m1_536_n1694# 0.00fF
C106 XM5/w_n211_n319# m1_3050_20# 0.34fF
C107 vn XM4/w_n211_n319# 0.00fF
C108 C m1_630_n148# 0.02fF
C109 m1_540_40# m1_536_n1694# 0.00fF
C110 XM6/w_n211_n319# m1_n654_n1596# 0.26fF
C111 C XM1/w_n211_n319# 0.00fF
C112 m1_2210_n1670# vn 0.05fF
C113 XM3/w_n211_n319# A 0.00fF
C114 m1_2182_64# C 0.00fF
C115 m1_n342_n1718# m1_536_n1694# 0.00fF
C116 m1_630_n148# XM6/w_n211_n319# 0.00fF
C117 D m1_n654_n1596# 0.41fF
C118 m1_n246_n1566# m1_n654_n1596# 0.38fF
C119 F m1_3134_n1514# 0.05fF
C120 C XM2/w_n211_n319# 0.01fF
C121 XM5/w_n211_n319# XM4/w_n211_n319# 0.02fF
C122 XM3/w_n211_n319# m1_1514_n134# 0.14fF
C123 m1_n668_n500# m1_n654_n1596# 0.38fF
C124 m1_1416_60# C 0.07fF
C125 m1_n336_50# XM3/w_n211_n319# 0.00fF
C126 B m1_536_n1694# 0.07fF
C127 m1_3860_n1652# m1_3852_24# 0.00fF
C128 m1_540_40# C 0.00fF
C129 m1_1402_n1672# m1_536_n1694# 0.00fF
C130 E C 0.00fF
C131 m1_2182_64# XM6/w_n211_n319# 0.00fF
C132 D m1_630_n148# 0.14fF
C133 m1_n668_n500# m1_630_n148# 0.07fF
C134 m1_3860_n1652# m1_n654_n1596# 0.00fF
C135 m1_3852_24# m1_n654_n1596# 0.05fF
C136 F m1_1514_n134# 0.05fF
C137 XM1/w_n211_n319# m1_n246_n1566# 0.00fF
C138 XM3/w_n211_n319# vp 0.00fF
C139 m1_3034_n1672# m1_3134_n1514# 0.03fF
C140 vn XM3/w_n211_n319# 0.00fF
C141 m1_n668_n500# XM1/w_n211_n319# 0.35fF
C142 F m1_3034_n1672# 0.00fF
C143 m1_2182_64# m1_n246_n1566# 0.00fF
C144 D m1_2182_64# 0.06fF
C145 C m1_3050_20# 0.00fF
C146 m1_n336_50# A 0.06fF
C147 E XM6/w_n211_n319# 0.01fF
C148 m1_n668_n500# m1_2182_64# 0.00fF
C149 m1_630_n148# m1_3852_24# 0.00fF
C150 C B 0.06fF
C151 D XM2/w_n211_n319# 0.00fF
C152 C m1_1402_n1672# 0.07fF
C153 vn m1_3134_n1514# 0.24fF
C154 m1_n668_n500# XM2/w_n211_n319# 0.22fF
C155 m1_1416_60# m1_n246_n1566# 0.00fF
C156 D m1_1416_60# 0.00fF
C157 m1_n668_n500# m1_1416_60# 0.04fF
C158 vn F 0.08fF
C159 D m1_540_40# 0.00fF
C160 XM5/w_n211_n319# XM3/w_n211_n319# 0.00fF
C161 m1_630_n148# m1_n654_n1596# 0.06fF
C162 E D 0.09fF
C163 vp A 0.06fF
C164 m1_n668_n500# m1_540_40# 0.03fF
C165 vn A 0.00fF
C166 m1_3050_20# XM6/w_n211_n319# 0.00fF
C167 XM1/w_n211_n319# m1_n654_n1596# 0.00fF
C168 C XM4/w_n211_n319# 0.01fF
C169 vp m1_1514_n134# 0.00fF
C170 m1_n342_n1718# m1_n246_n1566# 0.04fF
C171 XM5/w_n211_n319# m1_3134_n1514# 0.00fF
C172 m1_2182_64# m1_n654_n1596# 0.02fF
C173 m1_n668_n500# m1_n342_n1718# 0.00fF
C174 m1_n336_50# vp 0.04fF
C175 m1_2210_n1670# C 0.00fF
C176 D m1_3050_20# 0.00fF
C177 XM5/w_n211_n319# F 0.01fF
C178 E m1_3860_n1652# 0.00fF
C179 vn m1_3034_n1672# 0.02fF
C180 E m1_3852_24# 0.00fF
C181 XM2/w_n211_n319# m1_n654_n1596# 0.01fF
C182 m1_630_n148# XM1/w_n211_n319# 0.00fF
C183 m1_n246_n1566# B 0.11fF
C184 m1_1416_60# m1_n654_n1596# 0.01fF
C185 D m1_1402_n1672# 0.00fF
C186 m1_n668_n500# B 0.08fF
C187 m1_n246_n1566# m1_1402_n1672# 0.04fF
C188 m1_2182_64# m1_630_n148# 0.03fF
C189 m1_540_40# m1_n654_n1596# 0.00fF
C190 XM6/w_n211_n319# XM4/w_n211_n319# 0.00fF
C191 m1_n668_n500# m1_1402_n1672# 0.00fF
C192 E m1_n654_n1596# 0.46fF
C193 XM5/w_n211_n319# m1_1514_n134# 0.28fF
C194 m1_630_n148# XM2/w_n211_n319# 0.13fF
C195 m1_3050_20# m1_3852_24# 0.01fF
C196 m1_1416_60# m1_630_n148# 0.00fF
C197 XM5/w_n211_n319# m1_3034_n1672# 0.00fF
C198 XM2/w_n211_n319# XM1/w_n211_n319# 0.02fF
C199 m1_n342_n1718# m1_n654_n1596# 0.05fF
C200 m1_540_40# m1_630_n148# 0.03fF
C201 D XM4/w_n211_n319# 0.05fF
C202 m1_n246_n1566# XM4/w_n211_n319# 0.00fF
C203 m1_1416_60# XM1/w_n211_n319# 0.00fF
C204 E m1_630_n148# 0.01fF
C205 m1_n668_n500# XM4/w_n211_n319# 0.00fF
C206 m1_3050_20# m1_n654_n1596# 0.05fF
C207 m1_2182_64# XM2/w_n211_n319# 0.00fF
C208 m1_540_40# XM1/w_n211_n319# 0.00fF
C209 A m1_536_n1694# 0.00fF
C210 m1_2210_n1670# m1_n246_n1566# 0.04fF
C211 D m1_2210_n1670# 0.08fF
C212 m1_2182_64# m1_1416_60# 0.01fF
C213 C XM3/w_n211_n319# 0.05fF
C214 B m1_n654_n1596# 0.38fF
C215 XM5/w_n211_n319# vn 0.00fF
C216 m1_2182_64# m1_540_40# 0.00fF
C217 m1_1402_n1672# m1_n654_n1596# 0.04fF
C218 m1_1416_60# XM2/w_n211_n319# 0.00fF
C219 E m1_2182_64# 0.00fF
C220 XM1/w_n211_n319# m1_n342_n1718# 0.00fF
C221 m1_3852_24# XM4/w_n211_n319# 0.00fF
C222 m1_3050_20# m1_630_n148# 0.00fF
C223 m1_540_40# XM2/w_n211_n319# 0.36fF
C224 m1_540_40# m1_1416_60# 0.00fF
C225 m1_630_n148# B 0.13fF
C226 E m1_1416_60# 0.00fF
C227 m1_2210_n1670# m1_3860_n1652# 0.00fF
C228 XM4/w_n211_n319# m1_n654_n1596# 0.11fF
C229 XM1/w_n211_n319# B 0.01fF
C230 m1_2182_64# m1_3050_20# 0.00fF
C231 vp m1_536_n1694# 0.00fF
C232 m1_2210_n1670# m1_n654_n1596# 0.00fF
C233 m1_2182_64# B 0.00fF
C234 vn m1_536_n1694# 0.04fF
C235 XM6/w_n211_n319# m1_3134_n1514# 0.00fF
C236 C m1_1514_n134# 0.06fF
C237 m1_1416_60# m1_3050_20# 0.00fF
C238 D XM3/w_n211_n319# 0.01fF
C239 XM3/w_n211_n319# m1_n246_n1566# 0.00fF
C240 m1_630_n148# XM4/w_n211_n319# 0.26fF
C241 XM2/w_n211_n319# B 0.06fF
C242 m1_n668_n500# XM3/w_n211_n319# 0.17fF
C243 XM6/w_n211_n319# F 0.05fF
C244 m1_1416_60# B 0.00fF
C245 E m1_3050_20# 0.06fF
C246 m1_1416_60# m1_1402_n1672# 0.00fF
C247 m1_2210_n1670# m1_630_n148# 0.00fF
C248 m1_540_40# B 0.06fF
C249 m1_n246_n1566# m1_3134_n1514# 0.00fF
C250 D m1_3134_n1514# 0.00fF
C251 m1_2182_64# XM4/w_n211_n319# 0.34fF
C252 XM6/w_n211_n319# m1_1514_n134# 0.17fF
C253 D F 0.00fF
C254 C vp 0.00fF
C255 XM2/w_n211_n319# XM4/w_n211_n319# 0.00fF
C256 C vn 0.00fF
C257 m1_n342_n1718# B 0.00fF
C258 m1_2210_n1670# m1_2182_64# 0.00fF
C259 m1_n246_n1566# A 0.06fF
C260 m1_1416_60# XM4/w_n211_n319# 0.01fF
C261 m1_n668_n500# A 0.31fF
C262 m1_540_40# XM4/w_n211_n319# 0.00fF
C263 XM3/w_n211_n319# m1_n654_n1596# 0.09fF
C264 E XM4/w_n211_n319# 0.01fF
C265 m1_3860_n1652# m1_3134_n1514# 0.03fF
C266 m1_3852_24# m1_3134_n1514# 0.00fF
C267 m1_n246_n1566# m1_1514_n134# 0.00fF
C268 D m1_1514_n134# 0.06fF
C269 F VSUBS 0.63fF
C270 E VSUBS 0.47fF
C271 D VSUBS 0.38fF
C272 C VSUBS 0.41fF
C273 B VSUBS 0.45fF
C274 A VSUBS 0.59fF
C275 m1_3860_n1652# VSUBS 0.28fF
**FLOATING
C276 m1_3034_n1672# VSUBS 0.27fF
**FLOATING
C277 m1_2210_n1670# VSUBS 0.27fF
**FLOATING
C278 m1_1402_n1672# VSUBS 0.27fF
**FLOATING
C279 m1_536_n1694# VSUBS 0.28fF
**FLOATING
C280 m1_n342_n1718# VSUBS 0.29fF
**FLOATING
C281 m1_3134_n1514# VSUBS 0.15fF
**FLOATING
C282 vn VSUBS 1.30fF
C283 m1_n246_n1566# VSUBS 0.81fF
**FLOATING
C284 XM6/w_n211_n319# VSUBS 1.08fF
**FLOATING
C285 XM5/w_n211_n319# VSUBS 1.08fF
**FLOATING
C286 XM4/w_n211_n319# VSUBS 1.08fF
**FLOATING
C287 XM3/w_n211_n319# VSUBS 1.08fF
**FLOATING
C288 m1_630_n148# VSUBS 0.03fF **FLOATING
C289 XM2/w_n211_n319# VSUBS 1.08fF
**FLOATING
C290 vp VSUBS 0.42fF
C291 XM1/w_n211_n319# VSUBS 1.08fF
**FLOATING
.ends
```


