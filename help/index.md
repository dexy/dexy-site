## Help

There are various ways to get help. First, try to troubleshoot your problem yourself.

### Troubleshooting

The dexy log, in logs/dexy.log, has very verbose output. You can try [grepping](http://en.wikipedia.org/wiki/Grep) (or [acking](http://betterthangrep.com/)) for the document or artifact key you are having trouble with. It is worth creating a very simple Dexy project (such as one of the [project templates](https://bitbucket.org/ananelson/dexy-templates/src) and running dexy once to familiarize yourself with the log file format before you need to use it for troubleshooting your own project.

If your dexy command finished without an error occurring, there is also a more friendly HTML log which is located in logs/run-latest/index.html. You can have this page open in a browser and refresh it after each run. The logs/dexy.log file is less friendly and more confusing, but it has the benefit of being written to even when Dexy runs into an error.

If the logs aren't helpful, then you can try to search and see if there is a relevant document, bug, or forum discussion. You can use the [Dexy custom google search](http://dexy.it/search) to search this site, the Dexy blog and forum, and other sites that may contain useful information. (If you have suggestions for sites that should be included, please let us know.)

If you are getting a Jinja error, then you might find it useful to review the [Jinja template documentation](http://jinja.pocoo.org/docs/templates/). Remember that in your templates, you don't have access to the full Python, it's a very restricted subset.

When using Jinja within Dexy, a very useful technique is to create a debug.txt file to let you easily view the keys and contents of inputs you can use when composing your documents. The debug.txt and debug-full.txt files in the [code-journal-html-python project template](https://bitbucket.org/ananelson/dexy-templates/src/tip/code-journal-html-python/) are a good starting point (along with the supporting entries in the .dexy file of that project, of course).

### Support

If you are unable to troubleshoot the problem, then please do ask for help. If you are new to open source, then please take a look at [How To Ask Questions The Smart Way](http://www.catb.org/~esr/faqs/smart-questions.html) as this will save everyone time and help your question get answered faster.

You can post a question on the [support forum](http://discuss.dexy.it/). You can get in touch via twitter [@dexyit](http://twitter.com/dexyit). If you want to report a bug or request a new feature, you can do so [on bitbucket](https://bitbucket.org/ananelson/dexy/issues?status=new&status=open).


