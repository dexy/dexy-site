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

examples = {}
for t in dexy.template.Template:
    if not t.__module__ in "dexy_templates":
        continue

    for wrapper in t.dexy():
        batch = wrapper.batch
        # Get HTML output from dexy.rst
        doc_key = 'doc:dexy.rst|jinja|rst2html'

        if doc_key in batch.docs:
            data = batch.output_data(doc_key)
            soup = BeautifulSoup(unicode(data))
            example_content = "\n".join(str(x) for x in soup.body.contents)
            examples[t.alias] = example_content

        if t.setting('copy-output-dir'):
            output_dir = t.alias
            os.makedirs(os.path.join(wd, output_dir))
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

with open("examples.json", "w") as f:
    json.dump(examples, f, sort_keys=True, indent=4)
