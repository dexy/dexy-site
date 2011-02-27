curl -O http://pypi.python.org/packages/source/v/virtualenv/virtualenv-1.5.1.tar.gz
tar -xzvf virtualenv-1.5.1.tar.gz
cd virtualenv-1.5.1
python2.7 virtualenv.py --no-site-packages DEXY_ENV # Put this directory wherever you want..
cd DEXY_ENV
source bin/activate # Activate the virtual environment 

easy_install dexy[common,liveserver]
which python
which dexy
dexy --version

