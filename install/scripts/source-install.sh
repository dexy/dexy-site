easy_install nose &> easy-install.out
easy_install dexy[py26,common] &> easy-install.out
hg clone http://bitbucket.org/ananelson/dexy
cd dexy
python setup.py install
dexy --version
nosetests 
dexy --setup -s examples
dexy -s examples # run twice

