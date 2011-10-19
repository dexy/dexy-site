set -u
set -e

cd ../docs/tutorials/1-python/01/

dexy setup

### @export "run"
dexy

### @export "cat"
cat output/doc.html
### @end

dexy cleanup
