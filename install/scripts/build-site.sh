easy_install BeautifulSoup==3.2.0
easy_install dexy[py26,common,liveserver]
hg clone http://bitbucket.org/ananelson/dexy-site
cd dexy-site
dexy --setup -s -d || exit
tar -czvf dexy-site.tgz -C cache .
/home/ubuntu/s3-put -k $AWS_KEY -s /home/ubuntu/secret.txt -T dexy-site.tgz /artifacts/dexy-site.tgz

