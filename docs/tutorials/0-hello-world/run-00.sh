set -u
set -e
cd ../docs/tutorials/0-hello-world/00/

### @export "run"
dexy setup
dexy

### @export "cat"
cat output/hello.txt
### @end

dexy cleanup
