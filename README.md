rudder-ncf-workshop
===================

Contains code base for Rudder & NCF workshop

It contains a Vagrant provision file, with the following system definition:
* cfengine: Creates an Ubuntu 14.04 VM, with CFEngine provisionned. It needs 1024 MB of RAM, and forwards port 8080 to 8083 on the host
* ncf: Creates an Ubuntu 14.04 VM, with CFEngine installed, as well as the latest tarball of ncf deployed. It needs 1024MB of RAM, and forwards port 8080 to 8082 on the host
* rudder: Creates a Debian 7 VM, with the Rudder server installed and configured (version 2.10.2). It requires 1536 MB of RAM, have the static IP address 192.168.30.10, and forwards port 80 to 8080, and 443 to 8081
* node: Creates a Debian 7 VM, with the Rudder agant installed and configured (version 2.10.2). It requires 1024 MB of RAM, have the static IP address 192.168.30.11n abd forwards port 8080 to 8181


