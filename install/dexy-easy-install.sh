### @export "install-setuptools"
apt-get install -y python-setuptools
### @export "easy-install"
easy_install dexy

### @export "install-pip"
apt-get install -y python-pip
### @export "pip-install"
pip install dexy

### @export "upgrade"
pip install --upgrade dexy
easy_install --upgrade dexy

### @export "check"
dexy version
dexy help

