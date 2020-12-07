FROM fithwum/debian-base:stretch
MAINTAINER fithwum

# URL's for files
ARG INSTALL_SCRIPT=https://raw.githubusercontent.com/fithwum/teamspeak3/master/files/Install_Script.sh

# Install dependencies and folder creation
RUN apt-get -y update && apt-get clean \
	&& rm -rf /var/lib/apt/lists/* \
	&& mkdir -p /ts3server /ts3temp /ts3temp/inifiles /ts3temp/serverfiles \
	&& chmod 777 -R /ts3server /ts3temp \
	&& chown 99:100 -R /ts3server /ts3temp
ADD "${INSTALL_SCRIPT}" /ts3temp
RUN chmod +x /ts3temp/Install_Script.sh

# directory where data is stored
VOLUME /ts3server

# 9987 default voice, 10011 server query, 30033 file transport
EXPOSE 9987/udp 10011/tcp 30033/tcp

# Run command
CMD [ "/bin/sh", "/ts3temp/Install_Script.sh" ]
