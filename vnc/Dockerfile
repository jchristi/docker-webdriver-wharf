# sections ordered from least likely to change to most
FROM fedora:21
MAINTAINER "Jeremy Christian <jchristi@redhat.com>"

# Obligatory
RUN yum -y update

# Default start script
ADD ./scripts/xstartup.sh /xstartup.sh
RUN chmod 775 /xstartup.sh

# Bring in all the dependencies
ADD ./scripts/install_deps /install_deps
RUN chmod +x /install_deps && /install_deps

# chrome
ADD https://dl.google.com/linux/direct/google-chrome-stable_current_x86_64.rpm /root/google-chrome-stable_current_x86_64.rpm
ADD http://chromedriver.storage.googleapis.com/2.14/chromedriver_linux64.zip /root/chrome-driver/chromedriver_linux64.zip
ADD ./scripts/install_chrome /install_chrome
RUN chmod +x /install_chrome && /install_chrome

# firefox
ADD https://download-installer.cdn.mozilla.net/pub/firefox/releases/31.6.0esr/linux-x86_64/en-US/firefox-31.6.0esr.tar.bz2 /root/firefox.tar.bz2
ADD ./scripts/install_firefox /install_firefox
RUN chmod +x /install_firefox && /install_firefox

# phantomJS
ADD https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-2.0.0-source.zip /root/phantomjs-source.zip
ADD ./scripts/install_phantomjs /install_phantomjs
RUN chmod +x /install_phantomjs && /install_phantomjs

# selenium
ADD http://selenium-release.storage.googleapis.com/2.44/selenium-server-standalone-2.44.0.jar /root/selenium-server/selenium-server-standalone.jar

EXPOSE 22
EXPOSE 4444
EXPOSE 5999
CMD ["/bin/bash", "/xstartup.sh"]
