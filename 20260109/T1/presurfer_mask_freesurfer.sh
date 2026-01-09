#!/bin/bash

# gunzip mannually .nii.gz to .nii first
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

