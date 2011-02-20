cd ../docs/tutorials/0-hello-world/00/

### @export "run"
dexy --setup

### @export "cat"
cat cache/hello.txt-jinja.txt
### @end

dexy --cleanup
