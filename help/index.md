## Help

First, some general suggestions and reminders.

Dexy has a lot of command line options which may help you to solve or at least narrow down your problem or question. Run *dexy help* to see what these options are. These may also give you ideas about things you can do with Dexy that you hadn't thought of.

If a script generates an error, or if dexy is interrupted while it's running, elements in the cache may be corrupted. This may cause problems with later dexy runs. A good first step in debugging is to run dexy with the -nocache option or, even better, run *dexy reset* to get rid of all artifacts and logs (this does mean you will lose your history).

Each of the dexy filters has [its own documentation page](/docs/filters/) including the full source code for the filter. If you are having trouble with a particular filter, check the doc page for examples or tips. Sometimes you can figure out what to do by looking at the source code. You can always get to any filter's page by going to http://dexy.it/docs/filters/alias where alias is any of the filter's aliases. This will redirect you to the page for that filter. For example, <http://dexy.it/docs/filters/py> or <http://dexy.it/docs/filters/python> will bring you to the Python stdout filter doc page.

The fastest way to solve your problem is usually to try to solve it by yourself first, see the suggestions in the Troubleshooting section, but don't be afraid to get in touch and ask for help at any time, especially if you are new to Python. See the Support section below for how to get in touch.

### Troubleshooting

If you are getting an error or some unexpected behaviour is occurring, here are some tips for trying to troubleshoot it.

If you get an error message, don't panic :-) and make sure to read it carefully. It might be something that you can figure out by looking at the source code files that are referred to in the error message's stack trace. Also, the error message might contain instructions suggesting that you report a bug or telling you how to fix the problem. Make sure that what you are seeing is actually an error, sometimes a message that looks scary is actually not a real problem but just a warning message about some minor but not serious issue. You can use the error message to help search for a solution online. Remove any terms that are specific to your project or your computer because these won't show up in somebody else's error report. Finally, if you end up asking for help, you should copy and paste the full error message and stack trace into your support request (see How To Ask Questions link below).

The dexy log, in logs/dexy.log, has a lot of information. Probably too much information, it can be a little overwhelming, especially in large projects, but this can be a very important resource when things go wrong (or just to learn more about how Dexy works). It is worth creating a very simple Dexy project (such as one of the [project templates](https://bitbucket.org/ananelson/dexy-templates/src) and running dexy on it (just once) to familiarize yourself with the log file format. You can simply open the log file in a text editor or a console viewer, or you can try [grepping](http://en.wikipedia.org/wiki/Grep) (or [acking](http://betterthangrep.com/)) for the document or artifact key you are having trouble with. If the log is really overwhelming, then delete logs/dexy.log and run dexy again. This way you know the contents of logs/dexy.log relate to a single dexy run.

There is also a much more user-friendly log format which is saved to logs/run-latest/index.html. You can have this page open in a browser and refresh the page after each run of Dexy to see the latest information. This has most of the same information as the dexy.log file, but presented in a way that is much easier to understand. The disadvantage of this HTML format is that, if something goes wrong that stops Dexy from finishing, it won't get generated. So, when things go wrong you might need to use the uglier, but more robust, dexy.log file.

After you've looked at the logs and learned what there is to learn from them, then you can try to search and see if there is a relevant document, bug, or forum discussion. You can use the [Dexy custom google search](http://dexy.it/search) to search this site, the Dexy blog and forum, and other sites that may contain useful information. (If you have suggestions for sites that should be included, please let us know.)

If you are getting a Jinja error, then you might find it useful to review the [Jinja template documentation](http://jinja.pocoo.org/docs/templates/). Remember that in your templates, you don't have access to the full Python, it's a very restricted subset.

When using Jinja within Dexy, a very useful technique is to create a debug.txt file to let you easily view the keys and contents of inputs you can use when composing your documents. The debug.txt and debug-full.txt files in the [code-journal-html-python project template](https://bitbucket.org/ananelson/dexy-templates/src/tip/code-journal-html-python/) are a good starting point (along with the supporting entries in the .dexy file of that project, of course).

### Support

If you are unable to solve the problem, or if you have questions or feedback, then please do get in touch. If you solved your problem but you think it might affect other people, or if you think the documentation should be improved to help people solve or prevent the type of problem you encountered, then we'd really like to hear your suggestions or feedback. If you are new to open source, then please take a look at [How To Ask Questions The Smart Way](http://www.catb.org/~esr/faqs/smart-questions.html) as this will save everyone time and help your question get answered faster.

You can post a question on the [support forum](http://discuss.dexy.it/). You can get in touch via twitter [@dexyit](http://twitter.com/dexyit). If you want to report a bug or request a new feature, you can do so [on bitbucket](https://bitbucket.org/ananelson/dexy/issues?status=new&status=open).

Finally, if you have any tips or resources you think could improve this page, let us know (or just submit a patch!).
