set -u
set -e

dexy gen -t "t00" -d "d00"
cd d00
dexy cleanup

### @export "tree-before"
ls

### @export "run"
dexy setup
dexy

### @export "tree-after"
ls -R

### @export "cat"
cat output/hello.txt
