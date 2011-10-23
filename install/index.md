## Source

Dexy's source code is available from [github](http://github.com/ananelson/dexy).

## Installation Instructions

Dexy is tested on Python 2.6 and Python 2.7. There is no support for Python 3.X yet.

You can:
{{ d['min-install-ubuntu.sh|idio']['pip-install'] }}

or:
{{ d['source-install.sh|idio']['easy-install'] }}

You can upgrade to the most re
{{ d['source-install.sh|idio']['easy-install-upgrade'] }}

If you want more detail or if you are new to installing Python packages, keep reading.  

If you run into issues with this install process then [let me know](http://discuss.dexy.it).

## New to Python?

Dexy is installed in the same way as most Python packages. Dexy uses Setuptools which is a standard Python way to handle package management. Many systems already have setuptools installed. If you have a command called easy_install, then you can install dexy by typing:

{{ d['source-install.sh|idio']['easy-install'] }}

On Mac or Linux you probably need to add 'sudo' to the start of this command.

If you don't have easy_install already, then you will need to install some additional software before you can install Dexy.

(Note: If you are on a machine without administrator privileges then you can try using the <a href="#nosudo">Virtualenv installation</a> method described below. All you need is to have Python already installed on the machine.)

The first requirement is to have Python installed on your machine. If you don't already have Python 2.6 or 2.7 then go to [python.org/download](http://www.python.org/download/) and install the most recent version of Python 2.7 for your platform. Do not install Python 3.

You can check whether Python is installed, and which version, by typing:
{{ d['source-install.sh|idio']['python-version'] }}

Once you have Python installed, you can install [Setuptools](http://pypi.python.org/pypi/setuptools). Once this is installed you should be able to install Dexy as at the start of this section. (Some people prefer to use [pip](http://www.pip-installer.org/), after you have installed Setuptools you may also want to install pip and use that to install Dexy.)

Once you have installed Dexy, you can make sure it's working by typing:

{{ d['source-install.sh|idio']['dexy-help'] }}

## Dexy Filter Requirements

Many of Dexy's filters depend on having other software installed, so depending on which filters you want to use, you might need to install some extra software too. For example, if you want to use the latex filter to turn documents written in LaTeX into PDFs, then you'll need to install TeXLive or a similar package.

You can call dexy with the --filters option to see which filters are available on your system. If a filter you want isn't available, then search the dexy.log file for information about why it's not available.

{{ d['source-install.sh|idio']['list-filters'] }}

In order to test all the Dexy filters and generate the filter documentation, we install all the software needed for each of the filters on a Ubuntu server. You can look at the [automated build guide](dexy-automated-build-guide.pdf) to see what is installed.

## Source Install

Here is how to install Dexy from source using easy_install:
{{ d['source-install.sh|idio']['source-install'] }}

This will also install any dependencies which Dexy needs. You might want to follow this by:
{{ d['source-install.sh|idio']['develop'] }}

which will put the code into 'develop' mode so any changes to the source code (either from pulling down updated code from the repository, or making changes yourself) are reflected immediately.

## Checking That It Works

Regardless of which method you use, you can make sure it works by typing:

{{ d['source-install.sh|idio']['dexy-help'] }}

Once you have Dexy installed, you can start working through the [tutorials](/docs/tutorials) or get started with one of the [project templates](http://github.com/ananelson/dexy-templates).

## Windows

<span id="windows">&nbsp;</span>

Dexy should install on Windows using any of the above methods, however not all the filters will work on Windows. The dexy.log file should provide clues about why a given filter isn't available. Any filters that rely on the pexpect module will not be available on Windows.

## Virtualenv Install

<span id="nosudo">&nbsp;</span>

Here is an example using [virtualenv](http://virtualenv.openplans.org/) to create a local self-contained install of Dexy without requiring root access.

Download and unpack virtualenv:
{{ d['virtualenv-install.sh|idio']['download-virtualenv'] }}

Create a new virtual environment:
{{ d['virtualenv-install.sh|idio']['create-virtualenv'] }}

Activate the virtualenv (you will need to do this each time you wish to use it):
{{ d['virtualenv-install.sh|idio']['activate-virtualenv'] }}

Install Dexy:
{{ d['virtualenv-install.sh|idio']['install-dexy'] }}

When you are finished, you can deactivate the virtualenv:
{{ d['virtualenv-install.sh|idio']['deactivate-virtualenv'] }}
