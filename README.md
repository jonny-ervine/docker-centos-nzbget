# docker-centos-nzbget
## NZBget running on the latest CentOS docker image (7.4)
### Build Version: 3
Date: 15th September 2017

The Dockerfile should intialise the CentOS image and subscribe to the EPEL repository. The pre-requisites for nzbget are then installed via yum.

The EPEL repository provides:

    supervisor

The NZBget daemon is controlled via the supervisord daemon which has a web front end exposed via port 9006. Default username and password for the web front end is admin:admin.

The NZBget software is pulled from the github 18.1 release (compiled on a build host and uploaded to this github) and installed via RPM into the docker container ready for use.

The container can be run as follows:

    docker pull jervine/docker-centos-nzbget
    docker run -d -t -n <optional name of container> -h <optional host name of container> -e USER="<user account to run as> -e USERUID="<uid of user account"> -e TZ="<optional timezone> -v /<config directory on host>:/config -v /<download directory on host>:<download directory in container> -v <other media locations on host>:<other media locations in container> -p jervine/docker-centos-nzbget

The USER and UID variables will be used to create an unprivileged account in the container to run the nzbget daemon under. The startup.sh script will create this user and also inject the username into the user= parameter of the couchpotato.ini supervisor file.

The docker container is started with the -t switch to create a pseudo-TTY, as the nzbget daemon will actually launch in 'server' mode.

The TZ variable allows the user to set the correct timezone for the container and should take the form "Europe/London". If no timezone is specified then UTC is used by default. The timezone is set up when the container is run. Subsequent stops and starts will not change the timezone.

The container can be verified on the host by using:

    docker logs <container id/container name>

Please note that the SELinux permissions of the config and downloads directories may need to be changed/corrected as necessary. [Currently chcon -Rt svirt_sandbox_file_t <directory>]
