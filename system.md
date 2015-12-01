# About #

**system** is the root package for the maashaack application framework.

<a href='Hidden comment: 
<a href="http://maashaack.googlecode.com"><img src="http://maashaack.googlecode.com/svn/gfx/download.png" align="left"/>

Unknown end tag for &lt;/a&gt;


'></a>

| **package** | **FPAPI** | **CC** | **dependencies** | **cross-platform** | **redtamarin** |
|:------------|:----------|:-------|:-----------------|:-------------------|:---------------|
| `system.*`  | FP\_10\_2 | n/a    | n/a              | yes                | no             |

| **browse** | [/packages/system/trunk](http://code.google.com/p/maashaack/source/browse/#svn%2Fpackages%2Fsystem%2Ftrunk) |
|:-----------|:------------------------------------------------------------------------------------------------------------|
| **checkout** | `svn checkout http://maashaack.googlecode.com/svn/packages/system/trunk system-read-only`                   |

<br>
<br>

<h1>Introduction</h1>

The <b>system</b> root package is the starting point of the application framework structure,<br>
dependencies are allowed but strictly controlled.<br>
<br>
Definitions in <b>system</b> are allowed to reuse the builtin types (Object, Array, etc.),<br>
the Flash API classes and packages, and other system libraries.<br>
<br>
Here some basic rules :<br>
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

<hr />
<h1>Documentation</h1>

<hr />
<h1>Usages</h1>

<h2>Assemble different functions in a string utility class</h2>
<pre><code>package system<br>
{<br>
    import core.strings.fastformat;<br>
    import core.strings.format;<br>
    import core.strings.pad;<br>
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
same function <b>format</b> between 2 implementations.<br>
<br>
With that we would end up with a <b>system-light.swc</b> and <b>system-standard.swc</b>.