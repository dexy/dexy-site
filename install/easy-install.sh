### @export "prelims"
apt-get update
apt-get install -y mercurial
apt-get install -y python-setuptools

### @export "clone-repo"
hg clone http://bitbucket.org/ananelson/dexy

### @export "install"
easy_install dexy

### @export "test"
dexy -h

### @export "setup"
mkdir work
cd work
dexy --setup .    # that command ends with a dot (.) in case you can't see it

### @export "run"
dexy -g http://www.dexy.it/examples/jinja/hello.dexy -d .  # ditto dot :-)

### @export "log"
tail logs/dexy.log

### @export "output"
cat cache/hello.txt-jinja.txt
