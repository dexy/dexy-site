Filters
=======

{% from "dexy.jinja" import hl, code, codes with context %}

{% macro hl_pydoc(key) -%}
{{ hl(d['/modules.txt|pydoc'][key], 'python') }}
{% endmacro -%}

{% macro hl_pytest(key) -%}
{{ hl(d['/modules.txt|pytest'][key], 'python') }}
{% endmacro -%}

.. contents:: Contents
    :local:


This is developer documentation for filters, describing how they are implemented.


Python Introspection
--------------------

The Pydoc and Pytest filters use Python's introspection to provide information
about Python packages and standalone files. It would be nice to replace this
with code which works by properly parsing python files instead, because there
are potential side effects to importing and loading modules or files.

PythonIntrospection Base Class
..............................

The base class provides utilities for importing python modules or files.

If we are referencing a python package which is installed somewhere on the
system, we can load this by its name:

{{ hl_pydoc("dexy.filters.pydoc.PythonIntrospection.load_module:source") }}

For loading an individual python file, we need to populate the workspace so that any other python files on which it depends are available, and we need to add the file's parent directory to python's `sys.path` so it can be imported:

{{ hl_pydoc("dexy.filters.pydoc.PythonIntrospection.load_source_file:source") }}

Here's the specifics of which directories are added to the workspace:

{{ hl_pydoc("dexy.filters.pydoc.PythonIntrospection.add_workspace_to_sys_path:source") }}

Pydoc Filter
............

The pydoc filter takes either a list of installed python packages, or a single python source code file. The filter can tell which it is being passed because of the file extension of the input file:

{{ hl_pydoc("dexy.filters.pydoc.Pydoc.process:source") }}

Processing Packages
^^^^^^^^^^^^^^^^^^^

To generate documentation for packages by name, we first split the list by
whitespace and then import each item as a package:

{{ hl_pydoc("dexy.filters.pydoc.Pydoc.process_packages:source") }}

Next, to process each package, we process the members of the top-level package, and then iterate over all modules and sub-packages contained within the package:

{{ hl_pydoc("dexy.filters.pydoc.Pydoc.process_package:source") }}

The `process_module` method first adds the source code of the whole module and
then calls `process_members`:

{{ hl_pydoc("dexy.filters.pydoc.Pydoc.process_module:source") }}

The `process_members` method iterates over every item found in the module and calls `append_item_content` on each:

{{ hl_pydoc("dexy.filters.pydoc.Pydoc.process_members:source") }}

The `append_item_content` method tries to add source, doc and comment (applicable to method-like things) and a json-encoded value (more applicable to constants):

{{ hl_pydoc("dexy.filters.pydoc.Pydoc.append_item_content:source") }}

Importing Files
^^^^^^^^^^^^^^^

When importing from a single file, we simply need to call `process_members` on the module defined by the file:

{{ hl_pydoc("dexy.filters.pydoc.Pydoc.process_file:source") }}

Pytest Filter
.............

The Pytest filter introspects on test content and can also run tests and report on test results.

{{ hl_pydoc("dexy.filters.pytest.PythonTest.process:source") }}

The `run_test` method will run the provided test (if the setting `run-tests` is
set to True) and return the results of the test suite, or the specified
fallback if the tests are not run:

{{ hl_pydoc("dexy.filters.pytest.PythonTest.run_test:source") }}

Then the `append_source` method uses introspection to get the source code for each test:

{{ hl_pydoc("dexy.filters.pytest.PythonTest.append_source:source") }}


Running Code
------------

Filters which run code.

Syntax Highlighting
-------------------

Filters which apply syntax highlighting.

Sectioning
----------

Filters which split code into sections.

Document Templating
-------------------

Filters like jinja.

API Filters
-----------

API filters need to 
