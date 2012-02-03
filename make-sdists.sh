# This script must be run from the dexy-site directory.
export DEXY_SITE_DIR=`pwd`

# make sdist for dexy package
mkdir /tmp/build-dexy/
cd /tmp/build-dexy/
git clone https://github.com/ananelson/dexy
cd dexy
python setup.py sdist
cp dist/dexy-*.tar.gz $DEXY_SITE_DIR/external-dependencies/
rm -rf /tmp/build-dexy/

# make sdist for idiopidae package
mkdir /tmp/build-idiopidae/
cd /tmp/build-idiopidae
hg clone https://bitbucket.org/ananelson/idiopidae-fork
cd idiopidae-fork
python setup.py sdist
cp dist/idio*.tar.gz $DEXY_SITE_DIR/external-dependencies
rm -rf /tmp/build-idiopidae/

