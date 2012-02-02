mkdir /tmp/build-dexy/
cd /tmp/build-dexy/
git clone https://github.com/ananelson/dexy
cd dexy
python setup.py sdist
cp dist/dexy-*.tar.gz ~/dev/dexy-site/external-dependencies/
rm -rf /tmp/build-dexy/
