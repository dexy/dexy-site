apt-get install -y python-setuptools &> install-setuptools.out
easy_install dexy[py26,common] &> easy-install.out
dexy --version
dexy --help

