easy_install nose &> easy-install.out
easy_install dexy[py26,common,liveserver] &> easy-install.out
hg clone http://bitbucket.org/ananelson/dexy
cd dexy
python setup.py install
dexy --version
dexy --setup -s examples
dexy -s examples # run twice
nosetests # must be after --setup

