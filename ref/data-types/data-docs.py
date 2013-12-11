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

    source = inspect.getsource(data_class)
    html_source = highlight(source, py_lexer, fm)

    members = inspect.getmembers(data_class)
    member_info = {}

    for member_name, member in members:
        member_info[member_name] = {}

        if hasattr(member, 'im_func'):
            code = member.im_func.func_code

            member_info[member_name]['doc'] = inspect.getdoc(member)
            member_info[member_name]['source'] = inspect.getsource(member)
            member_info[member_name]['args'] = code.co_varnames[code.co_argcount-1]

    datas_info[alias] = {
            'aliases' : class_args['aliases'][1],
            'settings' : data_class._settings,
            'html_source' : html_source,
            'source' : source,
            'members' : member_info,
            'doc' : class_args['help'][1]
            }

    with open("datas-info.json", "w") as f:
        json.dump(datas_info, f, sort_keys=True, indent=4)
