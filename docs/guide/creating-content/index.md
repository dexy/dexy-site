<div class="grid_8"><!-- keep things narrow and readable -->

When we write template-based documents, we have a template, and information
that fills in the blanks in that template. This chapter deals with how to make
information available to your documents, and covers the standard information
that Dexy makes available by default.

A very simple example of creating a document from a template is string
interpolation, a feature found in many programming languages. Here is an
example in Python:

{{ d['interpolation-example.py|pyg'] }}

Running this code will output the following 'document' with dynamic content
replacing the placeholders:

<pre>
{{ d['interpolation-example.py|py'] }}
</pre>

The two basic elements are: a document template with placeholders, and a source
of data to fill in those placeholders. Dexy's plugin system provides a
convenient way to make any kind of data available to your documents, including
data from other documents.

### Template Plugins

Dexy has a system of Template Plugins which allow us to easily customize what
data we want available to our placeholders when we come to write documents.
Here is the source of the base TemplatePlugin class:

{{ d['/classes.json']['dexy.filters.templating_plugins.TemplatePlugin']['source'] }}

Template plugins are very simple classes which implement a run method which
returns a dictionary of key-value pairs.  The values can be pretty much
anything: primitives like numbers or strings, python functions or classes, or
other data structures like dictionaries or arrays.

The base TemplateFilter class defines a run_plugins method which calls the
run() method for each plugin listed in the PLUGINS constant, and aggregates all
the results into 1 dict. Each TemplateFilter class can then use that dict to
provide data to the documents which pass through that filter in a process or
process_text method. The base TemplateFilter just uses string interpolation:

{{ d['/classes.json']['dexy.filters.templating_filters.TemplateFilter']['source'] }}

The JinjaFilter passes the dict to the document template's stream method:

{{ d['/classes.json']['dexy.filters.templating_filters.JinjaFilter']['source'] }}

This means that the different templating systems implemented by Dexy can all
share the underlying data processing. So, it's easy to switch between
templating systems, or to add support for a new one. And, you can create your
own custom plugins, and also custom filters which can incorporate just the
plugins you want.

### Writing Custom Plugins and Templates

In this section, we look at writing some custom plugins and template filters,
and using them in a document. Even if you aren't interested in writing custom
plugins, this section will help you understand how plugins work, and how
template filters make use of them.

Here is a simple plugin which just returns a static dict:

{{ d['ex1/filters/simple_template_filter.py|idio']['plugin'] }}

We can create a template filter which uses this by subclassing the
TemplateFilter class and just defining an alias and overriding the list of
plugins, to include just our custom plugin.

{{ d['ex1/filters/simple_template_filter.py|idio']['filter'] }}

Here are the files in this example:

<pre>
{{ d['ex1/list-files.sh|jinja|sh'] }}
</pre>

The dexy config is:

{{ d['ex1/config.dexy|ppjson|pyg'] }}

Our template document is:

<pre>
{{ d['ex1/template.txt'] }}
</pre>

Here is the output generated:

{{ d['script-output-ex1.json']['docs']['template.txt|simple']['1'] }}

Here is another filter, this time based on Jinja rather than string interpolation:

{{ d['ex2/filters/simple_template_filter.py|idio']['filter'] }}

Now our template looks like:

<pre>
{{ "{{ '" + d['ex2/template.txt'] + "' }}" }}
</pre>

Here are the files in this example:

<pre>
{{ d['ex2/list-files.sh|jinja|sh'] }}
</pre>

And the output is:

{{ d['script-output-ex2.json']['docs']['template.txt|simplejinja']['1'] }}

Let's make another filter with some more interesting structures:

{{ d['ex3/filters/simple_template_filter.py|pyg'] }}

<pre>
{{ "{{ '" + d['ex3/template.txt'] + "' }}" }}
</pre>

Here are the files in this example:

<pre>
{{ d['ex3/list-files.sh|jinja|sh'] }}
</pre>

And the output is:

<pre>
{{ d['script-output-ex3.json']['docs']['template.txt|twoplugins']['1'] }}
</pre>

Plugins can be used to expose lots of information in documents. Commonly in Dexy,
we will want to have access to the other documents we specified as inputs, and we
can use plugins to customize how we display this information.

We create a plugin to load CSV data from an input file into a DictReader object:

{{ d['ex4/filters/simple_template_filter.py|pyg'] }}

Here is the template:

<pre>
{{ "{{ '" + d['ex4/template.txt'] + "' }}" }}
</pre>

Here are the files in this example:

<pre>
{{ d['ex4/list-files.sh|jinja|sh'] }}
</pre>

Here is the config file:

{{ d['ex4/config.dexy|ppjson|pyg'] }}

Here are the input files:

<pre>
{{ d['ex4/data1.csv'] }}
</pre>

<pre>
{{ d['ex4/data2.csv'] }}
</pre>

Here is the output:

<pre>
{{ d['script-output-ex4.json']['docs']['template.txt|csv']['1'] }}
</pre>

### The Built-In Plugins

The dict items defined in all of the following plugins are available in the
default Dexy filters, so you can use them in your documents that are run
through these filters.

If you want to disable some of these filters, for performance reasons or to
avoid naming conflicts, then you can subclass a template filter and override
the PLUGINS constant to just have the plugins you want, whether they are
built-in or custom plugins.

The PrettyPrinterTemplatePlugin makes pformat available (the version of pretty
print that prints to a string, rather than stdout):

{{ d['/classes.json']['dexy.filters.templating_plugins.PrettyPrinterTemplatePlugin']['source'] }}

Use regular expression matching and searching:

{{ d['/classes.json']['dexy.filters.templating_plugins.RegularExpressionsTemplatePlugin']['source'] }}

Make most Python builtins available:

{{ d['/classes.json']['dexy.filters.templating_plugins.PythonBuiltinsTemplatePlugin']['source'] }}

Makes HTML and LaTeX Pygments stylesheets available:

{{ d['/classes.json']['dexy.filters.templating_plugins.PygmentsStylesheetTemplatePlugin']['source'] }}

Lists subdirectories of the directory a document is in:

{{ d['/classes.json']['dexy.filters.templating_plugins.SubdirectoriesTemplatePlugin']['source'] }}

Gives access to variables specified in a dexy config file:

{{ d['/classes.json']['dexy.filters.templating_plugins.VariablesTemplatePlugin']['source'] }}

Gives access to globals specified in a dexy config file:

{{ d['/classes.json']['dexy.filters.templating_plugins.GlobalsTemplatePlugin']['source'] }}

Does preprocessing of inputs. Loads JSON into a dict etc. Populates the standard dexy objects:

{{ d['/classes.json']['dexy.filters.templating_plugins.InputsTemplatePlugin']['source'] }}

Makes the 'clippy' helper available, so you can make it easy for readers to copy/paste text snippets:

{{ d['/classes.json']['dexy.filters.templating_plugins.ClippyHelperTemplatePlugin']['source'] }}

</div>
