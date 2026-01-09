#!/bin/bash

# Run MATLAB
echo "Presurfer"
matlab -nodesktop -nosplash -r "matlab_presurfer"
echo "Presurfer Done."


# Mask
echo "Masking"
MPRAGEised_path=$(find ./presurf_MPRAGEise/presurf_UNI -name "*_MPRAGEised.nii")
stripMask_path=$(find ./presurf_INV2 -name "*_stripmask.nii")
brainMask_path=$(find ./presurf_MPRAGEise/presurf_UNI -name "*_brainmask.nii")

fslmaths ${MPRAGEised_path} -mul ${stripMask_path} MPRAGEised_stripped.nii
fslmaths ${MPRAGEised_path} -mul ${brainMask_path} MPRAGEised_brainmasked.nii

echo "Masking Done."


# Freesurfer
echo "Freesurfer"
output_path=$(pwd)
recon_path="${output_path}/recon"
export SUBJECTS_DIR=${output_path}
recon-all -i ${MPRAGEised_path} -s ${recon_path} -all

echo "Freesurfer Done."
