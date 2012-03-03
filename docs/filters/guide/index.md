This is an in-depth guide to dexy filters.

The basic steps to implementing a new filter in Dexy are:

1. subclass the DexyFilter class
1. assign one or more unique aliases
1. implement a process_text() method

Here is an example of a very simple filter:

{{ d['../filter-info.json']['HeadFilter']['html_source'] }}

If you want to write a Hello, World filter, or if your filter involves simple text processing, perhaps using a Python library, then this is all you need to do.

Here's another example of a simple text processing filter:

{{ d['../filter-info.json']['StartSpaceFilter']['html_source'] }}

That filter was recently added to Dexy because Mediawiki, the software that runs wikipedia, will only display pre-formatted code correctly if you start each line with a space. With this filter, it's easy for us to apply syntax highlighting to code using Dexy, and to publish that to a Mediawiki page.

The DexyFilter class defines a method called 'process' which sets up convenience methods process_text, process_dict and process_text_to_dict which you can implement. This method also shows you what you need to implement if you decide to subclass the 'process' method in your subclass:

{{ d['/dexy-source.txt|pydoc']['dexy']['dexy.dexy_filter.DexyFilter.process'] }}

In the case of non-binary data, the artifact's data_dict attribute needs to be set to a dict that contains the output. In the case of binary data (such as an image), the binary data needs to be written to the file specified in artifact.filename().


