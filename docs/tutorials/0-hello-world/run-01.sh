set -u
set -e

cd ../docs/tutorials/0-hello-world/01/
dexy --setup

### @export "run"
dexy

### @export "cat"
cat output-long/hello.py-py.txt
### @end

dexy --cleanup
