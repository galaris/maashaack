# About #

**core** is specialized in classes and functions utilities that are highly reusable without creating any dependencies.

<a href='http://creativecommons.org/licenses/by-sa/3.0/'><img src='http://i.creativecommons.org/l/by-sa/2.0/uk/88x31.png' alt='Licence Creative Commons' /></a>



| **package** | **FPAPI** | **CC** | **dependencies** | **cross-platform** | **redtamarin** |
|:------------|:----------|:-------|:-----------------|:-------------------|:---------------|
| `core.*`    | FP\_10\_2 | n/a    | n/a              | yes                | 0.3.1          |

| **browse** | [/packages/core/trunk](http://code.google.com/p/maashaack/source/browse/#svn%2Fpackages%2Fcore%2Ftrunk) |
|:-----------|:--------------------------------------------------------------------------------------------------------|
| **checkout** | `svn checkout http://maashaack.googlecode.com/svn/packages/core/trunk core-read-only`                   |

<a href='http://maashaack.googlecode.com/svn/libs/trunk/swc/packages/core.swc'><img src='http://maashaack.googlecode.com/svn/gfx/swc.png' align='left' /></a>
<a href='http://maashaack.googlecode.com/svn/libs/trunk/abc/packages/core.abc'><img src='http://maashaack.googlecode.com/svn/gfx/abc.png' align='left' /></a>


<br>
<br>
<br>
<br>

<h1>Introduction</h1>

The <b>core</b> package organize an aggregation of classes and functions<br>
in sub-packages.<br>
<br>
<pre><code>core<br>
  |_ arrays<br>
  |_ chars<br>
  |_ data<br>
  |_ functors<br>
  |_ hash<br>
  |_ html<br>
  |_ maths<br>
  |_ objects<br>
  |_ reflect<br>
  |_ strings<br>
  |_ vectors<br>
</code></pre>

TODO<br>
<br>
<br>
<br>
<h1>Details</h1>

You can consider a library as a set of functions organized into classes,<br>
here with a "core" library in some cases we organize the functions<br>
in the package definitions without assembling them into a class.<br>
<br>
ideally you would want to write it like that<br>
<pre><code>package core<br>
{<br>
    public function test( message:String ):void<br>
    {<br>
        trace( message );<br>
    }<br>
}<br>
</code></pre>

but there is a subtle bug in Flash CS3 that would prevent users to use<br>
a function declared at the package level from a SWC, so instead of a declaring<br>
a function, we declare a variable of the type <code>Function</code>.<br>
<br>
<pre><code>package core<br>
{<br>
    public var test:Function = function( message:String ):void<br>
    {<br>
        trace( message );<br>
    }<br>
}<br>
</code></pre>

but wait, we want speeeeeed so we make that a constant<br>
<pre><code>package core<br>
{<br>
    public const test:Function = function( message:String ):void<br>
    {<br>
        trace( message );<br>
    }<br>
}<br>
</code></pre>

We'll try to come up with speed comparison, but here what we assume<br>
<ul><li>a package-level function is slightly faster than a static function call<br>
</li><li>a function marked as final is faster (avoid the compiler to do runtimes lookup)<br>
</li><li>a package-level constant should be as fast or even faster than a package-level function</li></ul>


Also in most of the code editors (even Flex Builder), when you make a reference to<br>
a variable declared at the package level, the <code>import</code> can be cleaned up<br>
here a way to force the import to stay, use <code>void(function)</code>
<pre><code>package<br>
{<br>
    import core.strings.format; void(format);<br>
    <br>
    import flash.display.Sprite;<br>
    <br>
    public class Main extends Sprite<br>
    {<br>
        //...<br>
    }<br>
}<br>
</code></pre>
(this seems fixed in Flash Builder 4/4.5)<br>
<br>
Those functions are allowed to reuse the builtin types (Object, Array, etc.),<br>
the Flash API classes and packages, but nothing else.<br>
<br>
Here some basic rules:<br>
<ul><li>nothing declared in the unnamed package (eg. <code>package { ... }</code>)<br>
</li><li>all functions or classes start with a lowercase letter (use <code>bit</code>, not <code>Bit</code>)<br>
</li><li>try to reuse similar name for similar functionality (<code>core.strings.compare</code> and <code>core.arrays.compare</code>)<br>
</li><li>you can not reuse another function or class from any other maashaack package, even from core itself<br>
</li><li>you can not reuse a third party library at all<br>
</li><li>no use of interfaces, enums, events, namespaces, etc.<br>
</li><li>everything have to be "inlined code"<br>
</li><li>the code have to be written for speed and less use of memory<br>
</li><li>it have to work everywhere (redtamarin included)</li></ul>

You really have to see what's in <b>core</b> as building blocks to build bigger classes.<br>
<br>
Why we impose all those rules ?<br>
<ul><li>even if you include <b>core.swc</b> in your libraries<br>the final bytecode injected in your final swf will be minimal<br>
</li><li>core will not create strong dependencies of any sort in your code<br>
</li><li>at the very worst, you can extract the code of a function and inline it directly in your code</li></ul>


TODO<br>
<br>
<br>
<hr />
<h1>Documentation</h1>


<hr />

<h1>Usages</h1>