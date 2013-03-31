set -u
set -e

dexy gen -t "t06" -d "d06"
cd d06

### @export "run"
dexy
