set -u
set -e

cd ../docs/tutorials/0-hello-world/02/
dexy setup

### @export "run"
dexy

### @export "cat"
cat output/hello.txt
### @end

# make sure alternate config files work
dexy reset
dexy -config implicit.dexy
dexy reset
dexy -config allinputs.dexy

dexy cleanup
