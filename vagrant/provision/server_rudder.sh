#!/bin/bash

set -e

## Config stage

# Fetch parameters
KEYSERVER=keyserver.ubuntu.com
KEY=474A19E8


# Rudder related parameters
SERVER_INSTANCE_HOST="server.rudder.local"
DEMOSAMPLE="no"
LDAPRESET="yes"
INITPRORESET="yes"
ALLOWEDNETWORK[0]='192.168.30.0/24'


# Misc
# Make sure we don't run interactive commands
export DEBIAN_FRONTEND=noninteractive

APTITUDE_ARGS="--assume-yes"

# Host preparation:
# This machine is "server", with the FQDN "server.rudder.local".
# It has this IP : 192.168.30.10 (See the Vagrantfile)

sed -ri "s/^127\.0\.1\.1[\t ]+server(.*)$/127\.0\.1\.1\tserver\.rudder\.local\1/" /etc/hosts
echo -e "\n192.168.30.10        server.rudder.local server" >> /etc/hosts
echo -e "\n192.168.30.11        node.rudder.local node" >> /etc/hosts


# Install lsb-release so we can guess which Debian version are we operating on.
aptitude update && aptitude ${APTITUDE_ARGS} install lsb-release
DEBIAN_RELEASE=$(lsb_release -cs)

##Accept Java Licence
echo sun-java6-jre shared/accepted-sun-dlj-v1-1 select true | /usr/bin/debconf-set-selections

# Accept the Rudder repository key
wget --quiet -O- "http://${KEYSERVER}/pks/lookup?op=get&search=0x${KEY}" | sudo apt-key add -

#APT configuration
echo "deb http://ftp.fr.debian.org/debian/ ${DEBIAN_RELEASE} main non-free" > /etc/apt/sources.list
echo "deb-src http://ftp.fr.debian.org/debian/ ${DEBIAN_RELEASE} main non-free" >> /etc/apt/sources.list
echo "deb http://security.debian.org/ ${DEBIAN_RELEASE}/updates main" >> /etc/apt/sources.list
echo "deb-src http://security.debian.org/ ${DEBIAN_RELEASE}/updates main" >> /etc/apt/sources.list
echo "deb http://ftp.fr.debian.org/debian/ ${DEBIAN_RELEASE}-updates main" >> /etc/apt/sources.list
echo "deb-src http://ftp.fr.debian.org/debian/ ${DEBIAN_RELEASE}-updates main" >> /etc/apt/sources.list

echo "deb http://www.rudder-project.org/apt-2.10/ ${DEBIAN_RELEASE} main contrib non-free" > /etc/apt/sources.list.d/rudder.list


# Update APT cache
aptitude update

#Packages required by Rudder
aptitude ${APTITUDE_ARGS} install rudder-server-root

# Initialize Rudder
/opt/rudder/bin/rudder-init.sh $SERVER_INSTANCE_HOST $DEMOSAMPLE $LDAPRESET $INITPRORESET ${ALLOWEDNETWORK[0]} < /dev/null > /dev/null 2>&1

echo "Rudder server install: FINISHED" |tee /tmp/rudder.log
echo "You can now access the Rudder web interface on https://localhost:8080/" |tee /tmp/rudder.log

