FROM fedora:21
MAINTAINER "Jeremy Christian <jchristi@redhat.com>"

USER root

# Bring in all the dependencies
RUN yum -y update \
  && yum -y install \
    sudo \
    wget \
    bzip2 \
    net-tools \
    dbus-glib \
    gtk2 \
    java-1.8.0-openjdk-headless \
    alsa-plugins-pulseaudio \
    libcurl \
    unzip \
    xdg-utils \
    redhat-lsb \
    GConf2 \
    libXScrnSaver \
    xorg-x11-server-Xvfb \
    xorg-x11-fonts-ISO8859-1-75dpi \
    xorg-x11-fonts-ISO8859-1-100dpi \
    dejavu* \
    libexif \
    libvpx \
    mozilla-filesystem \
    nspr.i686 \
    nss.i686 \
    sqlite.i686 \
    initscripts \
  && yum clean all \
  && sed -i 's#/dev/random#/dev/urandom#' /etc/alternatives/jre/lib/security/java.security

# Selenium
RUN mkdir -p /opt/selenium \
  && wget --no-verbose \
    http://selenium-release.storage.googleapis.com/2.44/selenium-server-standalone-2.44.0.jar \
    -O /opt/selenium/selenium-server-standalone.jar

# Add normal user with passwordless sudo
RUN sudo useradd seluser --shell /bin/bash --create-home \
  && sudo usermod -a -G wheel seluser \
  && echo 'ALL ALL = (ALL) NOPASSWD: ALL' >> /etc/sudoers \
  && echo 'seluser:secret' | chpasswd

# Firefox
ENV FF_VER 31.6.0esr
RUN wget --no-verbose https://download-installer.cdn.mozilla.net/pub/firefox/releases/${FF_VER}/linux-x86_64/en-US/firefox-${FF_VER}.tar.bz2 -O /tmp/firefox.tar.bz2 \
  && tar -C /opt/ -xjf /tmp/firefox.tar.bz2 \
  && rm -f /tmp/firefox.tar.bz2

# Default start script
ADD ./entry_point.sh /opt/bin/entry_point.sh
RUN chmod +x /opt/bin/entry_point.sh

USER seluser

EXPOSE 4444

CMD ["/opt/bin/entry_point.sh"]
