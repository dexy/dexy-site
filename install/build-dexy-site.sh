pip install dexy

git clone http://github.com/ananelson/dexy-site
cd dexy-site
dexy --setup

cp -r logs output/logs
cp -r artifacts output/artifacts

tar -czvf dexy-site.tgz -C output .

/home/ubuntu/s3-put -k $AWS_ACCESS_KEY_ID -s /home/ubuntu/secret.txt -T dexy-site.tgz /artifacts/dexy-site.tgz

