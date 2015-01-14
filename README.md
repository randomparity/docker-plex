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

`docker run -d --restart always -h plex --name plex -v /etc/docker/plex-test:/config -v /mnt/media:/media -v /etc/localtime:/etc/localtime:ro -p 32400:32400 randomparity/docker-plex`

Then open `http://<docker host IP>:32400/web/` in a browser.
