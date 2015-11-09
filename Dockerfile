# sections ordered from least likely to change to most
FROM fedora:21
MAINTAINER "Jeremy Christian <jchristi@redhat.com>"
# Bring in all the dependencies; we could probably do this with deplist and bash
# shenanigans, but the manual method does the job well enough
RUN yum -y update
RUN yum -y install http://linuxdownload.adobe.com/linux/x86_64/adobe-release-x86_64-1.0-1.noarch.rpm; rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-adobe-linux
RUN yum -y install x11vnc wget fluxbox bzip2 xterm nano xorg-x11-server-Xvfb net-tools dbus-glib gtk2 java-1.8.0-openjdk flash-plugin nspluginwrapper alsa-plugins-pulseaudio libcurl unzip xdg-utils redhat-lsb GConf2 libXScrnSaver xorg-x11-fonts-ISO8859-1-75dpi xorg-x11-fonts-ISO8859-1-100dpi dejavu* openssh-server nginx supervisor python-gunicorn python-flask libexif; yum clean all
RUN mkdir -p /.mozilla/plugins
RUN ln -s /usr/lib64/flash-plugin/libflashplayer.so /.mozilla/plugins/libflashplayer.so
RUN sed -i 's#/dev/random#/dev/urandom#' /etc/alternatives/jre/lib/security/java.security
# chrome
ADD https://dl.google.com/linux/direct/google-chrome-stable_current_x86_64.rpm /root/google-chrome-stable_current_x86_64.rpm
RUN yum install -y /root/google-chrome-stable_current_x86_64.rpm; rm -f /root/google-chrome-stable_current_x86_64.rpm
# chromedriver
ADD http://chromedriver.storage.googleapis.com/2.14/chromedriver_linux64.zip /root/chrome-driver/chromedriver_linux64.zip
RUN mkdir -p /root/chrome-driver; unzip -d /root/chrome-driver/ /root/chrome-driver/chromedriver_linux64.zip; rm -f /root/chrome-driver/chromedriver_linux64.zip
# xstartup
ADD ./xstartup.sh /xstartup.sh
RUN chmod 775 /xstartup.sh
# selenium
ADD http://selenium-release.storage.googleapis.com/2.44/selenium-server-standalone-2.44.0.jar /root/selenium-server/selenium-server-standalone.jar
# firefox
ADD https://download-installer.cdn.mozilla.net/pub/firefox/releases/latest-esr/linux-x86_64/en-US/firefox-31.5.0esr.tar.bz2 /root/firefox.tar.bz2
RUN tar -C /root/ -xjvf /root/firefox.tar.bz2; rm -f /root/firefox.tar.bz2
# phantomJS
ADD https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-2.0.0-source.zip /root/phantomjs-source.zip
RUN yum -y install gcc gcc-c++ make flex bison gperf ruby openssl-devel freetype-devel fontconfig-devel libicu-devel sqlite-devel libpng-devel libjpeg-devel && mkdir -p /root/phantomjs && unzip -d /root/phantomjs/ /root/phantomjs-source.zip && rm -f /root/phantomjs-source.zip && cd /root/phantomjs && ./build.sh && chmod +x bin/phantomjs && mv bin/phantomjs /usr/local/bin/ ; rm -rf /root/phantomjs ; yum -y remove gcc gcc-c++ make flex bison gperf ruby openssl-devel freetype-devel fontconfig-devel libicu-devel sqlite-devel libpng-devel libjpeg-devel
# runtime
EXPOSE 22
EXPOSE 4444
EXPOSE 5999
CMD ["/bin/bash", "/xstartup.sh"]
