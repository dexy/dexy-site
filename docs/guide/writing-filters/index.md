<div class="grid_8"><!-- keep things narrow and readable -->

This document is about writing your own Dexy filters. We'll start with a very simple example, then talk in depth about filter design. Please update to Dexy 0.5.1 before trying these examples (if 0.5.1 isn't out yet, then you will need to install Dexy from source and you should do a 'git pull' every time you start working to get the latest source code).

### Simple Example

You can add custom filters to any Dexy project by creating a folder in the top level of your project called 'filters'. (You can also put your custom filters in a directory called <code>~/dexy_filters</code>, where they will be available to all your projects.) You need to have a blank file named <code>\_\_init\_\_.py</code> in this directory, this is a [python thing](http://docs.python.org/tutorial/modules.html#packages).

Any filters you define in the 'filters' directory will be available to your project. Here is a simple example of a filter:

{{ d['ex1/filters/simple_filter.py|pyg'] }}

The crucial elements for simple text-based Dexy filters like this are:

 + Subclass the DexyFilter class
 + Define at least 1 unique Alias
 + Define a process_text() method to do the 'work' of your filter. This method should return the text you want to output.

Here are the files in our example:

<pre>
{{ d['ex1/list-files.sh|jinja|sh'] }}
</pre>

The dexy config is:

{{ d['ex1/config.dexy|ppjson|pyg'] }}

The input file is:

<pre>
{{ d['ex1/hello.txt'] }}
</pre>

The output generated is:

<pre>
{{ d['script-output-ex1.json']['docs']['hello.txt|simple']['1'] }}
</pre>

### Respecting Sections

The <code>process_text</code> method lets you return a single block of text. Sometimes we want to process a document in sections, and preserve those sections. You can write a filter that does this by implementing a <code>process_dict</code> method instead.

{{ d['ex2/filters/simple_sections_filter.py|pyg'] }}

Your <code>process_dict</code> method will receive an OrderedDict of sections, and you should return an OrderedDict.

Here are the files in our example:

<pre>
{{ d['ex2/list-files.sh|jinja|sh'] }}
</pre>

The dexy config is:

{{ d['ex2/config.dexy|ppjson|pyg'] }}

We pass our input file through the 'lines' filter to split it into sections. This means that each line of the file is put into a different section.

The input file is:

<pre>
{{ d['ex2/hello.txt'] }}
</pre>

The results are:

<pre>
{% for section_name, section_text in d['script-output-ex2.json']['docs']['hello.txt|lines|simplesections'].iteritems() -%}
Section: {{ section_name }}
Contents: {{ section_text }}

{% endfor -%}
</pre>

### Testing Filters

Your filters are just Python classes, so you can test them using nose or any other Python testing tool. Dexy also has a 'test' filter.

Here is an example of a unit test:

{{ d['ex3/test_simple_filter.py|pyg'] }}

<pre>
{{ d['script-output-ex3.json']['test-out'] }}
</pre>

Here is an example of using Dexy's test filter:

{{ d['ex3/config.dexy|ppjson|pyg'] }}

<pre>
{{ d['script-output-ex3.json']['ex3-run'] }}
</pre>

### File Extensions

Each Dexy filter defines INPUT_EXTENSIONS and OUTPUT_EXTENSIONS. These are a list of file extensions that the filter is capable of taking in and putting out.

At the beginning of each run, the filter will figure out what extension it should output. It will usually be the first element in the list of OUTPUT_EXTENSIONS, but the filter will check whether the next filter in line can accept that as an input. If not, it tries the rest of the OUTPUT_EXTENSIONS until it finds one. If the filter can't output anything the next filter can accept, then Dexy will raise an exception to let you know that your combination of filters is impossible. The file extension is available within your filters as <code>self.artifact.ext</code>.

Here is a filter that outputs plain text or HTML:

{{ d['ex4/filters/file_extension_aware_filter.py|pyg'] }}

The default file extension will be '.txt' because that is listed first in the OUTPUT_EXTENSIONS array. To force our filter to output HTML, we need to have another filter after it that only accepts HTML. The 'h' filter is a filter that does exactly that. It doesn't change the text it receives, it just says "you must give me HTML" so the previous filter will output HTML.

Here is our .dexy config:

{{ d['ex4/config.dexy|ppjson|pyg'] }}

Here is the plain text output:

<pre>
{{ d['script-output-ex4.json']['docs']['hello.txt|fileextension']['1'] }}
</pre>

And here is the HTML output:

<pre>
{{ d['script-output-ex4.json']['docs']['hello.txt|fileextension|h']['1'] | escape }}
</pre>

If both the INPUT_EXTENSIONS and OUTPUT_EXTENSIONS are set to ".*", then the file extension will not change when passing through the filter. i.e. if a ".txt" file comes in, it will still be a ".txt" file.

### Try It Yourself

Try creating one or two custom filters of your own now and get them to run. Remember that you can use any Python package in your filter code.

Here are some ideas:

* Write a Dexy filter which converts each character in the input to its unicode/ascii number using the ord() function. This can be helpful for debugging the output from previous filters. You can present each character on its own line, or separated by spaces, and you can decide whether or not to print the character itself after its number.
* <http://sandbox.pocoo.org/clevercss/> - Write a Dexy filter which converts CleverCSS markup to CSS.
* <https://github.com/Fantomas42/sudoku-solver/tree/master/datas> - Write a Dexy filter which takes Sudoku grids in .grid files and solves them, outputting a completed grid.
* <http://code.google.com/p/prettytable/> - Write a Dexy filter which takes CSV data and outputs a pretty table. Your filter should support both plain text and HTML output, and it should figure out which to return based on the file extension.

You can put as many filters as you want in a single module (i.e. a single file), but it's a good idea to put filters that depend on a 3rd party library into a separate module from filters that don't. This is because if you try to import a package that isn't installed, all the filters defined in that module will be unavailable, whether or not those particular filters need the missing package.

### The Process Method

When a Dexy filter is run, it is actually the filter class's <code>process</code> method that is called. The DexyFilter class implements a process method that checks whether methods named <code>process_text</code>, <code>process_dict</code> or <code>process_text_to_dict</code> exist (in that order), and it calls those methods if so. This makes it very easy to implement filters without having to worry about Dexy's internals, you just return text or a dict and that's it.

However, many filters need to do more complex things than this, and so rather than implementing one of these convenience methods, they will override the <code>process</code> method instead. When working with the <code>process</code> method, you need to be aware of the filter's artifact. The artifact is responsible for persisting the content that is generated in the filter, and the artifact is also what takes care of caching so your filter only gets run when it needs to.

If you implement a process method, then at a minimum you need to either:

* Save your output content in the artifact's data_dict, either by assigning an OrderedDict to this attribute directly, or by calling the artifact's set_data method. This only works with non-binary data.

or

* Save your output content under the correct filename for the artifact.

We will look at SubprocessStdout filters which take the first approach, and Subprocess filters which take the second approach.

### SubprocessStdoutFilters

Rather than subclassing DexyFilter, you can also subclass any other Dexy filter to recycle that filter's functionality. Many Dexy filters don't have any code, they just subclass a filter and change some class constants.  The SubprocessStdoutFilter is designed to be easily subclassed to implement new filters that run an executable on an input file (with optional command line arguments) and return whatever gets written to STDOUT.

Here is the process method of the SubprocessStdoutFilter class:

{{ d['/source.json']['dexy.filters.stdout_filters.SubprocessStdoutFilter.process'] }}

The <code>previous_artifact_filename</code> attribute of the artifact stores the cache file location of the previous artifact's output, which is this artifact's input. This filename is the one that our executable will run on. (The filename is written to the log so you can inspect the file, and even run it manually, which can be useful for troubleshooting.) In the last line, the contents of stdout are passed to the artifact's <code>set_data</code> method.

{{ d['/source.json']['dexy.artifact.Artifact.set_data'] }}

Later, Dexy will automatically save the contents of the <code>data_dict</code> in the cache.

The default command string is:

{{ d['/source.json']['dexy.filters.stdout_filters.SubprocessStdoutFilter.command_string_stdout'] }}

So, in the simplest cases, you can create a new filter just by subclassing this filter and set some constants, like this:

{{ d['/classes.json']['dexy.filters.stdout_filters.BashSubprocessStdoutFilter']['source'] }}

Or this:

{{ d['/classes.json']['dexy.filters.stdout_filters.PythonSubprocessStdoutFilter']['source'] }}

If you need to, you can override the <code>command_string_stdout</code> method if you need to pass arguments in a different order or pass different arguments, for example:

{{ d['/classes.json']['dexy.filters.stdout_filters.CowsaySubprocessStdoutFilter']['source'] }}

If you created your own custom filter earlier, then try to create another one now by subclassing SubprocessStdoutFilter. Set the EXECUTABLE to be the name of the command you want to call. Remember, this command should just print its output, not write it to a file (the next section deals with programs that write their output to a file).

You can override <code>command_string_stdout</code> if you need to, but remember that you can include arguments in the EXECUTABLE string and you can pass additional arguments to your filter from the .dexy file, so think about those options first. In the Ragel-for-Ruby filter, we always want to call ragel with the <code>-R</code> option, so we include this in the EXECUTABLE string. You can pass arguments to any SubprocessFilter-based filter by including an 'args' dict in your .dexy file, where each key is a filter alias and the value is the args you want to pass to that filter. For examples check out the [cowsay filter docs](/docs/filters/cowsay).

### SubprocessStdoutInputFilters

In the previous section, we just ran a command on a file and captured the output. Sometimes we also need to have additional inputs. For example, we might write a sed script and want to run this through the sed filter, along with one or more text files. Or, your Python or Ruby script might read STDIN to get user input, and you want to simulate this in your documentation.

In these cases, your sed, python or ruby script is the file that gets put through the filter. Dexy uses inputs to pass other information to a filter. The SubprocessStdoutInputFilter class handles this for you, you can subclass this if you need to create a filter where you run your script and also pass additional information to it.

Check out the [sed](/docs/filters/sed), [shinput (bash)](/docs/filters/shinput) and [pyinput (python)](/docs/filters/pyinput) filter docs for some examples. The sed filter also overrides <code>command_string_stdout</code>.

These examples mostly have plain text files being used as inputs, but inputs can be any other Dexy document, so you can use jinja templates, or the output from other scripts, or pretty much anything else as your additional inputs.

### SubprocessFilters

With some tools, the natural thing to do is to capture STDOUT. With others, it makes more sense to have the executable write its output directly to a file. Particularly where the output is binary content, like an image.

Here is the process method of the SubprocessFilter class:

{{ d['/source.json']['dexy.filters.process_filters.SubprocessFilter.process'] }}

The default command string is:

{{ d['/source.json']['dexy.filters.process_filters.SubprocessFilter.command_string'] }}

In this case, the generated content is written directly to the cache under the correct file name, which is available from <code>self.artifact.filename()</code>. The <code>self.artifact.stdout</code> attribute is set to whatever gets written to stdout or stderr, which is going to be debugging or error messages.

Here is a simple filter that just needs constants set:

{{ d['/classes.json']['dexy.filters.subprocess_filters.Ps2PdfSubprocessFilter']['source'] }}

Here is a filter that overrides the <code>command_string</code> method:

{{ d['/classes.json']['dexy.filters.subprocess_filters.RagelRubySubprocessFilter']['source'] }}

You can also do other setup work in the <code>command_string</code> method:

{{ d['/classes.json']['dexy.filters.subprocess_filters.Html2PdfSubprocessFilter']['source'] }}

And, here is a filter that overrides the <code>process</code> method while still taking advantage of several helper methods defined in the SubprocessFilter class:

{{ d['/classes.json']['dexy.filters.subprocess_filters.Pdf2ImgSubprocessFilter']['source'] }}

And it, in turn, can be subclassed:

{{ d['/classes.json']['dexy.filters.subprocess_filters.Pdf2JpgSubprocessFilter']['source'] }}
