## Introduction ##

Before you build you need a fair good understanding of the [projects structure](ProjectStructure.md).

All our builds use Ant.

We have different types of build
  * [local build](LocalBuild.md), from within the project
  * [MetaBuild](MetaBuild.md), a build driving other builds

## Building a single project ##

Select the category (either `packages`, `libraries`, `tools` or `platform`)<br>
and select a project name.<br>
<br>
Go into the root folder of this project<br>
for ex: <code>../packages/core</code>

Run the local build<br>
<pre><code>$ ant<br>
</code></pre>
or<br>
<pre><code>$ ant -f build.xml<br>
</code></pre>

You will get the result of the build in the <code>bin-release</code> folder.<br>
<br>
<br>

<b>build defaults</b>

A local build will expect a path for a Flex SDK<br>
our default build.xml use<br>
<pre><code>&lt;property name="FLEX_HOME_MAC" value="/OpenSource/Flex/sdks/4.5.0" /&gt;<br>
&lt;property name="FLEX_HOME_WIN" value="c:/OpenSource/Flex/sdks/4.5.0" /&gt;<br>
</code></pre>

<br>

<b>build options</b>

By default, with a local build we always build the documentation (with ASDoc)<br>
but you can desactivate it like that<br>
<pre><code>ant -Dbuild.nodocumentation=true<br>
</code></pre>

<br>

<b>custom local build</b>

If you're not happy with some defaults or you have special needs<br>
just copy <b>build.xml</b> to say <b>build-custom.xml</b><br>
and edit accordingly<br>
<br>
for ex:<br>
<pre><code>&lt;property name="FLEX_HOME_MAC" value="/dev_stuff/Adobe/Flex_sdks_4.5.0" /&gt;<br>
</code></pre>

<br>

<b>build properties</b>

Here an example<br>
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

Things are pretty straightforward and simple.<br>
<br>
If you are the owner of a module/project, edit the <b>project.creator</b> property.<br>
<br>
<br>
<br>

<h2>Building a solution</h2>

For now we have only two solutions: <b>maashaack</b> and <b>maashaackSA</b> (see <a href='Code101.md'>Get the Code</a>).<br>
<br>
The difference with a single project is that a solution can build more than one project<br>
and for advanced case like <b>maashaackSA</b> we use what we call a <a href='MetaBuild.md'>MetaBuild</a>.<br>
<br>
In either case, things would be already setup in advance and to build a solution<br>
you just need to<br>
<br>
Run the solution build from the root<br>
<pre><code>$ ant<br>
</code></pre>
or<br>
<pre><code>$ ant -f build.xml<br>
</code></pre>

<b>build options</b>

By default, a solution build use the file <code>build/common.properties</code>.<br>
<br>
To override this file,<br>
you will need to copy <code>build/user.tmp</code> to <code>build/user.properties</code><br>
and change your personal settings in <b>user.properties</b>.<br>
<br>
for example:<br>
<b>common.properties</b>
<pre><code>local.flashplayerversion = 10.2<br>
build.showoptions = true<br>
</code></pre>

<b>user.properties</b>
<pre><code>local.flashplayerversion = 10.3<br>
build.showoptions = false<br>
</code></pre>