### @export "create files"
echo "hello.txt|jinja" > dexy.yaml
echo "hello\n1+1 = {{ 1+1 }}" > hello.txt
rm dexy.sh.txt

### @export "run dexy without setup"
dexy

### @export "dexy setup"
dexy setup
ls -a

### @export "dexy"
dexy

### @export "dexy reset"
dexy reset

### @export "dexy with r"
dexy -r
dexy -reset

### @export "dexy cleanup"
ls -a
dexy cleanup
ls -a

### @export "dexy help"
dexy help -on dexy
