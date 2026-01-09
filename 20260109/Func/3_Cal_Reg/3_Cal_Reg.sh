#!/bin/bash

cd /nd_disk4/qinbolin/Bolin/Data/MT_EPI/2025/testdata_MT01/NIFTI/Func3

3drefit -TR 2.38 rtMT_ON.nii
3drefit -TR 2.38 rtMT_OFF.nii

3dcalc -overwrite -a rtMT_ON.nii -b rtMT_OFF.nii -expr '(b-a)/b' -prefix rtMTR.nii
3dcalc -overwrite -a rtMT_ON.nii -b rtMT_OFF.nii -expr 'a/b' -prefix rtMT_boco.nii

3dTstat -cvarinv -overwrite -prefix rtMT_ON_tSNR.nii rtMT_ON.nii
3dTstat -cvarinv -overwrite -prefix rtMT_OFF_tSNR.nii rtMT_OFF.nii
3dTstat -cvarinv -overwrite -prefix rtMTR_tSNR.nii rtMTR.nii
3dTstat -cvarinv -overwrite -prefix rtMT_boco_tSNR.nii rtMT_boco.nii

3dTstat -mean -overwrite -prefix rtMT_ON_mean.nii rtMT_ON.nii
3dTstat -mean -overwrite -prefix rtMT_OFF_mean.nii rtMT_OFF.nii
3dTstat -mean -overwrite -prefix rtMTR_mean.nii rtMTR.nii
3dTstat -mean -overwrite -prefix rtMT_boco_mean.nii rtMT_boco.nii

3dcalc -overwrite -a rtMT_ON_mean.nii -b rtMT_OFF_mean.nii -expr '(b-a)/(a+10)' -prefix MT_anat.nii

# Register T1 to rtMT_OFF_mean.nii , we need T1.nii here (need editting)
matlab -nodesktop -nosplash -r "registerT1_batch"
