Quickstart
==========

{% from "dexy.jinja" import code, codes, ext, hl with context %}

This section contains examples of using dexy, with explanations of the features being used.

To install dexy do `pip install dexy`. If you need more help with installation,
see the `installation guide </guide/installing-dexy.html>`__.

.. contents:: Contents
    :local:

Quick Tips
----------

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

Documenting a Web App
---------------------

To Be Developed.

{% if False -%}

We create a simple web application (using the `web.py` framework) and show how we can use dexy to create different types of documentation.

{{ codes('code/quickstart/webapp.sh|idio|shint|pyg', 'gen') }}

{{ codes('code/quickstart/webapp.sh|idio|shint|pyg', 'ls') }}

{{ codes('code/quickstart/webapp.sh|idio|shint|pyg', 'dexy') }}

Sqlite:

{{ code('code/quickstart/webapp/schema.sql|pyg') }}

{{ codes('code/quickstart/webapp/dexy.yaml|idio', 'screenshots') }}

{% endif -%}

Writing up Simulation Research
------------------------------

To Be Developed.

