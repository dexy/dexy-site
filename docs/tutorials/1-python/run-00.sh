set -u
set -e

cd ../docs/tutorials/1-python/00/

### @export "run"
dexy setup
dexy

### @export "cat"
cat output/doc.html
### @end

dexy cleanup
