### @export "download-virtualenv"
curl -O http://pypi.python.org/packages/source/v/virtualenv/virtualenv-1.7.tar.gz
tar -xf virtualenv-1.7.tar.gz

### @export "python-version"
python --version

### @export "create-virtualenv"
python virtualenv-1.7/virtualenv.py dexy_env

### @export "activate-virtualenv"
source dexy_env/bin/activate

### @export "pip-install-dexy"
pip install dexy

### @export "check-dexy"
dexy version
dexy help

### @export "list-filters"
dexy filters

### @export "check-install"
echo "=================================================="
echo "test 1"
dexy version
echo "=================================================="
dexy help

### @export "deactivate-virtualenv"
deactivate

### @end
rm -r dexy_env
python virtualenv-1.7/virtualenv.py dexy_env
source dexy_env/bin/activate

### @export "easy-install-dexy"
easy_install dexy

### @export "check-easy-install"
echo "=================================================="
echo "test 2"
dexy version
echo "=================================================="
dexy help

### @end
deactivate
rm -r dexy_env
python virtualenv-1.7/virtualenv.py dexy_env
source dexy_env/bin/activate

### @export "easy-install-previous"
easy_install dexy==0.4.4

### @export "easy-upgrade-dexy"
easy_install --upgrade dexy

### @export "check"
echo "=================================================="
echo "test 3"
dexy version
echo "=================================================="
dexy help

### @end
deactivate
rm -r dexy_env
python virtualenv-1.7/virtualenv.py dexy_env
source dexy_env/bin/activate

### @export "pip-install-previous"
pip install dexy==0.4.4

### @export "pip-upgrade-dexy"
pip install --upgrade dexy

### @export "check"
echo "=================================================="
echo "test 4"
dexy version
echo "=================================================="
dexy help

