### @export "start-swapfile"
sudo swapon /swapfile1

### @export "temp"
# stuff in here is also in create-custom-ami and will be removed from here when
# a new custom image is built that has these installs already

echo "PATH=$PATH:/var/lib/gems/1.8/bin:/usr/games:/usr/local/texlive/2011/bin/x86_64-linux" | sudo tee -a /etc/environment
echo "HOME=/home/ubuntu # for erlang" >> /home/ubuntu/.pam_environment

sudo apt-get install -y build-essential
sudo apt-get install -y ttf-freefont
sudo apt-get install -y libv8

sudo pip install BeautifulSoup
sudo pip install cssutils
sudo pip install pynliner
sudo pip install ansi2html

wget http://nodejs.org/dist/v0.6.12/node-v0.6.12.tar.gz
tar -xzvf node-v0.6.12.tar.gz
cd node-v0.6.12/
./configure
make
sudo make install
cd ..

wget http://www.pjsip.org/release/1.12/pjproject-1.12.tar.bz2
tar -xjvf pjproject-1.12.tar.bz2
cd pjproject-1.12/
./configure
make
sudo make install
cd ..

### @export "virtual-display"
Xvfb :75 -ac &
export DISPLAY=:75

### @export "restart-apache"
echo "
<VirtualHost *:80>
    DocumentRoot /mnt/build-dexy-site/dexy-site/output/
    <Directory /mnt/build-dexy-site/dexy-site/output/>
        Options Indexes FollowSymLinks MultiViews
        AllowOverride All
        Order allow,deny
        allow from all
    </Directory>
</VirtualHost>
" > apache-config.txt
sudo mv apache-config.txt /etc/apache2/sites-available/default
sudo apachectl restart

### @export "config-sciposter'size"
SCI_W="11.125in"
SCI_H="15in"
echo "
\\renewcommand{\\papertype}{custom}
\\renewcommand{\\fontpointsize}{14pt}
\\setlength{\\paperwidth}{$SCI_W}
\\setlength{\\paperheight}{$SCI_H}
\\renewcommand{\\setpspagesize}{
  \\ifthenelse{\\equal{\\orientation}{portrait}}{
    \\special{papersize=$SCI_W,$SCI_H}
    }{\\special{papersize=$SCI_H,$SCI_W}
    }
  }
" > papercustom.cfg
sudo mv papercustom.cfg /usr/local/texlive/2011/texmf-dist/tex/latex/sciposter/papercustom.cfg

### @export "selenium-url"
export SELENIUM_URL="http://selenium.googlecode.com/files/selenium-server-standalone-2.17.0.jar"

### @export "start-selenium"
mkdir selenium
cd selenium
wget $SELENIUM_URL
java -jar selenium-server-standalone-2.17.0.jar &
cd ..

### @export "install-latest-pygments"
hg clone https://bitbucket.org/birkenfeld/pygments-main
cd pygments-main
sudo pip install .
cd ..

### @export "pip-install-dexy-source"
sudo pip install git+git://github.com/ananelson/dexy

### @export "download-dexy-site"
git clone https://github.com/ananelson/dexy-site
cd dexy-site

### @export "make-sdists"
bash make-sdists.sh

cd docs/examples/webpy
### @export "start-webpy"
sqlite3 todo.sqlite3 < schema.sql
python todo.py 8080 &
### @end
cd ../../..

cd docs/examples/newspaper/pitchlift-2/
### @export "start-webpy-tropo-pitchlift"
sqlite3 pitch.sqlite3 < schema.sql
python pitchlift2.py 8081 &
### @export "start-webpy-tropo-hello"
python hello.py 8082 &
### @end
cd ../../../../


### @export "run-dexy-on-dexy-site"
dexy setup
dexy -danger -strictinherit -loglevel DEBUG

### @export "add-logs"
cp -r logs output/logs

### @export "add-artifacts"
cp -r artifacts output/artifacts

### @export "check-links"
linkchecker --file-output html -q --no-warnings --no-follow-url=logs --no-follow-url=artifacts http://0.0.0.0
mv linkchecker-out.html output/

tar -czvf dexy-site.tgz -C output .
