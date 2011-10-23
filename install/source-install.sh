env

### @export "python-version"
python --version

### @export "source-install"
git clone http://github.com/ananelson/dexy
cd dexy
pip install .

### @export "nosetests"
nosetests

### @export "dexy-version"
dexy version

### @export "dexy-help"
dexy help

### @export "list-filters"
dexy filters

### @export "list-reporters"
dexy reporters

### @export "clone-templates"
git clone http://github.com/ananelson/dexy-templates
cd dexy-templates

for dir in \`ls\`
do
  if [ -d "\$dir" ]; then
    cd \$dir
    echo "running dexy in \$dir"
    dexy setup
    dexy
    cd ..
  fi
done

cd .. # finished with templates

### @export "clone-examples"
git clone http://github.com/ananelson/dexy-examples
cd dexy-examples

for dir in \`ls\`
do
  if [ -d "\$dir" ]; then
    cd \$dir
    echo "running dexy in \$dir"
    dexy setup
    dexy
    cd ..
  fi
done

cd .. # finished with examples

### @export "dexy-site"
git clone http://github.com/ananelson/dexy-site
cd dexy-site
dexy setup
dexy

cd .. # finished with website

