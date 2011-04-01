set -u
set -e
cd ../docs/tutorials/0-hello-world/00/

### @export "run"
dexy --setup

### @export "cat"
cat output-long/hello.txt-jinja.txt
### @end

dexy --cleanup > /dev/null
