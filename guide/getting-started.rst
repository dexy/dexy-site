Getting Started
===============

{% from "dexy.jinja" import code, codes, ext with context %}

This section is designed to gently introduce you to Dexy by working through
several progressive examples.  These examples are written in Python because
everyone using Dexy will have Python installed on their system, and Python is
an easy, accessible language to understand. However, Dexy supports many other
programming languages and it's easy to add support for new languages, so please
don't feel left out if Python is not your preferred language.

As a reminder, if you aren't already familiar with using the command line, then
you should work through a course like Zed Shaw's `Command Line Crash Course
<http://cli.learncodethehardway.org/>`_ before you start with these examples.

The point of all these examples is for you to work through them, not just read
them. While the contents of each example can be found in a git repository, you
will get far more benefit from typing in the contents manually. The content is
short, and typing it in will mean you will be more aware of the details of the
syntax, and you will make typos and mistakes and learn how dexy responds and
how to debug and fix them. After a while the examples will stop telling you to
make new files and type them in, but you are still expected and encouraged to
do so. Also, please experiment once you have understood the basics, and you are
welcome to use these examples as the starting point for your own projects.

.. contents:: Contents
    :local:

Simple Dexy Example
-------------------

{% set ex = 'd00' -%}
We are going to create a very simple project to learn how to run dexy.

Create a new, empty directory to work in. Make a text file named `hello.txt` and type the following into it::

    {{ d['code/getting-started/d00/hello.txt'] | indent(4) }}

The curly brackets are jinja tags, and they are how we are going to get dexy to incorporate code and other fun stuff into our documents later on. Whatever goes in those brackets gets evaluated, including simple arithmetic like `1+1`.

Next we need to give dexy some instructions about what files we want to be processed, and what we want done to those files. Create another text file named `dexy.txt` (the name is important) and type the following into it::

    {{ d['code/getting-started/d00/dexy.txt'] | indent(4) }}

Here we are telling dexy to take the file named `hello.txt` and run it through the `jinja` filter.

Your directory should now look like this:

{{ codes('code/getting-started/run-00.sh|idio|shint|pyg', 'tree-before') }}

Now we are ready to run dexy! The first time you run dexy in a directory, you will need to call `dexy setup` first. Then to run dexy you simply type `dexy`:

{{ codes('code/getting-started/run-00.sh|idio|shint|pyg', 'run') }}

Dexy puts some of the finished documents into the output/ directory (the ones it thinks you are most interested in) and all the finished documents into the output-long/ directory (with uglier, but unique, filenames). To see the output of our `hello.txt` template, you can run:

{{ codes('code/getting-started/run-00.sh|idio|shint|pyg', 'cat') }}

We see from this output that jinja has taken the `1+1` which we typed within the tag and evaluated it, giving `2`. So, this tells us that dexy has successfully called the jinja filter we specified in the `dexy.txt` file.

The Run Report
--------------

{% set run_report_path = ".dexy/reports/run/index.html" -%}

Dexy has also generated a report which describes what has happened. You should
have a HTML file at `{{ run_report_path }}` in your project directory. You can
open this in your browser by running the "Open File" command in your browser,
or by using the `open` or `xdg-open` command on OS X or Linux systems.

.. raw:: html

    <iframe style="width: 100%; height: 500px; border: thin solid gray;" src="code/getting-started/{{ ex }}/{{ run_report_path }}"></iframe>

The run report lets you drill down into the steps of dexy's processing. It's
especially useful when the output of a document isn't written to the `output/`
directory as we'll see in the next section. As you work on a project, keep the
report open in a browser and refresh the page each time you run dexy.

Getting Dexy to Run Code
------------------------

{% set ex = 'd01' -%}

Next, we will get dexy to evaluate a simple python script. In the same directory where you've been working, create a new file named `hello.py` and put the following in it::

    {{ d['code/getting-started/d01/hello.py'] | indent(4) }}

Your project directory should look like this now:

{{ codes('code/getting-started/run-01.sh|idio|shint|pyg', 'ls') }}

Run this script from the command line to make sure that it works, you should see the script print out the results of the calculation:

{{ codes('code/getting-started/run-01.sh|idio|shint|pyg', 'run-script-manually') }}

Now modify your `dexy.txt` file so that it looks like this::

    {{ d['code/getting-started/d01/dexy.txt'] | indent(4) }}

This means we want the file named `hello.py` to be run through the `py` filter,
and we want the file named `hello.txt` to be run through the `jinja` filter.
The order of these lines is important because in the next section we want
`hello.py` to be run first, so that it is available to `hello.txt|jinja`.

Now you can call dexy again:

{{ codes('code/getting-started/run-01.sh|idio|shint|pyg', 'run') }}

This time we can't look in the `output/` directory to see what dexy did,
because by default the output of running code through the `py` filter isn't
included in that directory. However, we can see the results in the run report.
You should use the run report to verify that dexy has run the code and produced
the expected result.


Showing Code and Output
-----------------------

Now we're finally ready to start using dexy to document code! In this example we will incorporate the python script we wrote into our `hello.txt` document, and we will also show the output it produces. Modify the `dexy.txt` file so it looks like this::

    {{ d['code/getting-started/d02/dexy.txt'] | indent(4) }}

And modify the `hello.txt` file so that it looks like this::

    {{ d['code/getting-started/d02/hello.txt'] | indent(4) }}

Now try running dexy, and then view the contents of the output `hello.txt` file:

{{ codes('code/getting-started/run-02.sh|idio|shint|pyg', 'cat') }}

If this doesn't work, go back and make sure you have typed everything in exactly as shown (exactly means every single character is identical, even spaces and blank lines).

Next, experiment with changing one of the variable values in `hello.py`, for example set `x` to `8`, and then run dexy again. The `output/hello.txt` file will be updated with the new value in both the script and the output.

Here are some more things you can try:

* Change the text in your `hello.txt` file and run dexy again.
* Remove just one of the closing curly brackets `}` from the `hello.txt` file and
  try to run dexy again. You should get an error message because the jinja
  processor can't parse the file. Fix the file and make sure dexy runs with no
  more errors. Experiment with other ways to break things, noting that some
  produce error messages and others don't (like removing an opening curly
  bracket `{`).

Processing Multiple Scripts
---------------------------

{% set ex = "d03" -%}

Next we're going to add a second python script and make a change to the way we write config files.

Change your `dexy.txt` file so that it looks like this::

    {{ d['code/getting-started/' + ex + '/dexy.txt'] | indent(4) }}

We have replaced the file name `hello.py` with a wildcard expression which will match any file ending in `.py`. After making this change, run dexy and make sure everything still works.

Next create a new file named `loop.py` and put the following into it::

    {{ d['code/getting-started/' + ex + '/loop.py'] | indent(4) }}

And then modify your `hello.txt` file to look like this::

    {{ d['code/getting-started/' + ex + '/hello.txt'] | indent(4) }}

Then after you have run dexy, the contents of `output/hello.txt` should look like this:

{{ codes('code/getting-started/run-03.sh|idio|shint|pyg', 'cat') }}

YAML Configuration Files
------------------------

{% set ex = "d04" -%}

Up to now we have been creating files named `dexy.txt` and listing a few
documents in each file to tell dexy what to do. This was a simple way to get
started, but it has limitations. Now we want to start using a YAML-based
configuration file format. `YAML <http://en.wikipedia.org/wiki/YAML>`_ is a
relatively sane and human-friendly format.

Delete your `dexy.txt` file and create a new file `dexy.yaml` with contents::

    {{ d['code/getting-started/' + ex + '/dexy.yaml'] | indent(4) }}

Run the `dexy` command again, you should get the same result as before.

The way you use the YAML syntax is to list the dependencies for a document
underneath it in an indented list. As a shortcut, you can (and should) leave
off the initial `*` for a wildcard expression. (If you ever do need to start an
expression with an asterisk, then it needs to be wrapped in "double quotes" or
escaped with a \\ (forward slash).) In general in YAML you do not need to put
string expressions in quotes (which makes it very convenient to work with). You
can also include comments in your YAML by starting a comment line with #.

HTML Documents
--------------

{% set ex = "d05" -%}

Now we will start creating HTML documents instead of just plain text, and we'll
also learn about some of the other filters we can use to run python code.

Create a new working directory. Let's start by writing a short Python script
called `script.py`::

    {{ d['code/getting-started/' + ex + '/script.py'] | indent(4) }}

And also create a simple HTML file named `doc.html` which includes the source
of the python file::

    {{ d['code/getting-started/' + ex + '/doc.html'] | indent(4) }}

Here is the `dexy.yaml` configuration::

    {{ d['code/getting-started/' + ex + '/dexy.yaml'] | indent(4) }}

Your working directory should look like this:

{{ codes('code/getting-started/run-05.sh|idio|shint|pyg', 'ls') }}

Because this is a new project, we need to call `dexy setup` once before we call dexy:

{{ codes('code/getting-started/run-05.sh|idio|shint|pyg', 'run') }}

The generated HTML should be:

{{ codes('code/getting-started/run-05.sh|idio|shint|pyg', 'cat') }}

{% if ext == '.html' %}
If you open the file in a browser, it will look like:

.. raw:: html

    <iframe style="width: 300px; height: 200px; border: thin solid gray;" src="code/getting-started/{{ ex }}/output/doc.html"></iframe>

{% endif %}

Syntax Highlighting
-------------------

{% set ex = "d06" -%}

Now that we're using HTML, let's make this output a little more colorful by
applying syntax highlighting to our source code. Here's how you include this in
your HTML::

    {{ d['code/getting-started/' + ex + '/doc.html'] | indent(4) }}

In the header of the file, we are inserting style definitions into a `text/css`
style block. The 'pygments' object we use is a dict which contains CSS (and
also LaTeX) stylesheets in various styles. Just pass the name of the style with
the appropriate file extension to include it in your HTML header. Also make
sure to add the `|pyg` after `script.py` in the body of the html document.

Next, change the `dexy.yaml` file to look like::

    {{ d['code/getting-started/' + ex + '/dexy.yaml'] | indent(4) }}

After you run this example, open the file in a web browser, you should see the source code colorized.

{% if ext == '.html' %}

.. raw:: html

    <iframe style="width: 300px; height: 200px; border: thin solid gray;" src="code/getting-started/{{ ex }}/output/doc.html"></iframe>

{% endif %}

{% set ex = "d07" -%}

Next we want to run the python code. Add a line to the `dexy.yaml` file::

    {{ d['code/getting-started/' + ex + '/dexy.yaml'] | indent(4) }}

And update the html file::

    {{ d['code/getting-started/' + ex + '/doc.html'] | indent(4) }}

{% if ext == '.html' %}

.. raw:: html

    <iframe style="width: 100%; height: 300px; border: thin solid gray;" src="code/getting-started/{{ ex }}/output/doc.html"></iframe>

{% endif %}

Passing Custom Options
----------------------

{% set ex = "d08" -%}

Now let's pass a custom option to the pyg filter::

    {{ d['code/getting-started/' + ex + '/dexy.yaml'] | indent(4) }}

To pass custom options to a filter, add an indented line beneath the document and start with the filter alias, followed by a colon, then the dict of options. The filter documentation should tell you what available options are.

There is no need to make any change to the HTML file. After running dexy you should see line numbers appear in the generated `doc.html`.

{% if ext == '.html' %}

.. raw:: html

    <iframe style="width: 100%; height: 300px; border: thin solid gray;" src="code/getting-started/{{ ex }}/output/doc.html"></iframe>

{% endif %}

Next, look at the documentation for the `pygments HtmlFormatter <http://pygments.org/docs/formatters#htmlformatter>`_ and try out some of the other options.

Applying a HTML Template
------------------------

{% set ex = "d09" -%}

In the last few examples we have been writing complete HTML documents by hand,
but typing `<head>` tags all the time gets old fast. So, now let's use another
dexy filter to help us.

We will use the `easyhtml` filter in dexy to apply a basic stylesheet including
pygments CSS to our document. The `dexy.yaml` file should look like this::

    {{ d['code/getting-started/' + ex + '/dexy.yaml'] | indent(4) }}

Remove everything from the doc.html file except the contents of the <body>
tags, it should look like this now::

    {{ d['code/getting-started/' + ex + '/doc.html'] | indent(4) }}

Now we are applying multiple filters to the `doc.html` file. First, we run the
jinja filter. Second, we run the `easyhtml` filter which adds a header and
footer to our document, making it a complete HTML document.

{% if ext == '.html' %}

.. raw:: html

    <iframe style="width: 100%; height: 300px; border: thin solid gray;" src="code/getting-started/{{ ex }}/output/doc.html"></iframe>

{% endif %}

Python Console Output
---------------------

{% set ex = "d10" -%}

The `pycon` filter used in this section is not available for Windows. If you
are using Windows to run dexy then the example described in this section will
not work.

Now, let's change this example so that instead of showing the code and,
separately, showing the output, we just show a console transcript. The
`dexy.yaml` file should look like::

    {{ d['code/getting-started/' + ex + '/dexy.yaml'] | indent(4) }}

The `pycon` dexy filter runs python code in the python REPL, so you see the
prompts, input and output from running each line of code. We can pass this REPL
transcript to pygments which knows how to syntax highlight console output.

Update the html file as follows::

    {{ d['code/getting-started/' + ex + '/doc.html'] | indent(4) }}

{% if ext == '.html' %}

.. raw:: html

    <iframe style="width: 100%; height: 300px; border: thin solid gray;" src="code/getting-started/{{ ex }}/output/doc.html"></iframe>

{% endif %}

Splitting Code into Sections
----------------------------

{% set ex = "d11" -%}

Up until now we have been running whole python scripts. However, we don't want
to always have to include whole scripts in our documents. Dexy is designed to
allow you to split your code into sections and then preserve these sections in
subsequent filters.

The `idio` filter will interpret special comments in your source code and split
your script into sections accordingly. Create a new working directory and
create a file named `script.py` which should look like this::

    {{ d['code/getting-started/' + ex + '/script.py'] | indent(4) }}

These comments follow a special format of three comment characters, the python comment character being #, followed by the `@export` command, and then the name of the section in quotes. We have defined two sections, the first named `assign-variables` and the second named `multiply`.

Here is the `dexy.yaml` file which tells dexy to run all files with `.py` extension through the `idio` filter::

    {{ d['code/getting-started/' + ex + '/dexy.yaml'] | indent(4) }}

Then in our document, we refer to the sections as follows::

    {{ d['code/getting-started/' + ex + '/doc.html'] | indent(4) }}

{% if ext == '.html' %}

.. raw:: html

    <iframe style="width: 100%; height: 300px; border: thin solid gray;" src="code/getting-started/{{ ex }}/output/doc.html"></iframe>

{% endif %}

{% set ex = "d12" -%}

By default, the `idio` filter will apply HTML syntax highlighting to the
sections. So, you can include the output directly in HTML documents. To prevent
`idio` from adding HTML formatting, add the `t` filter after it. The `t` filter
will only accept input files that end with the `.txt` extension, so this forces
`idio` to generate plain text output::

    {{ d['code/getting-started/' + ex + '/dexy.yaml'] | indent(4) }}

Now we have to wrap the sections in <pre> tags::

    {{ d['code/getting-started/' + ex + '/doc.html'] | indent(4) }}

{% if ext == '.html' %}

.. raw:: html

    <iframe style="width: 100%; height: 300px; border: thin solid gray;" src="code/getting-started/{{ ex }}/output/doc.html"></iframe>

{% endif %}

Running Sectioned Code
----------------------

{% set ex = "d13" -%}

The `pycon` filter used in this section is not available for Windows. If you are using Windows to run dexy then the example described in this section will not work.

Splitting code into sections is really useful when we can pass this code through an interpreter, such as the `pycon` filter, and keep the sections. Here is the `dexy.yaml`::

    {{ d['code/getting-started/' + ex + '/dexy.yaml'] | indent(4) }}

We pass our python script through 3 filters. First, the `idio` filter will
split the code into sections. Second, the `pycon` filter will run the code
through the python interpreter (the `pycon` filter accepts files ending in
`.py` or `.txt` extensions, so this forces the `idio` filter to output plain
text). Finally, the `pyg` filter will apply syntax highlighting to the output
from the python interpreter.

Our `doc.html` looks like::

    {{ d['code/getting-started/' + ex + '/doc.html'] | indent(4) }}

{% if ext == '.html' %}

.. raw:: html

    <iframe style="width: 100%; height: 300px; border: thin solid gray;" src="code/getting-started/{{ ex }}/output/doc.html"></iframe>

{% endif %}

Using Markup Languages
----------------------

{% set ex = "d14" -%}

The next thing we want to be able to do is to generate HTML without having to
type all of the HTML tags ourselves. There are several lightweight markup
languages commonly in use, such as `Markdown <http://daringfireball.net/projects/markdown/>`__,
`reStructuredText <http://docutils.sourceforge.net/rst.html>`__,
`Wiki markup <http://en.wikipedia.org/wiki/Help:Wiki_markup>`__ (various flavors),
and `AsciiDoc <http://www.methods.co.nz/asciidoc/>`__.

The examples that follow will use reStructuredText since dexy already comes
with the software needed to generate various output formats from rst files.

Here is the `dexy.yaml`::

    {{ d['code/getting-started/' + ex + '/dexy.yaml'] | indent(4) }}

The `rst` filter takes rst and converts it into one of reStructuredText's
output formats. By default it will output self-contained HTML documents, which
is what we want.

Create a file named `doc.rst` with these contents::

    {{ d['code/getting-started/' + ex + '/doc.rst'] | indent(4) }}

If you aren't familiar with reStructuredText, you can work through the `quickstart <http://docutils.sourceforge.net/docs/user/rst/quickstart.html>`__ and then refer to the `quickref <http://docutils.sourceforge.net/docs/user/rst/quickref.html>`__. For more advanced usage, the `markup specification <http://docutils.sourceforge.net/docs/ref/rst/restructuredtext.html>`__ describes the language in detail and the `directives reference <http://docutils.sourceforge.net/docs/ref/rst/directives.html>`__ describes various directives you can include in reStructuredText documents such as `.. image:: <http://docutils.sourceforge.net/docs/ref/rst/directives.html#images>`__ and `..table:: <http://docutils.sourceforge.net/docs/ref/rst/directives.html#tables>`__.

In this example, we create two `sections <http://docutils.sourceforge.net/docs/user/rst/quickstart.html#sections>`__ by underlining the section names with hyphens. To indicate that our code samples and the generated output is preformatted, we `end the preceding paragraphs with :: <http://docutils.sourceforge.net/docs/user/rst/quickstart.html#preformatting-code-samples>`__. We have indented the jinja tags by 4 spaces, but after jinja inserts its contents, only the first line will be properly indented. Fortunately, jinja comes with an `indent <http://jinja.pocoo.org/docs/templates/#indent>`__ filter, and we indicate that we want text indented by 4 spaces (this is the default, so it could be omitted). By default, jinja's indent filter assumes you have indented the first line manually, as we have here, so it won't end up being double-indented.

{% if ext == '.html' %}

Here is what the resulting `doc.html` file looks like:

.. raw:: html

    <iframe style="width: 100%; height: 300px; border: thin solid gray;" src="code/getting-started/{{ ex }}/output/doc.html"></iframe>

{% endif %}

Syntax Highlighting: Using RST Directives
-----------------------------------------

{% set ex = "d15" -%}

In the previous section, we simply indicated that our code samples were
preformatted, so they appeared in a fixed-width font. Now we want to add
syntax highlighting. There are a few ways to apply syntax highlighting and they
have different implications, so there will be a few sections about this topic.

In this example, we will use reStructuredText's built-in syntax highlighting.
The `.. code:: <http://docutils.sourceforge.net/docs/ref/rst/directives.html#code>`__
directive tells reStructuredText to apply syntax highlighting to the subsequent
indented block of text.

We only need to modify the `doc.rst` document. Now we end the preceding
paragraphs with just a single `:` instead of two, and we add the `.. code::`
directive, specifying that the language to be used is python. We do not need to
change the contents of our jinja tags::

    {{ d['code/getting-started/' + ex + '/doc.rst'] | indent(4) }}

{% if ext == '.html' %}

Here is what the resulting `doc.html` file looks like:

.. raw:: html

    <iframe style="width: 100%; height: 300px; border: thin solid gray;" src="code/getting-started/{{ ex }}/output/doc.html"></iframe>

{% endif %}

Customizing Builtin Highlighting
--------------------------------

{% set ex = "d16" -%}

reStructuredText allows you to customize the behavior of a `directive
<http://docutils.sourceforge.net/docs/ref/rst/restructuredtext.html#directives>`__
(like `.. code::`) by specifying *directive options*. Directive options take
the form of `field lists <http://docutils.sourceforge.net/docs/ref/rst/restructuredtext.html#field-lists>`__.

Here is the `doc.rst` file with the `number-lines
<http://docutils.sourceforge.net/docs/ref/rst/directives.html#code>`__
directive option specified for the first python code block::

    {{ d['code/getting-started/' + ex + '/doc.rst'] | indent(4) }}

We are using reStructuredText's default HTML template which includes a
stylesheet for the syntax highlighting. Unfortunately there is no configuration
option which allows you to quickly specify a different pygments style, you need
to specify a completely different template. This can be specified by passing
configuration options to reStructuredText, however we will see shortly how to
use a custom HTML template using dexy which will be easier.

Here is how to pass configuration options to reStructuredText::

    {{ d['code/getting-started/' + ex + '/dexy.yaml'] | indent(4) }}

You can use hyphenated or underscore syntax, so initial-header-level and
initial_header_level will both work. You can see all the available
configuration options by running `rst2html.py --help` or viewing the
`configuration documentation <http://docutils.sourceforge.net/docs/user/config.html>`__.

{% if ext == '.html' %}

Here is what the resulting `doc.html` file looks like, with line numbers
enabled on the first code example and with the custom configuration options:

.. raw:: html

    <iframe style="width: 100%; height: 300px; border: thin solid gray;" src="code/getting-started/{{ ex }}/output/doc.html"></iframe>

{% endif %}

Typing Less with Macros
-----------------------

Let's look again at our reStructuredText document from the previous section::

    {{ d['code/getting-started/d16/doc.rst'] | indent(4) }}

{% set ex = "d17" -%}

While the reStructuredText code directive syntax is pretty concise, it's still
a lot of extra typing, especially if we have a long document.  Dexy is all
about automation, so let's see if we can shorten the amount of text needed to
include a block of source code.

We are using the `jinja` templating system to incorporate content into our
reStructuredText documents. Jinja supports defining custom `macros
<http://jinja.pocoo.org/docs/templates/#macros>`__, so we will use a macro to
help simplify creating blocks of code.

Create a new file named `rst.jinja` with contents::

    {{ d['code/getting-started/' + ex + '/rst.jinja'] | indent(4) }}

reStructuredText is very fussy about whitespace, so when writing a macro to
generate a directive you may have to do some fiddling to get the whitespace
right. A good way to do this is to just run the `jinja` filter and not the
`rst` filter until you have generated the correct syntax. See the section in
the jinja template documentation about `whitespace control
<http://jinja.pocoo.org/docs/templates/#whitespace-control>`__ for more
information.

To use the macro, we need to import it into our document template before the first usage::

    {{ d['code/getting-started/' + ex + '/doc.rst'] | indent(4) }}

We no longer need to do any indenting in our document since this is handled in
the macro. We just call the name of the macro and pass in the document key and
section name, and optional keyword arguments if we want to change the language
or whether lines are numbered.

The jinja filter in dexy automatically makes any macro definition files
available to your documents, you just need to use the correct relative path
from your document to the macro file. In this case `rst.jinja` is in the same
directory as `doc.rst`.

{% if ext == '.html' %}

Here is what the resulting `doc.html` file looks like:

.. raw:: html

    <iframe style="width: 100%; height: 300px; border: thin solid gray;" src="code/getting-started/{{ ex }}/output/doc.html"></iframe>

{% endif %}

Generating Multiple Output Formats
----------------------------------

{% set ex = "d18" -%}

We have seen how we can generate HTML from reStructuredText source, but
reStructuredText supports several other output formats too, and we can use dexy
to generate all of these simultaneously.

Here is a `dexy.yaml` file which specifies that we want `doc.rst` converted to
HTML, to PDF (via LaTeX), and to ODT (word processor) format::

    {{ d['code/getting-started/' + ex + '/dexy.yaml'] | indent(4) }}

{% if ext == '.html' %}

Here are links to the resulting `PDF <code/getting-started/{{ ex }}/output/doc.pdf>`__ and `ODT <code/getting-started/{{ ex }}/output/doc.odt>`__ files. Here is what the resulting `doc.html` file looks like:

.. raw:: html

    <iframe style="width: 100%; height: 300px; border: thin solid gray;" src="code/getting-started/{{ ex }}/output/doc.html"></iframe>

{% endif %}

{% if False -%}
Using Custom reStructuredText Templates
---------------------------------------

To be developed.

{% endif -%}

Syntax Highlighting: Using Dexy
-------------------------------

{% set ex = "d19" -%}

In the last few sections we have used reStructuredText's directives for
applying syntax highlighting to code blocks. We've also been using
reStructuredText's default HTML template. In this section we'll use a different
approach where we'll do the syntax highlighting in dexy, and we'll use dexy to
apply a template to the HTML. Either approach works, they each have pros and
cons. It's common in dexy for there to be several ways to accomplish a given
goal.

Here is the `dexy.yaml` we will use::

    {{ d['code/getting-started/' + ex + '/dexy.yaml'] | indent(4) }}

We are now using a different filter, `rstbody` instead of `rst`. The `rstbody`
filter does not apply a template, it just returns the body text converted to
the desired output format, by default HTML. Then we use the `easyhtml` filter
we've already seen to apply a template.

We will use the `idio` filter to split the python code into sections and syntax
highlight them. Now we need to tell reStructuredText that we will be including
chunks of HTML-formatted code which should be left alone. To do this we will
use the `raw` directive::

    {{ d['code/getting-started/' + ex + '/doc.rst'] | indent(4) }}

{% if ext == '.html' %}

Here is what the resulting `doc.html` file looks like:

.. raw:: html

    <iframe style="width: 100%; height: 300px; border: thin solid gray;" src="code/getting-started/{{ ex }}/output/doc.html"></iframe>

{% endif %}

Macros Again
------------

{% set ex = "d20" -%}

Once again, we can use a macro to simplify this. This time we'll call the macro
`codes` which you can think of as standing for 'code - sectioned'.

Here is the `rst.jinja`::

    {{ d['code/getting-started/' + ex + '/rst.jinja'] | indent(4) }}

And here is the `doc.rst`::

    {{ d['code/getting-started/' + ex + '/doc.rst'] | indent(4) }}

{% if ext == '.html' %}

Here is what the resulting `doc.html` file looks like:

.. raw:: html

    <iframe style="width: 100%; height: 300px; border: thin solid gray;" src="code/getting-started/{{ ex }}/output/doc.html"></iframe>

{% endif %}

Generalizing Beyond HTML
------------------------

{% set ex = "d21" -%}

As you may have noticed, by including raw HTML markup we have made it
impossible to convert the reStructuredText to any format besides HTML. You
can't generate LaTeX with a bunch of `<span>` tags in the middle of it and
expect it to compile. Fortunately, we have a very nice way around this, which
is to use macros not just to shorten what we have to type, but to be smart
about what format to insert.

These macros are actually built into dexy, so you don't need to have an
`rst.jinja` file of your own (although you can write one if you want to
customize the behavior of the macros).

Here is the `dexy.yaml` we start with, we want to tell dexy to generate both
HTML and LaTeX formatted syntax highlighting::

    {{ d['code/getting-started/' + ex + '/dexy.yaml'] | indent(4) }}

Here is our `doc.rst` file. We start by importing the `codes` macro from `dexy.jinja` which is a macro file which ships with dexy::

    {{ d['code/getting-started/' + ex + '/doc.rst'] | indent(4) }}

Notice that we pass `script.py|idio` as the first argument to `codes`. The
macro will look at the final output format of the document and insert contents
from either `script.py|idio|h` or `script.py|idio|l` as required.

{% if ext == '.html' %}

Here is the resulting `PDF <code/getting-started/d21/output/doc.pdf>`__. Here is what the resulting `doc.html` file looks like:

.. raw:: html

    <iframe style="width: 100%; height: 300px; border: thin solid gray;" src="code/getting-started/{{ ex }}/output/doc.html"></iframe>

{% endif %}

{% if False -%}
Writing Custom Templates
------------------------

Writing _template.html files to customize page templates.

To be developed.
{% endif %}
