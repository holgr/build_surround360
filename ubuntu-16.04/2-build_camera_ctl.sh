#!/bin/bash

####
# Updated: 2017-01-02 by Holger Eilhard <holger@eilhard.net>
# Used with upstream commit: 8d323f09e77b010a4cfa5e9045c89dea107b0e34 (Date: Fri Dec 30 17:24:45 2016 -0800)
####


###
# Build camera_ctl
###
cd surround360/surround360_camera_ctl
cmake -DCMAKE_BUILD_TYPE=Release
make -j

echo "Now try using this: "
echo "./bin/CameraControl -list"
echo ""
echo "Or this:"
echo "./bin/CameraControl -numcams 17 -raw -nbits 8 -shutter 20 -gain 0 -debug -cli -dir test"
