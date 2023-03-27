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

## FLOW 

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

## Comparion of pre layout and post layout netlist

![comparision between pre and post](https://user-images.githubusercontent.com/68071764/221345895-affd7cfa-8a39-4cd6-bf47-f1de59512ffd.png)


## Post-layout simulation of function using ALIGN

- Create a python virtualenv
 ```
 python -m venv general
source general/bin/activate
python -m pip install pip --upgrade
mkdir build
cd build
```

- Running Design(use your original inverter spice file generated from xschem as input).

![error netlist](https://user-images.githubusercontent.com/68071764/220626124-15b81438-18a1-4b6f-a2a2-66e7fdac407d.png)

- Once you run this netlist, below error will be pop up 

![align errorr](https://user-images.githubusercontent.com/68071764/220626444-ee6047ba-3b04-4edc-b62e-3107aa853de3.png)

- Make changes as per error, in my case:

![align input](https://user-images.githubusercontent.com/68071764/220625621-4d443a91-5fbb-494a-bd1f-61b19c63c38f.png)

- NOTE!! ( The first path should be netlist directory)(Rename the spice file netlist with .sp instead of .spice tool understands .sp format)

- Now run the design(location of your spice file and the pdk)

```
(general) ativi07@ativi07-VirtualBox:~/Desktop/ALIGN-public/build$ python3 ../bin/schematic2layout.py  /home/ativi07/.xschem/simulations -p ../pdks/SKY130_PDK/ 
```
- Generated .lef and .gds
- 
![gds generated using align](https://user-images.githubusercontent.com/68071764/220627315-c6b64aae-0726-462f-8c89-745b0ea29187.png)

- Now open .gds file using magic tool(Go to options and Read GDS).

![gds output](https://user-images.githubusercontent.com/68071764/220631655-76212d9b-60f8-4533-b3b9-980554c6919a.png)

- GDS file loaded, Extract the netlist file.

```
extract do local
extract all
ext2spice cthresh 0 rthresh 0
ext2spice
```
- New spice netlist will be created. "Function_0.spice"

![newnetlist](https://user-images.githubusercontent.com/68071764/220634036-44221f57-3dbb-4663-ab9b-fb167caf6a1f.png)

- Merged the testbench netlist and the new generated netlist(Just keep one subckt there are two subckts).
- Run the updated spice netlist(the extracted netlist which you get from magic does not contain the control statements(plots, sources, etc). It's just a bare subckt(black box or an IC). You must add the .control statements(power it) by pasting them from the pre-layout and get a similar results.
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




.lib /usr/local/share/pdk/sky130A/libs.tech/ngspice/sky130.lib.spice tt

.control
save all
tran 10p 4n
plot A B C D E F Fn
.endc

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
XM1 net2 A vp vp sky130_fd_pr__pfet_01v8
XM2 net3 B vp vp sky130_fd_pr__pfet_01v8
XM3 net1 D net3 vp sky130_fd_pr__pfet_01v8
XM4 net1 C net2 vp sky130_fd_pr__pfet_01v8
XM5 Fn F net1 vp sky130_fd_pr__pfet_01v8
XM6 Fn E net1 vp sky130_fd_pr__pfet_01v8
XM7 Fn A net4 vn sky130_fd_pr__nfet_01v8
XM8 net4 B vn vn sky130_fd_pr__nfet_01v8
XM9 Fn C net4 vn sky130_fd_pr__nfet_01v8
XM10 Fn E net5 vn sky130_fd_pr__nfet_01v8
XM11 net4 D vn vn sky130_fd_pr__nfet_01v8
XM12 net6 F vn vn sky130_fd_pr__nfet_01v8
.ends

.GLOBAL GND
.GLOBAL VDD
.end


* SPICE3 file created from FUNCTION_0.ext - technology: sky130A

X0 m1_656_3248# B VN VN sky130_fd_pr__nfet_01v8 ad=1.8165e+13p pd=1.648e+08u as=1.55925e+13p ps=1.431e+08u w=1.05e+06u l=150000u
X1 VN B m1_656_3248# VN sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X2 m1_656_3248# B VN VN sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X3 m1_656_3248# B VN VN sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X4 VN B m1_656_3248# VN sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X5 VN B m1_656_3248# VN sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X6 m1_656_3248# B VN VN sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X7 m1_656_3248# B VN VN sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X8 VN B m1_656_3248# VN sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X9 m1_656_3248# B VN VN sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X10 m1_656_3248# B VN VN sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X11 VN B m1_656_3248# VN sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X12 VN B m1_656_3248# VN sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X13 VN B m1_656_3248# VN sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X14 m1_656_3248# B VN VN sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X15 VN B m1_656_3248# VN sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X16 m1_656_3248# B VN VN sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X17 m1_656_3248# B VN VN sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X18 VN B m1_656_3248# VN sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X19 m1_656_3248# B VN VN sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X20 VN B m1_656_3248# VN sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X21 m1_656_3248# B VN VN sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X22 VN B m1_656_3248# VN sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X23 m1_656_3248# B VN VN sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X24 VN B m1_656_3248# VN sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X25 m1_656_3248# B VN VN sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X26 VN B m1_656_3248# VN sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X27 m1_656_3248# B VN VN sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X28 VN B m1_656_3248# VN sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X29 VN B m1_656_3248# VN sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X30 m1_7536_1652# D m1_5902_4172# VP sky130_fd_pr__pfet_01v8 ad=3.633e+13p pd=2.95e+08u as=1.9215e+13p ps=1.569e+08u w=2.1e+06u l=150000u
X31 m1_5902_4172# D m1_7536_1652# VP sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=2.1e+06u l=150000u
X32 m1_5902_4172# D m1_7536_1652# VP sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=2.1e+06u l=150000u
X33 m1_7536_1652# D m1_5902_4172# VP sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=2.1e+06u l=150000u
X34 m1_7536_1652# D m1_5902_4172# VP sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=2.1e+06u l=150000u
X35 m1_5902_4172# D m1_7536_1652# VP sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=2.1e+06u l=150000u
X36 m1_7536_1652# D m1_5902_4172# VP sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=2.1e+06u l=150000u
X37 m1_7536_1652# D m1_5902_4172# VP sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=2.1e+06u l=150000u
X38 m1_5902_4172# D m1_7536_1652# VP sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=2.1e+06u l=150000u
X39 m1_5902_4172# D m1_7536_1652# VP sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=2.1e+06u l=150000u
X40 m1_7536_1652# D m1_5902_4172# VP sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=2.1e+06u l=150000u
X41 m1_7536_1652# D m1_5902_4172# VP sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=2.1e+06u l=150000u
X42 m1_5902_4172# D m1_7536_1652# VP sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=2.1e+06u l=150000u
X43 m1_5902_4172# D m1_7536_1652# VP sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=2.1e+06u l=150000u
X44 m1_5902_4172# D m1_7536_1652# VP sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=2.1e+06u l=150000u
X45 m1_7536_1652# D m1_5902_4172# VP sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=2.1e+06u l=150000u
X46 m1_7536_1652# D m1_5902_4172# VP sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=2.1e+06u l=150000u
X47 m1_5902_4172# D m1_7536_1652# VP sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=2.1e+06u l=150000u
X48 m1_7536_1652# D m1_5902_4172# VP sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=2.1e+06u l=150000u
X49 m1_5902_4172# D m1_7536_1652# VP sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=2.1e+06u l=150000u
X50 m1_7536_1652# D m1_5902_4172# VP sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=2.1e+06u l=150000u
X51 m1_5902_4172# D m1_7536_1652# VP sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=2.1e+06u l=150000u
X52 m1_7536_1652# D m1_5902_4172# VP sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=2.1e+06u l=150000u
X53 m1_5902_4172# D m1_7536_1652# VP sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=2.1e+06u l=150000u
X54 m1_7536_1652# D m1_5902_4172# VP sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=2.1e+06u l=150000u
X55 m1_5902_4172# D m1_7536_1652# VP sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=2.1e+06u l=150000u
X56 m1_7536_1652# D m1_5902_4172# VP sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=2.1e+06u l=150000u
X57 m1_5902_4172# D m1_7536_1652# VP sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=2.1e+06u l=150000u
X58 m1_7536_1652# D m1_5902_4172# VP sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=2.1e+06u l=150000u
X59 m1_5902_4172# D m1_7536_1652# VP sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=2.1e+06u l=150000u
X60 m1_7536_1652# C m2_4272_4247# VP sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=1.9215e+13p ps=1.569e+08u w=2.1e+06u l=150000u
X61 m2_4272_4247# C m1_7536_1652# VP sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=2.1e+06u l=150000u
X62 m2_4272_4247# C m1_7536_1652# VP sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=2.1e+06u l=150000u
X63 m1_7536_1652# C m2_4272_4247# VP sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=2.1e+06u l=150000u
X64 m1_7536_1652# C m2_4272_4247# VP sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=2.1e+06u l=150000u
X65 m2_4272_4247# C m1_7536_1652# VP sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=2.1e+06u l=150000u
X66 m1_7536_1652# C m2_4272_4247# VP sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=2.1e+06u l=150000u
X67 m1_7536_1652# C m2_4272_4247# VP sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=2.1e+06u l=150000u
X68 m2_4272_4247# C m1_7536_1652# VP sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=2.1e+06u l=150000u
X69 m2_4272_4247# C m1_7536_1652# VP sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=2.1e+06u l=150000u
X70 m1_7536_1652# C m2_4272_4247# VP sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=2.1e+06u l=150000u
X71 m1_7536_1652# C m2_4272_4247# VP sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=2.1e+06u l=150000u
X72 m2_4272_4247# C m1_7536_1652# VP sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=2.1e+06u l=150000u
X73 m2_4272_4247# C m1_7536_1652# VP sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=2.1e+06u l=150000u
X74 m2_4272_4247# C m1_7536_1652# VP sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=2.1e+06u l=150000u
X75 m1_7536_1652# C m2_4272_4247# VP sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=2.1e+06u l=150000u
X76 m1_7536_1652# C m2_4272_4247# VP sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=2.1e+06u l=150000u
X77 m2_4272_4247# C m1_7536_1652# VP sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=2.1e+06u l=150000u
X78 m1_7536_1652# C m2_4272_4247# VP sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=2.1e+06u l=150000u
X79 m2_4272_4247# C m1_7536_1652# VP sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=2.1e+06u l=150000u
X80 m1_7536_1652# C m2_4272_4247# VP sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=2.1e+06u l=150000u
X81 m2_4272_4247# C m1_7536_1652# VP sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=2.1e+06u l=150000u
X82 m1_7536_1652# C m2_4272_4247# VP sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=2.1e+06u l=150000u
X83 m2_4272_4247# C m1_7536_1652# VP sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=2.1e+06u l=150000u
X84 m1_7536_1652# C m2_4272_4247# VP sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=2.1e+06u l=150000u
X85 m2_4272_4247# C m1_7536_1652# VP sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=2.1e+06u l=150000u
X86 m1_7536_1652# C m2_4272_4247# VP sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=2.1e+06u l=150000u
X87 m2_4272_4247# C m1_7536_1652# VP sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=2.1e+06u l=150000u
X88 m1_7536_1652# C m2_4272_4247# VP sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=2.1e+06u l=150000u
X89 m2_4272_4247# C m1_7536_1652# VP sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=2.1e+06u l=150000u
X90 NMOS_S_57089185_X5_Y3_1677070276_1/a_230_462# F VN VN sky130_fd_pr__nfet_01v8 ad=4.41e+12p pd=3.99e+07u as=0p ps=0u w=1.05e+06u l=150000u
X91 VN F NMOS_S_57089185_X5_Y3_1677070276_1/a_230_462# VN sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X92 NMOS_S_57089185_X5_Y3_1677070276_1/a_230_462# F VN VN sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X93 NMOS_S_57089185_X5_Y3_1677070276_1/a_230_462# F VN VN sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X94 VN F NMOS_S_57089185_X5_Y3_1677070276_1/a_230_462# VN sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X95 VN F NMOS_S_57089185_X5_Y3_1677070276_1/a_230_462# VN sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X96 NMOS_S_57089185_X5_Y3_1677070276_1/a_230_462# F VN VN sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X97 NMOS_S_57089185_X5_Y3_1677070276_1/a_230_462# F VN VN sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X98 VN F NMOS_S_57089185_X5_Y3_1677070276_1/a_230_462# VN sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X99 NMOS_S_57089185_X5_Y3_1677070276_1/a_230_462# F VN VN sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X100 NMOS_S_57089185_X5_Y3_1677070276_1/a_230_462# F VN VN sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X101 VN F NMOS_S_57089185_X5_Y3_1677070276_1/a_230_462# VN sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X102 VN F NMOS_S_57089185_X5_Y3_1677070276_1/a_230_462# VN sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X103 VN F NMOS_S_57089185_X5_Y3_1677070276_1/a_230_462# VN sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X104 NMOS_S_57089185_X5_Y3_1677070276_1/a_230_462# F VN VN sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X105 VN F NMOS_S_57089185_X5_Y3_1677070276_1/a_230_462# VN sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X106 NMOS_S_57089185_X5_Y3_1677070276_1/a_230_462# F VN VN sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X107 NMOS_S_57089185_X5_Y3_1677070276_1/a_230_462# F VN VN sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X108 VN F NMOS_S_57089185_X5_Y3_1677070276_1/a_230_462# VN sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X109 NMOS_S_57089185_X5_Y3_1677070276_1/a_230_462# F VN VN sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X110 VN F NMOS_S_57089185_X5_Y3_1677070276_1/a_230_462# VN sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X111 NMOS_S_57089185_X5_Y3_1677070276_1/a_230_462# F VN VN sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X112 VN F NMOS_S_57089185_X5_Y3_1677070276_1/a_230_462# VN sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X113 NMOS_S_57089185_X5_Y3_1677070276_1/a_230_462# F VN VN sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X114 VN F NMOS_S_57089185_X5_Y3_1677070276_1/a_230_462# VN sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X115 NMOS_S_57089185_X5_Y3_1677070276_1/a_230_462# F VN VN sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X116 VN F NMOS_S_57089185_X5_Y3_1677070276_1/a_230_462# VN sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X117 NMOS_S_57089185_X5_Y3_1677070276_1/a_230_462# F VN VN sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X118 VN F NMOS_S_57089185_X5_Y3_1677070276_1/a_230_462# VN sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X119 VN F NMOS_S_57089185_X5_Y3_1677070276_1/a_230_462# VN sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X120 m1_656_3248# D VN VN sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X121 VN D m1_656_3248# VN sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X122 m1_656_3248# D VN VN sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X123 m1_656_3248# D VN VN sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X124 VN D m1_656_3248# VN sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X125 VN D m1_656_3248# VN sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X126 m1_656_3248# D VN VN sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X127 m1_656_3248# D VN VN sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X128 VN D m1_656_3248# VN sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X129 m1_656_3248# D VN VN sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X130 m1_656_3248# D VN VN sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X131 VN D m1_656_3248# VN sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X132 VN D m1_656_3248# VN sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X133 VN D m1_656_3248# VN sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X134 m1_656_3248# D VN VN sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X135 VN D m1_656_3248# VN sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X136 m1_656_3248# D VN VN sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X137 m1_656_3248# D VN VN sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X138 VN D m1_656_3248# VN sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X139 m1_656_3248# D VN VN sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X140 VN D m1_656_3248# VN sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X141 m1_656_3248# D VN VN sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X142 VN D m1_656_3248# VN sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X143 m1_656_3248# D VN VN sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X144 VN D m1_656_3248# VN sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X145 m1_656_3248# D VN VN sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X146 VN D m1_656_3248# VN sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X147 m1_656_3248# D VN VN sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X148 VN D m1_656_3248# VN sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X149 VN D m1_656_3248# VN sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X150 FN C m1_656_3248# VN sky130_fd_pr__nfet_01v8 ad=1.323e+13p pd=1.197e+08u as=0p ps=0u w=1.05e+06u l=150000u
X151 FN C m1_656_3248# VN sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X152 m1_656_3248# C FN VN sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X153 m1_656_3248# C FN VN sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X154 FN C m1_656_3248# VN sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X155 m1_656_3248# C FN VN sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X156 FN C m1_656_3248# VN sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X157 m1_656_3248# C FN VN sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X158 FN C m1_656_3248# VN sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X159 FN C m1_656_3248# VN sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X160 m1_656_3248# C FN VN sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X161 FN C m1_656_3248# VN sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X162 m1_656_3248# C FN VN sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X163 FN C m1_656_3248# VN sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X164 m1_656_3248# C FN VN sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X165 FN C m1_656_3248# VN sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X166 FN C m1_656_3248# VN sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X167 m1_656_3248# C FN VN sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X168 FN C m1_656_3248# VN sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X169 m1_656_3248# C FN VN sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X170 m1_656_3248# C FN VN sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X171 m1_656_3248# C FN VN sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X172 m1_656_3248# C FN VN sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X173 FN C m1_656_3248# VN sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X174 m1_656_3248# C FN VN sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X175 FN C m1_656_3248# VN sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X176 m1_656_3248# C FN VN sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X177 FN C m1_656_3248# VN sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X178 FN C m1_656_3248# VN sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X179 m1_656_3248# C FN VN sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X180 FN A m1_656_3248# VN sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X181 FN A m1_656_3248# VN sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X182 m1_656_3248# A FN VN sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X183 m1_656_3248# A FN VN sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X184 FN A m1_656_3248# VN sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X185 m1_656_3248# A FN VN sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X186 FN A m1_656_3248# VN sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X187 m1_656_3248# A FN VN sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X188 FN A m1_656_3248# VN sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X189 FN A m1_656_3248# VN sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X190 m1_656_3248# A FN VN sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X191 FN A m1_656_3248# VN sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X192 m1_656_3248# A FN VN sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X193 FN A m1_656_3248# VN sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X194 m1_656_3248# A FN VN sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X195 FN A m1_656_3248# VN sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X196 FN A m1_656_3248# VN sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X197 m1_656_3248# A FN VN sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X198 FN A m1_656_3248# VN sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X199 m1_656_3248# A FN VN sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X200 m1_656_3248# A FN VN sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X201 m1_656_3248# A FN VN sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X202 m1_656_3248# A FN VN sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X203 FN A m1_656_3248# VN sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X204 m1_656_3248# A FN VN sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X205 FN A m1_656_3248# VN sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X206 m1_656_3248# A FN VN sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X207 FN A m1_656_3248# VN sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X208 FN A m1_656_3248# VN sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X209 m1_656_3248# A FN VN sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X210 FN E m1_7536_1652# VP sky130_fd_pr__pfet_01v8 ad=1.764e+13p pd=1.428e+08u as=0p ps=0u w=2.1e+06u l=150000u
X211 m1_7536_1652# E FN VP sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=2.1e+06u l=150000u
X212 FN E m1_7536_1652# VP sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=2.1e+06u l=150000u
X213 FN E m1_7536_1652# VP sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=2.1e+06u l=150000u
X214 m1_7536_1652# E FN VP sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=2.1e+06u l=150000u
X215 FN E m1_7536_1652# VP sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=2.1e+06u l=150000u
X216 m1_7536_1652# E FN VP sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=2.1e+06u l=150000u
X217 FN E m1_7536_1652# VP sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=2.1e+06u l=150000u
X218 FN E m1_7536_1652# VP sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=2.1e+06u l=150000u
X219 m1_7536_1652# E FN VP sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=2.1e+06u l=150000u
X220 m1_7536_1652# E FN VP sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=2.1e+06u l=150000u
X221 FN E m1_7536_1652# VP sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=2.1e+06u l=150000u
X222 m1_7536_1652# E FN VP sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=2.1e+06u l=150000u
X223 FN E m1_7536_1652# VP sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=2.1e+06u l=150000u
X224 m1_7536_1652# E FN VP sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=2.1e+06u l=150000u
X225 FN E m1_7536_1652# VP sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=2.1e+06u l=150000u
X226 FN E m1_7536_1652# VP sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=2.1e+06u l=150000u
X227 m1_7536_1652# E FN VP sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=2.1e+06u l=150000u
X228 FN E m1_7536_1652# VP sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=2.1e+06u l=150000u
X229 m1_7536_1652# E FN VP sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=2.1e+06u l=150000u
X230 m1_7536_1652# E FN VP sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=2.1e+06u l=150000u
X231 FN E m1_7536_1652# VP sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=2.1e+06u l=150000u
X232 FN E m1_7536_1652# VP sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=2.1e+06u l=150000u
X233 FN E m1_7536_1652# VP sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=2.1e+06u l=150000u
X234 m1_7536_1652# E FN VP sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=2.1e+06u l=150000u
X235 FN E m1_7536_1652# VP sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=2.1e+06u l=150000u
X236 m1_7536_1652# E FN VP sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=2.1e+06u l=150000u
X237 m1_7536_1652# E FN VP sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=2.1e+06u l=150000u
X238 m1_7536_1652# E FN VP sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=2.1e+06u l=150000u
X239 m1_7536_1652# E FN VP sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=2.1e+06u l=150000u
X240 FN E NMOS_4T_9093182_X15_Y1_1677070275_2/a_147_462# VN sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=4.6725e+12p ps=4.25e+07u w=1.05e+06u l=150000u
X241 FN E NMOS_4T_9093182_X15_Y1_1677070275_2/a_147_462# VN sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X242 NMOS_4T_9093182_X15_Y1_1677070275_2/a_147_462# E FN VN sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X243 NMOS_4T_9093182_X15_Y1_1677070275_2/a_147_462# E FN VN sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X244 FN E NMOS_4T_9093182_X15_Y1_1677070275_2/a_147_462# VN sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X245 NMOS_4T_9093182_X15_Y1_1677070275_2/a_147_462# E FN VN sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X246 FN E NMOS_4T_9093182_X15_Y1_1677070275_2/a_147_462# VN sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X247 NMOS_4T_9093182_X15_Y1_1677070275_2/a_147_462# E FN VN sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X248 FN E NMOS_4T_9093182_X15_Y1_1677070275_2/a_147_462# VN sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X249 FN E NMOS_4T_9093182_X15_Y1_1677070275_2/a_147_462# VN sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X250 NMOS_4T_9093182_X15_Y1_1677070275_2/a_147_462# E FN VN sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X251 FN E NMOS_4T_9093182_X15_Y1_1677070275_2/a_147_462# VN sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X252 NMOS_4T_9093182_X15_Y1_1677070275_2/a_147_462# E FN VN sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X253 FN E NMOS_4T_9093182_X15_Y1_1677070275_2/a_147_462# VN sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X254 NMOS_4T_9093182_X15_Y1_1677070275_2/a_147_462# E FN VN sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X255 FN E NMOS_4T_9093182_X15_Y1_1677070275_2/a_147_462# VN sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X256 FN E NMOS_4T_9093182_X15_Y1_1677070275_2/a_147_462# VN sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X257 NMOS_4T_9093182_X15_Y1_1677070275_2/a_147_462# E FN VN sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X258 FN E NMOS_4T_9093182_X15_Y1_1677070275_2/a_147_462# VN sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X259 NMOS_4T_9093182_X15_Y1_1677070275_2/a_147_462# E FN VN sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X260 NMOS_4T_9093182_X15_Y1_1677070275_2/a_147_462# E FN VN sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X261 NMOS_4T_9093182_X15_Y1_1677070275_2/a_147_462# E FN VN sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X262 NMOS_4T_9093182_X15_Y1_1677070275_2/a_147_462# E FN VN sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X263 FN E NMOS_4T_9093182_X15_Y1_1677070275_2/a_147_462# VN sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X264 NMOS_4T_9093182_X15_Y1_1677070275_2/a_147_462# E FN VN sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X265 FN E NMOS_4T_9093182_X15_Y1_1677070275_2/a_147_462# VN sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X266 NMOS_4T_9093182_X15_Y1_1677070275_2/a_147_462# E FN VN sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X267 FN E NMOS_4T_9093182_X15_Y1_1677070275_2/a_147_462# VN sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X268 FN E NMOS_4T_9093182_X15_Y1_1677070275_2/a_147_462# VN sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X269 NMOS_4T_9093182_X15_Y1_1677070275_2/a_147_462# E FN VN sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=1.05e+06u l=150000u
X270 FN F m1_7536_1652# VP sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=2.1e+06u l=150000u
X271 m1_7536_1652# F FN VP sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=2.1e+06u l=150000u
X272 FN F m1_7536_1652# VP sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=2.1e+06u l=150000u
X273 FN F m1_7536_1652# VP sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=2.1e+06u l=150000u
X274 m1_7536_1652# F FN VP sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=2.1e+06u l=150000u
X275 FN F m1_7536_1652# VP sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=2.1e+06u l=150000u
X276 m1_7536_1652# F FN VP sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=2.1e+06u l=150000u
X277 FN F m1_7536_1652# VP sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=2.1e+06u l=150000u
X278 FN F m1_7536_1652# VP sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=2.1e+06u l=150000u
X279 m1_7536_1652# F FN VP sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=2.1e+06u l=150000u
X280 m1_7536_1652# F FN VP sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=2.1e+06u l=150000u
X281 FN F m1_7536_1652# VP sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=2.1e+06u l=150000u
X282 m1_7536_1652# F FN VP sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=2.1e+06u l=150000u
X283 FN F m1_7536_1652# VP sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=2.1e+06u l=150000u
X284 m1_7536_1652# F FN VP sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=2.1e+06u l=150000u
X285 FN F m1_7536_1652# VP sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=2.1e+06u l=150000u
X286 FN F m1_7536_1652# VP sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=2.1e+06u l=150000u
X287 m1_7536_1652# F FN VP sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=2.1e+06u l=150000u
X288 FN F m1_7536_1652# VP sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=2.1e+06u l=150000u
X289 m1_7536_1652# F FN VP sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=2.1e+06u l=150000u
X290 m1_7536_1652# F FN VP sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=2.1e+06u l=150000u
X291 FN F m1_7536_1652# VP sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=2.1e+06u l=150000u
X292 FN F m1_7536_1652# VP sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=2.1e+06u l=150000u
X293 FN F m1_7536_1652# VP sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=2.1e+06u l=150000u
X294 m1_7536_1652# F FN VP sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=2.1e+06u l=150000u
X295 FN F m1_7536_1652# VP sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=2.1e+06u l=150000u
X296 m1_7536_1652# F FN VP sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=2.1e+06u l=150000u
X297 m1_7536_1652# F FN VP sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=2.1e+06u l=150000u
X298 m1_7536_1652# F FN VP sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=2.1e+06u l=150000u
X299 m1_7536_1652# F FN VP sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=2.1e+06u l=150000u
X300 m1_5902_4172# B VP VP sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=1.9215e+13p ps=1.569e+08u w=2.1e+06u l=150000u
X301 m2_4272_4247# A VP VP sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=2.1e+06u l=150000u
X302 VP A m2_4272_4247# VP sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=2.1e+06u l=150000u
X303 VP A m2_4272_4247# VP sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=2.1e+06u l=150000u
X304 m1_5902_4172# B VP VP sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=2.1e+06u l=150000u
X305 VP A m2_4272_4247# VP sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=2.1e+06u l=150000u
X306 VP B m1_5902_4172# VP sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=2.1e+06u l=150000u
X307 m1_5902_4172# B VP VP sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=2.1e+06u l=150000u
X308 m1_5902_4172# B VP VP sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=2.1e+06u l=150000u
X309 VP B m1_5902_4172# VP sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=2.1e+06u l=150000u
X310 VP B m1_5902_4172# VP sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=2.1e+06u l=150000u
X311 m1_5902_4172# B VP VP sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=2.1e+06u l=150000u
X312 m1_5902_4172# B VP VP sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=2.1e+06u l=150000u
X313 VP A m2_4272_4247# VP sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=2.1e+06u l=150000u
X314 m2_4272_4247# A VP VP sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=2.1e+06u l=150000u
X315 VP B m1_5902_4172# VP sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=2.1e+06u l=150000u
X316 m1_5902_4172# B VP VP sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=2.1e+06u l=150000u
X317 VP B m1_5902_4172# VP sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=2.1e+06u l=150000u
X318 VP A m2_4272_4247# VP sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=2.1e+06u l=150000u
X319 m2_4272_4247# A VP VP sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=2.1e+06u l=150000u
X320 m2_4272_4247# A VP VP sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=2.1e+06u l=150000u
X321 VP B m1_5902_4172# VP sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=2.1e+06u l=150000u
X322 m1_5902_4172# B VP VP sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=2.1e+06u l=150000u
X323 VP A m2_4272_4247# VP sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=2.1e+06u l=150000u
X324 m1_5902_4172# B VP VP sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=2.1e+06u l=150000u
X325 m2_4272_4247# A VP VP sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=2.1e+06u l=150000u
X326 VP B m1_5902_4172# VP sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=2.1e+06u l=150000u
X327 VP B m1_5902_4172# VP sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=2.1e+06u l=150000u
X328 VP B m1_5902_4172# VP sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=2.1e+06u l=150000u
X329 m1_5902_4172# B VP VP sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=2.1e+06u l=150000u
X330 m2_4272_4247# A VP VP sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=2.1e+06u l=150000u
X331 m2_4272_4247# A VP VP sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=2.1e+06u l=150000u
X332 VP A m2_4272_4247# VP sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=2.1e+06u l=150000u
X333 VP B m1_5902_4172# VP sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=2.1e+06u l=150000u
X334 m1_5902_4172# B VP VP sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=2.1e+06u l=150000u
X335 m2_4272_4247# A VP VP sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=2.1e+06u l=150000u
X336 m1_5902_4172# B VP VP sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=2.1e+06u l=150000u
X337 VP A m2_4272_4247# VP sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=2.1e+06u l=150000u
X338 m2_4272_4247# A VP VP sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=2.1e+06u l=150000u
X339 VP A m2_4272_4247# VP sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=2.1e+06u l=150000u
X340 VP B m1_5902_4172# VP sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=2.1e+06u l=150000u
X341 VP B m1_5902_4172# VP sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=2.1e+06u l=150000u
X342 m2_4272_4247# A VP VP sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=2.1e+06u l=150000u
X343 VP B m1_5902_4172# VP sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=2.1e+06u l=150000u
X344 m1_5902_4172# B VP VP sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=2.1e+06u l=150000u
X345 m2_4272_4247# A VP VP sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=2.1e+06u l=150000u
X346 VP A m2_4272_4247# VP sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=2.1e+06u l=150000u
X347 m2_4272_4247# A VP VP sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=2.1e+06u l=150000u
X348 VP B m1_5902_4172# VP sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=2.1e+06u l=150000u
X349 VP A m2_4272_4247# VP sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=2.1e+06u l=150000u
X350 VP A m2_4272_4247# VP sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=2.1e+06u l=150000u
X351 m2_4272_4247# A VP VP sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=2.1e+06u l=150000u
X352 m1_5902_4172# B VP VP sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=2.1e+06u l=150000u
X353 VP A m2_4272_4247# VP sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=2.1e+06u l=150000u
X354 m2_4272_4247# A VP VP sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=2.1e+06u l=150000u
X355 m1_5902_4172# B VP VP sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=2.1e+06u l=150000u
X356 VP B m1_5902_4172# VP sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=2.1e+06u l=150000u
X357 VP A m2_4272_4247# VP sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=2.1e+06u l=150000u
X358 m2_4272_4247# A VP VP sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=2.1e+06u l=150000u
X359 VP A m2_4272_4247# VP sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=2.1e+06u l=150000u
C0 m1_656_3248# m2_4272_4247# 0.01fF
C1 B F 1.68fF
C2 A m2_4272_4247# 1.89fF
C3 FN VP 2.71fF
C4 B NMOS_4T_9093182_X15_Y1_1677070275_2/a_147_462# 0.00fF
C5 E B 0.01fF
C6 m1_7536_1652# m1_5902_4172# 11.63fF
C7 m1_656_3248# F 0.51fF
C8 B m1_5902_4172# 1.66fF
C9 A F 1.01fF
C10 m1_656_3248# NMOS_4T_9093182_X15_Y1_1677070275_2/a_147_462# 0.07fF
C11 m1_656_3248# E 0.15fF
C12 E A 0.04fF
C13 A m1_5902_4172# 1.66fF
C14 B NMOS_S_57089185_X5_Y3_1677070276_1/a_230_462# 0.01fF
C15 m2_4272_4247# F 1.07fF
C16 E m2_4272_4247# 0.00fF
C17 D m1_7536_1652# 2.96fF
C18 VN m1_7536_1652# 0.27fF
C19 m1_656_3248# NMOS_S_57089185_X5_Y3_1677070276_1/a_230_462# 0.50fF
C20 B D 1.02fF
C21 B VN 0.26fF
C22 C m1_7536_1652# 3.66fF
C23 m2_4272_4247# m1_5902_4172# 4.93fF
C24 E F 0.06fF
C25 C B 0.80fF
C26 E NMOS_4T_9093182_X15_Y1_1677070275_2/a_147_462# 1.63fF
C27 m1_656_3248# D 3.43fF
C28 D A 0.40fF
C29 m1_7536_1652# VP 7.07fF
C30 FN m1_7536_1652# 22.40fF
C31 m1_656_3248# VN 3.38fF
C32 VN A 0.03fF
C33 B VP 10.44fF
C34 m1_5902_4172# F 0.13fF
C35 m1_656_3248# C 1.79fF
C36 E m1_5902_4172# 0.00fF
C37 C A 0.17fF
C38 m2_4272_4247# NMOS_S_57089185_X5_Y3_1677070276_1/a_230_462# 0.00fF
C39 m1_656_3248# VP 0.30fF
C40 m1_656_3248# FN 21.42fF
C41 A VP 8.43fF
C42 FN A 1.99fF
C43 D m2_4272_4247# 0.73fF
C44 NMOS_S_57089185_X5_Y3_1677070276_1/a_230_462# F 3.14fF
C45 NMOS_S_57089185_X5_Y3_1677070276_1/a_230_462# NMOS_4T_9093182_X15_Y1_1677070275_2/a_147_462# 0.00fF
C46 E NMOS_S_57089185_X5_Y3_1677070276_1/a_230_462# 0.00fF
C47 VN m2_4272_4247# 0.22fF
C48 C m2_4272_4247# 3.12fF
C49 D F 0.87fF
C50 E D 0.01fF
C51 VN F 0.49fF
C52 VN NMOS_4T_9093182_X15_Y1_1677070275_2/a_147_462# 0.05fF
C53 m2_4272_4247# VP 15.51fF
C54 E VN 0.20fF
C55 FN m2_4272_4247# 0.00fF
C56 C F 0.39fF
C57 C NMOS_4T_9093182_X15_Y1_1677070275_2/a_147_462# 0.00fF
C58 E C 0.25fF
C59 D m1_5902_4172# 3.04fF
C60 VP F 7.49fF
C61 FN F 1.36fF
C62 VP NMOS_4T_9093182_X15_Y1_1677070275_2/a_147_462# 0.10fF
C63 FN NMOS_4T_9093182_X15_Y1_1677070275_2/a_147_462# 10.60fF
C64 E VP 6.13fF
C65 C m1_5902_4172# 0.01fF
C66 E FN 3.09fF
C67 B m1_7536_1652# 0.12fF
C68 VP m1_5902_4172# 19.12fF
C69 FN m1_5902_4172# 0.00fF
C70 D NMOS_S_57089185_X5_Y3_1677070276_1/a_230_462# 0.21fF
C71 m1_656_3248# m1_7536_1652# 0.32fF
C72 A m1_7536_1652# 0.16fF
C73 VN NMOS_S_57089185_X5_Y3_1677070276_1/a_230_462# 0.39fF
C74 m1_656_3248# B 3.15fF
C75 B A 8.36fF
C76 D VN 0.61fF
C77 FN NMOS_S_57089185_X5_Y3_1677070276_1/a_230_462# 0.00fF
C78 m1_656_3248# A 1.80fF
C79 C D 0.28fF
C80 C VN 0.21fF
C81 D VP 6.40fF
C82 m1_7536_1652# m2_4272_4247# 11.35fF
C83 VN VP 0.82fF
C84 FN VN 0.18fF
C85 B m2_4272_4247# 1.19fF
C86 C VP 5.98fF
C87 C FN 2.09fF
C88 m1_7536_1652# F 2.03fF
C89 m1_7536_1652# NMOS_4T_9093182_X15_Y1_1677070275_2/a_147_462# 0.06fF
C90 E m1_7536_1652# 1.55fF
C91 C 0 5.53fF
**FLOATING
C92 A 0 5.12fF
**FLOATING
C93 D 0 8.51fF
**FLOATING
C94 m1_656_3248# 0 19.92fF
**FLOATING
C95 E 0 5.33fF
**FLOATING
C96 B 0 6.18fF
**FLOATING
C97 F 0 9.93fF
**FLOATING
C98 NMOS_4T_9093182_X15_Y1_1677070275_2/a_147_462# 0 0.12fF
**FLOATING
C99 NMOS_S_57089185_X5_Y3_1677070276_1/a_230_462# 0 11.56fF
**FLOATING
C100 VP 0 66.72fF
**FLOATING
```

![output using align](https://user-images.githubusercontent.com/68071764/220641415-59d9e43a-b54c-4d2d-a838-db6da0d50dd5.png)

![opalign](https://user-images.githubusercontent.com/68071764/220641496-576d2aae-f9df-4f12-9991-b6bb13e498f4.png)

![plot A fn](https://user-images.githubusercontent.com/68071764/220641526-18d344b5-0cb5-4ae2-9b96-6f0383dbe5c9.png)

- netlist can be compared using LVS by netgen.

```
(general) ativi07@ativi07-VirtualBox:~/Desktop/ALIGN-public/week0/inverter/netgen$ netgen -batch lvs "../mag/mergedfunction.spice"  "/home/ativi07/.xschem/simulations/alignfunctb.spice"
```
![compare 14 and 15](https://user-images.githubusercontent.com/68071764/220644365-b4894f2a-b01d-4e6d-be66-d4e7fdfc4ad7.png)


## Conclusion
- In summary, pre-layout simulation and post-layout simulation yield slightly different waveforms due to the consideration of parasitic capacitances and resistances in post-layout simulations, which are not considered in pre-layout simulations. Moreover, post-layout simulations using different tools like Magic and ALIGN also result in a variation of parasitic effects and delay, with ALIGN showing lower parasitic effects and a lower delay than Magic during post-layout simulations.

# References
- https://github.com/ALIGN-analoglayout/ALIGN-public
- http://opencircuitdesign.com/magic/
