## Introduction ##

The purpose of the ApplicationDomain class is to store a table of ActionScript 3.0 definitions.<br>
All code in a SWF file is defined to exist in an application domain.<br>
You use application domains to partition classes that are in the same security domain.<br>
This allows multiple definitions of the same class to exist and also lets children reuse parent definitions.<br>
<br>
<br>
<h2>Details</h2>

Yep the dirty secrets stuff, ok not that secret but nowhere clearly explained by the Adobe doc.<br>
<br>
<h3>Rules about ApplicationDomain</h3>

Things to always keep in mind when dealing with appdom.<br>
<br>
<ol><li><b>An ApplicationDomain is always dependant on a SecurityDomain</b>
<ul><li>you have to <b>explicitly trust</b> another SWF to be able to access its appdom<br>
</li><li>the only way to connect two SecurityDomain is to use <b>Direct Communication</b></li></ul></li></ol>

<blockquote>a) <b>Import loading</b> using the <code>Loader</code> class<br>
<blockquote>using <code>Loader.load()</code>
<pre><code>var loader:Loader = new Loader();<br>
var AD:ApplicationDomain = ApplicationDomain.currentDomain;<br>
var SD:SecurityDomain    = SecurityDomain.currentDomain;<br>
var context:LoaderContext = new LoaderContext( false, AD, SD );<br>
loader.load( new URLRequest( "other.swf" ), context );<br>
</code></pre>
or using <code>Loader.loadBytes()</code>
<pre><code>var raw:URLLoader = new URLLoader();<br>
       raw.dataFormat = URLLoaderDataFormat.BINARY;<br>
       raw.load( new URLRequest( "other.swf" )  );<br>
var loader:Loader = new Loader();<br>
loader.loadBytes( data );<br>
</code></pre>
here without <code>LoaderContext</code> you end up as a child appdomain</blockquote></blockquote>

<blockquote>be carefull here, by default a <code>loadBytes()</code> places the bytes in the current <code>SecurityDomain</code> but not necessary in the current <code>ApplicationDomain</code>, so you still have to use a <code>LoaderContext</code> to do a real <b>import loading</b> if you want to share the class definitions in memory!!</blockquote>

<blockquote>so to do that<br>
<pre><code>var raw:URLLoader = new URLLoader();<br>
       raw.dataFormat = URLLoaderDataFormat.BINARY;<br>
       raw.load( new URLRequest( "other.swf" )  );<br>
var AD:ApplicationDomain = ApplicationDomain.currentDomain;<br>
var context:LoaderContext = new LoaderContext( false, AD );<br>
var loader:Loader = new Loader();<br>
loader.loadBytes( data, context );<br>
</code></pre>
here all is placed in the current appdomain and so you can share class definitions<br>
yes the difference is subtle but <b>very</b> important</blockquote>

<blockquote>b) <b>Cross-Scripting</b> permissions via <code>Security.allowDomain()</code>
<pre><code>The Security.allowDomain() method grant access for cross-scripting,<br>
scripting the display list, access to the Stage object and event detection.<br>
</code></pre>
You can use <code>childAllowsParent</code> or <code>parentAllowsChild</code> properties of the <code>LoaderInfo</code> class<br>to know if two SWFs (a parent and a child) can cross-script.<br>
</blockquote><ol><li><b>The root appdom is the system domain</b><br>which contains the builtins, Flash Player API classes, etc.<b><br>
<ul><li>the system domain have no parent <a href='#1.md'>|1|</a>
</li><li>all other appdomain</b>always have a parent<b><br>
</li></ul></li><li></b>The definition of <code>ApplicationDomain.currentDomain</code> is the appdom<br>that contains the code that is calling <code>ApplicationDomain.currentDomain</code><b><ul><li>the <code>ApplicationDomain.currentDomain</code> is</b>unique to a SWF<b><a href='#2.md'>|2|</a>
</li><li>the <code>ApplicationDomain.currentDomain</code> is</b>unique to all loaded SWF<b>,</b><br>if <code>main.swf</code> load <code>child.swf</code> they both share the same <code>ApplicationDomain.currentDomain</code>
</li></ul></li><li><b>If a definition already exists in a parent appdom,</b><br>the definition in the child is ignored<b><br>
<ul><li>you can not override a definition in anyway, period.</b><br>A child swf can not redefine/update/etc. a parent definition<br>
</li><li>a child appdom will <b>always</b> use the <code>static</code> or <code>const</code> definitions from the parent appdom<br>
</li><li>the only way a child appdom can use its own definitions (but without overriding the parent definition)<br>is to be loaded in isolation</li></ul></li></ol>

<h3>Different ApplicationDomains interaction</h3>

<ol><li><b>Isolated ApplicationDomain</b><br><i>new ApplicationDomain( null )</i>
<pre><code>var loader:Loader = new Loader();<br>
var AD:ApplicationDomain = new ApplicationDomain( null );<br>
var context:LoaderContext = new LoaderContext( false, AD );<br>
loader.load( new URLRequest( "other.swf" ), context );<br>
</code></pre>
<ul><li>the parent appdom is the system domain<br>
</li><li>definitions in this appdom are <b>guaranteed to not collide</b> with other definitions<br>
</li><li>you <b>can not use those definitions in a strongly typed manner</b> in the parent appdom<br>
</li><li>you <b>can use those definitions as Objects (builtins)</b> using <code>getDefinition()</code> in the parent appdom<br>
</li></ul></li><li><b>Child ApplicationDomain</b><br><i>new ApplicationDomain( ApplicationDomain.currentDomain )</i>
<pre><code>var loader:Loader = new Loader();<br>
var AD:ApplicationDomain = new ApplicationDomain( ApplicationDomain.currentDomain );<br>
var context:LoaderContext = new LoaderContext( false, AD );<br>
loader.load( new URLRequest( "other.swf" ), context );<br>
</code></pre>
<ul><li>the parent appdom is the ApplicationDomain.currentDomain<br>
</li><li>definitions in this appdom are added to the parent appdomain if not already defined<br>
</li><li>you <b>can use those definitions in a strongly typed manner</b> in the parent appdom<br>
</li><li>this child appdom <b>can not access definitions from the parent appdom</b> by default<br>
<pre><code>If the loading SWF [parent] has classes that should not be immediately exposed to loaded SWF files [childs],<br>
then the developer should load the SWF as a child of the system's ApplicationDomain<br>
to ensure it [child] does not inherit the loading SWF [parent] file's classes.<br>
</code></pre>
</li><li>you <b>can load definitions as strong types</b> using <code>getDefinition()</code> from other appdom<br>
<pre><code>However, in this usage, the child SWF file may still be able to explicitly retrieve<br>
definitions from other ApplicationDomain if it knows their location.<br>
</code></pre>
</li></ul></li><li><b>Imported ApplicationDomain</b><br><i>ApplicationDomain.currentDomain</i>
<pre><code>var loader:Loader = new Loader();<br>
var AD:ApplicationDomain = ApplicationDomain.currentDomain;<br>
var context:LoaderContext = new LoaderContext( false, AD );<br>
loader.load( new URLRequest( "other.swf" ), context );<br>
</code></pre>
<ul><li>the parent appdom is the system domain<br>
</li><li>definitions in this appdom <b>are imported into the ApplicationDomain.currentDomain</b> (hence the name <i>import loading</i>)<br>
</li><li>you have to <b>load this appdomain before any ABC calls/uses any of its definitions</b><a href='#3.md'>|3|</a>
</li><li>two identical definitions will conflict, you can not declare twice the class <code>FooBar</code> for ex<a href='#4.md'>|4|</a></li></ul></li></ol>


<h3>Special case with AIR</h3>

AIR run on the desktop and because of that the appdom is even more touchy there.<br>
<br>
Remember the first rule that an appdomain is always dependent on a SecurityDomain,<br>
so when come the time where a desktop AIR application want to load a remote SWF,<br>
you obtain a security clash between a local SecurityDomain and a remote SecurityDomain.<br>
<br>
This is by default in AIR and this is normal and wanted, you would not want to give I/O access or<br>
full control to a remotely downloaded SWF by default do you ?<br>
<br>
But if you have to or need to here how to do an import loading in AIR<br>
(consider that as pseudo-code)<br>
<pre><code>var urlloader:URLLoader = new URLLoader();<br>
       urlloader.dataFromat = URLLoaderDataFormat.BINARY;<br>
       urlloader.addEventListener( Event.COMPLETE, onComplete );<br>
       urlloader.load( new URLRequest( "other.swf" ) );<br>
<br>
var onComplete:Function = function( event:Event ):void<br>
{<br>
    var loader:Loader = new Loader();<br>
    var AD:ApplicationDomain = ApplicationDomain.currentDomain;<br>
    //with loadBytes(0 -- the checkPolicyFile and securityDomain properties of the LoaderContext object do not apply.<br>
    //var SD:SecurityDomain    = SecurityDomain.currentDomain;<br>
    var context:LoaderContext = new LoaderContext( false, AD );<br>
           context.allowLoadBytesCodeExecution = true;<br>
<br>
    loader.loadBytes( urlloader.data, context );<br>
}<br>
</code></pre>

<pre><code>If the context parameter is not specified or refers to a null object, the content is loaded into the current security domain<br>
— a process referred to as "import loading" in Flash Player security documentation. Specifically, if the loading SWF file<br>
trusts the remote SWF by incorporating the remote SWF into its code, then the loading SWF can import it directly into its own security domain.<br>
</code></pre>

The cool thing is once you have the SWF loaded with <code>URLLoader</code>
you can decide to apply different appdomain interactions with <code>Loader</code>,<br>
either isolated or child or imported.<br>
<br>
The bad thing is because the AIR API is defined at the system appdomain level,<br>
this remotely loaded SWF can use any AIR functionalities like reading from your hard drive,<br>
and you can not prevent that even if you put the appdom in isolation<br>
(it will isolate the loaded swf from calling your code that's all).<br>
<br>
So you should be very very very sure that this remote SWF you are loading is damn secure!!<br>
<br>
<h2>References</h2>

<ul><li><a href='http://livedocs.adobe.com/flash/9.0/main/wwhelp/wwhimpl/common/html/wwhelp.htm?context=LiveDocs_Parts&file=00000327.html'>Adobe - Using the ApplicationDomain class</a>
</li><li><a href='http://blogs.adobe.com/rgonzalez/2006/06/applicationdomain.html'>Roger Gonzalez - ApplicationDomain</a>
</li><li><a href='http://www.adobe.com/devnet/flashplayer/articles/secure_swf_apps_07.html'>Creating more secure SWF web applications - Communicating Between SWFs and across Domains</a>
</li><li><a href='http://jvalentino.blogspot.com/2009/06/flex-memory-issue-4-modules-and.html'>Flex Memory Issue #4: Modules and Application Domains</a>
</li><li><a href='http://weblogs.macromedia.com/emalasky/archives/2008/04/remote_plugins.html'>Remote Plugins and Modules in AIR</a>
</li><li><a href='http://code.google.com/p/doctype/wiki/ArticleFlashSecuritySolutions'>doctype - HOWTO secure your Flash applications</a>
</li><li><a href='http://www.senocular.com/flash/tutorials/contentdomains/'>senocular - Security Domains, Application Domains, and More in ActionScript 3.0 (part 1)</a> <a href='http://www.senocular.com/flash/tutorials/contentdomains/?page=2'>(part2)</a></li></ul>

<h2>Annotations</h2>

<h4>1</h4>
the Flash Player plugin contains the bytecode for the builtins class, yes it is embedded in the plugin hence why this system appdom can not have any parent.<br>
<br>
<h4>2</h4>
here we're talking about the root SWF, meaning the first loaded SWF in the plugin, the <i>owner</i>.<br>
<br>
<h4>3</h4>
ABC = ActionScript ByteCode, contains the definition as binary form (see <a href='http://code.google.com/p/redtamarin/wiki/ABC'>ABC</a> on redtamarin).<br>
<br>
<h4>4</h4>
this also explain why you can not override or redefine a builtin class, first because its definition is in the parent appdom, but even if you were able to load your own definition in the system appdom it will collide with the already existing definition.