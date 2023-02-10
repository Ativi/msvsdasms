# msvsdasms
## Table of contents
- <b>Week 0</b>
   1. Install Oracle virtual box with Ubuntu 22.04 LTS
   2. Install Magic, ngspice and SKY130 PDKs
   3. Install ALIGN tool
   4. Lab - Checking Tool Installations
   5. Lab - Creating an Inverter Design

###  Install Oracle virtual box with Ubuntu 22.04 LTS

- Install Oracle virtual box with Ubuntu 20.04 - RAM at least 4GB, hard-disk atleast 120GB. 
        -   https://www.virtualbox.org/wiki/Downloads , https://ubuntu.com/download/desktop

###   Install Magic, ngspice and SKY130 PDKs

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
   

