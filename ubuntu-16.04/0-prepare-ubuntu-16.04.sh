#!/bin/bash

####
# Updated: 2017-03-06 by Holger Eilhard <holger@eilhard.net>
# Used with upstream commit: 5d21407e815588ae2b016001b859a4816851ab00 (Date: Fri Mar 3 00:35:34 2017 -0800)
####


###
# Save current dir for later packages
###
SRCDIR=`pwd`
mkdir ~/src

###
# Freshen apt cache
###
sudo apt-get update
sudo apt-get -y upgrade
sudo apt-get -y dist-upgrade


###
# Install debs
###
sudo apt-get -y install libgtkmm-3.0-1v5 \
    libgtkmm-3.0-dev \
    libglibmm-2.4-dev \
    libglibmm-2.4-1v5 \
    libgtk-3.0 \
    libgtk-3-dev \
    libglew-dev \
    libglew1.13 \
    zlib1g \
    zlib1g-dev 

#echo "Install gfx driver manually now. Press Enter when done."
#read -n1 -r -p "Press any key to continue..." key

sudo apt-get -y install \
    subversion \
    g++ \
    gcc \
    libraw1394-11 \
    libusb-1.0-0 \
    libvpx3 \
    libvpx-dev \
    libx264-148 \
    libx264-dev \
    git \
    libsdl1.2debian \
    libsdl1.2-dev \
    apache2 \
    libapache2-mod-php \
    php \
    nasm \
    gpac \
    libgflags-dev \
    libgflags2v5 \
    libgoogle-glog0v5 \
    libgoogle-glog-dev \
    libusb-1.0-0 \
    libusb-1.0-0-dev \
    python-pip \
    python-wxgtk3.0 \
    wget \
    joe \
    libgtkmm-2.4-dev \
    libglademm-2.4-dev \
    libgtkglextmm-x11-1.2-dev \
    libgtkglextmm-x11-1.2-0v5 \
    libglade2-dev \
    libgtk2.0-dev \
    libxml2-dev \
    gir1.2-gtk-2.0 \
    libxml2-utils \
    libgtkglext1 \
    libgtkglext1-dev \
    libxmu-dev  \
    libxt-dev \
    libpangox-1.0-dev \
    libpangox-1.0-0 \
    libicu-dev \
    libxmu-headers \
    icu-devtools \
    freeglut3-dev \
    libusb-1.0-0 \
    libtinfo-dev \
    automake \
    autoconf \
    autoconf-archive \
    libtool \
    libboost-all-dev \
    libevent-dev \
    libdouble-conversion-dev \
    libgoogle-glog-dev \
    libgflags-dev \
    liblz4-dev \
    liblzma-dev \
    libsnappy-dev \
    htop \
    iotop \
    iptraf \
    make \
    zlib1g-dev \
    binutils-dev \
    libjemalloc-dev \
    libssl-dev \
    libunwind8-dev \
    libelf-dev \
    libdwarf-dev \
    libiberty-dev


###
# Update Pip & install Gooey
###
echo "Updating pip. Press Enter when ready."
read -n1 -r -p "Press any key to continue..." key

sudo pip install --upgrade pip
sudo pip install Gooey


###
# Download things
###
echo "Downloading things. Press Enter when ready."
read -n1 -r -p "Press any key to continue..." key

cd ~/src
wget https://github.com/opencv/opencv/archive/3.2.0.zip -O opencv-3.2.0.zip
wget http://ffmpeg.org/releases/ffmpeg-3.2.4.tar.bz2
wget https://cmake.org/files/v3.7/cmake-3.7.1.tar.gz


###
# Extract things
###
echo "Extract those things. Press Enter when ready."
read -n1 -r -p "Press any key to continue..." key
sudo mkdir -p /usr/src
# Download this from the official site
#sudo tar -C /usr/src -xf flycapture2-2.10.3.266-amd64-pkg.tgz
sudo tar -C /usr/src -xf cmake-3.7.1.tar.gz
sudo unzip -d /usr/src opencv-3.2.0.zip
sudo tar -C /usr/src -xf ffmpeg-3.2.4.tar.bz2


###
# Install cmake
###
echo "Install cmake. Press Enter when ready."
read -n1 -r -p "Press any key to continue..." key
cd /usr/src/
sudo mkdir -p cmake-build
cd cmake-build
sudo ../cmake-3.7.1/configure
sudo make -j16
sudo make install


###
# Install ffmpeg
###
echo "Install ffmpeg. Press Enter when ready."
read -n1 -r -p "Press any key to continue..." key
cd /usr/src
sudo mkdir -p /usr/src/ffmpeg-build
cd /usr/src/ffmpeg-build
sudo ../ffmpeg-3.2.4/configure --enable-nonfree --enable-gpl --enable-libx264 --enable-shared --disable-stripping --enable-libvpx
sudo make -j16
sudo make install


###
# Install opencv
###
echo "Install opencv. Press Enter when ready."
read -n1 -r -p "Press any key to continue..." key
cd /usr/src/opencv-3.2.0
sudo cmake -DWITH_IPP=NO .
sudo make -j16
sudo make install


###
# Bootloader settings
# Note: Please refer to the official guide on what you need to update to update the bootloader 
###
echo "Updating bootloader. Press Enter when ready."
read -n1 -r -p "Press any key to continue..." key
sudo cp $SRCDIR/conf/grub /etc/default/grub
sudo update-grub


###
# TODO 
###
#echo "Configure ffserver. Press Enter when ready."
#read -n1 -r -p "Press any key to continue..." key
#sudo cp $SRCDIR/conf/ffserver-init.sh /etc/init.d
#sudo cp $SRCDIR/conf/ffserver.conf /etc/
#sudo update-rc.d ffserver-init.sh defaults
#sudo service ffserver-init.sh start


###
# Prep finished, now get the official repository
###
echo "Ready to clone git repo now."
read -n1 -r -p "Press any key to continue..." key
cd ~/src
git clone https://github.com/facebook/Surround360 surround360

###
# TODO
# Web interface (this actually seems to be gone now)
###
#echo "Configure web interface. Press Enter when ready."
#read -n1 -r -p "Press any key to continue..." key
#sudo mkdir /var/www/surround360
#sudo cp -r ~/src/surround360/surround360_camera_ctl/source/www/camera_capture /var/www/surround360


###
# Webserver
###
#echo "Configure web server. Press Enter when ready."
#read -n1 -r -p "Press any key to continue..." key
#sudo cp $SRCDIR/conf/000-camera.conf /etc/apache2/sites-available/
#sudo ln -s /etc/apache2/sites-available/000-camera.conf /etc/apache2/sites-enabled/000-camera.conf
#sudo /usr/sbin/service apache2 restart           


###
# Create snoraid directory
###
echo "Create snoraid. Press Enter when ready."
read -n1 -r -p "Press any key to continue..." key
sudo mkdir /media/snoraid


###
# Install flycapture software
# Run this once you downloaded the drivers from their website 
###
#echo "Install flycapture. Press Enter when ready."
#read -n1 -r -p "Press any key to continue..." key
#cd /usr/src/flycapture2-xxx/
#sudo /bin/bash ./install_flycapture.sh



