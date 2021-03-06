MODULE obc_par
   !!==============================================================================
   !!                  ***  MODULE obc_par   ***
   !! Open Boundary Cond. :   define related parameters
   !!==============================================================================
   !! history :  OPA  ! 1991-01 (CLIPPER)  Original code 
   !!   NEMO     1.0  ! 2002-04   (C. Talandier)  modules
   !!             -   ! 2004/06   (F. Durand) jptobc is defined as a parameter
   !!----------------------------------------------------------------------
#if defined key_obc
   !!----------------------------------------------------------------------
   !!   'key_obc' :                                 Open Boundary Condition
   !!----------------------------------------------------------------------
   USE par_oce         ! ocean parameters

   IMPLICIT NONE
   PUBLIC

#if ! defined key_agrif
   LOGICAL, PUBLIC, PARAMETER ::   lk_obc = .TRUE.     !: Ocean Boundary Condition flag
#else
   LOGICAL, PUBLIC            ::   lk_obc = .TRUE.     !: Ocean Boundary Condition flag
#endif

# if defined key_eel_r5
   !!----------------------------------------------------------------------
   !!   'key_eel_r5' :                                 EEL R5 configuration
   !!----------------------------------------------------------------------
#    include "obc_par_EEL_R5.h90"

# elif defined key_pomme_r025
   !!----------------------------------------------------------------------
   !!   'key_pomme_r025' :                         POMME R025 configuration
   !!----------------------------------------------------------------------
#    include "obc_par_POMME_R025.h90"
#elif defined key_periant05
   !!----------------------------------------------------------------------
   !!   'periant05' :                               PERIANT05 configuration
   !!----------------------------------------------------------------------
#    include "obc_par_PERIANT05.h90"
#elif defined key_natl025
   !!----------------------------------------------------------------------
   !!   'natl025' :                                   NATL025 configuration
   !!----------------------------------------------------------------------
#    include "obc_par_NATL025.h90"
#elif defined key_gib025
   !!----------------------------------------------------------------------
   !!   'gib025' :                                     GIB025 configuration
   !!----------------------------------------------------------------------
#    include "obc_par_GIB025.h90"
# else
   !!---------------------------------------------------------------------
   !! open boundary parameter
   !!---------------------------------------------------------------------
   INTEGER, PARAMETER ::   jptobc      =  2        !: time dimension of the BCS fields on input
   
   !! * EAST open boundary
   LOGICAL, PARAMETER ::   lp_obc_east = .FALSE.   !: to active or not the East open boundary
   INTEGER   &
#if !defined key_agrif
     , PARAMETER   & 
#endif
    ::     & 
      jpieob  = jpiglo-2,    &  !: i-localization of the East open boundary (must be ocean U-point)
      jpjed   =        2,    &  !: j-starting indice of the East open boundary (must be land T-point)
      jpjef   = jpjglo-1,    &  !: j-ending   indice of the East open boundary (must be land T-point)
      jpjedp1 =  jpjed+1,    &  !: first ocean point         "                 "
      jpjefm1 =  jpjef-1        !: last  ocean point         "                 "

   !! * WEST open boundary
   LOGICAL, PARAMETER ::   lp_obc_west = .FALSE.   !: to active or not the West open boundary
   INTEGER   &
#if !defined key_agrif
     , PARAMETER   & 
#endif
    ::     & 
      jpiwob  =	       2,    &  !: i-localization of the West open boundary (must be ocean U-point)
      jpjwd   =	       2,    &  !: j-starting indice of the West open boundary (must be land T-point)
      jpjwf   = jpjglo-1,    &  !: j-ending   indice of the West open boundary (must be land T-point)
      jpjwdp1 =  jpjwd+1,    &  !: first ocean point         "                 "
      jpjwfm1 =  jpjwf-1        !: last  ocean point         "                 "

   !! * NORTH open boundary
   LOGICAL, PARAMETER ::   lp_obc_north = .FALSE.   !: to active or not the North open boundary
     INTEGER   &
#if !defined key_agrif
     , PARAMETER   & 
#endif
    ::     & 
      jpjnob  = jpjglo-2,    &  !: j-localization of the North open boundary (must be ocean V-point)
      jpind   =        2,    &  !: i-starting indice of the North open boundary (must be land T-point)
      jpinf   = jpiglo-1,    &  !: i-ending   indice of the North open boundary (must be land T-point)
      jpindp1 =  jpind+1,    &  !: first ocean point         "                 "
      jpinfm1 =  jpinf-1        !: last  ocean point         "                 "

   !! * SOUTH open boundary
   LOGICAL, PARAMETER ::   lp_obc_south = .FALSE.   !: to active or not the South open boundary
     INTEGER   &
#if !defined key_agrif
     , PARAMETER   & 
#endif
    ::     & 
      jpjsob  =        2,    &  !: j-localization of the South open boundary (must be ocean V-point)
      jpisd   =        2,    &  !: i-starting indice of the South open boundary (must be land T-point)
      jpisf   = jpiglo-1,    &  !: i-ending   indice of the South open boundary (must be land T-point)
      jpisdp1 =  jpisd+1,    &  !: first ocean point         "                 "
      jpisfm1 =  jpisf-1        !: last  ocean point         "                 "
   

# endif

#else
   !!----------------------------------------------------------------------
   !!   Default option :                         NO open boundary condition
   !!----------------------------------------------------------------------
#if ! defined key_agrif
   LOGICAL, PUBLIC, PARAMETER ::   lk_obc = .FALSE.  !: Ocean Boundary Condition flag
#else
   LOGICAL, PUBLIC            ::   lk_obc = .FALSE.     !: Ocean Boundary Condition flag
#endif
#endif

   !!----------------------------------------------------------------------
   !! NEMO/OPA 3.3 , NEMO Consortium (2010)
   !! $Id: obc_par.F90 3294 2012-01-28 16:44:18Z rblod $ 
   !! Software governed by the CeCILL licence     (NEMOGCM/NEMO_CeCILL.txt)
   !!======================================================================
END MODULE obc_par
