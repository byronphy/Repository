#!/bin/bash

cd /nd_disk4/qinbolin/Bolin/Data/MT_EPI/2025/testdata_MT01/NIFTI/Func3

# input: ON, OFF, boco
FUNC_NII='rtMT_boco.nii'
MEAN_NII='rtMT_boco_mean.nii'

# 3-fold upsampling
read dx dy dz <<< $(3dinfo -ad3 ${MEAN_NII})
sdx=$(echo "$dx / 3" | bc -l)
sdy=$(echo "$dy / 3" | bc -l)
sdz=$(echo "$dz / 3" | bc -l) 

# Do once
#3dresample -dxyz ${sdx} ${sdy} ${sdz} -rmode Cu -overwrite -prefix us_rT1.nii -input rT1.nii

3dresample -dxyz ${sdx} ${sdy} ${sdz} -rmode Cu -overwrite -prefix us_${MEAN_NII} -input ${MEAN_NII}
3dresample -dxyz ${sdx} ${sdy} ${sdz} -rmode Cu -overwrite -prefix us_beta_percent_UBLOCK_${FUNC_NII} -input beta_percent_UBLOCK_${FUNC_NII}
3dresample -dxyz ${sdx} ${sdy} ${sdz} -rmode Li -overwrite -prefix us_t_UBLOCK_${FUNC_NII} -input t_UBLOCK_${FUNC_NII}
3dresample -dxyz ${sdx} ${sdy} ${sdz} -rmode Li -overwrite -prefix us_z_UBLOCK_${FUNC_NII} -input z_UBLOCK_${FUNC_NII}



