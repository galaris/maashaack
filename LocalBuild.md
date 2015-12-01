## Introduction ##

A local build is really a very basic and simple Ant build.

There are 3 files in total
  * the **build.xml** in the project
  * the **build.properties** that configure the project
  * the **meta.xml** that actually do the build

All those files follow the convention of the [projects structure](ProjectStructure.md).

## How to create a local build ? ##

The goal is to stay simple and minimalist, consider this setup to build the essential
  * a SWF
  * a SWC
  * an ABC
  * generate the documentation

nothing less, nothing more<br>
no packaging into a zip, no deployment into a folder, no copying into another project, etc.<br>
<br>
<br>

To get started, you need to create a <b>build.properties</b> in the <code>build</code> folder<br>
<br>
for example here the one for the project <b>system.terminals</b>
<pre><code>ASC      = build/abc/asc.jar<br>
builtin  = build/abc/builtin.abc<br>
toplevel = build/abc/toplevel.abc<br>
avmglue  = build/abc/avmglue.abc<br>
core     = lib-abc/core.abc<br>
<br>
release.dir = bin-release<br>
<br>
project.name      = system.terminals<br>
project.src       = src<br>
project.lib-swc   = lib-swc<br>
project.as        = ${project.name}.as<br>
project.swc       = ${project.name}.swc<br>
project.abc       = ${project.name}.abc<br>
project.namespace = http://maashaack.googlecode.com/2011/system/terminals<br>
project.manifest  = build/manifest.xml<br>
project.publisher = maashaack<br>
project.creator   = Firstname Lastname<br>
</code></pre>

By convention, we will always<br>
<ul><li>release in the <code>bin-release</code> folder<br>
</li><li>build from the <code>src</code> folder<br>
</li><li>have SWC libraries in the <code>lib-swc</code> folder<br>
</li><li>have ABC libraries in the <code>lib-abc</code> folder<br>
</li><li>etc.</li></ul>

The only variables should be the <b>name</b> of the project, its <b>namespace</b> and the <b>project.creator</b>.<br>
<br>
<br>

The <b>build.xml</b> is pretty generic<br>
<pre><code>&lt;?xml version="1.0" encoding="UTF-8"?&gt;<br>
<br>
&lt;project name="system.terminals-SA" default="main" basedir="."&gt;<br>
    &lt;target name="define"&gt;<br>
        &lt;property name="FLEX_HOME_MAC" value="/OpenSource/Flex/sdks/4.5.0" /&gt;<br>
        &lt;property name="FLEX_HOME_WIN" value="c:/OpenSource/Flex/sdks/4.5.0" /&gt;<br>
        &lt;property name="local.flashplayerversion" value="10.2" /&gt;<br>
        &lt;condition property="FLEX_HOME" value="${FLEX_HOME_MAC}"&gt;<br>
            &lt;os family="mac" /&gt;<br>
        &lt;/condition&gt;<br>
        &lt;condition property="FLEX_HOME" value="${FLEX_HOME_WIN}"&gt;<br>
            &lt;os family="windows" /&gt;<br>
        &lt;/condition&gt;<br>
        &lt;property file="build/build.properties"/&gt;<br>
        &lt;tstamp&gt;<br>
            &lt;format property="TODAY" pattern="dd MMMM yyyy" /&gt;<br>
        &lt;/tstamp&gt;<br>
        &lt;taskdef resource="flexTasks.tasks" classpath="${FLEX_HOME}/ant/lib/flexTasks.jar" /&gt;<br>
    &lt;/target&gt;<br>
    <br>
    &lt;target name="clean" depends="define"&gt;<br>
        &lt;delete dir="${basedir}/${release.dir}" /&gt;<br>
    &lt;/target&gt;<br>
    <br>
    &lt;import file="meta.xml" /&gt;<br>
&lt;/project&gt;<br>
</code></pre>

You could almost copy this file from projects to projects and it will almost always stay the same.<br>
<br>
The main things to edit are the project name, eg. "system.terminals-SA"<br>
and maybe some properties (it can vary depending on the project<br>
for example a <b>library</b> would probably define a <b>version.properties</b> on top of the <b>build.properties</b>.<br>
<br>
<br>
And to finish the <b>meta.xml</b> where all the work is done.<br>
<br>
Don't underestimate this file, it has to work locally but also when called by the <a href='MetaBuild.md'>MetaBuild</a>.<br>
<br>
here the basic structure<br>
<pre><code>&lt;?xml version="1.0" encoding="UTF-8"?&gt;<br>
<br>
&lt;project name="system.terminals" default="main" basedir="."&gt;<br>
    <br>
    &lt;target name="clean"&gt;<br>
    &lt;/target&gt;<br>
    <br>
    &lt;target name="before"&gt;<br>
    &lt;/target&gt;<br>
    <br>
    &lt;target name="main" depends="clean,before,build-abc,build-swc,after"&gt;<br>
    &lt;/target&gt;<br>
    <br>
    &lt;target name="build-abc"&gt;<br>
    &lt;/target&gt;<br>
    <br>
    &lt;target name="build-swc"&gt;<br>
    &lt;/target&gt;<br>
    <br>
    &lt;target name="after"&gt;<br>
    &lt;/target&gt;<br>
    <br>
&lt;/project&gt;<br>
</code></pre>

Here again the main thing to edit is the project name, eg. "system.terminals"<br>
<br>
For the rest, the important thing to understand is the order of execution of the different targets<br>
first we <b>clean</b>, then we do the <b>before</b>, we do all the <b>build-something</b> then we end up with the <b>after</b>.<br>
<br>
Again by convention we'll try to name those target the same way between different projects<br>
<ul><li><b>build-swf</b> build a SWF file (to use with Flash/AIR)<br>
</li><li><b>build-swc</b> build a SWC file (to use with Flash/AIR)<br>
</li><li><b>build-abc</b> build an ABC file (to use with redtamarin)<br>
</li><li><b>build-doc</b> generate the documentation (in general with ASDoc)</li></ul>

you can also have optional targets<br>
<ul><li><b>build-swf-test</b> build a SWF of the unit tests<br>
</li><li><b>build-swc-test</b> build a SWC of the unit tests<br>
</li><li><b>build-abc-test</b> build an ABC of the unit tests<br>
</li><li><b>build-swc-SA</b> build a standalone SWC (eg. combining all the dependencies from <code>lib-swc</code>)<br>
</li><li><b>build-exe</b> build an executable<br>
</li><li>etc.</li></ul>

<br>
<br>

<h2>Optional files</h2>

The <b>manifest.xml</b> file<br>
this file is needed (or preferred) when you build an SWC<br>
also in <b>build.properties</b> the following<br>
<ul><li><b>project.manifest</b> the manifest file<br>
</li><li><b>project.namespace</b>  the namespace<br>
and in the <b>src</b> folder<br>
</li><li><b>Library.as</b> shim to declare the SWC ID and associate an icon<br>
</li><li><b>projectname.png</b> the icon for the SWC</li></ul>

here some examples from the <b>system.terminals</b> project<br>
<br>
from <b>build.properties</b>
<pre><code>project.namespace = http://maashaack.googlecode.com/2011/system/terminals<br>
project.manifest  = build/manifest.xml<br>
</code></pre>

<b>manifest.xml</b>
<pre><code>&lt;?xml version="1.0" encoding="utf-8"?&gt;<br>
<br>
&lt;componentPackage&gt;<br>
    &lt;component id="system.terminals" class="Library" /&gt;<br>
&lt;/componentPackage&gt;<br>
</code></pre>

<b>Library.as</b>
<pre><code>package<br>
{<br>
    import flash.display.Sprite;<br>
    <br>
    [ExcludeClass]<br>
    [IconFile("system.terminals.png")]<br>
    public class Library extends Sprite<br>
    {<br>
        public function Library()<br>
        {<br>
            super();<br>
        }<br>
        <br>
    }<br>
}<br>
</code></pre>


<br>
<br>

The <b>config.xml</b> file<br>
this file is used to configure the compiler with <a href='ConditionalCompilation.md'>conditional compilation</a> constants.<br>
<br>
from the <b>system.terminals</b> project<br>
<b>config.xml</b>
<pre><code>&lt;?xml version="1.0"?&gt;<br>
&lt;flex-config&gt;<br>
    &lt;compiler&gt;<br>
        &lt;define append="true"&gt; <br>
            &lt;name&gt;API::FLASH&lt;/name&gt; <br>
            &lt;value&gt;true&lt;/value&gt; <br>
        &lt;/define&gt; <br>
        &lt;define append="true"&gt; <br>
            &lt;name&gt;API::REDTAMARIN&lt;/name&gt; <br>
            &lt;value&gt;false&lt;/value&gt; <br>
        &lt;/define&gt; <br>
   &lt;/compiler&gt;<br>
&lt;/flex-config&gt;<br>
</code></pre>

Also, when you are in a case where you're compiling both an ABC and a SWC,<br>
you will have to define those <b>CC</b> manually in the <b>build-abc</b> target<br>
<br>
from the <b>system.terminals</b> project<br>
in <b>meta.xml</b>, the <b>build-abc</b> target<br>
<pre><code>    &lt;target name="build-abc"&gt;<br>
        &lt;java<br>
            dir="${basedir}"<br>
            jar="${ASC}"<br>
            fork="true"<br>
            failonerror="true"<br>
        &gt;<br>
            &lt;arg line="-AS3 -strict -optimize"/&gt;<br>
            &lt;arg line="-config API::REDTAMARIN=true -config API::FLASH=false"/&gt;<br>
            &lt;arg line="-import ${builtin} -import ${toplevel} -import ${core} src/${project.as}"/&gt;<br>
        &lt;/java&gt;<br>
        <br>
        &lt;move file="${basedir}/src/${project.abc}" todir="${basedir}/${release.dir}" /&gt;<br>
    &lt;/target&gt;<br>
</code></pre>

<br>
<br>

<h2>Building ABC files</h2>

If you want your project to run under redtamarin you will need to build one or more <a href='http://code.google.com/p/redtamarin/wiki/ABC'>ABC</a> file(s).<br>
<br>
From the project <b>build-abc</b> (in tools) get the file <b>build-abc_ext.txt</b> (see it <a href='http://code.google.com/p/maashaack/source/browse/tools/build-abc/trunk/build-abc_ext.txt'>here</a>)<br>
<br>
<b>build-abc_ext.txt</b>
<pre><code>abc http://maashaack.googlecode.com/svn/tools/build-abc/trunk/src<br>
</code></pre>

and follow the <a href='http://code.google.com/p/maashaack/source/browse/tools/build-abc/trunk/readme.txt'>readme.txt</a>
<pre><code>copy the file "build-abc_ext.txt" to your build directory<br>
--------<br>
$ cd build<br>
$ svn ps svn:externals . -F build-abc_ext.txt<br>
property 'svn:externals' set on '.'<br>
--------<br>
</code></pre>

your project structure will look like that<br>
<pre><code>.<br>
|-- build<br>
|   |-- abc<br>
|   |   |-- asc.jar<br>
|   |   |-- avmglue.abc<br>
|   |   |-- builtin.abc<br>
|   |   `-- toplevel.abc<br>
|   |-- build.properties<br>
|   |-- config.xml<br>
|   `-- manifest.xml<br>
|-- build.xml<br>
|-- changelog.txt<br>
|-- docs<br>
|   `-- ...<br>
|-- license.txt<br>
|-- meta.xml<br>
`-- src<br>
    `-- ...<br>
</code></pre>

under <code>build/abc/</code> from the <b>build-abc</b> project you will get<br>
<ul><li><b>asc.jar</b> ASC is the <a href='http://code.google.com/p/redtamarin/wiki/ASC'>ActionScript Compiler</a>
</li><li><b>builtin.abc</b> this is the library containing Array, Object, Boolean, etc. eg. the builtin classes<br>
</li><li><b>toplevel.abc</b> this is the library containing the redtamarin shell classes (eg. FileSystem, Socket, etc.)<br>
</li><li><b>avmglue.abc</b> this is the library containing the Flash Player classes defintion (eg. Sprite, getTimer, etc.)</li></ul>

if you need other ABC libraries you can add them in the <code>lib-abc</code> folder<br>
for ex:<br>
<pre><code>.<br>
 -- lib-abc<br>
    |-- core.abc<br>
    `-- logd.abc<br>
</code></pre>

you will need also to define some properties in <b>build.properties</b>
<pre><code>ASC      = build/abc/asc.jar<br>
builtin  = build/abc/builtin.abc<br>
toplevel = build/abc/toplevel.abc<br>
avmglue  = build/abc/avmglue.abc<br>
</code></pre>

and if you added more ABC files in <code>lib-abc</code> also add them<br>
<pre><code>core     = lib-abc/core.abc<br>
logd     = lib-abc/logd.abc<br>
</code></pre>

Then you will need to define the target <b>build-abc</b>
<pre><code>    &lt;target name="build-abc"&gt;<br>
        &lt;java<br>
            dir="${basedir}"<br>
            jar="${ASC}"<br>
            fork="true"<br>
            failonerror="true"<br>
        &gt;<br>
            &lt;arg line="-AS3 -strict -optimize"/&gt;<br>
            &lt;arg line="-config API::REDTAMARIN=true -config API::FLASH=false"/&gt;<br>
            &lt;arg line="-import ${builtin} -import ${toplevel} -import ${core} src/${project.as}"/&gt;<br>
        &lt;/java&gt;<br>
        <br>
        &lt;move file="${basedir}/src/${project.abc}" todir="${basedir}/${release.dir}" /&gt;<br>
    &lt;/target&gt;<br>
</code></pre>

Finally you need to declare an AS file to do all the includes for your ABC library<br>
<br>
from the <b>system.terminals</b> project<br>
in <code>src/system.terminals.as</code>
<pre><code>include "system/terminals/console.as";<br>
include "system/terminals/InteractiveConsole.as";<br>
include "system/terminals/TraceConsole.as";<br>
</code></pre>

<br>

few problems you may encounter:<br>
<br>
If Flash Builder show you a warning or an error,<br>
be sure that the <code>${project.as}</code> is not included in the "ActionScript Applications".<br>
<br>
If you also generating the documentation with ASDoc,<br>
be sure to ignore the <code>${project.as}</code> file<br>
<pre><code>&lt;exclude-sources path-element="${basedir}/${project.src}/${project.as}" /&gt;<br>
</code></pre>