javadoc \
    -docletpath lib/json-doclet-0.3.1.jar:lib/antlr-3.4-complete-no-antlrv2.jar:lib/LaTeXlet.jar:lib/json_simple-1.1.jar \
    -doclet it.dexy.jsondoclet.Doclet -classpath . hello src/hello/*
