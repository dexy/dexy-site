set -u
set -e

dexy gen -t "cd-00" -d "d00"
cd d00

### @export "run"
dexy setup
dexy

### @export "tree-after"
ls -R
