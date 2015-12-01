<font color='red'>deprecated - you will find this tool distributed under the RedTamarin SDK</font>

## Introduction ##

**swc2abc** is a command-line tool made with [redtamarin](http://code.google.com/p/redtamarin/).

it basically unzip a SWC, and extract the ABC from the `library.swf`<br>
nothing fancy, just a little helper.<br>
<br>
<h2>Installation</h2>

Download the file for your operating system.<br>
<br>
<table><thead><th> Linux </th><th> OS X </th><th> Windows </th></thead><tbody>
<tr><td> n/a   </td><td>  n/a </td><td> n/a     </td></tr></tbody></table>

<b>get the source code</b><br>
<code>svn checkout http://maashaack.googlecode.com/svn/tools/swc2abc/trunk/ swc2abc-read-only</code>

<b>browse the source code</b><br>
<a href='http://code.google.com/p/maashaack/source/browse/#svn%2Ftools%2Fswc2abc%2Ftrunk'>/tools/swc2abc/trunk</a>

<b>notes:</b><br>
<ul><li>OS X file is for OS X 10.6+ intel<br>
</li><li>OS X and Linux file probably require to be chmoded<br><code>$ chmod +x swfinfo</code>
</li><li>Linux binary is compiled for Ubuntu</li></ul>


<h2>Documentation</h2>

<b>Usage</b>
<pre><code>swc2abc [-h] [-v] [-L] file<br>
</code></pre>