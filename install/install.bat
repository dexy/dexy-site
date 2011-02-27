easy_install dexy
easy_install jinja2
easy_install pygments

mkdir work
chdir work
dexy --setup .
dexy -d -g http://www.dexy.it/examples/jinja/hello.dexy .

type cache\filters\hello.txt-jinja.txt
