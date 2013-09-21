export DIR=quickstart-tips

### @export "templates"
dexy templates

### @export "gen"
dexy gen -t default -d $DIR

### @export "ls"
cd $DIR
ls -a

### @export 'yaml'
cat dexy.yaml

### @export "run-dexy"
dexy

### @export "after-run"
ls -a
ls output/
ls output-long/

### @export "grep"
dexy grep -expr hello

### @export "reset"
dexy reset

### @export "loglevel"
dexy -loglevel DEBUG

### @export "conf"
dexy conf

### @export "help"
dexy help
