cd ../docs/tutorials/0-hello-world/02/
dexy --setup .

### @export "run"
dexy .

### @export "cat"
cat cache/hello.txt-jinja.txt
### @end

dexy --cleanup .
