## Introduction ##

avmglue is an open source implementation of the following runtimes API:
  * Flash Player 9
  * Flash Player 10
  * Flash Player 10.0.32
  * Flash Player 10.1
  * AIR 1.0
  * AIR 1.5
  * AIR 1.5.1
  * AIR 1.5.2
  * AIR 2.0

We will refer to it as the Flash Platform API , shortened to **FPAPI**.

Based on publicly accessible documentation:<br>
<a href='http://help.adobe.com/en_US/FlashPlatform/beta/reference/actionscript/3/package-summary.html'>BETA ActionScript 3.0 Reference for the Adobe Flash Platform</a><br>
<a href='http://help.adobe.com/en_US/FlashPlatform/reference/actionscript/3/'>ActionScript 3.0 Reference for the Adobe Flash Platform</a><br>
<a href='http://help.adobe.com/en_US/AS3LCR/Flash_10.0/'>Flash CS4 Professional ActionScript 3.0 Language Reference</a><br>
etc.<br>
<br>
The goal is to implement in AS3 and/or native C/C++ the FPAPI in order to generate <code>*.abc</code> files compatible with <a href='http://www.mozilla.org/projects/tamarin/'>Tamarin</a>.<br>
<br>
This platform library is used by <a href='http://code.google.com/p/redtamarin/'>redtamarin</a> (starting with v0.3).<br>
<br>
<h2>Details</h2>

You have a great program in AS3 working with Flash Player or AIR<br>
but you want to reuse it or part of the source code in a command line tool<br>
<br>
something like<br>
<pre><code>package<br>
{<br>
    import flash.display.Sprite;<br>
<br>
    public class Main extends Sprite<br>
    {<br>
        //...<br>
    }<br>
}<br>
</code></pre>

will simply not work in the context of Tamarin because there is no <code>Sprite</code> class definition.<br>
<b>avmglue</b> will provide this <code>Sprite</code> class definition.<br>
<br>
<br><br>

You need to mock FPAPI classes for particular tests and/or unit tests,<br>
the problem is that those classes are only available trough <code>playerglobal.swc</code>, <code>airglobal.swc</code>, etc.<br>
and in fact are embedded directly in the runtime executable, you can not change them.<br>
<br>
By using <b>avmglue</b> and Tamarin, you can change those classes,<br>
for ex: you can force the locale to be <code>FR_fr</code> on a <code>US_gb</code> system<br>
or you can emulate the domain <code>www.domain.com</code> on your localhost<br>
etc.<br>
<br>
see:<br>
<ul><li><del><a href='http://code.google.com/p/maashaack/source/browse/platform/avmglue/trunk/src/flash_utils.as'>flash_api</a> namespace</del>
</li><li><del><a href='http://code.google.com/p/maashaack/source/browse/platform/avmglue/trunk/src/HostConfig.as'>HostConfig</a></del>
</li><li><del><a href='http://code.google.com/p/maashaack/source/browse/platform/avmglue/trunk/src/classes/FSCommand.as'>FSCommand</a></del></li></ul>

<br><br>

You want to write your Tamarin AS3 code in Flex Builder or other nice IDE with syntax completion etc.,<br>
<code>avmglue.swc</code> based on <code>avmglue.abc</code> should be able to ease the task and replace 1 to 1 <code>playerglobal.swc</code>.<br>
<br>
<br><br>

So yeah, we're basicaly rewriting the whole FPAPI, with versioning (see <a href='http://hg.mozilla.org/tamarin-central/file/fbecf6c8a86f/doc/apiversioning.txt'>Tamarin API versioning</a>), from scratch.<br>
<br>
It will off course not happen overnight, but here the plan<br>
<ul><li>follow the same file structure as found here in the <a href='http://opensource.adobe.com/svn/opensource/flex/sdk/trunk/modules/asc/build/java/build.xml'>target playerglobalabc</a>.<br>
</li><li>first, have a dumb implementation with almost no code logic<br>eg. you can extends <code>Sprite</code> but calling <code>addChild()</code> does nothing, except maybe tracing the call<br>
</li><li>second, have some part of the FPAPI with AS3 implementation, for ex: the <code>Timer</code> class<br>
</li><li>third, have some part of the FPAPI with C/C++ native implementation, for ex: the <code>Capabilities</code> class</li></ul>

what <b>avmglue</b> is not<br>
<ul><li>it's not an open source flash player<br>
</li><li>it's not an open source flash player<br>
</li><li>it's not an open source flash player<br>
</li><li>it's not a full native implementation of the FPAPI</li></ul>

To really understand what <b>avmglue</b> is look at the <a href='http://hg.mozilla.org/tamarin-central/raw-file/fbecf6c8a86f/shell/shell_toplevel.as'>Tamarin shell_toplevel.as class</a>
<pre><code>// The flash.system package is present so identical ATS test media can be used<br>
// in the command-line VM and the Player<br>
package flash.system<br>
{<br>
	import avmplus.*;<br>
	<br>
	public final class Capabilities<br>
	{<br>
		public static function get playerType():String { return "AVMPlus"; }<br>
		public static function get isDebugger():Boolean { return System.isDebugger(); }<br>
	}<br>
}<br>
</code></pre>

In short, <b>avmglue</b> do the same but at the <b>FPAPI</b> level,<br>
<code>Capabilities.playerType</code> and <code>Capabilities.isDebugger</code> are nice to have but not enought<br>
so <b>avmglue</b> fill the gap with all the rest.<br>
<br>
<br>
<h2>Informations</h2>

<a href='http://code.google.com/p/maashaack/source/browse/platform/avmglue/trunk/'>browse the code</a>

<a href='http://maashaack.googlecode.com/svn/platform/avmglue/trunk/'>svn</a>

<a href='http://code.google.com/p/maashaack/downloads/list'>avmglue v0.1 is available in downloads</a>

build<br>
<pre><code>$ svn co http://maashaack.googlecode.com/svn/platform/avmglue/trunk/ avmglue<br>
$ cd avmglue<br>
$ ant<br>
</code></pre>