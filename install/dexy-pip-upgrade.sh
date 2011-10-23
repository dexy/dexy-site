### @export "install-pip"
apt-get install -y python-pip

### @export "pip-install-previous"
pip install dexy==0.4.4

### @export "upgrade"
pip install --upgrade dexy

### @export "check"
dexy version
dexy help

