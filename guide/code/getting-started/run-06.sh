set -u
set -e

dexy gen -t "gs-06" -d "d06"
cd d06

### @export "run"
dexy
