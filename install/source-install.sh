apt-get install -y python-pip

### @export "pip-install"
pip install dexy

### @export "easy-install"
easy_install dexy

### @export "easy-install-upgrade"
easy_install --upgrade dexy

### @export "source-install"
hg clone http://bitbucket.org/ananelson/dexy
cd dexy
easy_install .

### @export "develop"
python setup.py develop

### @export "dexy-help"
dexy --version
dexy --help

### @export "nosetests"
easy_install nose
nosetests

dexy --setup examples

dexy examples
dexy --no-recurse examples

dexy docs

dexy

dexy --filters

dexy --reporters


cd ..

hg clone http://bitbucket.org/ananelson/dexy-templates
cd dexy-templates

cd code-journal-html-r
dexy --setup
cd ..

cd code-journal-html-python
dexy --setup
cd ..

cd code-journal-textile-r
dexy --setup
cd ..

cd code-journal-textile-ruby
dexy --setup
cd ..

cd latex-article-r
dexy --setup
cd ..

cd latex-tufte-article-r
dexy --setup
cd ..

cd .. # finished with templates

hg clone http://bitbucket.org/ananelson/dexy-site
cd dexy-site
dexy --setup
tar -czvf dexy-site.tgz -C output .
/home/ubuntu/s3-put -k $AWS_KEY -s /home/ubuntu/secret.txt -T dexy-site.tgz /artifacts/dexy-site.tgz

