# msvsdasms

Weekly AI's 

|S. No. | Week 0 AI's |Status|
|:---:| :---:| :---:| 
|1.| Install Oracle virtual box with Ubuntu 20.04| Completed|
|2.| Installation of Tools and SKY130 PDKs|Completed|
|3.| Create inverter and perform pre-layout using xschem or ngspice|Completed|
|4.| Inverter Post-layout characterization using ( step.2)|Completed|
|5.| Enroll in FREE VSD-custom layout course|completed|
|6.| Create the design shown in section 7 of the course and perform pre-layout using xschem or ngspice with general pdks|Completed|
|7.| Post layout characterization using ngspice with general pdks|Completed|
|8.| Update your findings on your GitHub repo with the title “Week 0”| Updated|

|S. No. | Week 1 AI's |Status|
|:---:| :---:| :---:| 
|9.| Install ALIGN tool|Completed|
|10.| Inverter post-layout characterization using (step.9)|completed|
|11.| Compare 10 and 4||
|12.| Enroll in FREE VSD-custom layout course |completed|
|13.|Create the design shown in section 7 of the course and perform pre-layout using xschem/ngspice using SKY130 PDKS||
|14.| Post layout characterization using magic/ngspice and SKY130 PDKs||
|15.|Post layout characterization using ALIGN |
|16.| Compare 14 and 15||
|17.| Update your findings on your GitHub repo with the title “Week 1” ||
## Table of contents
- <b>Week 0</b>
   1. Install Oracle virtual box with Ubuntu 22.04 LTS
   2. Installation of Tools and SKY130 PDKs
      - Magic
      - Netgen
      - Ngspice
      - Xschem
      - Open_pdks
      - Align Tool
   3. Create inverter and perform pre-layout using xschem or ngspice
      - Creation of Layout using inverter schematic in layout tool MAGIC

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

-To check for the functionality of the tool: Type Magic

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




### Creating an inverter schematic in Xschem

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

-Simulating the testbench

![simulation](https://user-images.githubusercontent.com/68071764/218276575-657e42e4-8aed-4b1f-8dc3-109cdeedfb44.png)
![graph1](https://user-images.githubusercontent.com/68071764/218276579-459dd06f-ea8a-4534-b173-b02e234e4dc2.png)

- we have verified the working of our inverter schematic and we need a netist of exclusively that, and not our entire testbench. Open the inverter from the files menu and go to suimulation menu and select "LVS netlist: top lvl is a subsckt" and then tap netlist. Exit xschem.

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

##Week 1 AI's

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

##### Making ALIGN Portable to Sky130 tehnology

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

