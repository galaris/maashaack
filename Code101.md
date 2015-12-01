## Introduction ##

We work on **maashaack** for many years, and now we come to a point<br>
where we had to reorganize the code to allow the project to evolve.<br>
<br>
If at the beginning we were planing just an application framework,<br>
now we are dealing with the organisation of an application framework<br>
but also the organisation of libraries, tools and platform libraries.<br>
<br>
That means only using Subversion and only using one repository is not enough, we need more.<br>
<br>
After different personal experiences (at work and with big commercial projects),<br>
a lot of discussions about code dependencies, organisations, builds, etc.<br>
and about one full year of numerous tests and experiments<br>
we think we came up with a "system" that works.<br>
<br>
In summary, we copied (more or less) what Google did with Chrome (and Chromium)<br>
and now we have <b>solutions</b> of code that you can check out with <b>gclient</b>.<br>
<br>
Those solutions are much more simple that what Google Chrome does,<br>
we have only one <b>DEPS</b> file at the root of a <b>config</b> which is used to create a solution.<br>
<br>
By default we have two main solutions:<br>
<ul><li><b>maashaack</b><br>the fusion of all the sources in one single project<br>
</li><li><b>maashaackSA</b><br>each project considered as standalone module<br>and organised in numerous projects</li></ul>

By extension, we can also create custom solutions to either<br>
work with other open source or commercial projects.<br>
<br>
What does it change for you if that to checkout the code<br>
you will have to use gclient on top of subversion,<br>
but this bring a lot of advantages:<br>
<ul><li>isolating projects as <b>modules</b> allow us to focus more on the module itself<br>
<ul><li>better code quality<br>
</li><li>more unit tests<br>
</li><li>better documentation<br>
</li><li>more modules as now we can start something new in about a week-end<br>
</li></ul></li><li>categories for those modules<br>
<ul><li>packages<br>
</li><li>libraries<br>
</li><li>tools<br>
</li><li>platform libraries<br>
</li></ul></li><li>better integration with <a href='http://code.google.com/p/redtamarin/'>http://code.google.com/p/redtamarin/</a> redtamarin]<br>
<ul><li>most of the maashaack code will be reusable there<br>
</li><li>some code will be specialized to run with redtamarin<br>
</li><li>AS3 server side stuff<br>
</li></ul></li><li>the freedom of choice<br>
<ul><li>we try to setup a well tested and organised framework<br>but you may want to use only parts of it<br>
</li><li>this new modular architecture will allow you to pick only what you need/want<br>
</li><li>we hope it will help people to either contribute to existing modules or create new ones</li></ul></li></ul>

<h2>New</h2>

You will need the <a href='gclient.md'>gclient</a> tool.<br>
<br>
<h3>maashaack</h3>
If you want to work with all the projects fused in one <b>src</b> folder<br>
<pre><code>$gclient config https://maashaack.googlecode.com/svn/configs/maashaack<br>
$gclient update<br>
</code></pre>

You will obtain this code structure<br>
<pre><code>.<br>
`-- maashaack<br>
    |-- DEPS<br>
    |-- build<br>
    |   |-- build.properties<br>
    |   |-- config.xml<br>
    |   `-- manifest.xml<br>
    |-- build.xml<br>
    |-- changelog.txt<br>
    |-- license.txt<br>
    |-- meta.xml<br>
    `-- src<br>
        |-- Library.as<br>
        |-- core<br>
        |   `-- ...<br>
        |-- diagnostics.as<br>
        |-- graphics<br>
        |   `-- ...<br>
        |-- maashaack.as<br>
        |-- maashaack.png<br>
        |-- system<br>
        |   |-- ...<br>
        |   `-- version.properties<br>
        `-- testrunner.as<br>
</code></pre>

From there you will be able to build <b>maashaack.swc</b>, <b>maashaack-debug.swc</b>, etc.<br>
all the source code combined in one SWC with some options<br>
for example: <b>maashaack-debug.swc</b> could contain debug logs.<br>
<br>
<br>
<br>

<h3>maashaackSA</h3>
If you want to work on each projects independently (SA: Stand Alone)<br>
<pre><code>$gclient config https://maashaack.googlecode.com/svn/configs/maashaackSA<br>
$gclient update<br>
</code></pre>

You will obtain this code structure<br>
<pre><code>.<br>
`-- maashaackSA<br>
    |-- DEPS<br>
    |-- build<br>
    |   |-- ant<br>
    |   |-- common.properties<br>
    |   |-- compile.properties<br>
    |   |-- macros<br>
    |   |-- modules<br>
    |   |-- tasks<br>
    |   |-- user.properties<br>
    |   |-- user.tmp<br>
    |   `-- version.properties<br>
    |-- build.xml<br>
    |-- changelog.txt<br>
    |-- libraries<br>
    |   |-- astuce<br>
    |   |-- cgilib<br>
    |   |-- eden<br>
    |   |-- httplib<br>
    |   |-- logd<br>
    |   |-- mimelib<br>
    |   `-- v8benchmark<br>
    |-- libs<br>
    |   |-- abc<br>
    |   `-- swc<br>
    |-- license.txt<br>
    |-- metabuild<br>
    |-- packages<br>
    |   |-- core<br>
    |   |-- graphics<br>
    |   |-- system<br>
    |   |-- system_broadcasters<br>
    |   |-- system_cli<br>
    |   |-- system_comparators<br>
    |   |-- system_data<br>
    |   |-- system_diagnostics<br>
    |   |-- system_errors<br>
    |   |-- system_evaluators<br>
    |   |-- system_events<br>
    |   |-- system_formatters<br>
    |   |-- system_hosts<br>
    |   |-- system_io<br>
    |   |-- system_ioc<br>
    |   |-- system_logging<br>
    |   |-- system_logic<br>
    |   |-- system_models<br>
    |   |-- system_network<br>
    |   |-- system_numeric<br>
    |   |-- system_process<br>
    |   |-- system_reflection<br>
    |   |-- system_remoting<br>
    |   |-- system_rules<br>
    |   |-- system_signals<br>
    |   |-- system_terminals<br>
    |   `-- system_text<br>
    |-- platform<br>
    |   |-- avmglue<br>
    |   |-- clib<br>
    |   |-- shell<br>
    |   `-- temp<br>
    `-- tools<br>
        |-- build-abc<br>
        |-- swc2abc<br>
        `-- swfinfo<br>
</code></pre>

From there you will be able to build <b>core.swc</b>, <b>system.terminals.swc</b>, etc.<br>
each projects compiled to its own SWC<br>
<code>packages/core</code> produce <b>core.swc</b><br>
<code>packages/system_terminals</code> produce <b>system.terminals.swc</b><br>
etc.<br>
<br>
<br>
<br>
If you need to work on boths (developers/commiters)<br>
copy <code>https://maashaack.googlecode.com/svn/configs/solutions.txt</code>
<pre><code>$mv solutions.txt .gclient<br>
$gclient update<br>
</code></pre>

<br>
<br>

<h2>Old</h2>

<pre><code>$svn checkout http://maashaack.googlecode.com/svn/trunk/AS3 maashaack<br>
</code></pre>

<font color='red'>Deprecated, we keep it only because some applications still use this SVN path with svn:external, but we don't update it anymore.</font><br>