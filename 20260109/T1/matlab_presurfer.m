%% MP2RAGE pre-processing Start-to-finish
UNI=fullfile('/nd_disk4/qinbolin/Bolin/Data/MT_EPI/2025/Data/QBL_MT01_YANGYIKUAN_MT01_20250314/NIFTI/T1/T1_MP2RAGE_SAG_0_75_UNI_IMAGES_0008.nii');
INV2=fullfile('/nd_disk4/qinbolin/Bolin/Data/MT_EPI/2025/Data/QBL_MT01_YANGYIKUAN_MT01_20250314/NIFTI/T1/T1_MP2RAGE_SAG_0_75_INV2_0007.nii');
% ########################################################################
% STEP - 0 : (optional) MPRAGEise UNI
% ########################################################################
UNI_out = presurf_MPRAGEise(INV2,UNI); % Outputs presurf_MPRAGEise directory

% ########################################################################
% STEP - 1 : Pre-process INV2 to get STRIPMASK
% ########################################################################
presurf_INV2(INV2); % Outputs presurf_INV2 directory

% ########################################################################
% STEP - 3 : Pre-process UNI to get BRAINMASK
% ########################################################################
% Change UNI path to that of the MPRAGEised UNI if Step-0 was done
if exist('UNI_out','var')
    presurf_UNI(UNI_out); % Outputs presurf_UNI directory
else
    presurf_UNI(UNI);
end

exit

% ########################################################################
% STEP - 4 : Prepare for Freesurfer
% ########################################################################

% Load the MPRAGEised UNI image and STRIPMASK in ITK-SNAP
% Clean the mask in the regions-of-interest and save
% Multiply the MPRAGEised UNI with the manually edited STRIPMASK
% Supply to recon-all
