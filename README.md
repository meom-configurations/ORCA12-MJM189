# ORCA12.L46-MJM189  
ORCA12.L46-MJM189 configuration performed at DRAKKAR/MEOM

This repository hold the code, and configuration files usefull for running this configuration.

## REFERENCE CODE : 
 This configuration is based on the NEMO configuration 3.5_beta. The exact revision number for the reference is not known, (likely revision 4023 of IPSL nemo forge),  but the corresponding code can be found in the NEMO directory of this repository. It uses DCM revision 1506.  It is used together with the XIOS server at rev. 703 of the XIOS branch/xios-1.0. Code can be downloaded from the IPSL forge using the following statements :

### NEMO
    See the code in NEMO directory of this repository

### XIOS
 ```svn co -r 703 http://forge.ipsl.jussieu.fr/ioserver/svn/XIOS/branchs/xios-1.0```
 
## BRIEF DESCRIPTION:
### Overview
   This global configuration  uses the ORCA12 grid, with the standard DRAKKAR 46 levels.  This run was performed as the 2014 modelling effort for MEOM. In this run, we use last revision of NEMO + corrections in the EEN advection scheme regarding the Hollingsworth instability. It also uses a mask correction in dyn_vor_een as proposed by Nicolas Ducousso. The run covers the period from 1958 to 2015, and was started on jade CINES super-computer in summer 2014, and finished in March 2015 (simulation up to 2012). This run was continued till the end of 2015 in February 2016.
   
###  Parameterizations:
 1. use filtered free surface (key_dynspg_flt)
 2. use vector form advection scheme for dynamics, with corrections.
 3. use TVD advection scheme for tracers.
 4. use biharmonic viscosity scaled with the cube of the mesh size.
 5. use laplacian isopycnal diffusivity for tracers.
 6. use TKE vertical mixing parameterization with enhanced vertical diffusion for deep convection. use tidal mixing parameterization.
 7. use LIM2 ice model
 8. use BBL (bottom boundary layer) parameterization.
 9. use free slip lateral condition except in the Idonesian through-flow area, Mediterannean Sea, West coast of Greenland ( near cape desolation) and in the northern part of Nares Strait.
 
### Forcing:
  1. Atmospheric forcing is DFS5.2, with ```CORE bulk formulae``` and relative winds (ocean surface velocity components taken into account for the wind stress computation). 
  2. SSS restoring toward Levitus98 with a piston velocity of 167 mm/day ( 60 days/10 meters).
  3. Run-off from Dai-Trenberth including climatological iceberg contribution from Da Silva
 
  
### XIOS output ( all file in netcdf3, 64_bit_offset).
  Unfortunatly, 1d and 5d output were lost from 1958 to 1969 when switching from jade to occigen computers, but computed monthly means were saved for all the period.
  1. 1h output ( 468 Gb/year, **only 1959** ! )
     * **1h_gridT** files : SST
  2. 1d output (289 Gb/year)
     * **1d_gridT** files :SST, SSS, SST, MXL
     * **1d_gridU** files :SSU 
     * **1d_gridV** files :SSV
     * **1d_icemod** files :  iicethic, ileadfra
  3. 5d output (1.2Tb/year, from 2003-onward : 539Gb [convertion to netcdf4/hdf4] )
     * **gridT** files : votemper, vosaline, sossheig
     * **gridU** files : vozocrtx, vozotaux
     * **gridV** files : vomecrty, vometauy
     * **gridW** files : vovecrtz, votkeavt 
     * **flxT** files : 12 fluxes/forcing variables
     * **icemod** files : 13 icemod variables.
     
### Run time files:
   Most of the run time files are indicated in the namelist files, except for:
   
   * bathymetry : ```bathymetry_ORCA12_V3.3.nc```
   * coordinates : ```coordinates_ORCA_R12_lbclnk_no_z.nc ```
   * bottom friction : ```orca12_bfr_coef_MAL101.nc ```
   * Ice initialisation : ```ORCA12.L46-MAL95_y1998-2007m01_icemod_initMAL101.nc ```
   * AABW damping mask : ``` ORCA12.L46_dmp_mask.nc ```


  

