env # print env for debugging

### @export "python-version"
python --version

### @export "source-install"
git clone http://github.com/ananelson/dexy
cd dexy
pip install .

### @export "nosetests"
nosetests

### @export "run-dexy-test-template"
dexy setup

# all filters should run
dexy --directory test-template/
dexy report --allreports

# filters should be cached
dexy --directory test-template/
dexy report --allreports
### @end

cd .. # finished in dexy dir

### @export "dexy-version"
dexy version

### @export "dexy-help"
dexy help

### @export "list-filters"
dexy filters

### @export "list-reporters"
dexy reporters

### @export "dexy-site"
git clone http://github.com/ananelson/dexy-site
cd dexy-site
dexy setup
dexy -output
dexy reports -allreports

cd .. # finished with website

