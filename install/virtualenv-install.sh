curl -O http://pypi.python.org/packages/source/v/virtualenv/virtualenv-1.5.1.tar.gz
tar -xzvf virtualenv-1.5.1.tar.gz
python virtualenv-1.5.1/virtualenv.py --no-site-packages dexy_env # Put this directory wherever you want..

source dexy_env/bin/activate # Activate the virtual environment 

hg clone https://bitbucket.org/ananelson/dexy
cd dexy
easy_install .
cd ..

which python
which dexy
dexy --version

deactivate # exit the virtualenv
