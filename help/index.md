Having trouble? Need help? Check out the Troubleshooting Tips and other suggestions on this page. If you get stuck, please ask for help, the [Support](#support) section has ways to get in touch.

<div class="divider"><h5><span>Where To Find Information</span></h5></div>

The various dexy commands have a lot of command line arguments which may help you to solve or at least narrow down your problem or question. Run <code>dexy help</code> to see a list of commands, and <code>dexy help -on dexy</code> for available arguments to the <code>dexy</code> command.

Each of the dexy filters has [its own documentation page](/docs/filters/) including the full source code for the filter. If you are having trouble with a particular filter, check the doc page for examples or tips. Sometimes you can figure out what to do by looking at the source code. You can always get to any filter's page by going to <code>http://dexy.it/docs/filters/alias</code> where <code>alias</code> is any of the filter's aliases. This will redirect you to the page for that filter. For example, <http://dexy.it/docs/filters/py> or <http://dexy.it/docs/filters/python> will bring you to the Python stdout filter doc page.

<div class="divider"><h5><span>Tips for Beginners</span></h5></div>

If you get an error message, don't panic :-) and make sure to read it carefully. It might be something that you can figure out by looking at the source code files that are referred to in the error message's stack trace. Also, the error message might contain instructions suggesting that you report a bug or telling you how to fix the problem. Make sure that what you are seeing is actually an error, sometimes a message that looks scary is actually not a real problem but just a warning message about some minor but not serious issue. You can use the error message to help search for a solution online. Remove any terms that are specific to your project or your computer because these won't show up in somebody else's error report. Finally, if you end up asking for help, you should copy and paste the full error message and stack trace into your support request (see How To Ask Questions link below).

The dexy log, in logs/dexy.log, has a lot of information. Probably too much information, it can be a little overwhelming, especially in large projects, but this can be a very important resource when things go wrong (or just to learn more about how Dexy works). It is worth creating a very simple Dexy project (such as one of the [project templates](https://bitbucket.org/ananelson/dexy-templates/src)) and running dexy on it to familiarize yourself with the log file format. You can simply open the log file in a text editor or a console viewer, or you can try [grepping](http://en.wikipedia.org/wiki/Grep) (or [acking](http://betterthangrep.com/)) for the document or artifact key you are having trouble with. If the log is really overwhelming, then delete logs/dexy.log and run dexy again. This way you know the contents of logs/dexy.log relate to a single dexy run.

There is also a much more user-friendly log format which is saved to logs/run-latest/index.html. You can have this page open in a browser and refresh the page after each run of Dexy to see the latest information. This has most of the same information as the dexy.log file, but presented in a way that is much easier to understand. The disadvantage of this HTML format is that, if something goes wrong that stops Dexy from finishing, it won't get generated. So, when things go wrong you might need to use the uglier, but more robust, dexy.log file.

<div class="divider"><h5><span>Troubleshooting Tips</span></h5></div>

If a script generates an error, or if dexy is interrupted while it's running, elements in the cache may be corrupted. This may cause problems with later dexy runs. A good first step in debugging is to run dexy with the -nocache option or, even better, run <code>dexy reset</code> to get rid of all artifacts and logs (this does mean you will lose your history). If this doesn't fix the problem, it will make it easier to debug.

If you are getting a Jinja error, then you might find it useful to review the [Jinja template documentation](http://jinja.pocoo.org/docs/templates/). Remember that in your templates, you don't have access to the full Python, it's a restricted subset. You can enclose sections of your document in <code>{{ "{% if False %}" }}</code> and <code>{{ "{% endif %}" }}</code> to temporarily disable jinja processing for that section (make sure any for loops or if blocks are fully inside or fully outside of these). If you are having trouble with referencing other documents, then a good trick is to print out <code>d.keys()</code> within your document.

If dexy stops in the middle of a run, it will try to tell you which document caused the problem. You can also look at the end of the dexy.log file to see the last file that was processed. The artifacts directory will contain working files which might have clues about what went wrong. If you look or search further back in dexy.log you should be able to figure out which files you want to look at, also you can look at the filter source code to see which files the filter works on.

<div class="divider"><h5><span>Search</span></h5></div>

You can use the [google custom search](/search) to search this site, the blog, forum and other relevant sites.

<div id="support" class="divider"><h5><span>Support</span></h5></div>

If you are unable to solve the problem, or if you have questions or feedback, then please get in touch. If you solved your problem but you think it might affect other people, or if you think the documentation should be improved to help people solve or prevent the type of problem you encountered, then we'd really like to hear your suggestions or feedback. If you are new to open source, then please take a look at [How To Ask Questions The Smart Way](http://www.catb.org/~esr/faqs/smart-questions.html) as this will save everyone time and help your question get answered faster.

You can post a question on the [support forum](http://discuss.dexy.it/). You can get in touch via twitter [@dexyit](http://twitter.com/dexyit). If you want to report a bug or request a new feature, you can do so [on bitbucket](https://bitbucket.org/ananelson/dexy/issues?status=new&status=open).
