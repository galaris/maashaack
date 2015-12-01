<font color='red'>deprecated - you will find this tool distributed under the RedTamarin SDK</font>

# About #

**abcdump** is a tool originating from [Tamarin utils](http://hg.mozilla.org/tamarin-redux/file/2d410bbd0312/utils/abcdump.as) that allow to display the contents of abc or swf files.

| **package** | **FPAPI** | **CC** | **dependencies** | **cross-platform** | **redtamarin** |
|:------------|:----------|:-------|:-----------------|:-------------------|:---------------|
| n/a         | n/a       | n/a    | n/a              | yes                | 0.3.2          |

| **browse** | [/tools/abcdump/trunk](http://code.google.com/p/maashaack/source/browse/#svn%2Ftools%2Fabcdump%2Ftrunk) |
|:-----------|:--------------------------------------------------------------------------------------------------------|
| **checkout** | `svn checkout http://maashaack.googlecode.com/svn/tools/abcdump/trunk abcdump-read-only`                |

<a href='http://maashaack.googlecode.com/svn/libs/trunk/exe/win/abcdump.exe'><img src='http://maashaack.googlecode.com/svn/gfx/win.png' align='left' /></a>
<a href='http://maashaack.googlecode.com/svn/libs/trunk/exe/osx/abcdump'><img src='http://maashaack.googlecode.com/svn/gfx/osx.png' align='left' /></a>
<a href='http://maashaack.googlecode.com/svn/libs/trunk/exe/osx105/abcdump'><img src='http://maashaack.googlecode.com/svn/gfx/osx105.png' align='left' /></a>
<a href='http://maashaack.googlecode.com/svn/libs/trunk/exe/nix/abcdump'><img src='http://maashaack.googlecode.com/svn/gfx/nix.png' align='left' /></a>

<br>
<br>
<br>
<b>notes:</b><br>
<ul><li>OS X and Linux file probably require to be chmoded<br><code>$ chmod +x swfinfo</code>
</li><li>Linux binary is compiled for Ubuntu, but should work with Debian, CentOS, etc.<br>
<br>
<br>
<br>
<br></li></ul>

<h1>Introduction</h1>

The tool will allow you to display the contents of abc and swf files in a lot of different way.<br>
<br>
<br>
<h1>Installation</h1>

Depends of your preferences.<br>
<br>
<hr />
<h1>Documentation</h1>

<h2>Usage</h2>
<pre><code>abcdump [options] file ...<br>
</code></pre>
Each file can be an ABC or SWF/SWC format file.<br>
<br>
<h2>Options</h2>
<pre><code>  -a   Extract the ABC blocks from the SWF/SWC, but do not<br>
       otherwise display their contents.  The file names are<br>
       of the form file&lt;n&gt;.abc where "file" is the name<br>
       of the input file minus the .swf/.swc extension;<br>
       and &lt;n&gt; is omitted if it is 0.<br>
<br>
  -i   Print information about the ABC, but do not dump the byte code.<br>
<br>
  -abs Print the bytecode, but no information about the ABC<br>
  -api Print the public API exposed by this abc/swf<br>
  -mdversions Use in conjunction with -api when the abc/swf uses old-style versioning<br>
  -pools Print out the contents of the constant pools<br>
  --decompress-only Write out a decompressed version of the swc and exit<br>
</code></pre>

<hr />

<h1>Usages</h1>

<h2>Print the informations about an ABC file</h2>
<pre><code>$ ./abcdump -i file.abc<br>
</code></pre>

<h2>Extract all the ABC files from a SWF file</h2>
<pre><code>$ ./abcdump -a file.swf<br>
</code></pre>