cd ../docs/tutorials/1-python/01/

dexy --setup -s

### @export "run"
dexy -s

### @export "cat"
cat cache/doc.html
### @end

dexy --cleanup
