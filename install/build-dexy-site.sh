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

### @export "pip-install-dexy-source"
git clone http://github.com/ananelson/dexy
cd dexy
sudo pip install .

### @end
cd ..

### @export "build-dexy-site"
git clone http://github.com/ananelson/dexy-site
cd dexy-site

dexy setup
dexy -danger -strictinherit

cp -r logs output/logs
cp -r artifacts output/artifacts

# hack because linkchecker thinks it's running as root, even though it's not
echo "whoami?"
whoami
touch linkchecker-out.html
chown -u nobody linkchecker-out.html
linkchecker --file-output html -q --no-warnings --no-follow-url=logs --no-follow-url=artifacts http://0.0.0.0
sudo chown -u nobody linkchecker-out.html
mv linkchecker-out.html output/

tar -czvf dexy-site.tgz -C output .

/home/ubuntu/s3-put -k $AWS_ACCESS_KEY_ID -s /home/ubuntu/secret.txt -T dexy-site.tgz /artifacts/dexy-site.tgz

