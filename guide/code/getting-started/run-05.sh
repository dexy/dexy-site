set -u
set -e

dexy gen -t "t05" -d "d05"
cd d05
dexy cleanup

### @export "ls"
ls

### @export "run"
dexy setup
dexy

### @export "cat"
cat output/doc.html
