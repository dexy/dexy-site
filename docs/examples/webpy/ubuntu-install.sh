#!/bin/bash

### @export "update-package-manager"
apt-get update
apt-get upgrade -y --force-yes

### @export "install"
apt-get install -y python-webpy
apt-get install -y mercurial
apt-get install -y sqlite3

### @export "get-code"
hg clone https://bitbucket.org/ananelson/dexy-examples
cd dexy-examples
cd webpy

### @export "init-db"
sqlite3 todo.sqlite3 < schema.sql

### @export "start-server"
python todo.py

