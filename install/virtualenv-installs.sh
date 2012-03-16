### @export "download-virtualenv"
curl -O http://pypi.python.org/packages/source/v/virtualenv/virtualenv-1.7.tar.gz
tar -xf virtualenv-1.7.tar.gz

### @export "install-git"
sudo apt-get install -y git-core

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
dexy help
echo "=================================================="

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
dexy help
echo "=================================================="

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
dexy help
echo "=================================================="

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
dexy help
echo "=================================================="

### @end
deactivate
rm -r dexy_env
python virtualenv-1.7/virtualenv.py dexy_env
source dexy_env/bin/activate

### @export "pip-install-from-git"
pip install git+https://github.com/ananelson/dexy

### @export "check"
echo "=================================================="
echo "test 5"
dexy version
dexy help
echo "=================================================="

### @end
deactivate
rm -rf dexy_env
python virtualenv-1.7/virtualenv.py dexy_env
source dexy_env/bin/activate

### @export "pip-install-from-git-editable"
pip install -e git://github.com/ananelson/dexy#egg=dexy

### @export "check"
echo "=================================================="
echo "test 6"
dexy version
dexy help
echo "=================================================="

### @end
deactivate
rm -rf dexy_env
python virtualenv-1.7/virtualenv.py dexy_env
source dexy_env/bin/activate

### @export "pip-install-from-git-local-editable"
git clone https://github.com/ananelson/dexy
cd dexy
pip install -e .
cd ..

### @export "check"
echo "=================================================="
echo "test 7"
dexy version
dexy help
echo "=================================================="

deactivate
rm -rf dexy_env
