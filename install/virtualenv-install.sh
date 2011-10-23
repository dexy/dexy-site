### @export "download-virtualenv"
curl -O http://pypi.python.org/packages/source/v/virtualenv/virtualenv-1.6.4.tar.gz
tar -xf virtualenv-1.6.4.tar.gz

### @export "create-virtualenv"
python virtualenv-1.6.4/virtualenv.py --no-site-packages dexy_env

### @export "activate-virtualenv"
source dexy_env/bin/activate

### @export "install-dexy"
pip install dexy

### @export "check-install"
dexy version
dexy help

### @export "source-install-dexy"
git clone https://github.com/ananelson/dexy
cd dexy
pip install .
nosetests
cd ..

### @export "show-versions-virtualenv"
which python
python --version
which pip
which dexy
dexy version

### @export "deactivate-virtualenv"
deactivate

### @export "show-versions"
which python
python --version
which dexy
