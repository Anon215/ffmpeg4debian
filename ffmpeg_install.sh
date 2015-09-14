#! /bin/bash

########################################################################
##                                                                    ##
##               this script installs ffmpeg from source              ##
##                    by anon215 XIII | VIII | MMXV                   ##
##                                                                    ##
########################################################################

### preparation, add repo
cat << EOF >> /etc/apt/sources.list

# deb-multimedia
deb http://www.deb-multimedia.org jessie main non-free
deb-src http://www.deb-multimedia.org jessie main non-free
EOF

### update and get the key : may the force be with you ^^
apt-get update
LANG=en_EN.UTF-8 apt-get --force-yes install deb-multimedia-keyring
apt-get update

### remove old version of ffmpeg, if exist
LANG=en_EN.UTF-8 apt-get -y remove ffmpeg

### install needed libraries for ffmpeg
LANG=en_EN.UTF-8 apt-get -y install build-essential libmp3lame-dev libvorbis-dev libtheora-dev libspeex-dev yasm pkg-config libfaac-dev libopenjpeg-dev libx264-dev gcc

### install ffmpeg from sources
mkdir /root/software && cd /root/software
wget http://ffmpeg.org/releases/ffmpeg-2.8.tar.bz2
cd .. && mkdir src && cd src
tar xvjf ../software/ffmpeg-2.8.tar.bz2
cd ffmpeg-2.8

### configure and build program
./configure --enable-gpl --enable-postproc --enable-swscale --enable-avfilter --enable-libmp3lame --enable-libvorbis --enable-libtheora --enable-libx264 --enable-libspeex --enable-shared --enable-pthreads --enable-libopenjpeg --enable-libfaac --enable-nonfree
make && make install

### if one try to run ffmpeg now it may throw errors because it linked wrong lib dir
echo "include /usr/local/lib" >> /etc/ld.so
ldconfig

######################### --> HAVE FUN <-- ############################
