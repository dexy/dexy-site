env

git clone https://github.com/rennat/pynliner.git
cd pynliner
python setup.py install
cd ..

### @export "python-version"
python --version

### @export "pip-install"
pip install dexy

### @export "easy-install"
easy_install dexy

### @export "easy-install-upgrade"
easy_install --upgrade dexy

### @export "source-install"
git clone http://github.com/ananelson/dexy
cd dexy
easy_install .

### @export "develop"
python setup.py develop

### @export "dexy-help"
dexy --version
dexy --help

### @export "examples"
dexy --setup examples
dexy examples
dexy --no-recurse examples

### @export "nosetests"
nosetests # Must be after --setup to have correct dirs

### @export "no-reports"
dexy --no-reports examples

### @export "dexy-docs"
dexy docs

### @export "list-filters"
dexy --filters

### @export "list-reporters"
dexy --reporters

### @export "test-custom-locations"
dexy --setup -a my_artifacts -l my_logs

### @export "dexy-all"
dexy

### @end
cd ..

### @export "clone-templates"
git clone http://github.com/ananelson/dexy-templates
cd dexy-templates

for dir in \`ls\`
do
  if [ -d "\$dir" ]; then
    cd \$dir
    echo "running dexy in \$dir"
    dexy --setup
    cd ..
  fi
done

cd .. # finished with templates

### @export "dexy-site"
git clone http://github.com/ananelson/dexy-site
cd dexy-site
dexy --setup
cp -r logs output/logs
cp -r artifacts output/artifacts
tar -czvf dexy-site.tgz -C output .
/home/ubuntu/s3-put -k $AWS_ACCESS_KEY_ID -s /home/ubuntu/secret.txt -T dexy-site.tgz /artifacts/dexy-site.tgz

