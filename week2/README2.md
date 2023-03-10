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


