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

image_extensions = ['.pdf', '.png', '.jpg', '.gif', '.svg', '.py.gif', '.py.png', '.py.jpg']

py_lexer = PythonLexer()
fm = HtmlFormatter(lineanchors = "l", anchorlinenos=True, linenos='table')

# store location of current wd since chdir happens
wd = os.path.abspath(".")

broken_examples = ('matlabint', 'cowsay', 'ditaa', 'phrender')

filter_info = {}
for filter_instance in dexy.filter.Filter:
    if filter_instance.alias in broken_examples:
        continue

    no_aliases = not filter_instance.setting('aliases')
    no_doc = filter_instance.setting('nodoc')
    not_dexy = not filter_instance.__class__.__module__.startswith("dexy.")
    exclude = filter_instance.alias in ('-')
    skip = no_aliases or no_doc or not_dexy or exclude

    if skip:
        continue

    defined_by_subclass = filter_instance.__class__.aliases == filter_instance.setting('aliases')

    if defined_by_subclass:
        source = inspect.getsource(filter_instance.__class__)
        html_source = highlight(source, py_lexer, fm)
    else:
        source = ''
        html_source = ''

    # run examples for this filter
    examples = []
    for t in filter_instance.templates():
        if t.__module__ == "dexy_filter_examples":
            for wrapper in t.dexy():
                batch = wrapper.batch
                # Get HTML output from dexy.rst
                doc_key = 'doc:dexy.rst|jinja|rst2html'
                if doc_key in batch.docs:
                    data = batch.output_data(doc_key)
                    soup = BeautifulSoup(str(data), features="html.parser")
                    examples.append("\n".join(str(x) for x in soup.body.contents))

                if t.setting('copy-output-dir'):
                    output_dir = t.alias
                    os.makedirs(os.path.join(wd, output_dir), exist_ok=True)
                    for doc in wrapper.nodes.values():
                        if not hasattr(doc, 'output_data'):
                            continue

                        data = doc.output_data()
                        if data.is_canonical_output():
                            local_filename = data.output_name()

                            if local_filename.endswith(".html") and not "|" in data.key:
                                continue

                            file_path = os.path.join(wd, output_dir, local_filename)
                            if not os.path.exists(os.path.dirname(file_path)):
                                os.makedirs(os.path.dirname(file_path))
                            shutil.copyfile(data.storage.data_file(), file_path)

                # Copy any image files
                for data in batch:
                    if data.ext in image_extensions:
                        png_filename = data.output_name()
                        png_path = os.path.join(wd, png_filename)
                        if not os.path.exists(os.path.dirname(png_path)):
                            os.makedirs(os.path.dirname(png_path))
                        shutil.copyfile(data.storage.data_file(), png_path)

    docstring = filter_instance.setting('help')
    filter_info[filter_instance.alias] = {
        'aliases' : filter_instance.setting('aliases'),
        'settings' : filter_instance._instance_settings,
        'defined_by_subclass' : defined_by_subclass,
        'parentclass' : filter_instance.__class__.__base__.__name__,
        'doc' : docstring,
        'firstdoc' : docstring.splitlines()[0],
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
