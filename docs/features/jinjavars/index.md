## Jinjavars

Sometimes we want to be able to directly specify values in a .dexy configuration file that we can use in our templates. For example, we may want to specify a version number so we use this consistently throughout our document. It's better practice to generate a version number by some automated means, but there are times when this isn't practical, and of course you might have other reasons for wanting to use this functionality.

In the document configuration, if you create a JSON object named "jinjavars" then the variable names you specify, and their corresponding values, will be available when jinja processing is done. Values will be converted using standard JSON processing.

Here are some variables:

<pre>
{{ d['.dexy|dexy'] }}
</pre>

Here is the document template:

<pre>
{{ d['jinjavars.txt|dexy'] }}
</pre>

And here is what the result looks like:

<pre>
{{ d['jinjavars.txt|jinja'] }}
</pre>

The global_var is set in a different .dexy file. See [globals](../global-args/) for more information.
