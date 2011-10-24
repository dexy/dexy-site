### @export "install-setuptools"
apt-get install -y python-setuptools

### @export "easy-install-previous"
easy_install dexy==0.4.4

### @export "upgrade"
easy_install --upgrade dexy

### @export "check"
dexy version
dexy help

