title: What is Dexy?
description: A short, minimally technical introduction to Dexy, how it works, and what it can do.
---
[TOC]

## What is Dexy?

{% macro callout(category) %}
{% if category == 'example' %}
{% set icon_name = "cogs" -%}
{% elif category == 'programmer' %}
{% set icon_name = "linux" -%}
{% else %}
{% set icon_name = "ambulance" %}
{% endif %}

<div class="admonitionblock">
<table>
  <tr>
    <td class="icon">
    <icon class="icon-{{ icon_name }}" title="{{ titleize(category) }}" />
    </td>
    <td class="content">

    {{ markdown(caller()) }}

    </td>
  </tr>
</table>
</div>
{% endmacro -%}

{% macro note() %}
<div class="note">
{{ caller() }}
</div>
{% endmacro -%}

Dexy is a multi-purpose project automation tool with lots of features designed
for working with documents. Dexy is written in Python and has a command-line
interface. It's open source software with an MIT license.

## What does Dexy do?

Dexy makes it easier to create technical documents by doing the repetitive
parts for you. Dexy provides a consistent interface to tools and scripts so you
don't have to run them manually. Your project's dexy configuration keeps track
of what to run, in which order, and with what parameters. This way, your whole
process is captured so anyone can run it using one simple command and the
results will be consistent.

{% call callout("example") %}
You want to write a blog post with examples showing how to use an API. Dexy will automatically:

- run your example code, saving the results
- apply syntax highlighting to your example code (using [pygments](http://pygments.org/))
- insert the results of API calls and your prettified example code into your post (using [jinja](http://jinja.pocoo.org/))
- convert your markdown-formatted blog post to HTML (using [python markdown](http://pythonhosted.org/Markdown/) or [pandoc](http://johnmacfarlane.net/pandoc/)).
- upload the HTML to the WordPress API in draft mode (using the [WordPress API](http://codex.wordpress.org/XML-RPC_WordPress_API))
- publish your blog post when you are finished tweaking it

{% endcall %}

## How does dexy run tools and scripts?

Dexy uses the idea of filters. A filter accepts some input, changes it somehow,
and emits some output. Filters are what do all the work in dexy.

{% call callout("example") %}
- The `markdown` filter takes markdown as input, and emits HTML as output. This filter wraps the python markdown library.
- The `java` filter takes java source code as input, and emits text as output (whatever was printed to STDOUT by running the java code, if anything). This filter wraps the `javac` and `java` command line tools.
- The `wordpress` filter takes HTML as input, and emits information about the generated blog post as output (in JSON format). This filter wraps the WordPress API.
{% endcall %}

When you write a dexy configuration file for your project, you tell dexy which filters to apply to which source files. When dexy runs, it looks for each source file and then applies each of the filters you specify.

{% call callout("example") %}
- If you write "index.md|markdown" in your dexy configuration file, dexy will apply the `markdown` filter to any files named `index.md`.
- If you write ".java|java" in your dexy configuration file, dexy will apply the `java` filter to all files in your project with extension `.java`.
- If you write "posts/2013/09/blog-post-about-dexy.html|wordpress" in your dexy configuration file, dexy will apply the `wordpress` filter to the file posts/2013/09/blog-post-about-dexy.html.
{% endcall %}

You can specify multiple filters, and each one will run in sequence, taking the previous filter's output as its input.

{% call callout("example") %}
- If you write "posts/*.md|markdown|wordpress" in your dexy configuration file, dexy will first apply the `markdown` filter to convert your blog posts to HTML, then apply the `wordpress` filter to publish each blog post.
{% endcall %}

Filters can be written in Python or other languages. To write filters in other
languages, you need to create an executable script. Dexy has a plugin system so
it's easy to write your own filters and add them to dexy.

You can also run scripts using dexy, by passing the script files through a
filter which executes them in the correct interpreter.

{% call callout("example") %}
There are several filters which run Python code in dexy.

- The `py` filter runs python code and returns STDOUT.
- The `pycon` filter runs python code in the python REPL and returns a full transcript with prompts.
{% endcall %}

Scripts can interact with other files in your project. They can open files to
read data, and generate new files which then become part of the project.

{% call callout("example") %}
You want to use R make a graph of some data which is in a CSV file. To implement this in dexy, you could:

- create a script named example.R which opens data.csv and generates plot.png
- specify the csv file as an input to `example.R|r`
- run dexy

After running dexy, `plot.png` will be included in the dexy output along with all the other generated files.
{% endcall %}

## How does dexy help you write technical documents?

When you want a document to include a few lines of code, or an image generated by an R script, or the result of a calculation based on data from your API, you do this by including a reference to the location of that information.

Dexy provides a standard way to refer to locations within your project. Each document has a `key` which is just the source file's filepath plus any filters which have been applied. You can refer to an entire document by referencing its key, or you can refer to just part of a document by referencing the name of a section in that document.

{% call callout("example") %}
- `d["script.R|r"]` refers to the whole document created by running the "script.R" source file through the "r" filter.
- `d["script.R|idio|r"]["foo"]` refers to a section named "foo" in the document created by running the "script.R" source file through the "idio" filter and then the "r" filter.
{% endcall %}

The `d` in these expressions refers to a dictionary or key-value map which contains references to each of the document's dependencies. These dependencies have already been processed (this is discussed in the next section), you are just telling dexy's template engine where to pull information from.

Dexy populates the `d` object as part of the `jinja` filter (several other templating systems are also available and they have access to the same `d` object). When you want to write a document which includes content from other documents, you apply the `jinja` filter to the source of this document. Jinja uses curly brackets to denote template content, so in your document you write expressions like {{ "`{{ d[\"script.R|r\"] }}`" }} and when the `d` expression is evaluated, it inserts the content from that source at that point in your document.

If you change the source of `script.R` and run dexy again, dexy inserts the most up-to-date version of `script.R|r` in every location which references it. This is how dexy makes it possible to always refresh your documents to refer to up to date versions of code.

There are some fancier features available too, like custom data types which let you call functions on the content from source files.

{% call callout("example") %}
Dexy's `data` class and custom subclasses let you transform or query the output from other documents in many ways. Here are just a few examples:

- Run a sql query against a sqlite3 input file (which may have been generated by a dexy filter).
- Access pytables queries to query an HDF5 data file.
- Parse JSON data into a Python object.
- Access content identified by a CSS selector expression in an HTML file using Beautiful Soup.

{% endcall %}
