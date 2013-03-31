set -u
set -e

dexy gen -t "t03" -d "d03"
cd d03

### @export "run"
dexy

### @export "cat"
cat output/hello.txt
