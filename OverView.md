## Introduction ##

The maashaack project provide different stuff.

The **maashaack application framework**<br>
is a set of different modular projects assembled together<br>
to produce a coherent set of AS3 classes, packages and libraries<br>
which represent our ideal of "programming in the large".<br>
<br>
The <b>maashaack projects</b><br>
are independent modules which focus on one particular set of problem,<br>
they fit the need of "programming in the small".<br>
<br>
The <b>maashaack tools</b><br>
are executable tools in relation with the AS3 language and/or the Flash Platform<br>
their goal is to cover small area not covered by much bigger tools (like the Flex SDK).<br>
<br>
The <b>maashaack documentation</b><br>
focus mainly on the use of the different frameworks, classes, libraries, etc.<br>
but also try to assemble the best ressources related to AS3 and Flash development in general.<br>
<br>
TODO<br>
<br>
<h2>Packages</h2>

see <a href='Packages.md'>Packages</a>.<br>
<br>
<br>
<h3>core</h3>

see <a href='core.md'>core</a>.<br>
<br>
<h3>system</h3>

The system root package is the starting point of the application framework structure,<br>
dependencies are allowed but strictly controlled.<br>
<br>
Definitions in <b>system</b> are allowed to reuse the builtin types (Object, Array, etc.),<br>
the Flash API classes and packages, and other system libraries.<br>
<br>
Here some basic rules:<br>
<ul><li>nothing declared in the unnamed package (eg. <code>package { ... }</code>)<br>
</li><li>classes starts with an uppercase letter and use CamelCase<br>
</li><li>namespaces starts with a lowercase letter<br>
</li><li>conditional compilation are always in uppercase letters (see ConditionalCompilation)<br>
</li><li>interfaces follow classes naming convention and are considered types<br>no interfaces starting with <b>I</b> (define <code>Serializable</code>, not <code>ISerializable</code>)<br>
</li><li><code>System.*</code> root package define commons types, classes, interfaces, namespaces etc.<br>that can be shared and reused in sub-packages<br>
</li><li>each sub-package should be independent of another sub-package but can have dependencies on the root package<br> in <code>System.terminals.*</code> you can reuse <code>System.Serializable</code> but not <code>System.diagnostics.Debuggable</code>
</li><li>there can be some exceptions with highly used packages like <code>System.data.*</code><br><code>System.process.*</code> can reuse classes and interfaces from <code>System.data.*</code><br>but the root package <code>System.*</code> will avoid to reuse <code>System.data.*</code>
</li><li>you can not reuse a third party library at all<br>
</li><li>...</li></ul>

You need to see <b>system</b> as a dual structure<br>
on one side you have the idea of generating the <b>maashaack.swc</b> library (contain everything)<br>
and on the other side you want to generates independent slices of the framework<br>
like: <b>system.swc</b>, <b>system.data.swc</b>, <b>system.terminals.swc</b>, etc.<br>
<br>
It is really hard and require a constant discipline to provide this level of controlled dependency<br>
between packages but it is really for the greater good :).<br>
<br>
We don't want a single <code>import</code> of a class to add tons of other classes and interfaces,<br>
but we can accept to say "if you want to use <code>system.process</code> you have to include <b>system.swc</b> and <b>system.data.swc</b>".<br>
<br>
At the end of the day, if we can not generate independent swc for each packages,<br>
and we have to resort on using only <b>maashaack.swc</b>, we fail.<br>
<br>
Why we impose all those rules ?<br>
<ul><li>we need to control the amount of bytecode ending in the final swf<br>see the Flex framework, you include one component and you end up with ~250KB of code<br>we want to avoid that<br>
</li><li>we want to be able to have common reusable areas and interchangeable areas<br>wether you want to use an optimized set of classes for flash player 10 (using <code>Vector</code> instead of <code>Array</code>)<br>or switch between different implementations of "signals and slots"<br>
</li><li>we want to be able to manage sub-packages as modules<br>creating, adding, removing, etc. a module should not influence other modules (or break things)<br>
</li><li>we want to be able to kick start a project or new sub-package over a week-end<br>when you face too much dependencies spread in every corners you can not do that</li></ul>


<b>use case:</b> assemble different functions in a string utility class<br>
<pre><code>package com.foobar.utils<br>
{<br>
    import core.strings.fastformat; void(fastformat);<br>
    import core.strings.format; void(format);<br>
    import core.strings.pad; void(pad);<br>
    <br>
    public class Strings<br>
    {<br>
        <br>
        CONFIG::LIGHT<br>
        public static var format:Function = core.strings.fastformat;<br>
        <br>
        CONFIG::STANDARD<br>
        public static var format:Function = core.strings.format;<br>
        <br>
        public static function padLeft( str:String, amount:uint, char:String = " " ):String<br>
        {<br>
            return pad( str, -int(amount), char );<br>
        }<br>
        <br>
        public static function padRight( str:String, amount:uint, char:String = " " ):String<br>
        {<br>
            return pad( str, int(amount), char );<br>
        }<br>
        <br>
    }<br>
}<br>
</code></pre>
here we reuse the building blocks of <b>core</b> to build <b>system.Strings</b><br>
you can see, for example, ConditionalCompilation settings that allow to switch the<br>
same function <b>format</b> between 2 implementations<br>
<br>
<br>
TODO<br>
<br>
<h3>graphics</h3>

The graphics root package is to be considered as an addon to <b>system</b>,<br>
mostly related to the highly graphic nature of the Flash Platform.<br>
<br>
Definitions in <b>graphics</b> are allowed to reuse the builtin types (Object, Array, etc.),<br>
the Flash API classes and packages, and other system libraries.<br>
<br>
TODO<br>
<br>
<h2>Library</h2>

The library root package is an effort to organize and standardize<br>
external and independent code libraries that can be added to <b>system</b> on a needed basis<br>
without necessary being part of the application framework.<br>
<br>
For example <code>library.zlib.*</code> would be a sub-package implementing in AS3<br>
the C/C++ zlib library that can be found here <a href='http://www.zlib.net'>www.zlib.net</a>.<br>
<br>
Another example would be <code>library.PNG</code> which could take some base code from<br>
other open source projects and/or from the <a href='http://www.w3.org/TR/PNG/'>PNG specification</a><br>
and/or port a library from another language and/or implements the library with <a href='http://labs.adobe.com/technologies/alchemy/'>Alchemy</a>.<br>
<br>
TODO<br>
<br>
<h2>Platform</h2>

Platform libraries are low level libraries, and mostly related to the <a href='http://www.mozilla.org/projects/tamarin/'>Tamarin project</a> or <a href='http://code.google.com/p/redtamarin/'>redtamarin</a>.<br>
<br>
For example <code>C.stdlib.*</code> would be subpackage defining native AS3 classes or functions<br>
to their implementation in C/C++ (defined in redtamarin)<br>
<br>
Another example would be <code>flash.*</code> implementing in AS3 the Flash Player native classes (found in <b>playerglobal.swc</b>)<br>
either used as mock with redtamarin, or as native AS3 classes and implemented in C/C++ to a certain levels to be used on the command line.<br>
<br>
<br>
<h2>Tools</h2>

The tools are not considered as part of a package structure,<br>
they are mainly the organization of small applications<br>
that focus on AS3 and Flash development.<br>
<br>
For example <code>abcdump.exe</code> could be a little command-line tool<br>
based on <code>abcdump.as</code> found in the Tamarin project.<br>
<br>
Another example would be to take <code>flvtool2</code> written in Ruby and port it to AS3.<br>
<br>
Here the goal is to create needed tool and/or improve existing tools,<br>
but also manage and maintain their build process and distribution.<br>
<br>
<b>use case:</b> abcdump<br>
For a basic user, being able to build <code>abcdump.exe</code> for Windows<br>
could be a big task: install and learn to use Visual Studio, learn to use mercurial,<br>
learn how to compile Tamarin, learn how to compile an abc file,<br>
learn how to compile a running exectubale with avmshell and and abc file, etc.<br>
<br>
For us, the task would be to create a small project to isolate the necessary source code,<br>
organize the build so a Windows, OS X and Linux command line executable could be generated<br>
document its usage and distribute it.<br>
<br>
<br>
TODO