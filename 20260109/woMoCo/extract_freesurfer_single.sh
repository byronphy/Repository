#!/bin/bash

export SUBJECTS_DIR=$(pwd)

aparcstats2table --hemi lh --meas thickness --parc aparc.a2009s \
                 --tablefile sub01_woMoCo_lh.txt  \
                 --subjects brainMasked_recon
		    
aparcstats2table --hemi rh --meas thickness --parc aparc.a2009s \
                 --tablefile sub01_woMoCo_rh.txt  \
                 --subjects brainMasked_recon

asegstats2table --meas volume --tablefile sub01_woMoCo_volume.txt \
                --subjects brainMasked_recon


echo "Done."



