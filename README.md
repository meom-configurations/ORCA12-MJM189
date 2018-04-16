# ORCA12.L46-MJM189
ORCA12.L46-MJM189 configuration performed at DRAKKAR/MEOM

This repository hold the code, and configuration files usefull for running this configuration.

## REFERENCE CODE : 
 This configuration is based on the NEMO configuration 3.5_beta. The exact revision number for the reference is not known, but the corresponding code can be found in the NEMO directory of this repository.  It is used together with the XIOS server at rev. 703 of the XIOS branch/xios-1.0. Code can be downloaded from the IPSL forge using the following statements :

### NEMO
    See the code in NEMO directory of this repository

### XIOS
 ```svn co -r 703 http://forge.ipsl.jussieu.fr/ioserver/svn/XIOS/branchs/xios-1.0```
 
## BRIEF DESCRIPTION:
### Overview
   This global configuration  uses the ORCA12 grid, with the standard DRAKKAR 46 levels. 
   
   This simulation was performed in the frame of the 2016 *grands defis* on CINES/OCCIGEN2 super computer. The project was entitled **SINGOUT** for SImulation Nouvelle Generation 
   
###  Parameterizations:
 1. use non linear free surface (VVL)
 2. use UBS advection scheme for dynamics
 3. use FCT4 advection scheme for tracers.
 4. no explicit lateral viscosity  ( UBS scheme does it)
 5. use laplacian isopycnal diffusivity for tracers.
 
### Forcing:
  1. Atmospheric forcing is DFS5.2, with ```CORE bulk formulae``` 
  2. SSS restoring toward WOA9 with a piston velocity of 167 mm/day ( 60 days/10 meters).
  3. Run-off from Dai-Trenberth as usual, except around Antarctica ( explicit iceberg calving and ice-shelf melting).
  
### Antarctic fresh water fluxes:
  1. use of ICB module to represent iceberg calving and melting explicitely (Merino et al )
  2. use ice-shelf parameterization to represent melting ( Mathiot et al.).
  
### XIOS output ( all file in netcdf4 with deflation level 1).
  1. Due to vvl use weighted average (e3 ) when relevant.
  2. 1d output (170 Gb/year)
     * **gridTsurf** files :SST, SSS, SST, MXL
     * **gridUsurf** files :SSU, U10m, U30m, U50m 
     * **gridVsurf** files :SSV, V10m, V30m, V50m
  3. 5d output (1.1 Tb/year)
     * **gridT** files : e3t, votemper, vosaline, sossheig
     * **gridU** files : e3u, vozocrtx, vozotaux
     * **gridV** files : e3v, vomecrty, vometauy
     * **gridW** files : e3w, vovecrtz, voavt, voavmu, voavmv 
     * **flxT** files : 17 fluxes/forcing variables
     * **icemod3** files : 22 LIM3 variables.
     * **ICB** files : 16 iceberg related variables.
     
### Run time files:
   Most of the run time files are indicated in the namelist files, except for:
   
   * bathymetry : ```EORCA12_bathymetry_v2.5.nc```
   * coordinates : ```EORCA12_coordinates.nc```
   * bottom friction : ```EORCA12_bfr2d_UKmod.nc ```

