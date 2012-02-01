install_dexy() {
    cd dexy
    pip install .
    cd ..

    # These are not required by Dexy, but they enable extra functionality.
    pip install GitPython
    pip install python-cjson
}

run_tests_and_examples() {
    nosetests
    dexy reset

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
}

apt-get install -y python2.6
apt-get install -y git

### @export "install-virtualenv"
apt-get install -y python-virtualenv
apt-get install -y python-setuptools

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

### @end
echo "--------------------------------------------------"
echo "Starting test 2"
echo "--------------------------------------------------"

### @export "test-python-2.6"
virtualenv --no-site-packages -p python2.6 testenv/

source testenv2.6/bin/activate
install_dexy
run_tests_and_examples
deactivate
