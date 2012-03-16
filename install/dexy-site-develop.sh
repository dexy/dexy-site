cd ..

### @export "pip-install-dexy-source"
git clone https://github.com/ananelson/dexy
cd dexy
sudo pip install -e .
cd ..

cd dexy-site

### @export "run-dexy-on-dexy-site"
dexy setup
dexy -danger -strictinherit -loglevel DEBUG
