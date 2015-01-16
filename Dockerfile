FROM randomparity/docker-supervisor:latest

MAINTAINER David Christensen <randomparity@gmail.com>

ENV LAST_UPDATE_PLEX 2015-01-16

# Install prerequisites
RUN apt-get -qy install avahi-daemon avahi-utils 

# Fetch the Plex package
ADD https://downloads.plex.tv/plex-media-server/0.9.11.7.803-87d0708/plexmediaserver_0.9.11.7.803-87d0708_amd64.deb \
    /tmp/plex.deb

# Install Plex and clean-up any unneeded files
RUN dpkg -i /tmp/plex.deb && \
    rm -f /tmp/plex.deb && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /var/tmp/* && \
    rm -rf /tmp/*

VOLUME ["/config", "/media"]

EXPOSE 32400

# Copy the supervisord configuration files into the container
COPY plex.conf /etc/supervisor/conf.d/plex.conf
RUN echo "user=$BASE_USER" >> /etc/supervisor/conf.d/plex.conf

# No need to setup a CMD directive since that was handled by FROM image.
