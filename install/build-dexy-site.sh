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

### @export "selenium-url"
export SELENIUM_URL="http://selenium.googlecode.com/files/selenium-server-standalone-2.17.0.jar"

### @export "start-selenium"
mkdir selenium
cd selenium
wget $SELENIUM_URL
java -jar selenium-server-standalone-2.17.0.jar &
cd ..

### @export "pip-install-dexy-source"
git clone https://github.com/ananelson/dexy
cd dexy
sudo pip install .

### @end
cd ..

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
dexy -danger -strictinherit

### @export "add-logs"
cp -r logs output/logs

### @export "add-artifacts"
cp -r artifacts output/artifacts

### @export "check-links"
linkchecker --file-output html -q --no-warnings --no-follow-url=logs --no-follow-url=artifacts http://0.0.0.0
mv linkchecker-out.html output/

tar -czvf dexy-site.tgz -C output .
