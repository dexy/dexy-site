Configuring Dexy
================

{% from "dexy.jinja" import code, codes with context %}

.. contents:: Contents
    :local:

Two config settings control how dexy looks for doc config files.

The `recurse` setting determines whether dexy will recurse into subdirectories
to look for additional `dexy.yaml` or other config files, by default this is
True. If you set `recurse` to False then dexy will only look in the root
directory. You can explicitly add other config files by mentioning them in the
`configs` argument. Set recurse to False if you want to avoid accidentally
running an unexpected dexy.yaml file or if you need to document a separate dexy
project in a subdirectory.

dexy.yaml Files
---------------

Writing document config files.

values for true : true True what about 'yes' '1'?

