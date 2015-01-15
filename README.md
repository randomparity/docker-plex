docker-plex
===========

Plex Server running in a container. The default paths have been altered to:

 * `/config`
 * `/media`

`Plex` runs with the HTTP RPC interface listening on TCP port `32400`.

Assumptions
-----------

I use a NAS with a "media" share with the following structure:

  - Media
  - Media\Music
  - Media\Movies
  - Media\Television
  - Media\Photos

The `media` directory is mounted at `/mnt/media`, the `config` directory is located at `/etc/docker/plex`.

Quick-start
-----------

There are two options for running Plex, the first is slightly insecure but simpler and what I use.  This first option uses `--net=host` which bypasses normal Docker network security and allows the container to attached directly to the host network.

`docker run -d --restart always --net=host --name plex -v /etc/docker/plex-test:/config -v /mnt/media:/media -v /etc/localtime:/etc/localtime:ro -p 32400:32400 randomparity/docker-plex`

The second and more secure option is as follows:

`docker run -d --restart always -h plex --name plex -v /etc/docker/plex-test:/config -v /mnt/media:/media -v /etc/localtime:/etc/localtime:ro -p 32400:32400 randomparity/docker-plex`

For this second option an additional configuration step is required.  

`TBD`

Then open `http://<docker host IP>:32400/web/` in a browser.
