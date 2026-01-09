clear;close all;clc

%% MP2RAGE pre-processing Start-to-finish
main_path='E:\Bolin\Project\3Dprint\WuBaoyu\NIFTI\';
UNI=[main_path,'T1_MP2RAGE_SAG_P2_0_65_UNI_IMAGES_0007.nii'];
INV2=[main_path,'T1_MP2RAGE_SAG_P2_0_65_INV2_0006.nii'];

% ########################################################################
% STEP - 0 : (optional) MPRAGEise UNI
% ########################################################################
UNI_out = presurf_MPRAGEise(INV2,UNI); % Outputs presurf_MPRAGEise directory

% ########################################################################
% STEP - 1 : Pre-process INV2 to get STRIPMASK
% ########################################################################

%presurf_INV2(INV2); % Outputs presurf_INV2 directory

% ########################################################################
% STEP - 3 : Pre-process UNI to get BRAINMASK
% ########################################################################
% Change UNI path to that of the MPRAGEised UNI if Step-0 was done
% if exist('UNI_out','var')
%     presurf_UNI(UNI_out); % Outputs presurf_UNI directory
% else
%     presurf_UNI(UNI);
% end

% ########################################################################
% STEP - 4 : Prepare for Freesurfer
% ########################################################################

% Load the MPRAGEised UNI image and STRIPMASK in ITK-SNAP
% Clean the mask in the regions-of-interest and save
% Multiply the MPRAGEised UNI with the manually edited STRIPMASK
% Supply to recon-all
