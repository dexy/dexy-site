from bs4 import BeautifulSoup
from pygments import highlight
from pygments.formatters.html import HtmlFormatter
from pygments.lexers.agile import PythonLexer
import dexy.plugin
import dexy.datas
import dexy.data
import inspect
import json
import os
import shutil

py_lexer = PythonLexer()
fm = HtmlFormatter(lineanchors = "l", anchorlinenos=True, linenos='table')

datas_info = {}
for alias, info in dexy.data.Data.plugins.iteritems():
    data_class, class_args = info
    print data_class
    print class_args

    source = inspect.getsource(data_class)
    html_source = highlight(source, py_lexer, fm)

    datas_info[alias] = {
            'aliases' : class_args['aliases'][1],
            'settings' : data_class._settings,
            'html_source' : html_source,
            'source' : source,
            'doc' : class_args['help'][1]
            }

    with open("datas-info.json", "w") as f:
        json.dump(datas_info, f, sort_keys=True, indent=4)
