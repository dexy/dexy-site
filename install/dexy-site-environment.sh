### @export "start-swapfile"
sudo swapon /swapfile1

### @export "virtual-display"
Xvfb :75 -ac &
export DISPLAY=:75

### @export "restart-apache"
echo "
<VirtualHost *:80>
    DocumentRoot /mnt/$SCRIPT_NAME/dexy-site/output/
    <Directory /mnt/$SCRIPT_NAME/dexy-site/output/>
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

### @export "download-dexy-site"
git clone https://github.com/ananelson/dexy-site
cd dexy-site

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
