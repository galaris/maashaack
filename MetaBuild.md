## Introduction ##

What we call a **MetaBuild** is simply an Ant build that drives other ant builds.

Because we deal with a lot of packages, libraries, tools and platform libraries<br>
we defined a way to build them all in sequence<br>
<ul><li>to be able to order them (eg. build <b>A</b> before <b>B</b>)<br>
</li><li>to be able to sync' them (eg. copy <b>A</b> into <b>B</b> libs)<br>
</li><li>to be able to tag them (eg. build <b>A</b>, <b>B</b>, <b>C</b> and tag them "beta 1")<br>
</li><li>to be able to distribute them (eg. copy <b>A</b> binaries in dist folder or into a zip file)</li></ul>

All this is automated and save us a lot of time.<br>
<br>
<br>
<br>

<h2>Important files</h2>

<b>build.xml</b> is where all the logic is, that's the <b>metabuild</b> file or the main entry point if you prefer.<br>
<br>
<b>meta.xml</b> are the project (or module) builds meant to be called by <b>build.xml</b>.<br>
<br>
<br>

The Metabuild gets all its configuration from the <code>build</code> folder<br>
<br>
<b>compile.properties</b> define which projects to compile and in which order.<br>
<br>
<b>common.properties</b> contains the default settings<br>
<br>
<b>version.properties</b> contains the version information for the metabuild<br>
<br>
the <code>macros</code> folder contains ant macrodef<br>
<br>
the <code>tasks</code> folder contains reusable tasks (also macrodef)<br>
<br>
and the <code>modules</code> folder contains each projects configurations<br>
<br>
<br>
<br>

<h2>How does it works ?</h2>

You run <b>build.xml</b>

all the macros, tasks, modules, etc. are loaded<br>
<br>
after we load either <b>common.properties</b> or <b>user.properties</b> to configure the build<br>
<br>
then a build tag is created based on <b>version.properties</b>, for ex: tag <b>1A099</b>

then we load <b>compile.properties</b> to know which projects to compile<br>
<br>
then we loop in those different projects and call their respective <code>/build/modules/NAME.xml</code><br>
(NAME being the current project name)<br>
<br>
which then call the respective <code>/CATEGORY/NAME/meta.xml</code> (CATEGORY being one of packages, libraries, tools or platform)<br>
<br>
and done.<br>
<br>
<br>
<br>
<br>

<h2>How to add a project to the metabuild ?</h2>

Before doing anything in the metabuild itself be sure that your project follow the <a href='ProjectStructure.md'>project structure</a><br>
and that the local <a href='Build.md'>Build</a> follow the organisation of defining both a <b>build.xml</b> and a <b>meta.xml</b> (as well as a <b>build.properties</b>).<br>
<br>
<br>

Now, you first need to edit the <b>DEPS</b> of the <b>solution</b> and be sure you project is checked out.<br>
<br>
with maashaackSA for ex:<br>
<pre><code>Var("root") + "/packages/system_terminals"    : Var("repo") + "/packages/system_terminals/trunk",<br>
</code></pre>

After doing a <code>gclient sync</code> or <code>gclient update</code><br>
the you will need to add your project to the <b>compile.properties</b>
<pre><code>system_terminals1.name = system_terminals1<br>
system_terminals1.path = packages<br>
system_terminals1.mod = system_terminals<br>
system_terminals1.alt<br>
</code></pre>

here pay attention<br>
<ul><li><b>name</b> is the id of the project<br>
</li><li><b>path</b> is the category where the project reside<br>
</li><li><b>mod</b> is the the file system name of the project and the default target name of the compile<br>
</li><li><b>alt</b> is an alternate target to compile</li></ul>

that means we call <code>build/modules/MOD.xml</code> in the directory <code>PATH/MOD</code><br>
if <b>alt</b> were defined<br>
we would call <code>build/modules/ALT.xml</code> in the directory <code>PATH/MOD</code>


Remember that <b>compile.properties</b> decide in which order projects are compiled<br>
for example:<br>
<pre><code>core1.name = core1<br>
core1.path = packages<br>
core1.mod = core<br>
core1.alt<br>
<br>
system_terminals1.name = system_terminals1<br>
system_terminals1.path = packages<br>
system_terminals1.mod = system_terminals<br>
system_terminals1.alt<br>
<br>
astuce1.name = astuce1<br>
astuce1.path = libraries<br>
astuce1.mod = astuce<br>
astuce1.alt<br>
</code></pre>

here <b>system.terminals</b> will be compiled after the <b>core</b> project but before the <b>astuce</b> project.<br>
<br>
<br>
In special case, where you need the same project to be compiled more than once use <b>alt</b>

<pre><code>core1.name = core1<br>
core1.path = packages<br>
core1.mod = core<br>
core1.alt<br>
<br>
system_terminals1.name = system_terminals1<br>
system_terminals1.path = packages<br>
system_terminals1.mod = system_terminals<br>
system_terminals1.alt<br>
<br>
astuce1.name = astuce1<br>
astuce1.path = libraries<br>
astuce1.mod = astuce<br>
astuce1.alt<br>
<br>
core2.name = core2<br>
core2.path = packages<br>
core2.mod = core<br>
core2.alt = special<br>
</code></pre>

here <b>core</b> will be compiled first with the default compile target <b>core</b><br>
then <b>system.terminals</b> get compiled<br>
then <b>astuce</b> compile too<br>
and you compile again <b>core</b> but this time with the alternative target <b>special</b>

As it is you can compile  and recompile a project many many times<br>
provided that each time you change the id (core1, core2, core3, core4, etc.)<br>
and provide an <b>alt</b> target with a different name<br>
<br>
<br>

Now you need to go into <code>build/modules/</code> and create an XML file to configure how the project is compiled<br>
<br>
For example with <b>system.terminals</b> we create <code>build/modules/system_terminals.xml</code>

you need to edit the name of the target<br>
<pre><code>&lt;target name="compile-system_terminals"&gt;<br>
</code></pre>

then you need to configure which properties are passed to the build<br>
<pre><code>&lt;ant antfile="${path}/meta.xml" target="main" inheritAll="false"&gt;<br>
  &lt;property name="FLEX_HOME" value="${FLEX_HOME}" /&gt;<br>
  &lt;property name="TODAY" value="${TODAY}" /&gt;<br>
  &lt;property name="local.flashplayerversion" value="${local.flashplayerversion}" /&gt;<br>
  &lt;property file="${path}/build/build.properties"/&gt;<br>
&lt;/ant&gt;<br>
</code></pre>

<code>${path}/meta.xml</code> will always be the same, but in very exceptional case could be changed.<br>
<br>
You need to pass the minimum properties required by the <b>meta.xml</b>
<ul><li>FLEX_HOME<br>
</li><li>TODAY<br>
</li><li>local.flashplayerversion</li></ul>

and also the respective <b>build.properties</b> for the project<br>
which will always be <code>${path}/build/build.properties</code> (but again can be changed for exceptional case)<br>
<br>
After that, you will need to configure if your project is deployed (or not) in the <b>dist</b> folder<br>
<pre><code>&lt;copy file="${path}/bin-release/system.terminals.swc" todir="libs/swc" overwrite="true" /&gt;<br>
&lt;copy file="${path}/bin-release/system.terminals.abc" todir="libs/abc" overwrite="true" /&gt;<br>
</code></pre>
here want to distribute both a SWC and an ABC of the package.<br>
<br>
And finally you need to indicate if the currently compiled project need to be copied in other projects dependencies<br>
<pre><code>&lt;copy file="${path}/bin-release/system.terminals.swc" todir="libraries/astuce/lib-swc" overwrite="true" /&gt;<br>
&lt;copy file="${path}/bin-release/system.terminals.abc" todir="libraries/astuce/lib-abc" overwrite="true" /&gt;<br>
</code></pre>
here we want to copy the newly compiled binaries to the <b>astuce</b> project.<br>
<br>
<br>

Voila, from there your project is integrated in the metabuild and will be compiled/copied/sync'ed/etc. each time the metabuild run.<br>
<br>
<br>
<br>

<h2>Problem with Subversion password</h2>

If the metabuild get stuck with<br>
<pre><code>Password for 'zwetan':       [svn] Authentication realm:<br>
&lt;https://maashaack.googlecode.com:443&gt; Google Code Subversion Repository<br>
</code></pre>

just paste your SVN password and type ENTER<br>
<br>
you may have to do that more than once<br>
(but once done the system should remember your log/pwd afterwards)<br>
<br>
<br>
<br>

<h2>Problem with Ant addons</h2>

if the metabuild fail with "FTP task not found" or other error related to an Ant addon.<br>
<br>
you need to do a full install of <b>Apache Ant 1.8.2</b><br>
download it here <a href='http://ant.apache.org/bindownload.cgi'>http://ant.apache.org/bindownload.cgi</a>

copy it to your share folder<br>
<pre><code>$ sudo cp -R apache-ant-1.8.2 /usr/share/java/apache-ant-1.8.2<br>
</code></pre>

replace the symlink<br>
<pre><code>$ cd /usr/share<br>
$ sudo mv ant ant-old<br>
$ sudo ln -s java/apache-ant-1.8.2 ant<br>
</code></pre>

install the Ant addons<br>
<pre><code>$ cd /usr/share/java/apache-ant-1.8.2<br>
$ sudo ant =f fetch.xml -Ddest=system<br>
</code></pre>

<br>
<br>

<h2>Problem with Ant memory</h2>

If you end up with a memory error<br>
for ex:<br>
<pre><code>/OpenSource/maashaackSA/build/modules/astuce.xml:8: The following error<br>
occurred while executing this line:<br>
/OpenSource/maashaackSA/libraries/astuce/meta.xml:99:<br>
java.lang.OutOfMemoryError: PermGen space<br>
</code></pre>

You will need to add more memory to Ant<br>
<br>
Under OS X / Linux, edit your <b>.profile</b> file<br>
<pre><code>$ cd ~<br>
$ sudo pico .profile<br>
</code></pre>

and add the following lines<br>
<pre><code>export ANT_HOME=/usr/share/ant/<br>
export ANT_OPTS="-Xms512m -Xmx2048m"<br>
</code></pre>

I use those settings for ex<br>
<pre><code>export ANT_HOME=/usr/share/ant/<br>
export ANT_OPTS="-Xms1024m -Xmx4096m -XX:MaxPermSize=512m"<br>
</code></pre>

Under Windows, you will have to set the ANT_OPTS environment variable in the appropriate<br>
"My Computer" properties dialog box (winXP), "Computer" properties (Vista).