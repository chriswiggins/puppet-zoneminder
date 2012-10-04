#!/bin/bash

export LD_LIBRARY_PATH="/usr/local/lib:/opt/libjpeg-turbo/lib:$LD_LIBRARY_PATH"
#export LDFLAGS=" -L/home/nextime/zm/libjpeg-turbo-1.2.1/.libs "


DEB_HOST_GNU_TYPE=$(dpkg-architecture -qDEB_HOST_GNU_TYPE)
DEB_BUILD_GNU_TYPE=$(dpkg-architecture -qDEB_BUILD_GNU_TYPE)

CXXFLAGS=" -DZM_FFMPEG_CVS -DHAVE_LIBCRYPTO  -msse2 -I/usr/local/include"

CXXFLAGS="$CXXFLAGS" ./configure --with-libarch=lib/$DEB_HOST_GNU_TYPE --disable-debug --host=$DEB_HOST_GNU_TYPE --build=$DEB_BUILD_GNU_TYPE --prefix=/opt --with-mysql=/usr  --with-webdir=/var/www/zm --with-ffmpeg=/usr --with-cgidir=/usr/lib/cgi-bin --with-webuser=www-data --with-webgroup=www-data --enable-crashtrace=no --enable-mmap=yes ZM_SSL_LIB=openssl

aclocal

