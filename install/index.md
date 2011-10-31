<div class="divider">
<h5><span>Source Code</span></h5>
<!--Divider With Titling-->
</div>

Dexy's source code is available from [gitorious](http://gitorious.org/dexy).

<div class="divider">
<h5><span>Installation Instructions</span></h5>
<!--Divider With Titling-->
</div>

Dexy is tested on Python 2.6 and Python 2.7.

The easiest way to install dexy is:

{{ d['dexy-pip-install.sh|idio']['install'] }}

You can also:

{{ d['dexy-easy-install.sh|idio']['install'] }}

If you want more detail or if you are new to installing Python packages, keep reading.

<div class="divider">
<h5><span>Upgrading</span></h5>
<!--Divider With Titling-->
</div>

To upgrade to the most recent version:

{{ d['dexy-pip-upgrade.sh|idio']['upgrade'] }}

or

{{ d['dexy-easy-upgrade.sh|idio']['upgrade'] }}

<div class="divider">
<h5><span>New to Python?</span></h5>
<!--Divider With Titling-->
</div>

Dexy is installed in the same way as most Python packages. Dexy uses Setuptools which is a standard Python way to handle package management. Many systems already have setuptools installed. If you have a command called easy_install, then you can install dexy by typing:

{{ d['dexy-easy-install.sh|idio']['install'] }}

On Mac or Linux you probably need to add 'sudo' to the start of this command.

If you don't have easy_install already, then you will need to install some additional software before you can install Dexy.

(Note: If you are on a machine without administrator privileges then you can try using the <a href="#nosudo">Virtualenv installation</a> method described below. All you need is to have Python already installed on the machine.)

The first requirement is to have Python installed on your machine. If you don't already have Python 2.6 or 2.7 then go to [python.org/download](http://www.python.org/download/) and install the most recent version of Python 2.7 for your platform. Do not install Python 3.

You can check whether Python is installed, and which version, by typing:
{{ d['dexy-easy-install.sh|idio']['python-version'] }}

Once you have Python installed, you can install [Setuptools](http://pypi.python.org/pypi/setuptools). Once this is installed you should be able to install Dexy as at the start of this section. (Some people prefer to use [pip](http://www.pip-installer.org/), after you have installed Setuptools you may also want to install pip and use that to install Dexy.)

Once you have installed Dexy, you can make sure it's working by typing:

{{ d['dexy-easy-install.sh|idio']['check'] }}

<div class="divider">
<h5><span>Software for Filters</span></h5>
<!--Divider With Titling-->
</div>

Many of Dexy's filters depend on having other software installed, so depending on which filters you want to use, you might need to install some extra software too. For example, if you want to use the latex filter to turn documents written in LaTeX into PDFs, then you'll need to install TeXLive or another latex distribution.

You can call the filters command to see which filters are available on your system. If a filter you want isn't available, then search the dexy.log file for information about why it's not available:

{{ d['source-install.sh|idio']['list-filters'] }}

In order to test all the Dexy filters and generate the filter documentation, we install all the software needed for each of the filters on a Ubuntu server. You can look at the [automated build guide](dexy-automated-build-guide.pdf) to see what is installed.

<div class="divider">
<h5><span>Source Install</span></h5>
<!--Divider With Titling-->
</div>

Here is how to install Dexy from source using pip:
{{ d['source-install.sh|idio']['source-install'] }}

<div class="divider">
<h5><span>Checking Your Installation</span></h5>
<!--Divider With Titling-->
</div>

Regardless of which method you use, you can make sure it works by typing:

{{ d['source-install.sh|idio']['dexy-help'] }}

Once you have Dexy installed, you can start working through the [tutorials](/docs/tutorials) or get started with one of the [project templates](http://github.com/ananelson/dexy-templates).

<div class="divider" id="windows">
<h5><span>Windows</span></h5>
<!--Divider With Titling-->
</div>

Dexy should install on Windows using any of the above methods, however not all the filters will work on Windows. The dexy.log file should provide clues about why a given filter isn't available. Any filters that rely on the pexpect module will not be available on Windows.

<div class="divider" id="nosudo">
<h5><span>Virtualenv</span></h5>
<!--Divider With Titling-->
</div>

Here is an example using [virtualenv](http://virtualenv.openplans.org/) to create a local self-contained install of Dexy without requiring root access.

Download and unpack virtualenv:
{{ d['virtualenv-install.sh|idio']['download-virtualenv'] }}

Create a new virtual environment:
{{ d['virtualenv-install.sh|idio']['create-virtualenv'] }}

Activate the virtualenv (you will need to do this each time you wish to use it):
{{ d['virtualenv-install.sh|idio']['activate-virtualenv'] }}

Install Dexy:
{{ d['virtualenv-install.sh|idio']['install-dexy'] }}

Check that it is working:
{{ d['virtualenv-install.sh|idio']['check-install'] }}

When you are finished, you can deactivate the virtualenv:
{{ d['virtualenv-install.sh|idio']['deactivate-virtualenv'] }}
