Customizing Dexy
================

{% from "dexy.jinja" import code, codes with context %}

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



Custom Filters
--------------

Writing custom filters.


Custom Reporters
----------------

Writing custom reporters.
