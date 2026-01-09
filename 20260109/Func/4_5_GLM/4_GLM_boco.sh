#!/bin/bash

cd /nd_disk4/qinbolin/Bolin/Data/MT_EPI/2025/testdata_MT01/NIFTI/Func3

FUNC_NII='rtMT_boco.nii'
CENSOR_1D='MT_boco_motion_censor.1D'
MOTION12_1D='MT_ON_motion_12.1D'
MOTION12_1D2='MT_OFF_motion_12.1D'

# ====GLM for beta, t, z====
3dDeconvolve -overwrite -jobs 16 -polort a -input ${FUNC_NII} \
	-TR_times 2.38 \
	-censor ${CENSOR_1D} \
	-num_stimts 3 \
	\
	-stim_times 1 '1D: 30 90 150 210 270' 'UBLOCK(30,1)' \
	-stim_label 1 Task \
	\
	-stim_file 2 ${MOTION12_1D} \
   	-stim_base 2 \
    	-stim_label 2 Motion \
	\
	-stim_file 3 ${MOTION12_1D2} \
   	-stim_base 3 \
    	-stim_label 3 Motion2 \
	\
	-tout \
	-x1D MODEL_UBLOCK_${FUNC_NII} \
	-bucket STATS_UBLOCK_${FUNC_NII}

echo "GLM done."

# beta 
3dbucket -prefix beta_UBLOCK_${FUNC_NII} STATS_UBLOCK_${FUNC_NII}'[Task#0_Coef]' -overwrite

# percent signal change
3dTstat -mean -prefix mean_${FUNC_NII} ${FUNC_NII} -overwrite
3dcalc -a beta_UBLOCK_${FUNC_NII} -b mean_${FUNC_NII} -expr 'a/b*100' -prefix beta_percent_UBLOCK_${FUNC_NII} -overwrite
rm mean_${FUNC_NII}

# t-map
3dbucket -prefix t_UBLOCK_${FUNC_NII} STATS_UBLOCK_${FUNC_NII}'[Task#0_Tstat]' -overwrite

# z-score
3dmerge -1zscore -prefix z_UBLOCK_${FUNC_NII} t_UBLOCK_${FUNC_NII} -overwrite

# ====GLM for HRF====
3dDeconvolve -overwrite -jobs 16 -polort a -input ${FUNC_NII} \
	-TR_times 2.38 \
	-censor ${CENSOR_1D} \
	-num_stimts 3 \
	\
	-stim_times 1 '1D: 30 90 150 210 270' 'TENT(0,47.6,21)' \
	-stim_label 1 Task \
	\
	-stim_file 2 ${MOTION12_1D} \
   	-stim_base 2 \
    	-stim_label 2 Motion \
	\
	-stim_file 3 ${MOTION12_1D2} \
   	-stim_base 3 \
    	-stim_label 3 Motion2 \
	\
	-fout \
	-x1D MODEL_TENT_${FUNC_NII} \
	-iresp 1 HRF_TENT_${FUNC_NII} \
	-bucket STATS_TENT_${FUNC_NII}

echo "Succees in GLM for HRF."

# percent signal change
3dTstat -mean -prefix mean_${FUNC_NII} ${FUNC_NII} -overwrite
3dcalc -a HRF_TENT_${FUNC_NII} -b mean_${FUNC_NII} -expr 'a/b*100' -prefix HRF_percent_TENT_${FUNC_NII} -overwrite
rm mean_${FUNC_NII}



