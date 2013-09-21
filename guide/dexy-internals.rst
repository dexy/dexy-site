Dexy Internals
==============

{% from "dexy.jinja" import hl, code, codes with context %}

{% macro hl_pydoc(key) -%}
{{ hl(d['/modules.txt|pydoc'][key], 'python') }}
{% endmacro -%}

{% macro hl_pytest(key) -%}
{{ hl(d['/test.txt|pytest'][key], 'python') }}
{% endmacro -%}

{% macro pyt(key) -%}
.. raw:: html

  <p><b>{{ humanize(d['/test.txt|pytest'][key+":name"]) }}
  {% if bool(d['test.txt|pytest'][key+":passed"]) %}
  <i class="icon-check passed"></i>
  {% else -%}
  <i class="icon-minus failed"></i>
  {% endif -%}
  </b></p>
{% endmacro -%}

{% macro raw_pydoc(key) -%}
{{ d['/modules.txt|pydoc'][key] | indent(4, True) }}
{% endmacro -%}

.. contents:: Contents
    :local:

Developer documentation for dexy's internals. For most purposes, you should be able to customize dexy's behavior by writing plugins instead of modifying dexy's internals. Read this if you want to use dexy as a library, fix a bug in dexy, or implement features which can't be implemented at plugin level.

Top-Down Tour of Dexy
---------------------

Starting with the wrapper class, we'll drill down into each of the classes which are subsequently called to process a dexy run.

Wrapper State Machine
.....................

The wrapper state machine encapsulates the steps which dexy takes to process a batch.

Instances of the wrapper class start out in the `new` state.

{{ hl_pytest('tests.test_wrapper.test_state_new_after_init:source') }}

If the dexy required directories are present in the current working directory,
then a wrapper instance can be moved into the `valid` state.

{{ pyt('tests.test_wrapper.test_state_valid_after_to_valid') }}

From a `valid` state, the wrapper can be moved into the `walked` state at
which point it has a populated tree of node objects which are ready for dexy
processing. The `walk()` method will populate the `nodes` and `roots` objects
by processing dexy config files, the `nodes` and `roots` objects can also be
populated directly for testing or using dexy as a library.

From a `walked` state, the wrapper can be moved into the `checked` state, at
which point all nodes in the tree have been checked to determine whether their
results are already present in dexy's cache or not, and whether the cached
values are valid. When the `checked` state is reached, the dexy cache should be
in a known state with any unnecessary files removed.

From the `checked` state, the wrapper can actually run dexy, after which the
wrapper will be in the `ran` state if all filters completed successfully, or
the `error` state if an error occurred while running a filter.

From the `valid` state, the wrapper can also be moved into the `loaded` state
in which there is no tree, but the batch information from the previous batch
has been loaded. This information is sufficient for running many reports.

Data
....

The data class is the interface for saving and accessing document data.
Different subclasses are available to handle different formats of data. The
Generic data class handles binary or textual data with no special structure.
The Sectioned data class holds text data which is in named, ordered sections
(such as you get after running the `idio` filter on an input file). The
KeyValue data class makes it convenient to work with key-value data, doing
things like appending and retrieving values.

Wrapper
.......

The Wrapper class::

    {{ d['/modules.txt|pydoc']['dexy.wrapper.Wrapper:doc'] | indent }}

The wrapper instance contains values for all the settings which control the behavior of a dexy run.

{{ hl(d['/modules.txt|pydoc']['dexy.wrapper.Wrapper.__init__:source'], 'python') }}

It reads defaults:

{{ hl(d['/modules.txt|pydoc']['dexy.wrapper.Wrapper.initialize_attribute_defaults:source'], 'python') }}

and then updates with any custom keyword arguments:

{{ hl(d['/modules.txt|pydoc']['dexy.wrapper.Wrapper.update_attributes_from_kwargs:source'], 'python') }}

The `project_root` parameter stores the location of the dexy project root, this
is mostly used for checking to ensure dexy does not accidentally write any
files outside of the project root.

The wrapper checks if the current directory appears to be an active dexy project:

{{ hl(d['/modules.txt|pydoc']['dexy.wrapper.Wrapper.dexy_dirs_exist:source'], 'python') }}

If so, then some setup is done for a dexy run. The `nodes` and `roots` objects
are created, and then logging is set up:

{{ hl(d['/modules.txt|pydoc']['dexy.wrapper.Wrapper.setup_log:source'], 'python') }}

A map is made of all files present in the project directory, along with file stat information:

{{ hl(d['/modules.txt|pydoc']['dexy.wrapper.Wrapper.map_files:source'], 'python') }}

And previously saved 

{{ hl(d['/modules.txt|pydoc']['dexy.wrapper.Wrapper.map_files:source'], 'python') }}

