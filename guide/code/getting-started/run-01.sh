set -u
set -e

dexy gen -t "t01" -d "d01"
cd d01
dexy cleanup

### @export "ls"
ls

### @export "setup"
dexy setup

### @export "run-script-manually"
python hello.py

### @export "run"
dexy

### @export "cat"
cat output-long/hello.py-py.txt
