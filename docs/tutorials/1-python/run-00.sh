set -u
set -e

cd ../docs/tutorials/1-python/00/

### @export "run"
dexy --setup

### @export "cat"
cat output-long/doc.html-jinja.html
### @end

dexy --cleanup
