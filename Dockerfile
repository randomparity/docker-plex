FROM randomparity/docker-supervisor:latest
MAINTAINER David Christensen <randomparity@gmail.com>

ENV PLEX_LAST_UPDATE 2015-07-23

# Install prerequisites
RUN DEBIAN_FRONTEND=noninteractive apt-get -q update && \
    DEBIAN_FRONTEND=noninteractive apt-get -qy upgrade && \
    DEBIAN_FRONTEND=noninteractive apt-get -qy install \
    avahi-daemon avahi-utils 

# Fetch the Plex package
ADD https://downloads.plex.tv/plex-media-server/0.9.12.6.1347-54c2e56/plexmediaserver_0.9.12.6.1347-54c2e56_amd64.deb \
    /tmp/plex.deb

# Install Plex and clean-up any unneeded files
RUN DEBIAN_FRONTEND=noninteractive dpkg -i /tmp/plex.deb && \
    rm -f /tmp/plex.deb && \
    DEBIAN_FRONTEND=noninteractive apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /var/tmp/* && \
    rm -rf /tmp/*

VOLUME ["/config", "/media"]

EXPOSE 32400

# Copy the supervisord configuration files into the container
COPY plex.conf /etc/supervisor/conf.d/plex.conf
RUN echo "user=$BASE_USER" >> /etc/supervisor/conf.d/plex.conf

# No need to setup a CMD directive since that was handled by FROM image.
