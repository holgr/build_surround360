# Setup macOS (works on macOS 10.12.4b2 build 16E154a) render with Halide

####
# Updated: 2017-02-16 by Holger Eilhard <holger@eilhard.net>
# Used with upstream commit: ec1050766c7cfb7aaac328beeae900b9213de578 (Date: Wed Feb 15 17:31:38 2017 -0800)
####

###
# Install Xcode from Mac App Store
###

###
# Install Homebrew
###
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"


###
# Install git
###
brew install git python gflags glog wget curl wxpython wxmac
brew link wxmac


###
# Install ffmpeg (from source!)
###
brew install ffmpeg --with-fdk-aac --with-ffplay --with-freetype --with-libass --with-libquvi --with-libvorbis --with-libvpx --with-opus --with-x265


###
# Install Gooey
###
pip install --upgrade pip
sudo pip install Gooey


###
# Install opencv
###
brew install opencv3 --HEAD
brew link --force opencv3 --HEAD


###
# Install folly
###
brew install folly


###
# Install ceres-solver (make sure to build from source to work around possible versioning issues with Eigen!)
###
brew install -s ceres-solver


###
# Install pillow
###
pip install pillow


###
# Install llvm
###
cd ~/src
svn co https://llvm.org/svn/llvm-project/llvm/branches/release_37 llvm3.7
svn co https://llvm.org/svn/llvm-project/cfe/branches/release_37 llvm3.7/tools/clang
cd llvm3.7
mkdir build && cd build
cmake -DLLVM_ENABLE_TERMINFO=OFF -DLLVM_TARGETS_TO_BUILD="X86;ARM;NVPTX;AArch64;Mips;PowerPC" -DLLVM_ENABLE_ASSERTIONS=ON -DCMAKE_BUILD_TYPE=Release ..
make -j
export LLVM_CONFIG=$HOME/src/llvm3.7/build/bin/llvm-config
export LLVM_ROOT=$HOME/src/llvm3.7/build
export LLVM_DIR=$HOME/src/llvm3.7/build/
export CLANG=$HOME/src/llvm3.7/build/bin/clang


###
# Install Halide
###
cd ~/src
git clone https://github.com/halide/Halide.git
cd Halide
mkdir build && cd build
make -j -f ../Makefile


###
# Build surround360_render with Halide
###
cd ~/src
git clone https://github.com/facebook/Surround360/
cd Surround360/surround360_render
cmake -DCMAKE_BUILD_TYPE=Release -DHALIDE_DIR=$HOME/src/Halide/build
make -j

###
# Now you can start the GUI:
# python ./scripts/run_all.py
###
