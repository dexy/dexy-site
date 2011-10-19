You need the garlicsim and garlicsim_lib Python packages installed for this tutorial. You also need R installed and the "rjson" package installed within R.

# 00

We are going to run a Python script to generate some data, then run R to analyze that data and (eventually) make some graphs.

Here is the [Python script](00/run-prisoner.py):

{{ d['00/run-prisoner.py|pyg'] }}
{{ f.clippy_helper(d['00/run-prisoner.py|dexy']) }}

You can run this from the command line and you should see a CSV file and a JSON file after you run it.

Here is the [R script](00/prisoner.R):

{{ d['00/prisoner.R|pyg'] }}
{{ f.clippy_helper(d['00/prisoner.R|dexy']) }}

If you run this (AFTER you run the python script) you should get some PNGs and another JSON file.

# 01

However, we don't want to have to run these files manually and in the correct order, and we also don't want the generated files cluttering up our workspace.

Dexy has a random filename generator. It looks for filenames starting with <code>dexy--</code> and it generates a random filename which is different each time you run Dexy.

In order for prisoner.R to have access to the random filenames generated for run-prisoner.py, we need to have run-prisoner.py as an input to prisoner.R.

{{ f.pre_and_clippy(d['01/.dexy|dexy']) }}

Here is how you might write a HTML file to show these:

{{ d['01/doc.html|pyg'] }}
{{ f.clippy_helper(d['01/doc.html|dexy']) }}

<iframe src="01/doc.html" width="500px" height="300px">
</iframe>

[tutorial home](/docs/tutorials/)
