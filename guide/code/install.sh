### @export "python-version"
python --version

### @export "install-distribute"
curl -O http://python-distribute.org/distribute_setup.py
sudo python distribute_setup.py

### @export "install-pip"
curl -O https://raw.github.com/pypa/pip/master/contrib/get-pip.py
sudo python get-pip.py

### @export "install-git"
sudo apt-get install -y git-core

### @export "install-markdown"
sudo pip install --use-mirrors Markdown

### @export "install-pandoc"
sudo apt-get install -y pandoc

### @export "download-virtualenv"
curl -O https://raw.github.com/pypa/virtualenv/master/virtualenv.py

### @export "create-virtualenv"
python virtualenv.py DEXYENV

### @export "activate-virtualenv"
source DEXYENV/bin/activate

### @export "virtualenv-pip-install-dexy"
pip install dexy

### @export "check-install"
dexy version
dexy help

### @export "deactivate-virtualenv"
deactivate

### @export "reset-virtualenv"
deactivate
rm -r DEXYENV
python virtualenv.py DEXYENV
source DEXYENV/bin/activate

### @export "easy-install-previous"
easy_install dexy==0.4.4

### @export "easy-upgrade-dexy"
easy_install --upgrade dexy

### @end
deactivate
rm -r DEXYENV
python virtualenv.py DEXYENV
source DEXYENV/bin/activate

### @export "pip-install-previous"
pip install dexy==0.4.4

### @export "pip-upgrade-dexy"
pip install --upgrade dexy

### @end
deactivate
rm -r DEXYENV
python virtualenv.py DEXYENV
source DEXYENV/bin/activate

### @export "pip-install-from-git"
git clone https://github.com/ananelson/dexy
cd dexy
pip install -e .
cd ..
### @end

deactivate
rm -r DEXYENV

### @export "pip-install-dexy"
sudo pip install dexy

### @export "easy-install-dexy"
sudo easy_install dexy

### @export "check-dexy"
dexy version
dexy help
