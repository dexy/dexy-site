#!/bin/bash -v

### @export "capture-logs"
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

CRAN_MIRROR=http://cran.cnr.berkeley.edu/ # previous mirror was missing several files
echo "deb $CRAN_MIRROR/bin/linux/ubuntu $DISTRIB_CODENAME/" >> /etc/apt/sources.list.d/sources.list
echo "deb http://archive.ubuntu.com/ubuntu $DISTRIB_CODENAME multiverse" >> /etc/apt/sources.list.d/sources.list

apt-get update # with multiverse

### @export "sys-installs"
apt-get install -y build-essential
apt-get install -y python-dev
apt-get install -y python-setuptools
apt-get install -y python-pip
apt-get install -y mercurial
apt-get install -y clang
apt-get install -y ragel
apt-get install -y ant
apt-get install -y jruby
apt-get install -y jython
apt-get install -y ghostscript
apt-get install -y graphviz
apt-get install -y rubygems
apt-get install -y lua50
apt-get install -y sloccount
apt-get install -y ruby1.8-dev
apt-get install -y espeak
apt-get install -y php5-cli
apt-get install -y erlang
apt-get install -y tree
apt-get install -y lame # multiverse
apt-get install -y r-base-dev # CRAN_MIRROR multiverse
apt-get install -y git-core
apt-get install -y libimlib2-dev
apt-get install -y python-kaa-imlib2
apt-get install -y python-tk
apt-get install -y wkhtmltopdf
apt-get install -y lynx-cur
apt-get install -y python-cheetah
apt-get install -y python-mako
apt-get install -y python-nltk
apt-get install -y python-numpy
apt-get install -y python-scipy
apt-get install -y python-matplotlib
apt-get install -y python-imaging
apt-get install -y ttf-bitstream-vera
apt-get install -y ttf-freefont
apt-get install -y cowsay
apt-get install -y clojure
apt-get install -y rhino
apt-get install -y ksh
apt-get install -y imagemagick
apt-get install -y libv8-dev # don't think we need dev but libv8 isn't resolving

### @export "preprint"
apt-get install -y poppler-utils

### @export "virtual-display"
apt-get install -y xvfb

### @export "check-links"
apt-get install -y apache2
apt-get install -y linkchecker

### @export "ruby-installs"
gem install --no-rdoc --no-ri RedCloth
gem install --no-rdoc --no-ri rspec
gem install --no-rdoc --no-ri gherkin
gem install --no-rdoc --no-ri cucumber
gem install --no-rdoc --no-ri jazor
gem install --no-rdoc --no-ri chef

### @export "python-installs"
python -c "import nltk; nltk.download(\"all-corpora\")"
pip install GitPython
pip install Markdown
pip install garlicsim
pip install garlicsim_lib
pip install regetron
pip install ipython
pip install BeautifulSoup
pip install cssutils
pip install pynliner
pip install ansi2html

### @export "webpy-installs"
apt-get install -y python-webpy
apt-get install -y sqlite3
apt-get install -y firefox
pip install selenium

### @export "seewave-installs"
apt-get install -y pkg-config
apt-get install -y libglu1-mesa-dev
apt-get install -y libfftw3-dev
R -e "install.packages(\"seewave\", repos=\"$CRAN_MIRROR\")"

### @export "tropo-installs"
git clone https://github.com/tropo/tropo-webapi-python.git
cd tropo-webapi-python
pip install .
cd ..

### @export "r-installs"
R -e "install.packages(\"rjson\", repos=\"$CRAN_MIRROR\")"
R -e "install.packages(\"xtable\", repos=\"$CRAN_MIRROR\")"

### @export "install-asciidoc"
wget http://sourceforge.net/projects/asciidoc/files/asciidoc/8.6.6/asciidoc-8.6.6.tar.gz/download
mv download asciidoc.tgz
tar -xzf asciidoc.tgz
cd asciidoc-8.6.6/
./configure
make
make install
cd ..

### @export "install-pandoc"
apt-get install -y pandoc

### @export "install-phantomjs"
apt-get install -y libqt4-dev
apt-get install -y libqtwebkit-dev
apt-get install -y qt4-qmake
git clone git://github.com/ariya/phantomjs.git
cd phantomjs
git checkout 1.4.1
qmake-qt4 && make
cp bin/phantomjs /usr/local/bin/
cd ..

### @export "install-texlive-2011"
wget http://mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz
tar -xzf install-tl-unx.tar.gz
cd install-tl-*
touch texlive.profile # blank texlive.profile forces non-interactive mode
./install-tl -profile texlive.profile
cd ..

### @export "install-node"
wget http://nodejs.org/dist/v0.6.12/node-v0.6.12.tar.gz
tar -xzf node-v0.6.12.tar.gz
cd node-v0.6.12/
./configure
make && make install
cd ..

### @export "install-pjsip"
wget http://www.pjsip.org/release/1.12/pjproject-1.12.tar.bz2
tar -xjf pjproject-1.12.tar.bz2
cd pjproject-1.12/
./configure
make && make install
cp pjsip-apps/bin/pjsua* /usr/local/bin/pjsua
cd ..

### @export "install-latest-pygments"
hg clone https://bitbucket.org/birkenfeld/pygments-main
cd pygments-main
pip install -e .
cd ..

### @export "setup-swapfile"
# Dexy website site has a lot of files, swapfile avoids 'cannot allocate
# memory' errors during build
dd if=/dev/zero of=/swapfile1 bs=1024 count=524288
mkswap /swapfile1
chown root:root /swapfile1
chmod 0600 /swapfile1

### @export "add-paths"
echo "PATH=$PATH:/var/lib/gems/1.8/bin:/usr/games:/usr/local/texlive/2011/bin/x86_64-linux" >> /etc/environment
echo "HOME=/home/ubuntu # for erlang" >> /home/ubuntu/.pam_environment

### @export "shutdown"
echo "setup completed! :-)"
echo "shutting down..."
shutdown -h now
