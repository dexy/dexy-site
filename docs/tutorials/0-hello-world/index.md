# 00

This tutorial is mostly about making sure that everything is installed correctly and working.

You need Python installed in order for Dexy to work, and of course you need Dexy installed to use Dexy!

If you haven't already, please [read the instructions](http://dexy.it/install) and install Dexy. If you installed Dexy a while ago then you should install it again to upgrade to the latest version.

To check if Dexy is installed:

{{ d['version.sh|pyg'] }}

{% if False -%}

Note dexy --version writes to stderr not stdout so this will not work as written

This tutorial was tested using Dexy version:

<pre>
{{ d['version.sh|bash'] }}
</pre>
{% endif %}

Too see the documentation for the Dexy command:

{{ d['help.sh|pyg'] }}

Here are the options currently available (may be slightly different depending on your version of Python):

<pre>
{{ d['help.sh|bash'] }}
</pre>

Now we are going to create a very simple file to illustrate one of the most important Dexy filters, the Jinja filter, and to learn about how to run Dexy and what output is generated.

Create a new, empty directory to work in. Create a text file, you can name it hello.txt, and type the following into it:

<pre>
{{ d['00/hello.txt|dexy'] }}
</pre>

The curly brackets are [Jinja](http://jinja.pocoo.org/) tags, and soon they will be how we are going to get Dexy to incorporate code and other fun stuff into our documents.

Next we need to give Dexy some instructions about what files we want Dexy to process, and what we want done to those files. Dexy looks for configuration files named .dexy (later we'll see how to name them something else), so create another text file named .dexy and type the following into it:

{{ f.pre_and_clippy(d['00/.dexy|dexy']) }}

This is a little [JSON](http://www.json.org/) which is the file format we currently use for writing configuration files for Dexy. In terms of JSON elements, we have an object containing a single key/value pair whose key is "*.txt|jinja" and whose value is another object which happens to be empty, i.e. {}. For now, you don't need to worry too much about this, just type it in exactly as you see it here.

Now we are ready to run dexy! The first time you run dexy you will need to call dexy with the --setup flag so it can create some directories it needs (this is a safety measure so you don't run Dexy in the wrong directory):
{{ d['run-00.sh|idio']['run'] }}

Look to see what new directories have been created and feel free to poke around. Dexy puts the finished documents into the output-long/ directory where they are named with the base filename, any filters they have been passed through separated with hyphens, and finally the correct final file extension. So, you should now be able to type:

{{ d['run-00.sh|idio']['cat'] }}

And you should see something like this:

<pre>
{{ d['00/hello.txt|jinja'] }}
</pre>

Jinja has taken the 1+1 which we typed within the Jinja tag and evaluated it, giving 2. So, this tells us that Dexy has successfully called the jinja filter to run on the text file we wrote.

Dexy also places files in directories called artifacts/ and logs/. At this point you should look in the logs/ directory and open the run reports, and also look at the contents of the dexy.log file.

The files stored in the artifacts/ directory mean that the next time you run Dexy, it won't need to reprocess every file. Dexy will only reprocess files whose contents have changed, or which depend on other files which have changed. If for some reason you want Dexy to reprocess everything, then you can run dexy with the --purge option and the artifacts/ files will be emptied. You can also run dexy with the --cleanup option and all dexy-generated files and reports will be removed.

To learn more:

* read more about [Jinja](http://jinja.pocoo.org) if you haven't used it before
* study the log file and look at the contents of the artifacts/ directory
* run dexy with the --help option and try to figure out what the command line options do (some of them relate to features you haven't seen yet, but many should make sense now)

# 01

Now we are going to get Dexy to do something more useful and interesting, we are going to write some Python code and then modify our hello.txt file so that we can see the contents of the Python file and also run the file to see the outcome.

Let's write a simple script called hello.py, and save this in the same directory where we've been working (if you want you can make a copy of this directory so that you still have your original example). Here is what the script should look like:

{{ d['01/hello.py|pyg'] }}
{{ f.clippy_helper(d['01/hello.py|dexy']) }}

You should run "python hello.py" from the command line to make sure that this script works.

Next we are going to modify the .dexy file. We want to add a line to tell Dexy to execute the Python file. We could use a wildcard again, but because running a Python script can have side effects, it's probably safer to mention this file by name in case we later add another Python file in this directory and Dexy runs it without us meaning for that to happen.

Modify your .dexy file so that it looks like this:

{{ f.pre_and_clippy(d['01/.dexy|dexy']) }}

We discussed briefly how each item in here is a key-value pair. Our 'values' are still empty objects like {}, we'll add something in the next step, but let's look at the keys now.

We have a file name, or a wildcard expression, followed by the pipe symbol "|" and a filter alias. The file name tells Dexy which file (or pattern) to operate on, and the filter aliases tell Dexy what to do to that file. We have said that all the text files should be run through a filter identified by 'jinja', and we have said that the file named 'hello.py' should be run through a filter identified by 'py'. The Dexy jinja filter treats the text file that gets input as a Jinja template, and so it looks for all the Jinja tags and evaluates what's inside. (You can see documentation for the jinja filter [here](http://www.dexy.it/docs/filters/jinja)). The Dexy 'py' filter means that the Python interpreter gets run on whatever script is passed to it, the documentation is [here](http://dexy.it/docs/filters/py).

If you have written your script and modified your .dexy configuration file as shown, then you can call dexy again. Unless you have removed them, you already have the directories that Dexy needs to run so this time you don't need the --setup flag and you can just do:

{{ d['run-01.sh|idio']['run'] }}

Now there should be a file containing the output of running the Python script, so you should be able to do:

{{ d['run-01.sh|idio']['cat'] }}

And you should see something like this:

<pre>{{ d['docs/tutorials/0-hello-world/01/hello.py|py'] }}</pre>

# 02

Now we're finally ready to start using Dexy to document code!

Let's first modify the .dexy file so it looks like this:

{{ f.pre_and_clippy(d['02/.dexy|dexy']) }}

We've made 3 changes here.

First, we've added a new item, "hello.py|dexy" saying that we want to run the hello.py file through the dexy filter. We can run the same file through as many different filters as we want. The 'dexy' filter is a dummy filter which basically says "give me the text in the original file without changing it", so hello.py|dexy will just give us the contents of hello.py

Secondly, we've changed the first item from "*.txt" to "hello.txt", so we're referencing a particular file instead of all text files.

Thirdly, we're going to finally put something in those empty curly brackets for the first entry, "hello.txt|jinja"! The curly brackets represent another JSON object, so again the format will be "key" : value. Now the key is the word "inputs", and the value is an array (indicated by square brackets) containing references to "hello.py|py" and "hello.py|dexy".

We'll come back to these a little more after we run our example. Now let's add some more lines to our hello.txt file:

<pre>
{{ d['docs/tutorials/0-hello-world/02/hello.txt|dexy'] }}
</pre>

The 'd' inside the jinja tags is a dictionary which Dexy has created. This dictionary (i.e. a hashmap of key-value pairs) has stored in it the contents of "hello.py|py" and "hello.py|dexy". Dexy stored these contents in the dictionary because we specified in the inputs array that we wanted these available as inputs. Now that we are writing our documents, we simply retrieve these items from this dictionary wherever we want them.

Now try running Dexy, and then do:

{{ d['run-02.sh|idio']['cat'] }}

Hopefully you will see something like this:

<pre>
{{ d['docs/tutorials/0-hello-world/02/hello.txt|jinja'] }}
</pre>

So, we wrote a document containing both the Python code and its output. Try changing the Python code, e.g. initialize x a different value, and run Dexy again.

We could have written our .dexy configuration file a few different ways to get this same result.

For one thing, because we listed "hello.py|py" and "hello.py|dexy" in the inputs array, they don't have to be listed again as files. Any file explicitly defined in an inputs array will be created anyway. (However, it's not possible to pass extra arguments to files defined in this way so usually you'll want to list them separately.) So, this would have worked as a configuration file too (try it):

<pre>
{{ d['docs/tutorials/0-hello-world/02/implicit.dexy|dexy'] }}
</pre>

And, we also don't have to list every dependency explicitly. Dexy has a shortcut form:

<pre>
{{ d['docs/tutorials/0-hello-world/02/allinputs.dexy|dexy'] }}
</pre>

The "allinputs" flag tells Dexy that we want everything else in the .dexy file to be available to our document. In practice this is usually the best option. Note that here we have gone back to "*.txt" rather than "hello.txt".

Here are some ideas you can try now to explore how Dexy works:

* Change the Python script and re-run Dexy to see what happens.
* Try these different options for the .dexy file format, re-run Dexy to make sure they work.
* Write a .dexy file which uses wildcards everywhere.
* Write a second Python script and include this in your hello.txt file also. (You might need to modify your .dexy file - unless you are using wildcards everywhere.)
* Create a second .txt file and include the source and output of your Python script(s) in a different way. (You might need to modify your .dexy file - unless you are using wildcards everywhere.)
* Create a .txt file which lists all the objects present in d. ([This](http://docs.python.org/tutorial/datastructures.html#tut-dictionaries) Python documentation might be helpful.) How might this be helpful when composing documents?
* Look at the list of filters [here](http://dexy.it/docs/filters). Read the documentation and look at the source code for all the filters we have used. Feel free to try other filters (if you have the necessary software installed).
* Read the [jinja](http://jinja.pocoo.org/docs) documentation. Try using one of the [built-in filters](http://jinja.pocoo.org/docs/templates/#builtin-filters) in your document.

[next tutorial](/docs/tutorials/1-python)
[tutorial home](/docs/tutorials/)
