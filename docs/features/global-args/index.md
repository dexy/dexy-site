## Global Args

When we create documents, we can pass along arguments, such as {"allinputs" : true}. Sometimes it is useful to have global arguments which apply to all documents. For example, we may wish to set a [jinja variable](../jinjavars/) that applies to every jinja document. Simply create an item named $globals, and its arguments will be passed on to all docs to which that .dexy file applies.

Globals inherit in the same way as config files do, so globals can be overridden or supplemented by creating a .dexy file in a subdirectory, and also any local arguments will override global arguments with the same name. If a global argument is a dict (as in the case of our jinjavars example), it will be merged with the corresponding local dict, and the local dict's entries will take precedence.

<pre>
{{ d['docs/.dexy|dexy'] }}
</pre>

You can always see which args are in effect for a given document by looking at the [logs](/logs/run-latest/).

