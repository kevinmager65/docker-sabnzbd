from ubuntu:16.04

ENV DEBIAN_FRONTEND="noninteractive"

# update box
RUN apt-get update
RUN apt-get install -y software-properties-common
# RUN apt-add-repository multiverse && apt-get update
RUN add-apt-repository ppa:jcfp/nobetas
RUN add-apt-repository ppa:jcfp/sab-addons
RUN apt-get update && apt-get -y dist-upgrade 
RUN apt-get install -y sabnzbdplus python-sabyenc



#RUN echo "deb http://ppa.launchpad.net/jcfp/ppa/ubuntu lucid main" | tee -a /etc/apt/sources.list \
#    && apt-key adv --keyserver hkp://pool.sks-keyservers.net:11371 --recv-keys 0x98703123E0F52B2BE16D586EF13930B14BB9F05F \
#    && apt-get update && apt-get -y dist-upgrade

#RUN apt-get -o APT::Install-Recommends=1 install -y sabnzbdplus

# install sabnzbdplus
#RUN apt-get install -y sabnzbdplus-theme-classic \
#	sabnzbdplus-theme-mobile \
#  sabnzbdplus-theme-plush \
#  par2 python-yenc unzip unrar 

# Clean up
RUN apt-get -y autoremove && \
  apt-get -y clean
RUN rm -rf /var/lib/apt/lists/*

# create sabnzbd user
RUN useradd --system --uid 1000 -M --shell /usr/sbin/nologin sabnzbd

# create directories
RUN mkdir /config
RUN chown sabnzbd /config
RUN mkdir /data
RUN chown sabnzbd /data

#run 
USER sabnzbd

CMD ["/usr/bin/sabnzbdplus","--config-file","/config","--console","--server", "0.0.0.0:8080"]
