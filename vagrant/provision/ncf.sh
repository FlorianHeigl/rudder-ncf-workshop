#!/bin/bash
#####################################################################################
# Copyright 2014 Normation SAS
#####################################################################################
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, Version 3.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.
#
#####################################################################################


# Simply installs CFEngine

# Accept the CFEngine repository GPG key
curl https://s3.amazonaws.com/cfengine.package-repos/pub/gpg.key | apt-key add -

# Add the repository
echo "deb http://cfengine.com/pub/apt/packages stable main" > /etc/apt/sources.list.d/cfengine-community.list

# install cfengine community
apt-get update
apt-get install cfengine-community

mkdir -p /usr/share/ncf
cd /usr/share/ncf

wget https://github.com/Normation/ncf/archive/master.tar.gz

tar xzvf master.tar.gz --strip-components=1

rm -rf /var/cfengine/inputs/*
cp -r /usr/share/ncf/tree/* /var/cfengine/inputs

