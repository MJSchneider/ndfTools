<h3 align="center">ndfTools</h3>
<p align="center"> A set of MATLAB functions for working with the ndf archive used by <a href="https://www.opensourceinstruments.com/">Open Source Instruments</a>.
    <br> 
</p>

## 📝 Table of Contents
- [Installation](#installation)
- [Usage](#usage)
- [TODO](./TODO.md)
- [Authors](#authors)

## Installation <a name="installation"></a>
First clone or install the repository into your desired directory.
```
git clone https://github.com/MJSchneider/ndfTools.git
```
Then add the following line to your startup.m file, replacing **ndfTools_Path** with the path to your choosen installation directory.

```
addpath(genpath(ndfTools_Path));
```
When you restart MATLAB the functions should now be available.

## Usage <a name="usage"></a>
### Functions
- [ndfRead](#ndfRead)
- [ndfExtract](#ndfExtract)
- [ndfReconstruct](#ndfReconstruct)
- [ndfWrite](#ndfWrite)

### Documentation 

#### ndfRead <a name="ndfRead"></a>
Opens an ndf archive as a struct.
```
ndf = ndfRead('filepath')
```
```
ndf = 

struct with fields:

      channel: [1×n double]
        value: [1×n double]
    timestamp: [1×n double]
```

#### ndfExtract <a name="ndfExtract"></a>
Pulls all channels from the ndf struct and creates a new struct were each field is a channel

#### ndfReconstruct <a name="ndfReconstruct"></a>
Simple reconstruction method to eliminate [bad messages](https://www.opensourceinstruments.com/Electronics/A3017/SCT.html#Bad%20Messages) by looking for large/inappropriate value changes. 

#### ndfWrite <a name="ndfwrite"></a>
Writes a string to the metadata section of the ndf arcihve

## Authors <a name="authors"></a>
- Copyright (c) 2021, [Michael Schneider](https://github.com/MJSchneider)



