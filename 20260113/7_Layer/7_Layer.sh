#!/bin/bash

cd /nd_disk4/qinbolin/Bolin/Data/MT_EPI/2025/Data/QBL_MT01_YANGYIKUAN_MT01_20250314/NIFTI/Func

LAYER_MASK='rim_V1R_13'

#gunzip ${LAYER_MASK}.nii.gz

LN_GROW_LAYERS -rim ${LAYER_MASK}.nii -N 21 -vinc 40


