### @export "reports"
dexy reports

### @export "setup dexy template"
dexy gen -t website-html5-altitude -d website
cd website

### @export "custom reports"
dexy --reports "ws long"
ls
