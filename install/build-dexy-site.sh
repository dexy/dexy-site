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

### @export "start-selenium"
mkdir selenium
cd selenium
wget http://selenium.googlecode.com/files/selenium-server-standalone-2.17.0.jar
java -jar selenium-server-standalone-2.17.0.jar &
cd ..

### @end
sudo pip install selenium # TODO remove
sudo apt-get install -y firefox # TODO remove

### @export "pip-install-dexy-source"
git clone http://github.com/ananelson/dexy
cd dexy
sudo pip install .

### @end
cd ..

### @export "download-dexy-site"
git clone http://github.com/ananelson/dexy-site
cd dexy-site

### @export "make-sdists"
bash make-sdists.sh

### @export "start-webpy"
cd docs/examples/webpy
sqlite3 todo.sqlite3 < schema.sql
python todo.py 8080 &
cd ../../..

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

/home/ubuntu/s3-put -k $AWS_ACCESS_KEY_ID -s /home/ubuntu/secret.txt -T dexy-site.tgz /artifacts/dexy-site.tgz

