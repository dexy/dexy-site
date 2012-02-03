install_dexy() {
    cd dexy
    pip install .
    cd ..

    # These are not required by Dexy, but they enable extra functionality.
    pip install GitPython
    pip install python-cjson
}

run_tests_and_examples() {
    cd dexy
    nosetests

    dexy setup

    dexy --directory test-examples --danger --output
    dexy report --allreports
    dexy --directory test-examples --danger --output
    dexy report --allreports
    dexy --directory test-examples --danger --output --uselocals no
    dexy report --allreports

    dexy --directory test-examples --danger --allreports --artifactclass FileSystemCjsonArtifact
    dexy --directory test-examples --danger --allreports --artifactclass FileSystemPickleArtifact
    dexy --directory test-examples --danger --allreports --artifactclass FileSystemcPickleArtifact

    echo "=================================================="
    dexy version
    echo "=================================================="
    python --version
    dexy help
    dexy help -on filters
    dexy filters
    dexy filters -alias rint
    dexy reporters

    dexy cleanup
    cd ..
}

sudo apt-get install -y python2.6
sudo apt-get install -y python-virtualenv
sudo apt-get install -y ksh

### @export "dexy-source"
git clone https://github.com/ananelson/dexy

### @end
echo "--------------------------------------------------"
echo "Starting test 1"
echo "--------------------------------------------------"

### @export "create-virtualenv"
virtualenv --no-site-packages testenv/

source testenv/bin/activate
install_dexy
run_tests_and_examples
deactivate

echo "completed test 1"
echo "removing virtualenv"

rm -r testenv/

### @end
echo "--------------------------------------------------"
echo "Starting test 2"
echo "--------------------------------------------------"

### @export "test-python-2.6"
virtualenv --no-site-packages -p python2.6 testenv/

source testenv/bin/activate
install_dexy
run_tests_and_examples
deactivate
