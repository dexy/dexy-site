# Code Journal

## Some R Examples

An example of using Dexy to document an R script in HTML, including using the filename filter and referencing generated graphs.

First we assign variables:

{{ d['code001.R|fn|idio|rint|pyg']['assign-variables'] }}

Let's do some multiplication:

{{ d['code001.R|fn|idio|rint|pyg']['multiply'] }}

Here's the source code of a graph:

{{ d['code001.R|fn|idio|rint|pyg']['graph'] }}

Here is the graph:

![simple plot](plot.png)


### Complete Script

{{ d['code001.R|pyg'] }}
