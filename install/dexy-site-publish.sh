### @export "pip-install-dexy"
sudo pip install dexy

### @export "make-sdists"
bash make-sdists.sh

### @export "run-dexy-on-dexy-site"
dexy setup
dexy -danger -strictinherit -loglevel DEBUG

### @export "check-links"
linkchecker --file-output html -q --no-warnings http://0.0.0.0
mv linkchecker-out.html output/

tar -czvf dexy-site.tgz -C output .
DEXY_SITE_TGZ="/mnt/build-dexy-site/dexy-site/dexy-site.tgz"
/home/ubuntu/s3-put -k $AWS_ACCESS_KEY_ID -s /home/ubuntu/secret.txt -T $DEXY_SITE_TGZ /artifacts/dexy-site.tgz
