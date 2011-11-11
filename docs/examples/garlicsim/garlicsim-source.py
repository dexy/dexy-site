from pygments import highlight
from pygments.formatters.html import HtmlFormatter
from pygments.formatters.latex import LatexFormatter
from pygments.lexers.agile import PythonLexer
import inspect
import json
import sys

py_lexer = PythonLexer()
h_fm = HtmlFormatter(lineanchors='l')
l_fm = LatexFormatter()

module_names = [
        "garlicsim",
        "garlicsim_lib",
        "garlicsim_lib.simpacks",
        "garlicsim_lib.simpacks.prisoner",
        "garlicsim_lib.simpacks.prisoner.players"
]

for m in module_names:
    __import__(m)

modules = [sys.modules[m] for m in module_names]

def get_modules(m):
    return [x for x_name, x in inspect.getmembers(m) if inspect.ismodule(x)]

def get_classes(m):
    return [x for x_name, x in inspect.getmembers(m) if inspect.isclass(x)]

def get_functions(m):
    return [x for x_name, x in inspect.getmembers(m) if (inspect.ismethod(x) or inspect.isfunction(x))]


code = {}
for m in modules:
    for c in get_classes(m):
        qualified_name = c.__module__ + "." + c.__name__
        code[qualified_name] = {}
        code[qualified_name]['doc'] = m.__doc__
        for f in get_functions(c):
            try:
                source = inspect.getsource(f)
                latex_source = highlight(source, py_lexer, l_fm)
                html_source = highlight(source, py_lexer, h_fm)

                code[qualified_name][f.__name__] = {}
                code[qualified_name][f.__name__]['source'] = source
                code[qualified_name][f.__name__]['html'] = html_source
                code[qualified_name][f.__name__]['latex'] = latex_source
            except IOError:
                pass


f = open("dexy--source.json", "w")
json.dump(code, f)
f.close()

