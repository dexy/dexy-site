### @export "easy-install"
apt-get install -y python-setuptools
easy_install dexy

### @export "pip-install"
apt-get install -y python-pip
pip install dexy

### @export "check"
dexy --version
dexy --help
dexy --setup
dexy --filters

