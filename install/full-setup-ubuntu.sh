#!/bin/bash
exec > >(tee /var/log/user-data.log|logger -t user-data -s 2>/dev/console) 2>&1

### @export "get-release-name"
source /etc/lsb-release
echo $DISTRIB_CODENAME

### @export "update-package-manager"
apt-get update
apt-get upgrade -y --force-yes

### @export "additional-sources"
apt-get install -y gnupg

gpg --keyserver keyserver.ubuntu.com --recv-key E084DAB9
gpg -a --export E084DAB9 | sudo apt-key add -

CRAN_MIRROR=http://software.rc.fas.harvard.edu/mirrors/R/
echo "deb $CRAN_MIRROR/bin/linux/ubuntu $DISTRIB_CODENAME/" >> /etc/apt/sources.list.d/sources.list
echo "deb http://archive.ubuntu.com/ubuntu $DISTRIB_CODENAME multiverse" >> /etc/apt/sources.list.d/sources.list

apt-get update # with multiverse

### @export "sys-installs"
apt-get install -y gcc make
apt-get install -y python-setuptools
apt-get install -y python-dev
apt-get install -y python-pip
apt-get install -y mercurial
apt-get install -y clang
apt-get install -y ragel
apt-get install -y ant
apt-get install -y jruby
apt-get install -y jython
apt-get install -y asciidoc
apt-get install -y ghostscript
apt-get install -y graphviz
apt-get install -y rubygems
apt-get install -y lua50
apt-get install -y sloccount
apt-get install -y ruby1.8-dev
apt-get install -y texlive-full
apt-get install -y espeak
apt-get install -y php5-cli
apt-get install -y erlang
apt-get install -y tree
apt-get install -y lame # multiverse
apt-get install -y r-base-dev # CRAN_MIRROR multiverse
apt-get install -y git-core
apt-get install -y libimlib2-dev
apt-get install -y python-kaa-imlib2

### @export "ruby-installs"
gem install --no-rdoc --no-ri RedCloth
gem install --no-rdoc --no-ri rspec
gem install --no-rdoc --no-ri gherkin
gem install --no-rdoc --no-ri cucumber

### @export "python-installs"
pip install GitPython
pip install Markdown
pip install garlicsim
pip install garlicsim_lib

### @export "r-installs"
R -e "install.packages(\"rjson\", repos=\"$CRAN_MIRROR\")"
R -e "install.packages(\"xtable\", repos=\"$CRAN_MIRROR\")"

### @export "install-asciidoc"
wget http://sourceforge.net/projects/asciidoc/files/asciidoc/8.6.6/asciidoc-8.6.6.tar.gz/download
mv download asciidoc.tgz
tar -xzvf asciidoc.tgz
cd asciidoc-8.6.6/
./configure
make
make install
cd ..

### @export "install-clojure"
curl -O http://repo1.maven.org/maven2/org/clojure/clojure/1.3.0/clojure-1.3.0.zip
unzip clojure-1.3.0.zip
mv clojure-1.3.0/clojure-1.3.0.jar /clojure.jar

### @export "shutdown"
shutdown -h now

