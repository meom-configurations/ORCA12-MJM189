MODULE agrif_top_interp
#if defined key_agrif && defined key_top
   USE par_oce
   USE oce
   USE dom_oce      
   USE sol_oce
   USE agrif_oce
   USE agrif_top_sponge
   USE trc
   USE lib_mpp
   USE wrk_nemo  

   IMPLICIT NONE
   PRIVATE

   PUBLIC Agrif_trc

#  include "domzgr_substitute.h90"  
#  include "vectopt_loop_substitute.h90"
  !!----------------------------------------------------------------------
   !! NEMO/NST 3.3 , NEMO Consortium (2010)
   !! $Id: agrif_top_interp.F90 3680 2012-11-27 14:42:24Z rblod $
   !! Software governed by the CeCILL licence (NEMOGCM/NEMO_CeCILL.txt)
   !!----------------------------------------------------------------------

   CONTAINS

   SUBROUTINE Agrif_trc
      !!----------------------------------------------------------------------
      !!                  ***  ROUTINE Agrif_Tra  ***
      !!----------------------------------------------------------------------
      !!
      INTEGER  ::   ji, jj, jk, jn   ! dummy loop indices
      REAL(wp) ::   zrhox , alpha1, alpha2, alpha3
      REAL(wp) ::   alpha4, alpha5, alpha6, alpha7
      REAL(wp), POINTER, DIMENSION(:,:,:,:) :: ztra
      !!----------------------------------------------------------------------
      !
      IF( Agrif_Root() )   RETURN

      CALL wrk_alloc( jpi, jpj, jpk, jptra, ztra )

      Agrif_SpecialValue    = 0.e0
      Agrif_UseSpecialValue = .TRUE.
      ztra(:,:,:,:) = 0.e0

      CALL Agrif_Bc_variable( ztra, trn_id, procname=interptrn )
      Agrif_UseSpecialValue = .FALSE.

      zrhox = Agrif_Rhox()

      alpha1 = ( zrhox - 1. ) * 0.5
      alpha2 = 1. - alpha1

      alpha3 = ( zrhox - 1. ) / ( zrhox + 1. )
      alpha4 = 1. - alpha3

      alpha6 = 2. * ( zrhox - 1. ) / ( zrhox + 1. )
      alpha7 =    - ( zrhox - 1. ) / ( zrhox + 3. )
      alpha5 = 1. - alpha6 - alpha7
      IF( nbondi == 1 .OR. nbondi == 2 ) THEN

         DO jn = 1, jptra
            tra(nlci,:,:,jn) = alpha1 * ztra(nlci,:,:,jn) + alpha2 * ztra(nlci-1,:,:,jn)
            DO jk = 1, jpkm1
               DO jj = 1, jpj
                  IF( umask(nlci-2,jj,jk) == 0.e0 ) THEN
                     tra(nlci-1,jj,jk,jn) = tra(nlci,jj,jk,jn) * tmask(nlci-1,jj,jk)
                  ELSE
                     tra(nlci-1,jj,jk,jn)=(alpha4*tra(nlci,jj,jk,jn)+alpha3*tra(nlci-2,jj,jk,jn))*tmask(nlci-1,jj,jk)
                     IF( un(nlci-2,jj,jk) > 0.e0 ) THEN
                        tra(nlci-1,jj,jk,jn)=( alpha6*tra(nlci-2,jj,jk,jn)+alpha5*tra(nlci,jj,jk,jn)  &
                           &                 + alpha7*tra(nlci-3,jj,jk,jn) ) * tmask(nlci-1,jj,jk)
                     ENDIF
                  ENDIF
               END DO
            END DO
         ENDDO
      ENDIF

      IF( nbondj == 1 .OR. nbondj == 2 ) THEN

         DO jn = 1, jptra
            tra(:,nlcj,:,jn) = alpha1 * ztra(:,nlcj,:,jn) + alpha2 * ztra(:,nlcj-1,:,jn)
            DO jk = 1, jpkm1
               DO ji = 1, jpi
                  IF( vmask(ji,nlcj-2,jk) == 0.e0 ) THEN
                     tra(ji,nlcj-1,jk,jn) = tra(ji,nlcj,jk,jn) * tmask(ji,nlcj-1,jk)
                  ELSE
                     tra(ji,nlcj-1,jk,jn)=(alpha4*tra(ji,nlcj,jk,jn)+alpha3*tra(ji,nlcj-2,jk,jn))*tmask(ji,nlcj-1,jk)
                     IF (vn(ji,nlcj-2,jk) > 0.e0 ) THEN
                        tra(ji,nlcj-1,jk,jn)=( alpha6*tra(ji,nlcj-2,jk,jn)+alpha5*tra(ji,nlcj,jk,jn)  &
                           &                 + alpha7*tra(ji,nlcj-3,jk,jn) ) * tmask(ji,nlcj-1,jk)
                     ENDIF
                  ENDIF
               END DO
            END DO
         ENDDO
      ENDIF
      IF( nbondi == -1 .OR. nbondi == 2 ) THEN
         DO jn = 1, jptra
            tra(1,:,:,jn) = alpha1 * ztra(1,:,:,jn) + alpha2 * ztra(2,:,:,jn)
            DO jk = 1, jpkm1
               DO jj = 1, jpj
                  IF( umask(2,jj,jk) == 0.e0 ) THEN
                     tra(2,jj,jk,jn) = tra(1,jj,jk,jn) * tmask(2,jj,jk)
                  ELSE
                     tra(2,jj,jk,jn)=(alpha4*tra(1,jj,jk,jn)+alpha3*tra(3,jj,jk,jn))*tmask(2,jj,jk)
                     IF( un(2,jj,jk) < 0.e0 ) THEN
                        tra(2,jj,jk,jn)=(alpha6*tra(3,jj,jk,jn)+alpha5*tra(1,jj,jk,jn)+alpha7*tra(4,jj,jk,jn))*tmask(2,jj,jk)
                     ENDIF
                  ENDIF
               END DO
            END DO
         END DO
      ENDIF

      IF( nbondj == -1 .OR. nbondj == 2 ) THEN
         DO jn = 1, jptra
            tra(:,1,:,jn) = alpha1 * ztra(:,1,:,jn) + alpha2 * ztra(:,2,:,jn)
            DO jk=1,jpk
               DO ji=1,jpi
                  IF( vmask(ji,2,jk) == 0.e0 ) THEN
                     tra(ji,2,jk,jn)=tra(ji,1,jk,jn) * tmask(ji,2,jk)
                  ELSE
                     tra(ji,2,jk,jn)=(alpha4*tra(ji,1,jk,jn)+alpha3*tra(ji,3,jk,jn))*tmask(ji,2,jk)
                     IF( vn(ji,2,jk) < 0.e0 ) THEN
                        tra(ji,2,jk,jn)=(alpha6*tra(ji,3,jk,jn)+alpha5*tra(ji,1,jk,jn)+alpha7*tra(ji,4,jk,jn))*tmask(ji,2,jk)
                     ENDIF
                  ENDIF
               END DO
            END DO
         ENDDO
      ENDIF
      !
      CALL wrk_dealloc( jpi, jpj, jpk, jptra, ztra )
      !

   END SUBROUTINE Agrif_trc

#else
CONTAINS
   SUBROUTINE Agrif_TOP_Interp_empty
      !!---------------------------------------------
      !!   *** ROUTINE agrif_Top_Interp_empty ***
      !!---------------------------------------------
      WRITE(*,*)  'agrif_top_interp : You should not have seen this print! error?'
   END SUBROUTINE Agrif_TOP_Interp_empty
#endif
END MODULE agrif_top_interp
