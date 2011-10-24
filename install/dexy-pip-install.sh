### @export "install-pip"
apt-get install -y python-pip

### @export "install"
pip install dexy

### @export "check"
dexy version
dexy help

