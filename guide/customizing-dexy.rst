Customizing Dexy
================

{% from "dexy.jinja" import hl, code, codes with context %}

.. contents:: Contents
    :local:

Plugin System
-------------

Dexy's filters, reporters and other elements can be customized by writing plugins.

Registering Plugins
...................

Dexy needs to know about your plugin in order for it to be available. Your
plugin needs to be written in a python file or be installed as part of a python
package, and then dexy needs to know where your plugin is.

dexyplugin.py
^^^^^^^^^^^^^

If you create a file named `dexyplugin.py` at the root of your dexy project,
dexy will automatically load any plugins it finds in that file.



Filters
-------

Writing custom filters.


Reporters
---------

Writing custom reporters.

Templates
---------

Templates are a way to share examples of using dexy.

You can use templates to give yourself a starting point for a project, or to
allow people to easily use your work as a jumping-off point for their own.

Writing a Template
..................

[to be developed] How to write a generic template.

Filter Examples
...............

Here is the command-line help for dexy's `cowsay` filter:

{{ codes('code/cli/filters.sh|idio|shint|pyg', 'cowsay filter') }}

The same examples from the command line help are also included on `cowsay's
page <http://www.dexy.it/filters/Cowsay.html#cowsay-examples>`__ on the dexy
website.

The example is implemented as a template,
`here <https://github.com/ananelson/dexy-filter-examples/tree/master/dexy_filter_examples/cowsay-template>`__
is the source of the cowsay template in github. Filter templates follow some
conventions to make them easy to use to generate HTML help or command line
help. Filters then specify which templates should be used to act as their
examples.

The help text itself is written in a file named `dexy.rst` and this file should
*not* be specified in the `dexy.yaml`. Here is the `dexy.rst` file for the cowsay filter::

    {{ d['code/customizing-dexy/cowsay/dexy.rst'] | indent(4) }}

The `dexy.rst` file should start with a descriptive heading using hyphens as the delimiter.

And here is the `dexy.yaml`. Note that all entries need to be part of a `filters` bundle::

    {{ d['code/customizing-dexy/cowsay/dexy.yaml'] | indent(4) }}

The `dexy` method in the Template class will run dexy on the template contents
in a temporary directory, applying some standard filters to the `dexy.rst` file:

{{ hl(d['/modules.txt|pydoc']['dexy.template.Template.dexy:source'], 'python') }}

This happens when the dexy website is generated for the pages on the website,
and it happens on your local system when you run examples via command line
help.

