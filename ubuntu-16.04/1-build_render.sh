#!/bin/bash

####
# Updated: 2017-03-06 by Holger Eilhard <holger@eilhard.net>
# Used with upstream commit: 5d21407e815588ae2b016001b859a4816851ab00 (Date: Fri Mar 3 00:35:34 2017 -0800)
####


cd ~/src
###
# Save current dir for later packages
###
SRCDIR=`pwd`


###
# Install llvm
###
echo "Ready to install llvm."
read -n1 -r -p "Press any key to continue..." key
svn co https://llvm.org/svn/llvm-project/llvm/branches/release_37 llvm3.7
svn co https://llvm.org/svn/llvm-project/cfe/branches/release_37 llvm3.7/tools/clang
cd llvm3.7
mkdir build
cd build
cmake -DLLVM_ENABLE_TERMINFO=OFF -DLLVM_TARGETS_TO_BUILD="X86;ARM;NVPTX;AArch64;Mips;PowerPC" -DLLVM_ENABLE_ASSERTIONS=ON -DCMAKE_BUILD_TYPE=Release ..
make -j16
export LLVM_CONFIG=$HOME/src/llvm3.7/build/bin/llvm-config
export CLANG=$HOME/src/llvm3.7/build/bin/clang
export LLVM_ROOT=$HOME/src/llvm3.7/build/
export LLVM_DIR=$HOME/src/llvm3.7/build/


###
# clone and build folly
###
echo "Ready to install folly."
read -n1 -r -p "Press any key to continue..." key
cd ~/src
git clone https://github.com/facebook/folly
cd ~/src/folly/folly
autoreconf -ivf
./configure
make -j16
#make check
sudo make install


###
# Install Colmap Part 1
###
echo "Ready to install Colmap (pt 1)."
read -n1 -r -p "Press any key to continue..." key
sudo apt-get install -y \
    cmake \
    build-essential \
    libboost-all-dev \
    libeigen3-dev \
    libfreeimage-dev \
    libgoogle-glog-dev \
    libgflags-dev \
    libglew-dev \
    freeglut3-dev \
    qt5-default \
    libxmu-dev \
    libxi-dev \
    python-pil \
    libtinfo-dev \
    libjpeg-dev
    


###
# Install ceres
###
echo "Ready to install ceres."
read -n1 -r -p "Press any key to continue..." key
sudo apt-get install -y libatlas-base-dev libeigen3-dev 
cd ~/src
git clone https://ceres-solver.googlesource.com/ceres-solver
cd ceres-solver
mkdir ceres-bin
cd ceres-bin
cmake ..
make -j16
sudo make install
sudo ln -s /usr/include/eigen3/Eigen /usr/local/include/Eigen


###
# Install Colmap Part 2
###
echo "Ready to install Colmap (pt 2)."
read -n1 -r -p "Press any key to continue..." key
cd ~/src
git clone https://github.com/colmap/colmap
cd colmap
mkdir build
cd build
cmake ..
make -j16
sudo make install


###
# Install Halide
###
echo "Ready to install Halide."
read -n1 -r -p "Press any key to continue..." key
cd ~/src/
git clone https://github.com/halide/Halide.git
cd Halide
mkdir cmake_build
cd cmake_build
cmake -DLLVM_BIN=${LLVM_ROOT}/bin -DLLVM_INCLUDE="${LLVM_ROOT}/../include;${LLVM_ROOT}/include" -DLLVM_LIB=${LLVM_ROOT}/lib -DLLVM_VERSION=37 ..
make -j16


###
# Build render
###
echo "Ready to build Facebook's renderer (with Halide)."
read -n1 -r -p "Press any key to continue..." key
cd ~/src/surround360/surround360_render
cmake -DCMAKE_BUILD_TYPE=Release -DHALIDE_DIR=$HOME/src/Halide/cmake_build
make -j16

echo "Now try using this: "
echo "./bin/TestRenderStereoPanorama --help"
echo ""
echo "Or use the GUI:"
echo "python scripts/run_all.py"
