from bs4 import BeautifulSoup
from pygments import highlight
from pygments.formatters.html import HtmlFormatter
from pygments.lexers.agile import PythonLexer
import dexy.plugin
import dexy.filter
import dexy.filters
import inspect
import json
import os
import shutil

py_lexer = PythonLexer()
fm = HtmlFormatter(lineanchors = "l", anchorlinenos=True, linenos='table')

# store location of current wd since templates will be run in tmp dir
wd = os.path.abspath(".")

filter_info = {}
for filter_instance in dexy.filter.Filter:
    no_aliases = not filter_instance.setting('aliases')
    no_doc = filter_instance.setting('nodoc')
    not_dexy = not filter_instance.__class__.__module__.startswith("dexy.")
    exclude = filter_instance.alias in ('-')
    skip = no_aliases or no_doc or not_dexy or exclude

    if skip:
        continue

    # TODO only include source if this is a source-implemented filter
    source = inspect.getsource(filter_instance.__class__)
    html_source = highlight(source, py_lexer, fm)

    # run examples for this filter
    examples = {}
    for t in filter_instance.templates():
        if t.__module__ == "dexy_filter_examples":
            for wrapper in t.dexy():
                batch = wrapper.batch
                # Get HTML output from dexy.rst
                doc_key = 'doc:dexy.rst|jinja|rst2html'
                if doc_key in batch.docs:
                    data = batch.output_data(doc_key)
                    soup = BeautifulSoup(unicode(data))
                    examples[t.alias] = "\n".join(str(x) for x in soup.body.contents)

                # Copy any image files
                for data in batch:
                    if data.ext in ('.pdf', '.png', '.jpg', '.gif',):
                        png_filename = data.name
                        png_path = os.path.join(wd, png_filename)
                        if not os.path.exists(os.path.dirname(png_path)):
                            os.makedirs(os.path.dirname(png_path))
                        shutil.copyfile(data.storage.data_file(), png_path)

    filter_info[filter_instance.name()] = {
        'aliases' : filter_instance.setting('aliases'),
        'settings' : filter_instance._instance_settings,
        'defined_by_subclass' : filter_instance.__class__.aliases == filter_instance.setting('aliases'),
        'parentclass' : filter_instance.__class__.__base__.__name__,
        'doc' : filter_instance.help(),
        'output' : filter_instance.setting('output'),
        'examples' : examples,
        'source' : source,
        'module' : filter_instance.__module__,
        'html_source' : html_source
    }


with open("filter-info.json", "w") as f:
    json.dump(filter_info, f, sort_keys=True, indent=4)

with open("filter-tags.json", "w") as f:
    json.dump(dexy.filter.filter_aliases_by_tag(), f, sort_keys=True, indent=4)
