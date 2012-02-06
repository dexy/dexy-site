install_dexy() {
    cd dexy
    pip install .
    cd ..

    # These are not required by Dexy, but they enable extra functionality.
    pip install GitPython

    python_version_is_2_7
    if [ $VERSION27 -eq 1 ]
        then pip install python-cjson
    fi
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

    python_version_is_2_7
    if [ $VERSION27 -eq 1 ]
        then dexy --directory test-examples --danger --allreports --artifactclass FileSystemCjsonArtifact
    fi
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

python_version_is_2_7() {
    VERSION=`python --version 2>&1 | tr "Python" " " | tr "." " " | tr "+" " "`
    read v_major v_minor v_rev << EOF
`echo ${VERSION}`
EOF

    VERSION27=0

    if [ $v_major == "2" ]
    then
        if [ $v_minor == "7" ]
        then VERSION27=1
        fi
    fi

    echo "Checked python version: $VERSION. Is 2.7? $VERSION27"
    which python
}

sudo apt-get install -y python2.6
sudo apt-get install -y python-virtualenv

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
