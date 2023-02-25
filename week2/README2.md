WEEK2 AI's

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
```
# Packages needed by Yosys
sudo apt install -y clang bison flex \
    libreadline-dev gawk tcl-dev libffi-dev git \
    graphviz xdot pkg-config python3 libboost-system-dev \
    libboost-python-dev libboost-filesystem-dev zlib1g-dev
 
# Packages needed by OpenROAD
sudo apt install -y cmake qtbase5-dev qtchooser qt5-qmake qtbase5-dev-tools \
    libmng2 qt5-image-formats-plugins tcl-tclreadline \
    swig libboost-all-dev libeigen3-dev libspdlog-dev
# Build 'lemon' from source
cd ~/Work/vlsi/tools && mkdir lemon && cd lemon
wget http://lemon.cs.elte.hu/pub/sources/lemon-1.3.1.tar.gz
tar -zxf lemon-1.3.1.tar.gz && cd lemon-1.3.1
cmake -B build .
sudo cmake --build build -j $(nproc) --target install
 
# Optional: Delete the 'lemon' sources
cd ~/Work/vlsi/tools && rm -fR lemon
```
