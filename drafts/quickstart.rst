Quickstart
==========

{% from "dexy.jinja" import code, codes, ext, hl with context %}

This section contains examples of using dexy, with explanations of the features being used.

To install dexy do `pip install dexy`. If you need more help with installation,
see the `installation documentation </docs/installing-dexy.html>`__.

For a more gentle, step-by-step introduction, see the `getting started
</docs/getting-started.html>`__ section.

.. contents:: Contents
    :local:

Command Line Intro
------------------

You can find more examples of dexy projects by running the `dexy templates` command.

{{ codes('code/quickstart/tips.sh|idio|shint|pyg', 'templates') }}

Use the `dexy gen` command to create a new project based on any of these templates:

{{ codes('code/quickstart/tips.sh|idio|shint|pyg', 'gen') }}

The `dexy gen` command sets up the new project so it's ready to run:

{{ codes('code/quickstart/tips.sh|idio|shint|pyg', 'ls') }}

The `dexy.yaml` file contains instructions on what dexy should do:

{{ codes('code/quickstart/tips.sh|idio|shint|pyg', 'yaml') }}

You run dexy by typing the `dexy` command:

{{ codes('code/quickstart/tips.sh|idio|shint|pyg', 'run-dexy') }}

There should be some new directories after you run dexy, containing the output from running dexy:

{{ codes('code/quickstart/tips.sh|idio|shint|pyg', 'after-run') }}

After you have run dexy once on a project, you can use the `dexy viewer`
command to start a local web server to help you search and preview your dexy
objects. There is also a simpler command line tool named `dexy grep`.

{{ codes('code/quickstart/tips.sh|idio|shint|pyg', 'grep') }}

Sometimes you will need to empty dexy's cache if it becomes corrupted, this might happen if an error occurs halfway through a run, or if you cancel a run partway through by pressing ctrl+c. You can do this by calling `dexy reset`:

{{ codes('code/quickstart/tips.sh|idio|shint|pyg', 'reset') }}

For more help with debugging, change the log level:

{{ codes('code/quickstart/tips.sh|idio|shint|pyg', 'loglevel') }}

To create a config file to store command line options you want to use each time you run dexy, run the `dexy conf` command then edit the defaults:

{{ codes('code/quickstart/tips.sh|idio|shint|pyg', 'conf') }}

Check out the `dexy help` command for more commands and for learning about available options for each command:

{{ codes('code/quickstart/tips.sh|idio|shint|pyg', 'help') }}

The `Command Line Interface </guide/command-line-interface/>`__ section has
more details on the various dexy commands.

Django Polls App
----------------

In this example, we'll make some developer documentation for the Polls
application from the `Django Tutorial
<https://docs.djangoproject.com/en/dev/intro/tutorial01/>`__.

We'll use the `quickstart` template:

{{ codes('code/quickstart/webapp.sh|idio|shint|pyg', 'gen') }}

Here are the files which are generated:

{{ codes('code/quickstart/webapp.sh|idio|shint|pyg', 'ls') }}

We'll run dexy:

{{ codes('code/quickstart/webapp.sh|idio|shint|pyg', 'dexy') }}

After running dexy, the `output-site` directory contains the newly generated files:

{{ codes('code/quickstart/webapp.sh|idio|shint|pyg', 'ls-after') }}

{% if ext == '.html' %}

Here is the generated documentation, including source code and screenshots:

.. raw:: html

    <iframe style="width: 100%; height: 500px; border: thin solid gray;" src="code/quickstart/example/output-site/developer.html"></iframe>

{% endif %}

Config
------

Here is the `dexy.conf` file specifying the default command line options::

    {{ d['code/quickstart/example/dexy.conf'] | indent(4) }}

Here is the full `dexy.yaml` file. The entries in the dexy.yaml file will be
discussed in detail in subsequent sections::

    {{ d['code/quickstart/example/dexy.yaml'] | indent(4) }}

Source Code
-----------

We want to document source code, so first we need to get it ready by applying
syntax highlighting.

The `idio` filter divides source code into sections and applies syntax
highlighting. The `h` and `l` filters don't do anything, but they indicate
whether html or latex should be output:

{{ codes('code/quickstart/example/dexy.yaml|idio', 'inputs') }}

For example, here is a file from the example project::

    {{ d['code/quickstart/example/example_com/polls/models.py'] | indent(4) }}

After running this file through the `idio` filter, the code is split into sections:

{% for k in d['code/quickstart/example/example_com/polls/models.py|idio|h'].keys() %}
- {{ k }}

.. raw:: html

    {{ d['code/quickstart/example/example_com/polls/models.py|idio|h'][k] | indent(4) }}

{% endfor %}

Assets
------

Files which just need to be copied to the output directory can be listed without any filters:

{{ codes('code/quickstart/example/dexy.yaml|idio', 'assets') }}

Tests
-----

{{ codes('code/quickstart/example/dexy.yaml|idio', 'run-tests') }}

Bash script to run tests::

    {{ d['code/quickstart/example/scripts/run-tests.sh'] | indent(4) }}


Screenshots
-----------

{{ codes('code/quickstart/example/dexy.yaml|idio', 'run-casper') }}

To take screenshots, we need to start the django server first::

    {{ d['code/quickstart/example/scripts/reset-server.sh'] | indent(4) }}

Then we can run the screenshot script through casper.js, following which we shut down the django server::

    {{ d['code/quickstart/example/scripts/stop-server.sh'] | indent(4) }}

Finally, we run an R script to analyze the data in the sqlite database (see next section).

Data Analysis
-------------

::

    {{ d['code/quickstart/example/docs/analyze.R'] | indent(4) }}

.. image:: code/quickstart/example/output-site/plot.png

Documents
---------

Finally, we can include all these components in a reStructuredText document. We
specify all the other bundles in the YAML as an input to our .rst document:

{{ codes('code/quickstart/example/dexy.yaml|idio', 'rst') }}

Here is the source of the document::

    {{ d['code/quickstart/example/docs/developer.rst'] | indent(4) }}


