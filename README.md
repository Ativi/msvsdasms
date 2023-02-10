# msvsdasms
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
   3. Lab - Creating an inverter schematic in Xschem

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











