from bs4 import BeautifulSoup
from pygments import highlight
from pygments.formatters.html import HtmlFormatter
from pygments.lexers.agile import PythonLexer
import dexy.filter
import dexy.filters
import inspect
import json
import os
import shutil

py_lexer = PythonLexer()
fm = HtmlFormatter(lineanchors = "l", anchorlinenos=True, linenos='table')

# TODO Fix this so it doesn't generate examples multiple times, run all
# examples first.

filter_info = {}
for filter_instance in dexy.filter.Filter:
    skip = (not filter_instance.aliases) or filter_instance.setting('nodoc') or not filter_instance.__class__.__module__.startswith("dexy.")
    name = filter_instance.__class__.__name__
    if not skip and not filter_info.has_key(name):
        source = inspect.getsource(filter_instance.__class__)
        html_source = highlight(source, py_lexer, fm)

        wd = os.getcwd()

        examples = {}
        for t in filter_instance.templates():
            if t.__module__ == "dexy_filter_examples":
                for batch in t.dexy():
                    # Get HTML output from dexy.rst
                    doc_key = 'doc:dexy.rst|jinja|rst2html'
                    if doc_key in batch.docs:
                        data = batch.doc_output_data(doc_key)
                        soup = BeautifulSoup(unicode(data))
                        examples[t.alias] = "\n".join(str(x) for x in soup.body.contents)

                    # Copy any image files
                    for data in batch:
                        if data.ext in ('.png', '.jpg', '.gif',):
                            png_filename = data.name
                            png_path = os.path.join(wd, png_filename)
                            if not os.path.exists(os.path.dirname(png_path)):
                                os.makedirs(os.path.dirname(png_path))
                            shutil.copyfile(data.storage.data_file(), png_path)

        filter_info[name] = {
            'aliases' : filter_instance.aliases,
            'parentclass' : filter_instance.__class__.__base__.__name__,
            'doc' : filter_instance.__doc__,
            'output' : filter_instance.setting('output'),
            'examples' : examples,
            'source' : source,
            'module' : filter_instance.__module__,
            'html_source' : html_source
        }


with open("filter-info.json", "w") as f:
    json.dump(filter_info, f, sort_keys=True, indent=4)
