#!/bin/bash

export SUBJECTS_DIR=$(pwd)

aparcstats2table --hemi lh --meas thickness --parc aparc.a2009s \
                 --tablefile sub01_wMoCo_lh.txt  \
                 --subjects brainMasked_recon
		    
aparcstats2table --hemi rh --meas thickness --parc aparc.a2009s \
                 --tablefile sub01_wMoCo_rh.txt  \
                 --subjects brainMasked_recon

asegstats2table --meas volume --tablefile sub01_wMoCo_volume.txt \
                --subjects brainMasked_recon


echo "Done."



