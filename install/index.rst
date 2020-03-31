Installing Dexy
===============

{% from "dexy.jinja" import code, codes with context %}

.. contents:: Contents
    :local:

Standard Installation
---------------------

`Dexy <http://pypi.python.org/pypi/dexy>`_ is a Python package (Python 3
only) and can be installed in the usual way, e.g. `pip install dexy`. If you
are familiar with Python then that's probably all you need to know, although
you might want to read the `Installing Additional Software`_ section.

The rest of this section explains in detail how to install Python and Dexy.

Installing Python
.................

Python has to be installed to run Dexy. (You don't need to know the Python
language to use Dexy.) First, check if Python is already installed. Python is
automatically installed on OSX and many other operating systems. Here is how
to check:

{{ codes("code/install.sh|idio", "python-version") }}

If you get a version number which starts with 3, then you are all
set.

If you see an error message like `command not found`, then you don't have
Python installed. In that case go to the `python website
<http://www.python.org/download/>`__ to find an installer for your operating
system.

Using a Virtual Machine
.......................

If you have concerns about installing Python, then one option is to use a virtual machine or container system, like Docker, and install Python on there, where it will not interfere with your main operating system.

Installing Dexy
...............

Once you get Python installed, then you can install dexy. If you have a tool called `pip` then this is the preferred way to install python packages:

{{ codes("code/install.sh|idio", "pip-install-dexy") }}

You should leave out the word `sudo` if you are on Windows or if you are installing into a virtualenv.

If you do not have the `pip` tool, then you probably do have `easy_install` and you can use that to install dexy:

{{ codes("code/install.sh|idio", "easy-install-dexy") }}

Again, leave out `sudo` if appropriate.

Updating Dexy
-------------

In order to get access to new dexy features, performance improvements, and
bug fixes, you will want to upgrade your dexy to the latest version from time
to time. As with any software, it's possible that an upgrade will cause your
dexy project to stop working, although there are lots of tests in place to
try to prevent this. So, you should keep your dexy updated, but use common
sense and don't update software the day before a huge project is due. Also,
learn about Python virtualenvs (see `Installing in a Virtualenv`_ below).

If you used pip to install dexy, then you can update by running:

{{ codes("code/install.sh|idio", "pip-upgrade-dexy") }}

If you used easy_install, then run:

{{ codes("code/install.sh|idio", "easy-upgrade-dexy") }}

Check out the next section on virtualenvs for a way to test out a new version
of dexy but still be able to revert back to the version you were using if
there are problems with it.

Installing in a Virtualenv
--------------------------

You can use `virtualenvs
<http://www.virtualenv.org/en/latest/#what-it-does>`__ to allow you to try
out a more recent version of dexy without losing the version that works for
you. Here's a brief example.

You can either `install virtualenv
<http://www.virtualenv.org/en/latest/#installation>`__ or download the
virtualenv script and run it. We'll do the latter in this example. It's a
little less convenient than installing virtualenv and running the
`virtualenv` command, but it has the advantage of not requiring sudo. Grab
the virtualenv script:

{{ codes("code/install.sh|idio", "download-virtualenv") }}

Create a new virtualenv:

{{ codes("code/install.sh|idio", "create-virtualenv") }}

Then, activate it:

{{ codes("code/install.sh|idio", "activate-virtualenv") }}

Now, with the active virtualenv, install dexy:

{{ codes("code/install.sh|idio", "virtualenv-pip-install-dexy") }}

When you are finished working, deactivate the virtualenv:

{{ codes("code/install.sh|idio", "deactivate-virtualenv") }}

Next time you want to work in this virtualenv, just activate it again:

{{ codes("code/install.sh|idio", "activate-virtualenv") }}

To safely update dexy, you would create a new virtualenv, install the latest
dexy (and any other python packages you need) in that env, and test your
code. If the newer version of dexy causes problems, then you can just
deactivate that virtualenv and go back to using your original virtualenv
until you have time to figure out why and update your code.

Source Install
--------------

If you want to have the bleeding-edge version of dexy, then you can install
dexy from the source code on github. Here's how:

{{ codes("code/install.sh|idio", "pip-install-from-git") }}

Checking the Installation
-------------------------

After you have installed Dexy, you should be able to run these commands:

{{ codes("code/install.sh|idio", "check-install") }}

Make sure the dexy version printed out is the one you expected.

Installing Additional Software
------------------------------

When you install dexy, it also installs some extra software which is commonly
used in dexy, such as pygments for syntax highlighting, and jinja2 for
creating document templates. But, you have to install any other software you
would like to use with dexy. Dexy filters can work with many different Python
packages and command line tools, but you need to install those packages or
tools yourself.

Here are some examples.

If you want dexy to upload files to Amazon S3 for storage, you will need to
install the boto package for python.

{{ codes("code/install.sh|idio", "install-boto") }}

If you want to use dexy to generate PDF documents from .tex sources (or from
other formats that can be converted to .tex), then you will need to install a
`LaTeX <http://www.latex-project.org/>`__ compiler.

`Pandoc <http://johnmacfarlane.net/pandoc/>`_ calls itself a "a universal
document converter" and dexy has a pandoc filter allowing you to convert many
different types of documents. On ubuntu/debian this can be installed via:

{{ codes("code/install.sh|idio", "install-pandoc") }}

There are `other pandoc installers
<http://johnmacfarlane.net/pandoc/installing.html>`__ available for other
operating systems.

Dexy's filters will try to tell you if you need to install extra software to
use them.

