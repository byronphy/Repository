#!/bin/bash

echo "Converting .pial to .pial.stl"


recon_path=""
name=""
surf_path="${recon_path}/surf"
lh_path="${recon_path}/${name}_lh.pial.stl"
rh_path="${recon_path}/${name}_rh.pial.stl"

cd ${surf_path}
mris_convert lh.pial ${lh_path}
mris_convert rh.pial ${rh_path}

echo "Done."


