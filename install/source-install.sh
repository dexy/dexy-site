### @export "source-install"
hg clone http://bitbucket.org/ananelson/dexy
cd dexy
easy_install .

### @export "dexy-help"
dexy --help

dexy --version
### @end

nosetests

dexy --setup examples

dexy examples
dexy --no-recurse examples

dexy docs

dexy

dexy --filters

dexy --reporters


cd ..

hg clone http://bitbucket.org/ananelson/dexy-templates
cd dexy-templates

cd code-journal-html-r
dexy --setup
cd ..

cd code-journal-html-python
dexy --setup
cd ..

cd code-journal-textile-r
dexy --setup
cd ..

cd code-journal-textile-ruby
dexy --setup
cd ..

cd latex-article-r
dexy --setup
cd ..

cd latex-tufte-article-r
dexy --setup
cd ..
