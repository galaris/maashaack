# About #

**logd** is a logging library implemented in the spirit of the **core** package,<br>
small, fast and without any dependencies.<br>
<br>
<a href='Hidden comment: 
<a href="http://maashaack.googlecode.com"><img src="http://maashaack.googlecode.com/svn/gfx/download.png" align="left"/>

Unknown end tag for </a>


'></a><br>
<br>
<table><thead><th> <b>package</b> </th><th> <b>FPAPI</b> </th><th> <b>CC</b> </th><th> <b>dependencies</b> </th><th> <b>cross-platform</b> </th><th> <b>redtamarin</b> </th></thead><tbody>
<tr><td> <code>core.*</code> </td><td> FP_10_2<br>avmglue 0.1 </td><td> <code>LOG::P</code> (optional) </td><td> n/a                 </td><td> yes                   </td><td> 0.3.1             </td></tr></tbody></table>

<table><thead><th> <b>browse</b> </th><th> <a href='http://code.google.com/p/maashaack/source/browse/#svn%2Flibraries%2Flogd%2Ftrunk'>/libraries/logd/trunk</a> </th></thead><tbody>
<tr><td> <b>checkout</b> </td><td> <code>svn checkout http://maashaack.googlecode.com/svn/libraries/logd/trunk logd-read-only</code>                    </td></tr></tbody></table>

<a href='http://maashaack.googlecode.com/svn/libs/trunk/swc/libraries/logd.swc'><img src='http://maashaack.googlecode.com/svn/gfx/swc.png' align='left' /></a>
<a href='http://maashaack.googlecode.com/svn/libs/trunk/abc/libraries/logd.abc'><img src='http://maashaack.googlecode.com/svn/gfx/abc.png' align='left' /></a>

<br>
<br>
<br>
<br>

<h1>Introduction</h1>

Today in AS3 you must have about 100's of different logging libraries,<br>
people kind of followed what happened with Java<br>
(Log4J, Jakarta Commons-Logging, SLF4J, java.util.logging, etc.).<br>
<br>
No seriously, search google code for "as3 logging" and <a href='http://code.google.com/hosting/search?q=as3+logging'>see for yourself</a>.<br>
<br>
One thing for sure is that to log information is something useful,<br>
but because there are so many different logging implementations in AS3<br>
you don't want to impose the use of one particular logging library (simply because you use it in your code).<br>
<br>
In the <b>maashaack framework</b> there is a fairly complete logging library <b>system.logging</b><br>
you can browse the code here <a href='http://code.google.com/p/maashaack/source/browse/#svn%2Ftrunk%2FAS3%2Fsrc%2Fsystem%2Flogging'>/trunk/AS3/src/system/logging</a>

But this <b>system.logging</b> is more something that someone would use in his/her application code,<br>
and something we try to not use in the lower layers of packages,libraries etc.<br>
<br>
<br>

<h1>Details</h1>

<b>logd</b> focus on 3 points<br>
<ul><li>being as small and fast as possible<br>
</li><li>being customisable so you can hook it with any other logging library<br>
</li><li>being completely removable with ConditionalCompilation</li></ul>

Also <b>logd</b> has been largely inspired by <a href='http://developer.android.com/reference/android/util/Log.html'>android.util.Log</a>.<br>
<br>
You could resume <b>logd</b> as a wrapper around <code>trace()</code> that connect its input/output to other loggers.<br>
<br>
here the API<br>
<pre><code>package core<br>
{<br>
    public interface Logger<br>
    {<br>
        function get SUPPRESS():int;<br>
        function get VERBOSE():int;<br>
        function get DEBUG():int;<br>
        function get INFO():int;<br>
        function get WARN():int;<br>
        function get ERROR():int;<br>
        function get ASSERT():int;<br>
        <br>
        function get id():String;<br>
<br>
        function get level():int;<br>
        function set level( value:int ):void;<br>
        <br>
        function get input():Function;<br>
        function set input( value:Function ):void;<br>
        <br>
        function get output():Function;<br>
        function set output( value:Function ):void;<br>
<br>
        function config( cfg:Object ):void;<br>
<br>
        function format( priority:int, pre:String = "", post:String = "" ):void;<br>
<br>
        function tag( name:String, level:int = -1 ):Logger;<br>
<br>
        function v( msg:String, o:* = null ):void;<br>
        function d( msg:String, o:* = null ):void;<br>
        function i( msg:String, o:* = null ):void;<br>
        function w( msg:String, o:* = null ):void;<br>
        function e( msg:String, o:* = null ):void;<br>
        function wtf( msg:String, o:* = null ):void;<br>
<br>
        function println( priority:int, tag:String, msg:String, o:* = null ):void;        <br>
    }<br>
}<br>
</code></pre>
<br>
<br>

to remove any <b>logd</b> calls enclose them with <code>LOG::P</code> and see ConditionalCompilation<br>
<br>
<pre><code><br>
public function test()<br>
{<br>
    LOG::P { log.d( "debug some stuff" ); }<br>
    //code<br>
}<br>
<br>
</code></pre>
<br>
<br>


<hr />
<h1>Documentation</h1>

<b>logd</b> can use 4 different mode<br>
<br>
<b>raw</b> for text file<br>
<code>ID | PRIORITY LETTER | TAG | MESSAGE | TIME</code>
<ul><li><b>ID</b> is a random hex of 8 chars<br>
</li><li><b>PRIORITY LETTER</b>
<ul><li><b>V</b> for verbose<br>
</li><li><b>D</b> for debug<br>
</li><li><b>I</b> for info<br>
</li><li><b>W</b> for warn<br>
</li><li><b>E</b> for error<br>
</li><li><b>WTF</b> for a fatal error<br>
</li></ul></li><li><b>TAG</b> a custom tag or the empty string by default<br>
</li><li><b>MESSAGE</b> the log message<br>
</li><li><b>TIME</b> timestamp in milliseconds</li></ul>

<b>clean</b> for console output<br>
<code>TAG | PRE | MESSAGE | POST | TIME</code>
<ul><li><b>TAG</b> a custom tag or the empty string by default<br>
</li><li><b>PRE</b> pre priority format<br>
</li><li><b>MESSAGE</b> the log message<br>
</li><li><b>POST</b> post priority format<br>
</li><li><b>TIME</b> timestamp in milliseconds</li></ul>

<b>data</b> for advanced custom output<br>
there is not a formated output, but a data structure meant<br>
to be formated by your own custom output function<br>
<pre><code>obj<br>
{<br>
    id: "17AC06D37",<br>
    priority: 4,<br>
    letter: "I",<br>
    pre: "( ",<br>
    post: " )",<br>
    tag: "",<br>
    time: 63,<br>
    sep: "|",<br>
    o: null<br>
}<br>
</code></pre>
<ul><li><b>id</b> (string): session id<br>
</li><li><b>priority</b> (int): priority number<br>
</li><li><b>letter</b> (string): priority letter<br>
</li><li><b>pre</b> (string): pre priority format<br>
</li><li><b>post</b> (string): post priority format<br>
</li><li><b>tag</b> (string): custom tag<br>
</li><li><b>time</b> (uint): timestamp<br>
</li><li><b>sep</b> (string): separator<br>
</li><li><b>o</b>: custom object</li></ul>

<b>short</b> for text field<br>
<code>MESSAGE</code>
and nothing else unless you customize the input/output.<br>
<br>
<br>
<br>

<h2>Constants</h2>

<h3>SUPPRESS</h3>
<pre><code>function get SUPPRESS():int;<br>
</code></pre>
SUPPRESS value.<br>
<br>
<br>

<h3>VERBOSE</h3>
<pre><code>function get VERBOSE():int;<br>
</code></pre>
VERBOSE value.<br>
<br>
<br>

<h3>DEBUG</h3>
<pre><code>function get DEBUG():int;<br>
</code></pre>
DEBUG value.<br>
<br>
<br>

<h3>INFO</h3>
<pre><code>function get INFO():int;<br>
</code></pre>
INFO value.<br>
<br>
<br>

<h3>WARN</h3>
<pre><code>function get WARN():int;<br>
</code></pre>
WARN value.<br>
<br>
<br>

<h3>ERROR</h3>
<pre><code>function get ERROR():int;<br>
</code></pre>
ERROR value.<br>
<br>
<br>

<h3>ASSERT</h3>
<pre><code>function get ASSERT():int;<br>
</code></pre>
ASSERT value.<br>
<br>
<br>

<h2>Properties</h2>

<h3>id</h3>
<pre><code>function get id():String<br>
</code></pre>
Returns the unique ID for the logger.<br>
<br>
<br>

<h3>level</h3>
<pre><code>function get level():int<br>
function set level( value:int ):void<br>
</code></pre>
Sets/Returns the logging level for this logger.<br>
<br>
<br>

<h3>input</h3>
<pre><code>function get input():Function<br>
function set input( value:Function ):void<br>
</code></pre>
Define a log input function.<br>
<br>
The input is used to parse the log before sending it,<br>
you could use it to support special formating, appending<br>
additional informations, etc.<br>
<br>
the function HAVE TO respect this signature<br>
<pre><code>function input( msg:String, o:* = null ):Object<br>
{<br>
    //your code<br>
}<br>
</code></pre>
The returned object must contains 2 properties <code>msg</code> and <code>o</code>.<br>
<br>
<br>

<h3>output</h3>
<pre><code>function get output():Function<br>
function set output( value:Function ):void<br>
</code></pre>
Define a log output function.<br>
<br>
The output is used to send the log to a destination,<br>
by default we use <code>trace()</code> but you could<br>
use Socket, LocalConnection, etc.<br>
<br>
the function HAVE TO respect this signature<br>
<pre><code>function output( msg:String, o:* = null ):String<br>
{<br>
    //your code<br>
}<br>
</code></pre>
<br>
<br>


<h2>Methods</h2>

<h3>config</h3>
<pre><code>function config( cfg:Object ):void<br>
</code></pre>
Configure the logger with values/pairs.<br>
<br>
<b>example</b>:<br>
<pre><code>cfg = { sep: " ", //char separator<br>
             mode: "raw", // "clean", "data", "short"<br>
             tag: true, //use tag<br>
             time: false  //use time<br>
          }<br>
log.config( cfg );<br>
</code></pre>
<br>
<br>

<h3>format</h3>
<pre><code>function format( priority:int, pre:String = "", post:String = "" ):void<br>
</code></pre>
Changes the formatting of the passed priority.<br>
<br>
<b>example</b>:<br>
<pre><code>log.config( { mode: "clean" } );<br>
log.format( log.DEBUG, "D{ ", " }" );<br>
log.d( "hello world" ); // D{ hello world }<br>
</code></pre>
<br>
<br>

<h3>tag</h3>
<pre><code>function tag( name:String, level:int = -1 ):Logger<br>
</code></pre>
Creates a tag and return a new logger object.<br>
<br>
<b>note:</b><br>
The default implementation does not provide a <code>tag</code> (eg. it's the empty string).<br>
A tag can be anything from a simple name to the full path of your class, etc.<br>

<b>example</b>:<br>
<pre><code>var mylog:Logger = log.tag( "socket" );<br>
mylog.d( "client connected" ); // D|socket|client connected<br>
</code></pre>
<br>
<br>

<h3>v</h3>
<pre><code>function v( msg:String, o:* = null ):void<br>
</code></pre>
Send a VERBOSE log message.<br>
<br>
<br>

<h3>d</h3>
<pre><code>function d( msg:String, o:* = null ):void<br>
</code></pre>
Send a DEBUG log message.<br>
<br>
<br>

<h3>i</h3>
<pre><code>function i( msg:String, o:* = null ):void<br>
</code></pre>
Send an INFO log message.<br>
<br>
<br>

<h3>w</h3>
<pre><code>function w( msg:String, o:* = null ):void<br>
</code></pre>
Send a WARN log message.<br>
<br>
<br>

<h3>e</h3>
<pre><code>function e( msg:String, o:* = null ):void<br>
</code></pre>
Send an ERROR log message.<br>
<br>
<br>

<h3>wtf</h3>
<pre><code>function wtf( msg:String, o:* = null ):void<br>
</code></pre>
What a Terrible Failure (or What The Fuck).<br>
Report a condition that should never happen (eg. send an ASSERT log message).<br>
<br>
<br>

<h3>println</h3>
<pre><code>function println( priority:int, tag:String, msg:String, o:* = null ):void<br>
</code></pre>
Low-level logging call.<br>
<br>
<br>

<hr />

<h1>Usages</h1>

<h2>import and log and that's it</h2>
<pre><code>package test<br>
{<br>
    import core.log;<br>
<br>
    public class MyClass<br>
    {<br>
        public function MyClass()<br>
        {<br>
            log.i( "constructor" );<br>
        }<br>
<br>
        public function toString():String<br>
        {<br>
            log.i( "toString" );<br>
            return "MyClass";<br>
        }<br>
    }<br>
}<br>
<br>
//output (by default with trace() and flashlogs.txt<br>
17AC06D37|I||constructor|64<br>
17AC06D37|I||toString|65<br>
</code></pre>

This format is the <b>raw</b> mode, when you mainly target a text file to store your logs.<br>
<br>
the <code>17AC06D37</code> is the id for the logging session and is here only to be able to<br>
filter the logs from a big text file (like <code>flashlogs.txt</code>) and get the particular session.<br>
<br>
<br>

<h2>Adding a custom tag</h2>
<pre><code>package test<br>
{<br>
    import core.log;<br>
    import core.Logger;<br>
<br>
    public class MyClass<br>
    {<br>
        private var _log:Logger;<br>
<br>
        public function MyClass()<br>
        {<br>
            _log = log.tag( "MyClass" );<br>
            _log.i( "constructor" );<br>
        }<br>
<br>
        public function toString():String<br>
        {<br>
            _log.i( "toString" );<br>
            return "MyClass";<br>
        }<br>
    }<br>
}<br>
<br>
//output<br>
17AC06D37|I|MyClass|constructor|64<br>
17AC06D37|I|MyClass|toString|65<br>
</code></pre>
<br>

<h2>Change the mode and the separator</h2>
<pre><code>package test<br>
{<br>
    import core.log;<br>
    import core.Logger;<br>
<br>
    public class MyClass<br>
    {<br>
        private var _log:Logger;<br>
<br>
        public function MyClass()<br>
        {<br>
            _log = log.tag( "MyClass" );<br>
            _log.config( { mode: "clean", sep: " " } );<br>
            _log.i( "constructor" );<br>
        }<br>
<br>
        public function toString():String<br>
        {<br>
            _log.i( "toString" );<br>
            return "MyClass";<br>
        }<br>
    }<br>
}<br>
<br>
//output<br>
MyClass ( constructor ) 64<br>
MyClass ( toString ) 65<br>
</code></pre>
<br>

<h2>Change the format for a particular priority and change the logging level (and all of the above)</h2>
<pre><code>package test<br>
{<br>
    import core.Logger;<br>
    import core.log;<br>
    <br>
    public class MyClass<br>
    {<br>
        private var _log:Logger;<br>
        <br>
        public function MyClass()<br>
        {<br>
            _log = log.tag( "MyClass" );<br>
            _log.level = log.VERBOSE;<br>
            _log.config( { mode: "clean", sep: " " } );<br>
            _log.format( log.DEBUG, "|---------&gt; ", "" );<br>
            _log.i( "constructor" );<br>
        }<br>
        <br>
        public function test():void<br>
        {<br>
            _log.d( "test" );<br>
        }<br>
        <br>
        public function toString():String<br>
        {<br>
            _log.i( "toString" );<br>
            return "MyClass";<br>
        }<br>
    }<br>
}<br>
//output<br>
MyClass ( constructor ) 64<br>
MyClass |---------&gt; test 65<br>
MyClass ( toString ) 65<br>
</code></pre>
<br>

<h2>Customize the input function</h2>
<pre><code>package test<br>
{<br>
    import core.Logger;<br>
    import core.log;<br>
    <br>
    public class MyClass<br>
    {<br>
        private var _log:Logger;<br>
        <br>
        public function MyClass()<br>
        {<br>
            _log = log.tag( "MyClass" );<br>
            _log.level = log.VERBOSE;<br>
            _log.config( { mode: "clean", sep: " " } );<br>
            _log.input = custom_input;<br>
            _log.i( "constructor: {0} {1}", [ "hello", "world" ] );<br>
        }<br>
        <br>
        private function custom_input( msg:String, o:* = null ):Object<br>
        {<br>
            if( o )<br>
            {<br>
                msg = fastformat( msg, o );<br>
                o   = null;<br>
            }<br>
            <br>
            return { msg: msg, o: o };<br>
        }<br>
        <br>
        public function fastformat( pattern:String , ...args:Array ):String<br>
        {<br>
            if( (pattern == null) || (pattern == "") )<br>
            {<br>
                return "";<br>
            }<br>
            <br>
            var len:int = args.length;<br>
            <br>
            if( (len == 1) &amp;&amp; (args[0] is Array) )<br>
            {<br>
                args = args[0] ;<br>
                len  = args.length;<br>
            }<br>
            <br>
            for( var i:int=0; i &lt; len; i++ )<br>
            {<br>
                pattern = pattern.replace( new RegExp( "\\{"+i+"\\}", "g" ), args[i] );<br>
            }<br>
            <br>
            return pattern;<br>
        }<br>
        <br>
        public function test():void<br>
        {<br>
            _log.d( "test {0}+{1}={2}", [2,5,7] );<br>
        }<br>
        <br>
        public function toString():String<br>
        {<br>
            _log.i( "toString{0}", "()" );<br>
            return "MyClass";<br>
        }<br>
    }<br>
}<br>
<br>
//output<br>
yClass ( constructor: hello world ) 64<br>
MyClass [ test 2+5=7 ] 65<br>
MyClass ( toString() ) 65<br>
</code></pre>
<br>

<h2>Customize the output function</h2>
<pre><code>package test<br>
{<br>
    import core.Logger;<br>
    import core.log;<br>
    <br>
    import flash.external.ExternalInterface;<br>
    <br>
    public class MyClass<br>
    {<br>
        private var _log:Logger;<br>
        <br>
        public function MyClass()<br>
        {<br>
            _log = log.tag( "MyClass" );<br>
            _log.level = log.VERBOSE;<br>
            _log.config( { mode: "clean", sep: " " } );<br>
            _log.output = custom_output;<br>
            _log.i( "constructor" );<br>
        }<br>
        <br>
        private function custom_output( msg:String, o:* = null ):void<br>
        {<br>
            //basic firebug hook<br>
            if( ExternalInterface.available )<br>
            {<br>
                ExternalInterface.call( "console.log", msg );<br>
            }<br>
        }<br>
        <br>
        public function test():void<br>
        {<br>
            _log.d( "test" );<br>
        }<br>
        <br>
        public function toString():String<br>
        {<br>
            _log.i( "toString" );<br>
            return "MyClass";<br>
        }<br>
    }<br>
}<br>
<br>
//output is forwarded to another logger<br>
</code></pre>
here any log message will be redirected to the firebug command <code>console.log()</code>.<br>
<br>
<br>

<h2>Advanced customization of the output function with mode 'data'</h2>
<pre><code>package test<br>
{<br>
    import core.Logger;<br>
    import core.log;<br>
    <br>
    import flash.external.ExternalInterface;<br>
    <br>
    public class MyClass<br>
    {<br>
        private var _log:Logger;<br>
        <br>
        public function MyClass()<br>
        {<br>
            _log = log.tag( "MyClass" );<br>
            _log.level = log.VERBOSE;<br>
            _log.config( { mode: "data", sep: " " } );<br>
            _log.output = custom_output;<br>
            _log.i( "constructor" );<br>
        }<br>
        <br>
        private function custom_output( msg:String, o:* = null ):void<br>
        {<br>
            var command:String;<br>
            <br>
            //advanced firebug hook<br>
            switch( o.priority )<br>
            {<br>
                case log.DEBUG:<br>
                command = "console.debug";<br>
                break;<br>
                <br>
                case log.INFO:<br>
                command = "console.info";<br>
                break;<br>
                <br>
                case log.WARN:<br>
                command = "console.warn";<br>
                break;<br>
                <br>
                case log.ERROR:<br>
                command = "console.error";<br>
                break;<br>
                <br>
                case log.ASSERT:<br>
                command = "console.assert";<br>
                break;<br>
                <br>
                case log.VERBOSE:<br>
                default:<br>
                command = "console.log";<br>
            }<br>
            <br>
            if( ExternalInterface.available )<br>
            {<br>
                ExternalInterface.call( command, msg );<br>
            }<br>
        }<br>
        <br>
        public function test():void<br>
        {<br>
            _log.d( "test" );<br>
        }<br>
        <br>
        public function toString():String<br>
        {<br>
            _log.i( "toString" );<br>
            return "MyClass";<br>
        }<br>
    }<br>
}<br>
<br>
//output is forwarded to another logger<br>
</code></pre>

here the log message will be redirected to the corresponding firebug command<br>
the <b>data</b> mode allow us to switch on the <code>o.priority</code><br>
<code>log.d( "debug infos" )</code> will redirect to <code>console.debug()</code><br>
<code>log.i( "infos" )</code> will redirect to <code>console.info()</code><br>
etc.