set -u
set -e

dexy gen -t "gs-05" -d "d05"
cd d05
dexy cleanup

### @export "ls"
ls

### @export "run"
dexy setup
dexy

### @export "cat"
cat output/doc.html
