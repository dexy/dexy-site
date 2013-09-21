set -u
set -e

dexy gen -t "gs-03" -d "d03"
cd d03

### @export "run"
dexy

### @export "cat"
cat output/hello.txt
