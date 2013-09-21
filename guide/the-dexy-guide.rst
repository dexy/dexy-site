The Dexy Guide
**************

{% include "blurb.rst" %}

.. contents:: Contents
    :depth: 1

{% from '_pages.jinja' import pages with context %}
{% for page in pages %}
{% set template = "%s.rst" % page %}
{% include template %}
{% endfor %}
