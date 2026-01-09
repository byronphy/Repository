%% Unzip
gunzip(fullfile(pwd,'UNI.nii.gz'));
gunzip(fullfile(pwd,'INV2.nii.gz'));

%% MP2RAGE pre-processing Start-to-finish
UNI=fullfile(pwd,'UNI.nii');
INV2=fullfile(pwd,'INV2.nii');
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
