# This script must be run from the dexy-site directory.
export DEXY_SITE_DIR=`pwd`

TIMESTAMP=`date +%s`

# make sdist for dexy package
mkdir -p /tmp/build-dexy/$TIMESTAMP
cd /tmp/build-dexy/$TIMESTAMP
git clone https://github.com/ananelson/dexy
cd dexy
python setup.py sdist
cp dist/dexy-*.tar.gz $DEXY_SITE_DIR/external-dependencies/

# make sdist for idiopidae package
mkdir -p /tmp/build-idiopidae/$TIMESTAMP
cd /tmp/build-idiopidae/$TIMESTAMP
hg clone https://bitbucket.org/ananelson/idiopidae-fork
cd idiopidae-fork
python setup.py sdist
cp dist/idio*.tar.gz $DEXY_SITE_DIR/external-dependencies

