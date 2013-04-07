Output and Post-Processing
==========================

{% from "dexy.jinja" import code, codes with context %}

.. contents:: Contents
    :local:

This section deals with what shows up in directories like output/ and
output-long/ after you run dexy, and how to automate post-processing with dexy.

(Maybe work this into another section later - not sure where this fits for now.)


Static Websites with Dexy
-------------------------

The output/ directory is designed to have pretty canonical filenames that can
be used with a website, but there's a special website reporter that is designed
particularly for creating websites. This reporter uses the same canonical
filenames as the output reporter but it also has helpful features to create
site navigation menus and other common features of websites.

The website reporter will apply page templates to the HTML content of your site.
These templates can include jinja tags and the website reporter will make
information available that's relevant for a website.

Navigation
..........

The website reporter creates a special 'nav' object you can use to
retrieve various types of information in your page templates.

You can do navobj.debug to get a dump (wrapping this in pre tags is
probably a good idea).


