<div class="grid_8"><!-- keep things narrow and readable -->

This is a guide to writing template-based documents using Dexy. We will cover
the template plugin system, and when to think about writing a custom plugin or
a custom filter.

A template system, such as Jinja or Ruby's ERB, lets you insert dynamic content into
your documents. In order to use a system like this, you need two elements. One,
a document template which has placeholders for dynamic content. Two, a data
structure of some kind which provides the content that goes into those
placeholders.

A very simple example of this is string interpolation, a feature found in many
programming languages. Here is an example in Python:

<< d['interpolation-example.py|pyg'] >>

<pre>
<< d['interpolation-example.py|py'] >>
</pre>

Writing templates is straightforward, you create a document and write your
content, inserting appropriate placeholders.

The more interesting question is, what content is available to put in those
placeholders?

This is where template plugins come in.



</div>
