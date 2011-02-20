cd ../docs/tutorials/0-hello-world/01/
dexy --setup

### @export "run"
dexy

### @export "cat"
cat cache/hello.py-py.txt
### @end

dexy --cleanup
