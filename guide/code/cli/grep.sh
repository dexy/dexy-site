### @export "gen"
dexy gen -t code-journal-markdown-matplotlib -d journal
cd journal
dexy

### @export "grep"
dexy grep -expr code

### @export "grep with pipe"
dexy grep -expr "code001.py|idio"

### @export "grep with keys"
dexy grep -expr code -keys

### @export "grep with keyexpr"
dexy grep -expr code -keyexpr pyplot

### @export "grep with contents"
dexy grep -expr "index.md" -contents -lines 5

### @export "info"
dexy info -expr "index.md"

### @export "look in cache"
ls .cache/
find .cache/work/da/
