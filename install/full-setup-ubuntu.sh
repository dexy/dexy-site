#!/bin/bash

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
apt-get install -y python-tk
apt-get install -y wkhtmltopdf xvfb
apt-get install -y lynx-cur
apt-get install -y python-cheetah
apt-get install -y python-mako
apt-get install -y python-nltk
apt-get install -y python-numpy
apt-get install -y python-scipy
apt-get install -y python-matplotlib
apt-get install -y python-imaging
apt-get install -y ttf-bitstream-vera
apt-get install -y cowsay
apt-get install -y clojure
apt-get install -y rhino

# for checking links
apt-get install -y apache2
apt-get install -y linkchecker

echo "
<VirtualHost *:80>
    DocumentRoot /mnt/work/dexy-site/output/
    <Directory /mnt/work/dexy-site/output/>
        Options Indexes FollowSymLinks MultiViews
        AllowOverride All
        Order allow,deny
        allow from all
    </Directory>
</VirtualHost>
" > /etc/apache2/sites-available/default

### @export "ruby-installs"
gem install --no-rdoc --no-ri RedCloth
gem install --no-rdoc --no-ri rspec
gem install --no-rdoc --no-ri gherkin
gem install --no-rdoc --no-ri cucumber

### @export "python-installs"
python -c "import nltk; nltk.download(\"all-corpora\")"
pip install GitPython
pip install Markdown
pip install garlicsim
pip install garlicsim_lib
pip install regetron
pip install ipython

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

### @export "shutdown"
echo "setup completed! :-)"
echo "shutting down..."
shutdown -h now
