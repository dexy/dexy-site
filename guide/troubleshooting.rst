Troubleshooting
===============

{% from "dexy.jinja" import code, codes with context %}

.. contents:: Contents
    :local:

Document not Available
----------------------

A common problem is that the code you want to include in another document isn't available. There's a few reasons this might happen:

- the code isn't correctly specified as a dependency to the document
- the code is available, but it wasn't split into sections properly


- why is this other document not available to my document?


Making Dexy Faster
------------------

- running specific targets, or disabling slow tasks while not using them
- why is my document not being cached?

Where to Look for Clues
-----------------------

- dexy log file
- run reporter (identifying dependencies)
- artifacts directory
