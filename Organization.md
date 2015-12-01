## Introduction ##

The main goal of maashaack is to not force something into you the developer<br>
but to allow you to pick what you want for your needs.<br>
<br>
Based on this principle, most of our libraries for the framework are interchangeable,<br>
don't like our version of signals and prefer to use as3-signals, you can<br>
even us have different libraries: a full blown system.data and a lighter system.data based on core.data<br>

TODO<br>
<br>
<br>
<h3>if you are a User</h3>

You will have mainly to deal with SWC libraries.<br>
<br>
With the default maashaack.swc you will have everything in one file,<br>
but you will be able to select between<br>
<ul><li>maashaack-speedy.swc : less features, more speed of execution<br>
</li><li>maashaack-10.swc : optimized for Flash Player 10<br>
</li><li>maashaack-10-1.swc : optimized for Flash Player 10.1<br>
</li><li>etc.</li></ul>

Or you will be able to assemble different SWC depending on your needs<br>
to compose your own custom "maashaack" library.<br>
<br>
Let's say for a SWF project you need general classes like Version and some utils to dump objects<br>
in a terminal-like interface, then you will assemble<br>
<ul><li>system.swc<br>
</li><li>system.terminals.swc<br>
</li><li>system.serializer.eden-light.swc<br>
</li><li>libraries.console1.swc</li></ul>

Let's say for a Tamarin project you need command line utilities and classes without events<br>
then you will assemble<br>
<ul><li>system.abc<br>
</li><li>system.cli.abc<br>
</li><li>etc.</li></ul>

If you really want to access the source code,<br>
you can always browse it on google code<br>
and in a near futur we will also provide a nighty zip of the sources<br>
(on a 3rd party server or maybe google code if they implement the feature first ;)).<br>
<br>
Not now, but later we may even provide a custom tool<br>
that will allow you to select what you need in a GUI<br>
and have it compile a custom SWC/SWF/ABC for you.<br>
<br>
<br>
<h3>if you are a Committer</h3>

You will have to use <b><a href='gclient.md'>gclient</a></b> to be able to work on the source code.<br>
<br>
If you want to work on all the different projects fused as if it was one big project<br>
you will select the "maashaack" solution, and all the different libraries will get<br>
automatically organized in a <code>/src</code> folder.<br>
<br>
something looking like that<br>
<pre><code>maashaack<br>
           |_ build<br>
           |_ build.xml<br>
           |_ DEPS<br>
           |_ src<br>
           |     |_ core<br>
           |     |     |_ strings<br>
           |     |<br>
           |     |_ system<br>
           |            |_ terminals<br>
           | ...<br>
           |_ tests<br>
                  |_ ...<br>
</code></pre>

this solution can generate all the different maashaack SWCs: maashaack-speedy.swc , maashaack-10.swc, etc.<br>
<br>
If you want to work on the different projects as independent projects<br>
you will select the "maashaackSA" solution (SA = StandAlone)<br>
and all the projects will get automatically organized in groups: packages, libraries, tools, etc.<br>
and then the respective project name, and then their own <code>/src</code> directory.<br>
<br>
something looking like that<br>
<pre><code>maashaackSA<br>
           |_ build<br>
           |_ build.xml<br>
           |_ DEPS<br>
           |_ libraries<br>
           |     |_ astuce<br>
           |     |        |_ build<br>
           |     |        |_ build.xml<br>
           |     |        |_ src<br>
           |     |        |     |_ ...<br>
           |     |        |<br>
           |     |        |_ tests<br>
           |     |              |_ ...<br>
           |     |<br>
           |     |_ v8benchmark<br>
           |<br>
           |_ packages<br>
           |      |_ core<br>
           |     |        |_ build<br>
           |     |        |_ build.xml<br>
           |     |        |_ src<br>
           |     |        |     |_ ...<br>
           |     |        |<br>
           |     |        |_ tests<br>
           |     |              |_ ...<br>
           |     |_ system<br>
           |     |        |_ build<br>
           |     |        |_ build.xml<br>
           |     |        |_ src<br>
           |     |        |     |_ ...<br>
           |     |        |<br>
           |     |        |_ tests<br>
           |     |              |_ ...<br>
           |     |_ system_terminals<br>
           |     |        |_ build<br>
           |     |        |_ build.xml<br>
           |     |        |_ src<br>
           |     |        |     |_ ...<br>
           |     |        |<br>
           |     |        |_ tests<br>
           |     |              |_ ...<br>
           | ...<br>
</code></pre>

this solution can generate all the independent libraries: core.swc, system.swc, system.terminals.swc, etc.<br>
<br>
<br>
<h2>Details</h2>

TODO<br>
<br>
<h3>Definitions</h3>

A <b>Solution</b> is a root configuration to be used with <b>gclient</b><br>
you can find the different solutions available in <code>/svn/configs</code>.<br>
<br>
A <b>Project</b> is an independent <b>Package</b>, <b>Library</b> or <b>Tool</b><br>
you can find them respectively in <code>/svn/packages</code>, <code>/svn/libraries</code> and <code>/svn/tools</code>.<br>
<br>
A <b>Package</b> project is an AS3 package that fit in one of the root packages as <b>core</b>, <b>system</b>, etc.<br>
those sources are considered of general use and part of a global application framework.<br>
<br>
A <b>Library</b> project is an AS3 library that fit in the package <b>library</b><br>
those source are considered as 3rd party or specific utilities,<br>
for example:<br>
the zlib library can be found in the <b>library.zlib</b> package<br>
and will generate <b>library.zlib.swc</b>.<br>
<br>
A <b>Platform</b> project is a particular kind of AS3 library that mock, integrate with or extend the Flash or AIR API<br>
or sources that are native (defined in AS3 but implemented in C/C++)<br>
those sources are considered very low level<br>
for example:<br>
<b>stdlib</b> is the implementation of the C standard library for AS3<br>
<b>glue</b> is the mock of the native classes of Flash Player 9.<br>
<br>
A <b>Tool</b> project is an AS3 based application that live in its own package (and sometime its own repository)<br>
it can be a Tamarin or an AIR project (or anything else),<br>
for example:<br>
the makeSWC command line tool can be found in the <code>/svn/tools/makeswc</code> directory<br>
the package could be something like <b>tamarin.makeswc</b><br>
and could generate <b>makeswc.exe</b> (windows) , <b>makeswc</b> (OS X) and <b>makeswc.bin</b> (Linux).<br>
<br>
<br>
TODO<br>
<br>
<br>
<h3>Directories and Project setup</h3>

TODO<br>
<br>
<h3>Add your Project to maashaack</h3>

One of our main goal is to try to define a standard unified library for AS3,<br>
if you think alike and want to be friend with maashaack, here one way to do it<br>
<ul><li>contact us (yes we can help)<br>
</li><li>apply the directories and project setup to your own project<br>
</li><li>follow the packages organization, if you have a RAR library for ex, define it in <b>libraries.rarlib</b> instead of <b>com.joe.util.RAR</b>
</li><li>and just contact us again so we sync with your project</li></ul>

with that, next time the maashaack sources are compiled,<br>
even if you project reside in an external repository,<br>
your particular library <b>libraries.rarlib</b> will be compiled<br>
and distributed as <b>libraries.rarlib.swc</b> (or <code>/libraries/rarlib.swc</code>) among the other libraries.<br>
<br>
Our idea is that it is simpler for the AS3 developers in general<br>
to look for libraries in a <code>library.*</code> and keep the whole thing clean and organized.<br>
<br>
Also as a community we think it would help to reach a certain maturity,<br>
like Perl or Python for example, but we're not there yet.<br>
<br>
TODO<br>
<br>
<br>
<h3>Custom Solution</h3>

TODO