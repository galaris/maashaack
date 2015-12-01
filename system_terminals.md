# About #

**system.terminals** define the input/output for a console.

<a href='http://maashaack.googlecode.com/svn/libs/trunk/swc/system.terminals.swc'><img src='http://maashaack.googlecode.com/svn/gfx/download.png' align='left' /></a>


| **package** | **FPAPI** | **CC** | **dependencies** | **cross-platform** | **redtamarin** |
|:------------|:----------|:-------|:-----------------|:-------------------|:---------------|
| `system.terminals.*` | FP\_10\_2 | n/a    | [core](core.md)  | yes                | 0.3.1          |

| **browse** | [/packages/system\_terminals/trunk](http://code.google.com/p/maashaack/source/browse/#svn%2Fpackages%2Fsystem_terminals%2Ftags) |
|:-----------|:--------------------------------------------------------------------------------------------------------------------------------|
| **checkout** | `svn checkout http://maashaack.googlecode.com/svn/packages/system_terminals/trunk system_terminals-read-only`                   |

<br>
<br>

<h1>Introduction</h1>

When you need a little more than a <code>trace()</code> ...<br>
<br>
TODO<br>
<br>
<br>
<h1>Details</h1>

Everything is dependant on the interface <code>InteractiveConsole</code>

<pre><code>package system.terminals<br>
{<br>
    public interface InteractiveConsole<br>
    {<br>
        function read():String;<br>
<br>
        function readLine():String;<br>
<br>
        function write( ...messages ):void;<br>
        <br>
        function writeLine( ...messages ):void;<br>
    }<br>
}<br>
</code></pre>


TODO<br>
<br>
<hr />
<h1>Documentation</h1>

<hr />

<h1>Usages</h1>