#!/bin/bash
apt-get update
apt-get install -y gnupg

gpg --keyserver keyserver.ubuntu.com --recv-key E084DAB9
gpg -a --export E084DAB9 | sudo apt-key add -

CRAN_MIRROR=http://software.rc.fas.harvard.edu/mirrors/R/
echo "deb $CRAN_MIRROR/bin/linux/ubuntu lucid/" >> /etc/apt/sources.list.d/sources.list
echo "deb http://archive.ubuntu.com/ubuntu lucid multiverse" >> /etc/apt/sources.list.d/sources.list

apt-get update

apt-get install -y gcc make
apt-get install -y python-setuptools
apt-get install -y python-pip
apt-get install -y r-base-dev # CRAN_MIRROR multiverse
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
apt-get install -y lame # multiverse
apt-get install -y php5-cli
apt-get install -y erlang
apt-get install -y tree

easy_install nose
easy_install garlicsim==0.6.0
easy_install garlicsim_lib==0.6.0

R -e 'install.packages("rjson", repos="http://cran.r-project.org")'

wget http://sourceforge.net/projects/asciidoc/files/asciidoc/8.6.4/asciidoc-8.6.4.tar.gz/download
mv download asciidoc.tgz
tar -xzvf asciidoc.tgz
cd asciidoc-8.6.4/
./configure
make
make install
cd ..

### @export "install-clojure"
wget --no-check-certificate http://github.com/downloads/clojure/clojure/clojure-1.2.0.zip
unzip clojure-1.2.0.zip
cp clojure-1.2.0/clojure.jar /

### @export "install-gems"
export PATH=$PATH:/var/lib/gems/1.8/bin
gem install --no-rdoc --no-ri RedCloth
gem install --no-rdoc --no-ri rspec
gem install --no-rdoc --no-ri gherkin
gem install --no-rdoc --no-ri cucumber

### @export "install-python-2.7"
curl -O http://python.org/ftp/python/2.7.1/Python-2.7.1.tgz
tar -xzvf Python-2.7.1.tgz
cd Python-2.7.1
./configure
make
make altinstall

shutdown -h now

