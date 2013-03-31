set -u
set -e

dexy gen -t "t04" -d "d04"
cd d04

### @export "run"
dexy

### @export "cat"
cat output/hello.txt
### @end
