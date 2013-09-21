Customizing Dexy
================

{% from "dexy.jinja" import hl, code, codes with context %}

.. contents:: Contents
    :local:

Introduction
------------

API documentation for writing dexy plugins. Many aspects of dexy can be
customized by writing plugins, which you can implement as local python files or
as python packages installed on your system. Dexy's filters, reporters, project
templates, template plugins, data objects, storage objects are all plugin-able.

Hello, World Plugin
...................

Let's look at a minimal dexy plugin to get familiar with the basic parts. This
plugin will be a custom filter.

{% set pluginfile = "dexyplugin.py" -%}

Create a file named `{{ pluginfile }}` with contents:

{% set template_dir = "code/customizing-dexy/cd-hello-world-filter/" -%}
{% set plugin_idio_file = template_dir + pluginfile + "|" + "idio" -%}

::

    {{ d[plugin_idio_file + "|" + "t"] | indent(4) }}


The important elements are:

1) Use the magic filename `dexyplugin.py` in the root of a dexy project. There are other ways to get dexy to recognize your plugins, but this is the simplest. See the `Installing Plugins`_ section for more details.

2) Subclass a pluginable class, in this case the `DexyFilter` class:

{{ codes(plugin_idio_file, "subclass") }}

The class name doesn't matter, it just needs to be unique.

3) Write a docstring, they are mandatory and will be displayed to end users:

{{ codes(plugin_idio_file, "docstring") }}

4) Define an `aliases` list, these are how you will refer to this plugin:

{{ codes(plugin_idio_file, "aliases") }}

Aliases should be unique. If two different plugins have the same alias then the one which is loaded later will override the former. [TODO ASSERT]

5) Define a `_settings` dictionary: 

{{ codes(plugin_idio_file, "settings") }}

This is optional. If you don't have any custom settings to set then you can leave this out or use an empty dictionary as a placeholder.

6) Define the method which does the work of the plugin. For filters, this means implementing a `process` method or the `process_text` convenience method:

{{ codes(plugin_idio_file, "process-text") }}

Sometimes you can customize a plugin just by changing values in the `_settings` dictionary and you won't need to write a custom method like `process_text`.

To run this example, create a `dexy.yaml` file like this:

{{ code(template_dir + "dexy.yaml|idio") }}

We are applying the filter with alias `custom` to the file `hello.txt`. Here are the contents of `hello.txt`::

    {{ d[template_dir + "hello.txt"] | indent(4) }}

And here is the resulting output::

    {{ d[template_dir + "output/hello.txt"] | indent(4) }}

This shows up in the `output/` directory because we have set `output` equal to `True` in the settings dictionary.

YAML-Based Plugins
..................

Some plugins don't require any custom python code, they can be configured just by changing values of settings. For example, the `SubprocessStdoutFilter` is generic enough to support interpreters for dozens of programming languages without having to write any custom python code for the majority of them. Instead we just need to configure settings like the executable which should be called and which file extensions should be accepted as input.

Many of dexy's filters are implemented in this way, you can see them in `dexy/filters/filters.yaml <https://github.com/ananelson/dexy/blob/develop/dexy/filters/filters.yaml>`__. You can define your own such filters in a file named `dexyplugin.yaml`. See the section `Configuring Filters Using YAML` [TODO link] in configuring-dexy.html for more information about this.

Common Plugin Features
----------------------

This section covers features which are common to all types of plugins.

Aliases and Instances
.....................

Each plugin needs to define a list of aliases, which is how we will refer to that plugin later. This makes it easier to choose and change class names without having any impact on end users, and it allows us to define plugins without necessarily having to write a subclass.

Each pluginable class has a `create_instance` class method which generates a new instance of the plugin corresponding to the provided alias. This method should always be used to create a new instance of any plugin-based class since it sets up some other standard plugin features such as Settings (as described in `Settings`_ section below).

{{ hl(d['/modules.txt|pydoc']['dexy.plugin.PluginMeta.create_instance:source'], 'python') }}

Settings
........

Settings are designed to be a standard, self-documenting way of configuring plugins.

{% set dexy_filter_settings =  json.loads(d['/modules.txt|pydoc']['dexy.filter.DexyFilter._settings:value']) -%}

Here are a few entries from the `_settings` dictionary for the `DexyFilter` base class::
{% for k in sorted(dexy_filter_settings)[0:5] %}
    {{ json.dumps(k) }}: {{ json.dumps(dexy_filter_settings[k]) | indent(4) }}
{% endfor %}

Each setting name is mapped to a tuple or list of 2 elements: (1) a docstring
for the setting explaining how it is used and (2) the default value of the
setting. The docstring is mandatory where a setting name is defined, but
optional in subclasses where you are just changing the default value of an
existing inherited setting.

Each of these settings are available to every filter class which is a subclass
of `DexyFilter`. Subclasses can change the default values of these settings and
can also define new settings.

{% set template_dir = "code/customizing-dexy/cd-settings-inheritance/" -%}

Setting Examples
^^^^^^^^^^^^^^^^

Here's an example of a Filter class which creates a new setting, including a
docstring, and also changes the default value of an existing setting:

{{ codes(template_dir + pluginfile + "|" + "idio", "setting-demo") }}

This filter prints out a list of all setting names and their values.

On a filter instance, the `setting_values()` method returns a dictionary with
all current setting names and values (not helpstrings). The `setting()` method
takes a setting name as its arguments and returns the default value.

For example, the output from applying this filter:

{{ codes(template_dir + "dexy.yaml|idio", "ex1") }}

Is::

    {{ d[template_dir + 'output/ex1.txt'] | indent(4) }}

For filters, we can change setting values for a particular document (or
pattern-based collection of documents) in the `dexy.yaml` file like this:

{{ codes(template_dir + "dexy.yaml|idio", "ex2") }}

The result is::

    {{ d[template_dir + 'output/ex2.txt'] | indent(4) }}

We can subclass this filter again and change the `process()` method so there's less clutter, and also change the default value of foo:

{{ codes(template_dir + pluginfile + "|" + "idio", "subclass") }}

Here's the config:

{{ codes(template_dir + "dexy.yaml|idio", "ex3") }}

And here's the output::

    {{ d[template_dir + 'output/ex3.txt'] | indent(4) }}

Again, we can specify a custom setting in the `dexy.yaml`:

{{ codes(template_dir + "dexy.yaml|idio", "ex4") }}

And here's the output from this::

    {{ d[template_dir + 'output/ex4.txt'] | indent(4) }}

In these examples, we just printed the setting values as part of the filter
output. Most of the time, setting values are used to control the behavior of
filters or provide user-settable parameters.

Here's an example from dexy's `SubprocessStdoutFilter` which shows how the `walk-working-dir` and `add-new-files` settings are used:

{{ hl(d['/modules.txt|pydoc']['dexy.filters.process.SubprocessStdoutFilter.process:source'], 'python') }}

You can see these settings listed on the documentation page for the `py </filters/Py.html>`__ filter, which is based on `SubprocessStdoutFilter` filter.

Implementation
..............

The details of how this plugin system is implemented is covered in the `Dexy Internals` section [TODO link]. The code is contained in the Plugin and PluginMeta classes in the `dexy/plugin.py module <https://github.com/ananelson/dexy/blob/develop/dexy/plugin.py>`__

Templates
---------

Templates are a way to easily distribute dexy projects. You can use templates
to give yourself a starting point for a project, or to allow people to easily
use your work as a jumping-off point for their own.

Most simply, templates are just a way of letting dexy know where a collection
of static files are, so you can make a copy of those files in a new working
directory by running the `dexy gen` command.


Filters
-------

Writing custom filters.

Using Templates for Filter Documentation
.........................................

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

Reporters
---------

Writing custom reporters.


Website Reporter
................

The built-in website reporter provides utilities for creating websites based on
a dexy project.


Parser
------

parsers.

Data & Storage
--------------

We'll handle these together.

Commands
--------

Dexy command line options are pluginable.

Installing Plugins
------------------

This section covers how to get Dexy to recognize and use your plugin.

YAML-defined plugins
....................

We don't always have to write a new python method to define a new plugin.


dexyplugin.py
.............

If you create a file named `dexyplugin.py` at the root of your dexy project,
dexy will automatically load any plugins it finds in that file.


The -plugin Command line option
...............................

You can specify individual python files or installed python packages which
should be loaded as dexy plugins by using the `-plugin` command line option. As
with all dexy command line options you can specify this on the command line or
in a `dexy.conf` file. If you are using a plugin on a project you will probably
need it all the time so you should make a `dexy.conf` file for this setting.

Creating Python Packages
........................

It makes sense to create a python package for your plugins if you want to
distribute them to others or use them across multiple packages.

Official Dexy Plugins
---------------------

Guide to the official dexy plugin packages.
