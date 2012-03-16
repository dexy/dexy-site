## Topics

[TOC]

Dexy is tested on Python 2.6 and Python 2.7. Please try to read this whole page, there is some useful stuff here. If you need help installing dexy, please open a [support ticket](http://dexy.tenderapp.com).

### Install Latest Release

The easiest way to install dexy is with [pip](http://www.pip-installer.org/en/latest/index.html):

{{ d['virtualenv-install.sh|idio']['pip-install-dexy'] }}

You can also use easy_install:

{{ d['virtualenv-install.sh|idio']['easy-install-dexy'] }}

If you are new to Python and pip/setuptools, please read the section [New to Python](#new-to-python) first. [Here is a discussion on StackOverflow about pip vs. easy_install.](http://stackoverflow.com/questions/3220404/why-use-pip-over-easy-install)

### Upgrading

To upgrade to the most recent release version:

{{ d['virtualenv-install.sh|idio']['pip-upgrade-dexy'] }}

or

{{ d['virtualenv-install.sh|idio']['easy-upgrade-dexy'] }}

### Source Install

Dexy's source code is available from [github](http://github.com/ananelson/dexy).

You can check out the source and install it in "editable" mode like this:

{{ d['virtualenv-install.sh|idio']['pip-install-from-git-local-editable'] }}

This means that the source code is 'live' and if you update the code or do a `git pull` this will have an immediate effect on running `dexy`.

Pip can also check out the repo for you:

{{ d['virtualenv-install.sh|idio']['pip-install-from-git-editable'] }}

Or you can install a static version from the repository (this will not be 'editable'):

{{ d['virtualenv-install.sh|idio']['pip-install-from-git'] }}

To learn more about these options, check out the [pip documentation](http://www.pip-installer.org/en/latest/usage.html#install-packages).

### Virtualenv

You have the option to install Dexy using any of these methods within a virtual Python environment, or virtualenv. Virtualenv has several advantages and it's simple to use, even for beginners. The advantages are that you don't need to use `sudo` to install Dexy, if you mess something up in an installation you haven't messed up your system Python and you can just delete the virtualenv and start over, and it makes it really easy to work with different versions of software and even different Python versions.

Note that before Virtualenv 1.7, you needed to pass `--no-site-packages` as an argument. This is now the default which is why we don't use it in this script. You should check your Virtualenv and upgrade it if your version is not 1.7 or higher.

Check out the [virtualenv](http://www.virtualenv.org/en/latest/) website for more information. Here is an example of how you can use [virtualenv](http://www.virtualenv.org/en/latest/) to create a local self-contained install of Dexy without requiring root access.

Download and unpack virtualenv:
{{ d['virtualenv-install.sh|idio']['download-virtualenv'] }}

Create a new virtual environment:
{{ d['virtualenv-install.sh|idio']['create-virtualenv'] }}

Activate the virtualenv (you will need to do this each time you wish to use it):
{{ d['virtualenv-install.sh|idio']['activate-virtualenv'] }}

Install Dexy:
{{ d['virtualenv-install.sh|idio']['pip-install-dexy'] }}

You can also install dexy [from source](#source-install) within your virtualenv, or create more than 1 virtualenv to have both stable and source versions of Dexy available.

Check that it is working:
{{ d['virtualenv-install.sh|idio']['check-dexy'] }}

When you are finished, you should deactivate the virtualenv:
{{ d['virtualenv-install.sh|idio']['deactivate-virtualenv'] }}

### New to Python?

Dexy is installed in the same way as most Python packages. Dexy uses Setuptools which is a standard Python way to handle package management. Many systems already have setuptools installed. If you have a command called easy_install, then you can install dexy by typing:

{{ d['virtualenv-install.sh|idio']['easy-install-dexy'] }}

On Mac or Linux you probably need to add `sudo` to the start of this command.

If you don't have easy_install already, then you will need to install some additional software before you can install Dexy.

(Note: If you are on a machine without administrator privileges then you can try using the [Virtualenv installation](#virtualenv) method. All you need is to have Python already installed on the machine.)

The first requirement is to have Python installed on your machine. If you don't already have Python 2.6 or 2.7 then go to [python.org/download](http://www.python.org/download/) and install the most recent version of Python 2.7 for your platform. Do not install Python 3.

You can check whether Python is installed, and which version, by typing:
{{ d['virtualenv-install.sh|idio']['python-version'] }}

Once you have Python installed, you can install [Setuptools](http://pypi.python.org/pypi/setuptools). Once this is installed you should be able to install Dexy as at the start of this section. (Some people prefer to use [pip](http://www.pip-installer.org/), after you have installed Setuptools you may also want to install pip and use that to install Dexy.)

Once you have installed Dexy, you can make sure it's working by typing:

{{ d['virtualenv-install.sh|idio']['check-dexy'] }}

### Software for Filters

Many of Dexy's filters depend on having other software installed, so depending on which filters you want to use, you might need to install some extra software too. For example, if you want to use the latex filter to turn documents written in LaTeX into PDFs, then you'll need to install TeXLive or another latex distribution.

You can call the filters command to see which filters are available on your system. If a filter you want isn't available, then search the dexy.log file for information about why it's not available:

{{ d['virtualenv-install.sh|idio']['list-filters'] }}

In order to test all the Dexy filters and generate the filter documentation, we install all the software needed for each of the filters on a Ubuntu server. You can look at the [automated build guide](dexy-automated-build-guide.pdf) to see what is installed.

### Checking Your Installation

Regardless of which method you use, you can make sure it works by typing:

{{ d['virtualenv-install.sh|idio']['check-dexy'] }}

Once you have Dexy installed, you can start working through the [tutorials](/docs/tutorials) or get started with one of the [project templates](http://github.com/ananelson/dexy-templates).

### Windows

Dexy should install on Windows using any of the above methods, however not all the filters will work on Windows. The dexy.log file should provide clues about why a given filter isn't available. Any filters that rely on the pexpect module will not be available on Windows.
