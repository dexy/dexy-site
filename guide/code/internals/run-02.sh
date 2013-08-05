set -u
set -e

dexy gen -t "gs-02" -d "d02"
cd d02

### @export "run"
dexy

### @export "cat"
cat output/hello.txt

### @export "ls"
ls -R
