### @export "test"
dexy -h

### @export "setup"
mkdir work
cd work
dexy --setup .    # that command ends with a dot (.) in case you can't see it

### @export "run"
dexy -d -g http://www.dexy.it/examples/jinja/hello.dexy .  # ditto dot :-)

### @export "log"
tail logs/dexy.log

### @export "output"
cat cache/hello.txt-jinja.txt

