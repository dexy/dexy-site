import json
import inspect
from dexy.controller import Controller
from pygments import highlight
from pygments.formatters.html import HtmlFormatter
from pygments.lexers.agile import PythonLexer
from pygments.lexers.web import JavascriptLexer
from pygments.styles import get_style_by_name

controller = Controller()
handlers = controller.find_filters()

py_lexer = PythonLexer()
fm = HtmlFormatter()

handler_info = {}
for k, v in handlers.items():
    name = v.__name__
    source = inspect.getsource(v)
    html_source = highlight(source, py_lexer, fm)
    if not handler_info.has_key(name):
        handler_info[name] = {
            'aliases' : v.ALIASES,
            'doc' : v.__doc__,
            'source' : source,
            'html_source' : html_source
        }

f = open("dexy--handler-info.json", "w")
json.dump(handler_info, f)
f.close()

