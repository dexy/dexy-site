cd ../docs/tutorials/1-python/00/

### @export "run"
dexy --setup

### @export "cat"
cat cache/doc.html-jinja.html
### @end

dexy --cleanup
