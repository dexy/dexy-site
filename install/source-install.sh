### @export "prelims"
apt-get update
apt-get install -y mercurial
apt-get install -y python-setuptools

### @export "easy-install-deps"
easy_install dexy[py26,common,liveserver]

### @export "clone-repo"
hg clone http://bitbucket.org/ananelson/dexy

### @export "ordereddict"
easy_install ordereddict # if Python 2.6

### @export "install"
cd dexy
python setup.py develop

