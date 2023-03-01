# WEEK2 AI's

## 1. KLAYOUT Installation

Download the ‘.deb’ file from the KLayout homepage and install it, as shown below.
```
# Install KLayout
mkdir -p ~/Work/vlsi/tools/KLayout && cd ~/Work/vlsi/tools/KLayout
wget https://www.klayout.org/downloads/Ubuntu-22/klayout_0.28.5-1_amd64.deb
sudo apt install -y ./klayout_0.28.5-1_amd64.deb
```

![dnloadklayout](https://user-images.githubusercontent.com/68071764/220927811-cde8e792-cedb-42bf-b8ea-04796db939db.png)

![klayout done](https://user-images.githubusercontent.com/68071764/220927180-97c18f0b-f205-4d3e-a91e-378237d378be.png)

## 2. Yosys and OpenROAD using OpenROAD-flow-scripts Installation

```
cd ~/Work/vlsi/tools
git clone --recursive https://github.com/The-OpenROAD-Project/OpenROAD-flow-scripts.git
```

Before you can go any further, you need to install some prerequisite software packages:

### Packages needed by Yosys
```
sudo apt install -y clang bison flex \
    libreadline-dev gawk tcl-dev libffi-dev git \
    graphviz xdot pkg-config python3 libboost-system-dev \
    libboost-python-dev libboost-filesystem-dev zlib1g-dev
 ```
 
### Packages needed by OpenROAD
```
sudo apt install -y cmake qtbase5-dev qtchooser qt5-qmake qtbase5-dev-tools \
    libmng2 qt5-image-formats-plugins tcl-tclreadline \
    swig libboost-all-dev libeigen3-dev libspdlog-dev
```
### Build 'lemon' from source
```
cd ~/Work/vlsi/tools && mkdir lemon && cd lemon
wget http://lemon.cs.elte.hu/pub/sources/lemon-1.3.1.tar.gz
tar-zxf lemon-1.3.1.tar.gz && cd lemon-1.3.1
cmake -B build .
sudo cmake --build build -j $(nproc) --target install
 ```
### Optional: Delete the 'lemon' sources
```
cd ~/Work/vlsi/tools && rm -fR lemon
```
Build all the tools needed for OpenROAD:
```
cd ~/Work/vlsi/tools/OpenROAD-flow-scripts
./build_openroad.sh --local
```
- This step can take over 30 minutes.

### Update '.bashrc' to point to the OpenROAD tools
printf '\n# Add Yosys and OpenROAD environment variables\n' >> ~/.bashrc
printf 'source ~/Work/vlsi/tools/OpenROAD-flow-scripts/setup_env.sh\n' >> ~/.bashrc

- Close the terminal and open a new one to pick up the environment variable changes.

# Add VHDL to Yosys
```
sudo apt install -y gnat
cd ~/Work/vlsi/tools && git clone https://github.com/ghdl/ghdl.git && cd ghdl
./configure --prefix=/usr/local
make
sudo make install
```

Install the ghdl-yosys-plugin:
```
cd ~/Work/vlsi/tools && git clone https://github.com/ghdl/ghdl-yosys-plugin.git
cd ghdl-yosys-plugin
make
# The plugin's installer detects where 'yosys' is on your system,
#  then installs the plugin to the right folder.
make install
```

Test the plugin’s integration:
```
cd ~/Work/vlsi/tools/ghdl-yosys-plugin/examples/icestick/leds/
ghdl -a leds.vhdl
ghdl -a spin1.vhdl
yosys -m ghdl -p 'ghdl leds; synth_ice40 -json leds.json'
```

You should see something like this in the output:

![yosys output](https://user-images.githubusercontent.com/68071764/221358698-be5a427d-cdc4-40a1-abc0-9b142f429c75.png)


![yos![Uploading yosys output.png…]()
ys](https://user-images.githubusercontent.com/68071764/221332544-77150620-db7c-471d-a145-fa0dec247c55.png)

## 3. Installing OpenRoad

- OpenROAD is an integrated chip physical design tool that takes a design from synthesized Verilog to routed layout.

- An outline of steps used to build a chip using OpenROAD is shown below:

- Initialize floorplan - define the chip size and cell rows
- Place pins (for designs without pads )
- Place macro cells (RAMs, embedded macros)
- Insert substrate tap cells
- Insert power distribution network
- Macro Placement of macro cells
- Global placement of standard cells
- Repair max slew, max capacitance, and max fanout violations and long wires
- Clock tree synthesis
- Optimize setup/hold timing
- Insert fill cells
- Global routing (route guides for detailed routing)
- Antenna repair
- Detailed routing
- Parasitic extraction
- Static timing analysis


- Steps to install openROAD are

```
cd
git clone --recursive https://github.com/The-OpenROAD-Project/OpenROAD.git
cd OpenROAD
sudo ./etc/DependencyInstaller.sh
cd
git clone --recursive https://github.com/The-OpenROAD-Project/OpenROAD-flow-scripts
cd OpenROAD-flow-scripts
./build_openroad.sh –local
export OPENROAD=~/OpenROAD-flow-scripts/tools/OpenROAD
export PATH=~/OpenROAD-flow-scripts/tools/install/OpenROAD/bin:~/OpenROAD-flow-scripts/tools/install/yosys/bin:~/OpenROAD-flow-scripts/tools/install/LSOracle/bin:$PATH
```
#### Building OpenROAD Locally 
```
./build_openroad.sh --local
source setup_env.sh
```

- You will see the following message:
```
OPENROAD: <path>/OpenROAD-flow-scripts/tools/OpenROAD
```

![ofrs complete](https://user-images.githubusercontent.com/68071764/221502311-ec5038fe-7934-4e93-b6cc-932ca91f20a4.png)


### 4. OpenFASOC Installation

- OpenFASoC is a project focused on automated analog generation from user specification to GDSII with fully open-sourced tools. It is led by a team of researchers at the University of Michigan and is inspired from FASoC which sits on proprietary software.

- The tool is comprised of analog and mixed-signal circuit generators, which automatically create a physical design based on user specifications.

- First, cd into a directory of your choice and clone the OpenFASoC repository:
```git clone https://github.com/idea-fasoc/openfasoc```

Now go to the home location of this repository (where the README.rst file is located) and ```run sudo ./dependencies.sh.```

# Temperature Sensor Auxiliary Cells

- An overview of how the Temperature Sensor Generator (temp-sense-gen) works internally in OpenFASoC.

#### Circuit

- This generator creates a compact mixed-signal temperature sensor based on the topology from this paper. It consists of a ring oscillator whose frequency is controlled by the voltage drop over a MOSFET operating in subthreshold regime, where its dependency on temperature is exponential.

![image](https://user-images.githubusercontent.com/68071764/221508171-1c4db4d0-9108-4761-a18f-b8aa085a820d.png)

- The physical implementation of the analog blocks in the circuit is done using two manually designed standard cells:

- HEADER cell, containing the transistors in subthreshold operation;

![headergds](https://user-images.githubusercontent.com/68071764/221580258-b6f3ed4b-0316-48f5-bd95-31bb0eec3e20.png)

- SLC cell, containing the Split-Control Level Converter.

![slcgds](https://user-images.githubusercontent.com/68071764/221580300-fdff5ab7-83b0-443b-9e45-5ef42b2007c1.png)

- The gds and lef files of HEADER and SLC cells are pre-created before the start of the Generator flow.
- The .gds files exist in ``` /.../openfasoc/openfasoc/generators/temp-sense-gen/blocks/sky130hd/gds ```

### Temperature Sensor Generation using OpenFASOC

1. <b>Verilog Generation:</b>

- By using make sky130hd_temp_verilog in ```/.../openfasoc/openfasoc/generators/temp-sense-gen ``` the verilog code based on <b>.jason file</b> will get generated. In this file temperature is being varied from -20 C to 100 C, and the parameter toward which the circuit must be optimized is selected which is <b>"error"</b> here. Based on the operating temperature range, generator calculates the number of header and inverters to minimize the error. 
- test.jason:
```
{
    "module_name": "tempsenseInst_error",
    "generator": "temp-sense-gen",
    "specifications": {
    	"temperature": { "min": -20, "max": 100 },
    	"power": "",
    	"error": "",
    	"area": "",
    	"optimization":"error",
    	"model" :"modelfile.csv"
	}
}
```
- By runnung make sky130hd_temp_verilog, the result on Terminal is: 

![openfasoc verilog generated](https://user-images.githubusercontent.com/68071764/221584760-593b4d5b-126c-4385-a7e1-1fd75e9eca1e.png)

- The opmization is done based on "modelfile.csv" exists in ``` /.../openfasoc/openfasoc/generators/temp-sense-gen/models ```

![image](https://user-images.githubusercontent.com/68071764/221585019-10033b58-bf91-4231-9cf2-4c66d2144d1f.png)

- After running the``` make sky130hd_temp_verilog``` command, the verilog files of ```counter.v, TEMP_ANALOG_hv.nl.v, TEMP_ANALOG_lv.nl.v ```are created in the ```/.../openfasoc/openfasoc/generators/temp-sense-gen/src``` folder. 

2. To run the default generator:
 -  cd into``` ~/openfasoc/generators/temp_sense`` and  enter ```make sky130hd_temp``` command.
 -  sometimes PDK_ROOT error arises:
 
 ![image](https://user-images.githubusercontent.com/68071764/221585754-b43d12fb-3dc7-4b57-a0cf-f833495b3dd4.png)
 
 - Make changes manually in config.jason file
 
 ![image](https://user-images.githubusercontent.com/68071764/221586029-8198ab17-3442-4b3d-8e7a-fd6f3c5e6247.png)

 - If OpenROAD not found in path error arises, provide path to openROAD along with PDK_ROOT 

![image](https://user-images.githubusercontent.com/68071764/221586567-33078602-9715-4f77-bbc5-e68242a878a2.png)

 ```
export OPENROAD=~/OpenROAD-flow-scripts/tools/OpenROAD/
export PATH=/home/ativi07/OpenROAD-flow-scripts/tools/install/OpenROAD/bin:/home/ativi07/OpenROAD-flow-scripts/tools/install/yosys/bin:/home/ativi07/OpenROAD-flow-scripts/tools/install/LSOracle/bin:$PATH
```
 
The default circuit’s physical design generation can be divided into three parts:

- Verilog generation
- RTL-to-GDS flow (OpenROAD)
- Post-layout verification (DRC and LVS)
After a successful run the following message is displayed:

![openfasoc](https://user-images.githubusercontent.com/68071764/221587137-00533d68-537c-4516-9d41-1a4a2c56d885.png)

- In the following directory all the files corresponding to different stages of the RTL2GDS flow is saved.

![openfasoc results](https://user-images.githubusercontent.com/68071764/221587968-af0d16ee-858e-4a70-a79d-a3ba7b09b955.png)

- Viewing the GDS view of the temperature generator using klayout in result folder.```klayout 6_final.gds```

![finalgdsopenfasoc](https://user-images.githubusercontent.com/68071764/221588079-bf3eeb2f-36f4-4dda-9a65-aadf21e35f29.png)







-------

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

![ring_osc_sym](https://user-images.githubusercontent.com/68071764/222116065-827cf17f-a4fd-486b-b1c8-ceacdcb1f827.png)

![ring_wave](https://user-images.githubusercontent.com/68071764/222116164-f6ff8360-b9ed-4e82-b132-32cb70a8b854.png)

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

- Run Design(use your original inverter spice file generated from xschem as input)

![align_input_netlist](https://user-images.githubusercontent.com/68071764/222158413-de3f4b89-b4e9-4eb0-a843-b839a766f334.png)

![gds generated](https://user-images.githubusercontent.com/68071764/222158855-5d21a536-238d-4884-b124-0fd881e110bb.png)

- Now open .gds file using magic tool(Go to options and Read GDS).

![ring_osc](https://user-images.githubusercontent.com/68071764/222168620-c35efb30-f34f-43aa-8234-0c3076b09580.png)


- GDS file loaded, Extract the netlist file. 

![extracted](https://user-images.githubusercontent.com/68071764/222166820-808069a1-0e10-4eac-aee9-522da5f784f4.png)

- New spice netlist will be created. 

```
* SPICE3 file created from RINGOSC_0.ext - technology: sky130A

X0 li_405_1579# STAGE2_INV_48754826_0_0_1677678370_0/li_491_571# m1_398_2912# m1_398_2912# sky130_fd_pr__pfet_01v8 ad=1.176e+11p pd=1.4e+06u as=6.678e+11p ps=8.22e+06u w=420000u l=150000u
X1 m1_398_2912# STAGE2_INV_48754826_0_0_1677678370_0/li_491_571# li_405_1579# m1_398_2912# sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=420000u l=150000u
X2 li_405_1579# STAGE2_INV_48754826_0_0_1677678370_0/li_491_571# VSUBS VSUBS sky130_fd_pr__nfet_01v8 ad=1.176e+11p pd=1.4e+06u as=6.678e+11p ps=8.22e+06u w=420000u l=150000u
X3 VSUBS STAGE2_INV_48754826_0_0_1677678370_0/li_491_571# li_405_1579# VSUBS sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=420000u l=150000u
X4 STAGE2_INV_48754826_0_0_1677678370_0/li_491_571# m1_688_4424# m1_398_2912# m1_398_2912# sky130_fd_pr__pfet_01v8 ad=1.176e+11p pd=1.4e+06u as=0p ps=0u w=420000u l=150000u
X5 m1_398_2912# m1_688_4424# STAGE2_INV_48754826_0_0_1677678370_0/li_491_571# m1_398_2912# sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=420000u l=150000u
X6 STAGE2_INV_48754826_0_0_1677678370_0/li_491_571# m1_688_4424# VSUBS VSUBS sky130_fd_pr__nfet_01v8 ad=1.176e+11p pd=1.4e+06u as=0p ps=0u w=420000u l=150000u
X7 VSUBS m1_688_4424# STAGE2_INV_48754826_0_0_1677678370_0/li_491_571# VSUBS sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=420000u l=150000u
X8 m1_688_4424# li_405_1579# VSUBS VSUBS sky130_fd_pr__nfet_01v8 ad=1.176e+11p pd=1.4e+06u as=0p ps=0u w=420000u l=150000u
X9 VSUBS li_405_1579# m1_688_4424# VSUBS sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=420000u l=150000u
X10 m1_688_4424# li_405_1579# m1_398_2912# m1_398_2912# sky130_fd_pr__pfet_01v8 ad=1.176e+11p pd=1.4e+06u as=0p ps=0u w=420000u l=150000u
X11 m1_398_2912# li_405_1579# m1_688_4424# m1_398_2912# sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=420000u l=150000u
C0 VDD m1_688_4424# 0.32fF
C1 VDD GND 0.24fF
C2 STAGE2_INV_48754826_0_0_1677678370_0/li_491_571# Y 0.00fF
C3 STAGE2_INV_48754826_0_0_1677678370_0/li_491_571# li_405_1579# 0.59fF
C4 Y li_405_1579# 0.01fF
C5 m1_398_2912# STAGE2_INV_48754826_0_0_1677678370_0/li_491_571# 2.97fF
C6 STAGE2_INV_48754826_0_0_1677678370_0/li_491_571# m1_688_4424# 0.62fF
C7 GND STAGE2_INV_48754826_0_0_1677678370_0/li_491_571# 0.15fF
C8 GND Y 0.02fF
C9 VDD STAGE2_INV_48754826_0_0_1677678370_0/li_491_571# 0.03fF
C10 VDD Y 0.24fF
C11 m1_398_2912# li_405_1579# 2.12fF
C12 m1_688_4424# li_405_1579# 0.46fF
C13 GND li_405_1579# 0.14fF
C14 VDD li_405_1579# 1.31fF
C15 m1_398_2912# m1_688_4424# 2.28fF
C16 VDD VSUBS 0.16fF
C17 m1_688_4424# VSUBS 2.58fF **FLOATING
C18 li_405_1579# VSUBS 1.88fF **FLOATING
C19 STAGE2_INV_48754826_0_0_1677678370_0/li_491_571# VSUBS 1.16fF **FLOATING
C20 m1_398_2912# VSUBS 8.15fF **FLOATING
```

- Merged the testbench netlist and the new generated netlist(Just keep one subckt there are two subckts).

```
SPICE3 file created from RINGOSC_0.ext - technology: sky130A

X0 li_405_1579# STAGE2_INV_48754826_0_0_1677678370_0/li_491_571# m1_398_2912# m1_398_2912# sky130_fd_pr__pfet_01v8 ad=1.176e+11p pd=1.4e+06u as=6.678e+11p ps=8.22e+06u w=420000u l=150000u
X1 m1_398_2912# STAGE2_INV_48754826_0_0_1677678370_0/li_491_571# li_405_1579# m1_398_2912# sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=420000u l=150000u
X2 li_405_1579# STAGE2_INV_48754826_0_0_1677678370_0/li_491_571# VSUBS VSUBS sky130_fd_pr__nfet_01v8 ad=1.176e+11p pd=1.4e+06u as=6.678e+11p ps=8.22e+06u w=420000u l=150000u
X3 VSUBS STAGE2_INV_48754826_0_0_1677678370_0/li_491_571# li_405_1579# VSUBS sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=420000u l=150000u
X4 STAGE2_INV_48754826_0_0_1677678370_0/li_491_571# m1_688_4424# m1_398_2912# m1_398_2912# sky130_fd_pr__pfet_01v8 ad=1.176e+11p pd=1.4e+06u as=0p ps=0u w=420000u l=150000u
X5 m1_398_2912# m1_688_4424# STAGE2_INV_48754826_0_0_1677678370_0/li_491_571# m1_398_2912# sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=420000u l=150000u
X6 STAGE2_INV_48754826_0_0_1677678370_0/li_491_571# m1_688_4424# VSUBS VSUBS sky130_fd_pr__nfet_01v8 ad=1.176e+11p pd=1.4e+06u as=0p ps=0u w=420000u l=150000u
X7 VSUBS m1_688_4424# STAGE2_INV_48754826_0_0_1677678370_0/li_491_571# VSUBS sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=420000u l=150000u
X8 m1_688_4424# li_405_1579# VSUBS VSUBS sky130_fd_pr__nfet_01v8 ad=1.176e+11p pd=1.4e+06u as=0p ps=0u w=420000u l=150000u
X9 VSUBS li_405_1579# m1_688_4424# VSUBS sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=420000u l=150000u
X10 m1_688_4424# li_405_1579# m1_398_2912# m1_398_2912# sky130_fd_pr__pfet_01v8 ad=1.176e+11p pd=1.4e+06u as=0p ps=0u w=420000u l=150000u
X11 m1_398_2912# li_405_1579# m1_688_4424# m1_398_2912# sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=420000u l=150000u
C0 VDD m1_688_4424# 0.32fF
C1 VDD GND 0.24fF
C2 STAGE2_INV_48754826_0_0_1677678370_0/li_491_571# Y 0.00fF
C3 STAGE2_INV_48754826_0_0_1677678370_0/li_491_571# li_405_1579# 0.59fF
C4 Y li_405_1579# 0.01fF
C5 m1_398_2912# STAGE2_INV_48754826_0_0_1677678370_0/li_491_571# 2.97fF
C6 STAGE2_INV_48754826_0_0_1677678370_0/li_491_571# m1_688_4424# 0.62fF
C7 GND STAGE2_INV_48754826_0_0_1677678370_0/li_491_571# 0.15fF
C8 GND Y 0.02fF
C9 VDD STAGE2_INV_48754826_0_0_1677678370_0/li_491_571# 0.03fF
C10 VDD Y 0.24fF
C11 m1_398_2912# li_405_1579# 2.12fF
C12 m1_688_4424# li_405_1579# 0.46fF
C13 GND li_405_1579# 0.14fF
C14 VDD li_405_1579# 1.31fF
C15 m1_398_2912# m1_688_4424# 2.28fF
C16 VDD VSUBS 0.16fF
C17 m1_688_4424# VSUBS 2.58fF
**FLOATING
C18 li_405_1579# VSUBS 1.88fF
**FLOATING
C19 STAGE2_INV_48754826_0_0_1677678370_0/li_491_571# VSUBS 1.16fF
**FLOATING
C20 m1_398_2912# VSUBS 8.15fF
**FLOATING








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
![alignrun](https://user-images.githubusercontent.com/68071764/222168165-58f862c6-232e-4183-b3a8-b5c99b4f4499.png)


![alignwaveform](https://user-images.githubusercontent.com/68071764/222168189-7a90a387-13cd-47a7-b17e-b3335f17eb79.png)
