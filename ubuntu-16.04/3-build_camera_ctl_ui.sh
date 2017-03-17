#!/bin/bash

####
# Updated: 2017-01-02 by Holger Eilhard <holger@eilhard.net>
# Used with upstream commit: 8d323f09e77b010a4cfa5e9045c89dea107b0e34 (Date: Fri Dec 30 17:24:45 2016 -0800)
####


cd ~/src
###
# Save current dir for later packages
###
SRCDIR=`pwd`


###
# Install dependencies
###
echo "Ready to install debs."
read -n1 -r -p "Press any key to continue..." key
sudo apt-get install libgtkmm-3.0-1v5 libgtkmm-3.0-dev \
                     libglibmm-2.4-dev libglibmm-2.4-1v5 \
                     libgtk-3.0 libgtk-3-dev \
                     libglew-dev libglew1.13 \
                     zlib1g zlib1g-dev \
                     libglademm-2.4-1v5 libglademm-2.4-dev \
                     libgtkmm-2.4-1v5 libgtkmm-2.4-dev \
                     libgtkglextmm-x11-1.2-dev \
                     libtinfo-dev \
                     freeglut3 freeglut3-dev


###
# Install gfx drivers
###
echo "Install NVIDIA drivers now. Go to Software & Updates -> Additional drivers and follow the steps."
read -n1 -r -p "Press any key to continue..." key


###
# Build camera_ctl_ui
###
echo "Ready to install camera_control_ui (with Halide)"
read -n1 -r -p "Press any key to continue..." key
cd ~/src/surround360/surround360_camera_ctl_ui
cmake -DCMAKE_BUILD_TYPE=Release -DHALIDE_DIR=$HOME/src/Halide/cmake_build
make -j


echo "Now try using this: "
echo "./bin/CameraControlUI"
