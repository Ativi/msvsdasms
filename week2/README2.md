# WEEK2 AI's

## 1. KLAYOUT INSTALLATION

Download the ‘.deb’ file from the KLayout homepage and install it, as shown below.
```
# Install KLayout
mkdir -p ~/Work/vlsi/tools/KLayout && cd ~/Work/vlsi/tools/KLayout
wget https://www.klayout.org/downloads/Ubuntu-22/klayout_0.28.5-1_amd64.deb
sudo apt install -y ./klayout_0.28.5-1_amd64.deb
```

![dnloadklayout](https://user-images.githubusercontent.com/68071764/220927811-cde8e792-cedb-42bf-b8ea-04796db939db.png)

![klayout done](https://user-images.githubusercontent.com/68071764/220927180-97c18f0b-f205-4d3e-a91e-378237d378be.png)

## 2. Install Yosys and OpenROAD using OpenROAD-flow-scripts

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

3. # Add VHDL to Yosys
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
