This document covers how to run code using Dexy. We will look at both compiled and interpreted code, how to run code that needs input from other files, and writing your own custom filters to add support for a new language or to create a custom implementation.

You might want to run code for different reasons. You might want to show a transcript of interpreted code for a tutorial. You might want to show the output from running interpreted or compiled code. Or, you might want to run code for its side effects, like generating data files or graphs. Because of this, it is common to have multiple filters for each language, to enable different modes of running code.

There are two mechanisms used behind the scenes to execute code. One is Python's subprocess module, the other is the pexpect package. The subprocess module allows us to execute complete scripts in batch mode. The pexpect module allows us to have a virtual REPL and to execute code in sections and retrieve the output of each section separately. This is very useful for writing documentation where you want to break scripts up into small chunks and explain what's happening in each one. Unfortunately, pexpect is not available on Windows. In some cases, we can still retrieve a REPL-style transcript using subprocess, where the interpreter makes this possible (for example, you can run R in batch mode and get a transcript which looks identical to interacting with the REPL).

Subprocess-based filters are a little more robust, available on all platforms, and suitable for tasks like running code for side effects, running code for the output, and running code that needs input from other files. Pexpect-based filters let you break code into sections and run it in a REPL, but they are not available on Windows, and you can't simulate STDIN (because the filter is using STDIN to feed in your script line-by-line).

So, we can have stdout output vs. REPL/transcript output, subprocess vs. pexpect, and input text vs. no input text. This makes for 8 possible modes according to this breakdown. In the following table, combinations that are probably impossible are marked in red, combinations that are difficult enough to not be implemented yet are marked in orange, successfully implemented combinations are marked in green.

<table>
<tr><th rowspan="3">Language</th><th colspan="4">Output</th><th colspan="4">Transcript/REPL</th></tr>
<tr>                             <th colspan="2">Subprocess</th><th colspan="2">Pexpect</th>
                                 <th colspan="2">Subprocess</th><th colspan="2">Pexpect</th></tr>
<tr>
    <th>No Input</th><th>Input</th>
    <th>No Input</th><th>Input</th>
    <th>No Input</th><th>Input</th>
    <th>No Input</th><th>Input</th>
</tr>
<tr>
    <td>Python</td>
    <td style="background-color: green;"><a href="/docs/filters/py">py</a></td>
    <td style="background-color: green;"><a href="/docs/filters/pyinput">pyinput</a></td>
    <td style="background-color: orange;" title="Might work using calls to send() and read() rather than expect(), haven't tried this yet."></td>
    <td style="background-color: red;"></td>
    <td colspan="2" style="background-color: red;" title="Have tried several options but can't get python or ipython to show linewise input when running in batch mode. 'python -i' forces a prompt but only after running file contents."></td>
    <td style="background-color: green;"><a href="/docs/filters/pycon">pycon</a><br /><a href="/docs/filters/ipython">ipython</a></td>
    <td style="background-color: red;"></td>
</tr>
<tr>
    <td>Ruby</td>
    <td style="background-color: green;"><a href="/docs/filters/rb">rb</a></td>
    <td style="background-color: green;"><a href="/docs/filters/rbinput">rbinput</a></td>
    <td style="background-color: orange;" title="Might work using calls to send() and read() rather than expect(), haven't tried this yet."></td>
    <td style="background-color: red;"></td>
    <td style="background-color: green;"><a href="/docs/filters/irbout">irbout</a></td>
    <td style="background-color: green;"><a href="/docs/filters/irboutinput">irboutinput</a></td>
    <td style="background-color: green;"><a href="/docs/filters/irb">irb</a></td>
    <td style="background-color: red;"></td>
</tr>
</table>

