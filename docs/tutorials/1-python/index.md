<div class="divider">
<h5><span>00</span></h5>
<!--Divider With Titling-->
</div>

In this tutorial we start creating HTML documents and learn about some of the different Python filters.

Let's start by writing a short Python script:

{{ d('00/script.py|pyg') }}
{{ clippy_helper(d('00/script.py')) }}

And a simple HTML file which includes it:

{{ d('00/doc.html|pyg') }}
{{ clippy_helper(d('00/doc.html')) }}

Here is the .dexy configuration to run this.

{{ pre_and_clippy(d('00/.dexy')) }}

Then by running this:

{{ d('run-00.sh|idio')['run'] }}

You should generate a html file that looks like this:

<iframe src="00/doc.html" width="300px" height="200px">
</iframe>

<div class="divider">
<h5><span>01</span></h5>
<!--Divider With Titling-->
</div>

Now that we're using HTML, let's make this output a little more colorful by applying syntax highlighting to our source code. Dexy's jinja filter automatically generates CSS for syntax highlighting if you have pygments installed (it should have been installed automatically when you installed dexy).

Here's how you include this in your HTML:

{{ d('01/doc.html|pyg') }}
{{ clippy_helper(d('01/doc.html')) }}

The 'pygments' object is a dict which contains CSS (and also LaTeX) stylesheets in various styles. Just pass the name of the style with the appropriate file extension to include it in your HTML header. You could also put this in a separate .css file.

Next we need to tell dexy to apply syntax highlighting:

{{ pre_and_clippy(d('01/.dexy')) }}

After you run dexy, if you open the generated html file in a web browser, you should be able to see the Python source code with syntax highlighting:

<iframe src="01/doc.html" width="300px" height="200px">
</iframe>

<div class="divider">
<h5><span>02</span></h5>
<!--Divider With Titling-->
</div>

Next we want to run the code. Add a line to the .dexy file:

{{ pre_and_clippy(d('02/.dexy')) }}

And update the html file:

{{ d('02/doc.html|pyg') }}
{{ clippy_helper(d('02/doc.html')) }}

<iframe src="02/doc.html" width="300px" height="200px">
</iframe>

<div class="divider">
<h5><span>03</span></h5>
<!--Divider With Titling-->
</div>

Now, let's change this so that instead of showing the code and, separately, showing the output, we just show a console transcript.

{{ pre_and_clippy(d('03/.dexy')) }}

And update the html file:

{{ d('03/doc.html|pyg') }}
{{ clippy_helper(d('03/doc.html')) }}

Different filters can be used depending on which style of code presentation you like. Sometimes the console view is useful, other times you will only want to show the output.

<iframe src="03/doc.html" width="300px" height="200px">
</iframe>

<p><a href="/docs/tutorials/2-python-r/" class="button light small">Next Tutorial</a></p>
<p><a href="/docs/tutorials" class="button dark small">Tutorials Home</a></p>
