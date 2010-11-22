#!/bin/bash -ex

# This script is part of the Dexy project http://dexy.it
# (c) Ana Nelson 2010 licensed under the MIT license

# This is an install script for Dexy 
# This is designed to be installed on top of this image:
# http://www.turnkeylinux.org/blog/core-lucid-beta


### @export "update"
apt-get update

### @export "vcs"
apt-get install -y mercurial

### @export "setuptools"
apt-get install -y python-setuptools

### @export "dexy-min"
hg clone http://bitbucket.org/ananelson/dexy
cd dexy
easy_install .

