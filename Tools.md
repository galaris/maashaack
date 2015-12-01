# Set up your development environment #

All our projects are dependant on certain languages, tools, compilers, interpreters, etc.

Here we describe how you need to set up your environment to be able to work on those different projects (and by work I mean: editing, patching, compiling, etc.).

This is if you are a developer, if you are a end-user you don't need to do all that and you should find pre-compiled libraries and tools in the [download](http://code.google.com/p/maashaack/downloads/list) section.

## default tools ##

we expect you to have on your system
  * [Subversion](http://subversion.tigris.org/) (svn) 1.5+
  * [Python](http://www.python.org/) 2.5+
  * [Java SE Development Kit](http://java.sun.com/javase/downloads/index.jsp) 1.4+

to test
```
$ svn --version
svn, version 1.6.9 (r901367)
   compiled Feb 12 2010, 19:35:27
```
```
$ python -V
Python 2.6.1
```
```
$ java -version
java version "1.6.0_17"
Java(TM) SE Runtime Environment (build 1.6.0_17-b04-248-10M3025)
Java HotSpot(TM) 64-Bit Server VM (build 14.3-b01-101, mixed mode)
```


## extra tools ##

  * [Apache Ant 1.7.1](http://ant.apache.org/bindownload.cgi)
  * [gclient 0.3.4](gclient.md)

to test
```
$ ant -v
Apache Ant version 1.7.1 compiled on June 27 2008
```
```
$ gclient --version
0.3.4
```

## Command-line shell ##

We build everything on the command-line, so you need to be comfortable there.

**Windows**

Let be honest, the default command prompt sucks, so on Windows you'll need to use **Cygwin**, which provides a Unix-like command-line environment vastly richer than Command Prompt.

  * [Cygwin](http://www.cygwin.com/)
  * [Console](http://sourceforge.net/projects/console/) (optional, but allow you to have tabs)

**OS X**

Just use the **Terminal.app**.

**Linux**

Use the terminal or anything that give you access to a shell.


## Environment Variables ##

http://en.wikipedia.org/wiki/Environment_variable

you need to define
  * **JAVA\_HOME**<br>must point to the J2SDK directory, which should contain bin and lib directories.<br>
<ul><li><b>ANT_HOME</b><br>must point to the Ant directory, which should contain bin and lib directories.<br>
</li><li><b>PATH</b>
<ul><li>Ant's bin directory, $ANT_HOME/bin<br>
</li><li>Java's bin directory, $JAVA_HOME/bin<br>
</li><li>etc.</li></ul></li></ul>

You need to add the path of each tool you want to be able to use on the command-line no matter what your current directory is.<br>
<br>
<b>example:</b><br>
Under OS X, I installed gclient here<br>
<pre><code>/Users/zwetan/scripts/gclient-0.3.4/<br>
</code></pre>
and so the symlink is there<br>
<pre><code>/Users/zwetan/scripts/gclient<br>
</code></pre>
so in my bash <code>.profile</code> I will be sure to add the <code>/Users/zwetan/script</code> path<br>
<pre><code>export PATH=/Users/zwetan/scripts:$PATH<br>
</code></pre>


<b>Windows</b>

You will need to<br>
<pre><code>1. Right-click My Computer, and then click Properties.<br>
2. Click the Advanced tab.<br>
3. Click Environment variables.<br>
</code></pre>
see <a href='http://support.microsoft.com/kb/310519'>How To Manage Environment Variables in Windows XP</a>

and there you'll add the path for<b>JAVA_HOME</b>, <b>ANT_HOME</b>, <b>PATH</b>, etc.<br>
<br>
<br>
<b>OS X and Linux</b>

By default we use <a href='http://en.wikipedia.org/wiki/Bash_(Unix_shell)'>Bash</a> and so we define everything in our <code>.profile</code>

<b>example:</b><br>
<pre><code>export PATH=/opt/local/bin:/opt/local/sbin:/Users/zwetan/scripts:$PATH<br>
export JAVA_HOME=/System/Library/Frameworks/JavaVM.framework/Versions/CurrentJDK/Home/<br>
export ANT_HOME=/usr/share/ant-1.7.1/<br>
</code></pre>