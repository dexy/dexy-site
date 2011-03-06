# TODO move to main setup
wget http://pypi.python.org/packages/2.7/s/setuptools/setuptools-0.6c11-py2.7.egg
echo "fe1f997bc722265116870bc7919059ea  setuptools-0.6c11-py2.7.egg" > checkmd5.txt
md5sum -c checkmd5.txt && bash setuptools-0.6c11-py2.7.egg
easy_install nose


hg clone http://bitbucket.org/ananelson/dexy
cd dexy
nosetests &> test.out
python setup.py sdist bdist_egg
python2.7 setup.py bdist_egg


tar -czvf dexy-pkg.tgz -C dist .
/home/ubuntu/s3-put -k $AWS_KEY -s /home/ubuntu/secret.txt -T dexy-pkg.tgz /artifacts/dexy-pkg.tgz
