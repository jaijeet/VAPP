## The Berkeley Verilog-A Parser and Processor (VAPP)

VAPP is a MATLAB/Octave tool that translates Verilog-A device models into [ModSpec](https://doi.org/10.1109/ICCAD.2011.6105356).
It is a subproject of the Berkeley Model and Algorithm Prototyping Platform ([MAPP](https://github.com/jaijeet/MAPP)).

## Requirements

VAPP requires MATLAB R2012a or later.

There is an Octave compatible version of VAPP which is maintained in a separate branch in this repository.
For more information see the [Octave Compatibility](#octave-compatibility) section below.

## Installation
After cloning this repository to your machine and changing into the VAPP directory, there are two options to start using this source release.

-----
###1 - On a Unix system

Run the following commands in a terminal

```
autoconf
./configure
make
```

This will create a new directory which will include softlinks to VAPP source files.
It will also create a script `start_VAPP.m` that will add the VAPP directory structure to your MATLAB path.
This script has to be run each time you start MATLAB. There are two ways you can do this.

####Option 1
Add the VAPP directory permanently to your MATLAB path by including 

```
addpath('/path/to/your/vapp_repo/');
```

in your `startup.m` file.
This file is most likely located in `~/Documents/MATLAB`.
Don't forget to change `/path/to/your/vapp_repo` to the actual path on your machine.
Now, each time you start MATLAB, you can run

```
start_VAPP
```

and VAPP paths will be setup for the rest of your MATLAB session.

Alternatively, you can add

```
run('/path/to/your/vapp_repo/start_VAPP');
```

to your `startup.m` and let MATLAB add VAPP directories to its path every time a new session is started.

####Option 2
Each time you start a MATLAB session, run the following commands at a MATLAB prompt
```
cd /path/to/your/vapp_repo/
start_VAPP
```

-----
###2 - On a non-Unix system
VAPP includes a `start_VAPP_portable.m` file to be used on a platform where the GNU build system is not available.
This script will setup VAPP paths relative to the directory from where it is being run.
To use this script run the following commands at a MATLAB prompt each time you start a new session.
```
cd /path/to/your/vapp_repo/
start_VAPP_portable
```

## Usage

VAPP has a simple user interface command: `va2modspec` which takes a Verilog-A file as input and prints out the corresponding ModSpec file.
Basic usage of this command is simply
```
va2modspec('veriloga_file_name.va')
```
For further information, run `help va2modspec` in MATLAB.
For a quick introduction and a complete example use case run `help VAPPquickstart`.

## Help Topics

For an introduction to VAPP try the following help documents.
```
help va2modspec
help VAPPquickstart
help VAPPexamples
```

## Examples

VAPP comes with extensive examples.
These examples are located in the examples directory.
Each example consists of a different model and a MAPP script to perform an analysis using that model.
The following models are available within the examples.

* [BSIM-3](http://bsim.berkeley.edu/models/bsim4/bsim3/)
* [BSIM-4](http://bsim.berkeley.edu/models/bsim4/)
* [BSIM-6](http://bsim.berkeley.edu/models/bsimbulk/)
* [MVS-1](https://nanohub.org/publications/15/4)
* [PSP](http://www.nxp.com/products/software-and-tools/models-and-test-data/compact-models-simkit/mos-models/model-psp:MODELPSP)
* [Purdue Negative Capacitance FET](https://nanohub.org/publications/95/2)
* [R3](https://nanohub.org/publications/26/1)
* [VBIC](http://www.designers-guide.org/VBIC/)

## Octave Compatibility
We maintain a separate branch in the repo that is Octave compatible.
If you are planning to use VAPP with Octave, please check out the Octave\_compatible branch instead of the main branch.
