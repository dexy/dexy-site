Getting Started
===============

{% from "dexy.jinja" import code, codes, ext with context %}

This section is designed to gently introduce you to Dexy by working through several progressive examples. If you are impatient, then try out the Quickstart sections instead. These examples are written in Python because everyone using Dexy will have Python installed on their system, and Python is an easy, accessible language to understand. However, Dexy supports many other programming languages and it's easy to add support for new languages, so please don't feel left out if Python is not your preferred language.

As a reminder, if you aren't already familiar with using the command line, then you should work through a course like Zed Shaw's `Command Line Crash Course <http://cli.learncodethehardway.org/>`_ before you start with these examples.

.. contents:: :local:

Simple Dexy Example
-------------------

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

Getting Dexy to Run Code
------------------------

Next, we will get dexy to evaluate a simple python script. In the same directory where you've been working, create a new file named `hello.py` and put the following in it::

    {{ d['code/getting-started/d01/hello.py'] | indent(4) }}

Your project directory should look like this now:

{{ codes('code/getting-started/run-01.sh|idio|shint|pyg', 'ls') }}

Run this script from the command line to make sure that it works, you should see the script print out the results of the calculation:

{{ codes('code/getting-started/run-01.sh|idio|shint|pyg', 'run-script-manually') }}

Now modify your `dexy.txt` file so that it looks like this::

    {{ d['code/getting-started/d01/dexy.txt'] | indent(4) }}

This means we want the file named `hello.py` to be run through the `py` filter, and we want the file named `hello.txt` to be run through the `jinja` filter. The order of these lines is important because we want `hello.py` to be run first, so that it is available to `hello.txt|jinja`.

Now you can call dexy again:

{{ codes('code/getting-started/run-01.sh|idio|shint|pyg', 'run') }}

In the `output-long/` directory, there should now be a file containing the output of running the Python script:

{{ codes('code/getting-started/run-01.sh|idio|shint|pyg', 'cat') }}

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
* Remove one of the curly brackets `{` from the `hello.txt` file and try to run dexy again. You should get an error message because the jinja processor can't parse the file. Fix the file and make sure dexy runs with no more errors.

Behind the Scenes
-----------------

Let's briefly take a look at what dexy is doing before we go on to more examples.

After running dexy, your working directory should look like something like this:

{{ codes('code/getting-started/run-02.sh|idio|shint|pyg', 'ls') }}

When we ran `dexy setup`, dexy created some extra directories called `.cache`
and `logs`. The cache directory contains the cache dexy uses to store results,
and also working directories for the filters that need to run commands on
files. The logs directory contains the main dexy log file `logs/dexy.log` and
also reports about the dexy run. Dexy writes the output it generates to
directories called `output/` and `output-long/`. The names of these directories
and the reports which are output are configurable using the command line
interface.

Dexy generates a run report which shows you the documents you have created and
the results of all the different steps of filter processing. This report will
help you understand how dexy is working. You can open the file
`logs/run-latest/index.html` in your browser. If you leave this page open, you
can just refresh it after each dexy run.

Processing Multiple Scripts
---------------------------

Next we're going to add a second python script and make a change to the way we write config files.

Change your `dexy.txt` file so that it looks like this::

    {{ d['code/getting-started/d03/dexy.txt'] | indent(4) }}

We have replaced the file name `hello.py` with a wildcard expression which will match any file ending in `.py`. After making this change, run dexy and make sure everything still works.

Next create a new file named `loop.py` and put the following into it::

    {{ d['code/getting-started/d03/loop.py'] | indent(4) }}

And then modify your `hello.txt` file to look like this::

    {{ d['code/getting-started/d03/hello.txt'] | indent(4) }}

Then after you have run dexy, the contents of `output/hello.txt` should look like this:

{{ codes('code/getting-started/run-03.sh|idio|shint|pyg', 'cat') }}

YAML Configuration Files
------------------------

Up to now we have been creating files named `dexy.txt` and listing a few
documents in each file to tell dexy what to do. This was a simple way to get
started, but it has limitations. Now we want to start using a YAML-based
configuration file format. `YAML <http://en.wikipedia.org/wiki/YAML>`_ is a
relatively sane and human-friendly format.

Delete your `dexy.txt` file and create a new file `dexy.yaml` with contents::

    {{ d['code/getting-started/d04/dexy.yaml'] | indent(4) }}

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

Now we will start creating HTML documents instead of just plain text, and we'll
also learn about some of the other filters we can use to run python code.

Create a new working directory. Let's start by writing a short Python script
called `script.py`::

    {{ d['code/getting-started/d05/script.py'] | indent(4) }}

And also create a simple HTML file named `doc.html` which includes the source
of the python file::

    {{ d['code/getting-started/d05/doc.html'] | indent(4) }}

Here is the `dexy.yaml` configuration::

    {{ d['code/getting-started/d05/dexy.yaml'] | indent(4) }}

Your working directory should look like this:

{{ codes('code/getting-started/run-05.sh|idio|shint|pyg', 'ls') }}

Because this is a new project, we need to call `dexy setup` once before we call dexy:

{{ codes('code/getting-started/run-05.sh|idio|shint|pyg', 'run') }}

The generated HTML should be:

{{ codes('code/getting-started/run-05.sh|idio|shint|pyg', 'cat') }}

{% if ext == '.html' %}
If you open the file in a browser, it will look like:

.. raw:: html

    <iframe style="width: 300px; height: 200px; border: thin solid gray;" src="code/getting-started/d05/output/doc.html"></iframe>

{% endif %}

Syntax Highlighting
-------------------

Now that we're using HTML, let's make this output a little more colorful by applying syntax highlighting to our source code. Here's how you include this in your HTML::

    {{ d['code/getting-started/d06/doc.html'] | indent(4) }}

In the header of the file, we are inserting style definitions into a `text/css` style block. The 'pygments' object we use is a dict which contains CSS (and also LaTeX) stylesheets in various styles. Just pass the name of the style with the appropriate file extension to include it in your HTML header. Also make sure to add the `|pyg` after `script.py` in the body of the html document.

Next, change the `dexy.yaml` file to look like::

    {{ d['code/getting-started/d06/dexy.yaml'] | indent(4) }}

After you run this example, open the file in a web browser, you should see the source code colorized.

{% if ext == '.html' %}

.. raw:: html

    <iframe style="width: 300px; height: 200px; border: thin solid gray;" src="code/getting-started/d06/output/doc.html"></iframe>

{% endif %}

{% if False -%}
- Read the documentation for the [pyg filter](/docs/filters/pyg)
- Read the documentation for [pygments](http://pygments.org/docs/)
- Redo this example so the CSS is in a separate stylesheet instead of in the document header.
- Generate a stylesheet using the pygmentize command line tool and redo this example so that dexy copies this CSS file to the output/ directory for you (hint: add a wildcard entry for `.css` to the `dexy.yaml` file).
- Redo this example so that dexy generates a separate CSS file in the output/ directory for you (hint: pass an empty file with .css extension through the pyg filter, see the documentation for the pyg filter for exactly how to do this).
{% endif %}

Next we want to run the python code. Add a line to the `dexy.yaml` file::

    {{ d['code/getting-started/d07/dexy.yaml'] | indent(4) }}

And update the html file::

    {{ d['code/getting-started/d07/doc.html'] | indent(4) }}

{% if ext == '.html' %}

.. raw:: html

    <iframe style="width: 100%; height: 300px; border: thin solid gray;" src="code/getting-started/d07/output/doc.html"></iframe>

{% endif %}

Passing Custom Options
----------------------

Now let's pass a custom option to the pyg filter::

    {{ d['code/getting-started/d08/dexy.yaml'] | indent(4) }}

To pass custom options to a filter, add an indented line beneath the document and start with the filter alias, followed by a colon, then the dict of options. The filter documentation should tell you what available options are.

There is no need to make any change to the HTML file. After running dexy you should see line numbers appear in the generated `doc.html`.

{% if ext == '.html' %}

.. raw:: html

    <iframe style="width: 100%; height: 300px; border: thin solid gray;" src="code/getting-started/d08/output/doc.html"></iframe>

{% endif %}

Next, look at the documentation for the `pygments HtmlFormatter <http://pygments.org/docs/formatters#htmlformatter>`_ and try out some of the other options.

Applying a HTML Template
------------------------

In the last few examples we have been writing complete HTML documents by hand,
but typing `<head>` tags all the time gets old fast. So, now let's use another
dexy filter to help us.

We will use the `easyhtml` filter in dexy to apply a basic stylesheet including
pygments CSS to our document. The `dexy.yaml` file should look like this::

    {{ d['code/getting-started/d09/dexy.yaml'] | indent(4) }}

Remove everything from the doc.html file except the contents of the <body>
tags, it should look like this now::

    {{ d['code/getting-started/d09/doc.html'] | indent(4) }}

Now we are applying multiple filters to the `doc.html` file. First, we run the
jinja filter. Second, we run the `easyhtml` filter which adds a header and
footer to our document, making it a complete HTML document.

{% if ext == '.html' %}

.. raw:: html

    <iframe style="width: 100%; height: 300px; border: thin solid gray;" src="code/getting-started/d09/output/doc.html"></iframe>

{% endif %}

Python Console Output
---------------------

The `pycon` filter used in this section is not available for Windows. If you
are using Windows to run dexy then the example described in this section will
not work.

Now, let's change this example so that instead of showing the code and,
separately, showing the output, we just show a console transcript. The
`dexy.yaml` file should look like::

    {{ d['code/getting-started/d10/dexy.yaml'] | indent(4) }}

The `pycon` dexy filter runs python code in the python REPL, so you see the
prompts, input and output from running each line of code. We can pass this REPL
transcript to pygments which knows how to syntax highlight console output.

Update the html file as follows::

    {{ d['code/getting-started/d10/doc.html'] | indent(4) }}

{% if ext == '.html' %}

.. raw:: html

    <iframe style="width: 100%; height: 300px; border: thin solid gray;" src="code/getting-started/d10/output/doc.html"></iframe>

{% endif %}

Splitting Code into Sections
----------------------------

Up until now we have been running whole python scripts. However, we don't want to always have to include whole scripts in our documents. Dexy is designed to allow you to split your code into sections and then preserve these sections in subsequent filters.

The `idio` filter will interpret special comments in your source code and split your script into sections accordingly. Create a new working directory and create a file named `script.py` which should look like this::

    {{ d['code/getting-started/d11/script.py'] | indent(4) }}

These comments follow a special format of three comment characters, the python comment character being #, followed by the `@export` command, and then the name of the section in quotes. We have defined two sections, the first named `assign-variables` and the second named `multiply`.

Here is the `dexy.yaml` file which tells dexy to run all files with `.py` extension through the `idio` filter::

    {{ d['code/getting-started/d11/dexy.yaml'] | indent(4) }}

Then in our document, we refer to the sections as follows::

    {{ d['code/getting-started/d11/doc.html'] | indent(4) }}

{% if ext == '.html' %}

.. raw:: html

    <iframe style="width: 100%; height: 300px; border: thin solid gray;" src="code/getting-started/d11/output/doc.html"></iframe>

{% endif %}

By default, the `idio` filter will apply HTML syntax highlighting to the sections. So, you can include the output directly in HTML documents. To prevent `idio` from adding HTML formatting, add the `t` filter after it. The `t` filter will only accept input files that end with the `.txt` extension, so this forces `idio` to generate plain text output::

    {{ d['code/getting-started/d12/dexy.yaml'] | indent(4) }}

Now we have to wrap the sections in <pre> tags::

    {{ d['code/getting-started/d12/doc.html'] | indent(4) }}

{% if ext == '.html' %}

.. raw:: html

    <iframe style="width: 100%; height: 300px; border: thin solid gray;" src="code/getting-started/d12/output/doc.html"></iframe>

{% endif %}

Running Sectioned Code
----------------------

The `pycon` filter used in this section is not available for Windows. If you are using Windows to run dexy then the example described in this section will not work.

Splitting code into sections is really useful when we can pass this code through an interpreter, such as the `pycon` filter, and keep the sections. Here is the `dexy.yaml`::

    {{ d['code/getting-started/d13/dexy.yaml'] | indent(4) }}

We pass our python script through 3 filters. First, the `idio` filter will split the code into sections. Second, the `pycon` filter will run the code through the python interpreter (the `pycon` filter accepts files ending in `.py` or `.txt` extensions, so this forces the `idio` filter to output plain text). Finally, the `pyg` filter will apply syntax highlighting to the output from the python interpreter.

Our `doc.html` looks like::

    {{ d['code/getting-started/d13/doc.html'] | indent(4) }}

{% if ext == '.html' %}

.. raw:: html

    <iframe style="width: 100%; height: 300px; border: thin solid gray;" src="code/getting-started/d13/output/doc.html"></iframe>

{% endif %}
