## Introduction ##

One of the most powerfull feature of the AS3 language and yet totally underused (to not say ignored).

The [definition given in the language specification is not very clear at first](http://livedocs.adobe.com/specs/actionscript/3/as3_specification108.html), so let's try to make it simpler.

The idea of the namespaces got their origin from XML namespaces, but really we don't care about that.

The basic principle of those namespaces is to allow you to define your own attribute statements.

what ?

You do know those basic little things like **public**, **private**, **protected** ?

in short defining your own namespace allow you to define your own _protected_ attribute keyword,<br>
if you use it, whatever you define under it will be visible, if you don't use it, it will be simply invisible.<br>
<br>
Yeah it's a bit magic like that.<br>
<br>
To put it another way, if you define a namespace <b>hello</b><br>
it can allow you to specify a variable, constant or method under this namespace<br>
and make them accessible (or visible) only if you open the namespace.<br>
<br>
And you can create as many namespaces as you want.<br>
And decide to use them all at the same time or not.<br>
<br>
<br>
<h2>Details</h2>

The problem with namespaces is there are not that obvious to use, but no worries here some examples and tips.<br>
<br>
The thing to remember mainly is if with <b>public</b>, <b>private</b>, <b>protected</b><br>
the language control the visibility of the defintions,<br>
with your own namespaces, you are in control<br>
but you gonna have to explicitly announce it to the language.<br>
<br>
<br>
<h3>basic usage</h3>

Let's say you have a basic class with a method that you want to do different things wether you're in debug or release mode.<br>
<br>
<pre><code>package test<br>
{<br>
	public class ClassA<br>
	{<br>
		public function ClassA()<br>
		{<br>
			<br>
		}<br>
		<br>
		public function debugTest( msg:String ):void<br>
		{<br>
			trace( "debug: " + msg );<br>
		}<br>
		<br>
		public function releaseTest( msg:String ):void<br>
		{<br>
			trace( "release: " + msg );<br>
		}<br>
	}<br>
}<br>
</code></pre>

not very sexy or usable like that, you just want to use <i>test</i> in either one context or another<br>
<br>
first define your namespaces<br>
<pre><code>package test<br>
{<br>
	public namespace debug;<br>
}<br>
</code></pre>

<pre><code>package test<br>
{<br>
	public namespace release;<br>
}<br>
</code></pre>

and now use them in your class<br>
<pre><code>package test<br>
{<br>
	public class ClassA<br>
	{<br>
		public function ClassA()<br>
		{<br>
			<br>
		}<br>
		<br>
		debug function test( msg:String ):void<br>
		{<br>
			trace( "debug: " + msg );<br>
		}<br>
		<br>
		release function test( msg:String ):void<br>
		{<br>
			trace( "release: " + msg );<br>
		}<br>
	}<br>
}<br>
</code></pre>

yes you just have 2 methods named the same, and yes you just replaced your <b>public</b> attributes<br>
by 2 custom attributes <b>debug</b> and <b>release</b>.<br>
<br>
now let's use this<br>
<pre><code>import test.ClassA;<br>
<br>
var a:ClassA = new ClassA();<br>
       a.test( "hello world" );<br>
</code></pre>

not gonna work, the compiler probably gonna tell you he can not find the test method.<br>
<br>
When you declare something <b>public</b>, this attribute is open by default by the language,<br>
when you use your own attributes, you don't have this kind of automated behaviour.<br>
<br>
You have to explicitly tell that you want to use your namespace, and for that there is 2 way of doing it<br>
<br>
you directly provide the path of the namespace<br>
<pre><code>import test.ClassA;<br>
import test.debug; //yes you have to import your namespace for it to be visible<br>
<br>
var a:ClassA = new ClassA();<br>
       a.debug::test( "hello world" ); //full path to the namespace containing your method<br>
       //will trace "debug: hello world"<br>
</code></pre>

or even better, you explicitly tell the language you want to use the namespace<br>
<pre><code>import test.ClassA;<br>
import test.debug;<br>
<br>
use namespace debug; //hey I want to use the namespace debug<br>
<br>
var a:ClassA = new ClassA();<br>
       a.test( "hello world" ); // and now you can directly access the method<br>
       //will trace "debug: hello world"<br>
</code></pre>

and off course, you can switch between namespaces<br>
<pre><code>import test.ClassA;<br>
import test.release;<br>
<br>
use namespace release; //hey I want to use the namespace release this time<br>
<br>
var a:ClassA = new ClassA();<br>
       a.test( "hello world" ); // and now you can directly access the method<br>
       //will trace "release: hello world"<br>
</code></pre>

Pretty neat if you ask me.<br>
<br>
why ?<br>
<br>
You can really isolate your debug and release logic keeping the same method names,<br>
it's like having two implementations in parallel.<br>
The disadvantage is that your class carry the two implementations at the same time,<br>
so if you want one or the other and stay light in size better use conditional compilation instead.<br>
<br>
But that's also my point, you do carry the two implementations, so you should be able to switch betweeen them.<br>
<br>
<br>
<h3>selectable namespaces</h3>

A namespace is a constant, you can not change it's value.<br>
But you can declare a variable of the type Namespace and fill its value at runtime ;).<br>
<br>
Let's transform our example, so you can switch from one namespace to another.<br>
<br>
<pre><code>package test<br>
{<br>
	public class ClassA<br>
	{<br>
                private var _ns:Namespace; //your variable<br>
                <br>
		public function ClassA( ns:Namespace = null )<br>
		{<br>
			if( !ns )<br>
			{<br>
				ns = debug;<br>
			}<br>
			<br>
			_ns = ns; //you assign a value<br>
		}<br>
		<br>
		public function test( msg:String ):void<br>
		{<br>
			_ns::test( msg ); //you reuse your var<br>
		}<br>
                <br>
		debug function test( msg:String ):void<br>
		{<br>
			trace( "debug: " + msg );<br>
		}<br>
		<br>
		release function test( msg:String ):void<br>
		{<br>
			trace( "release: " + msg );<br>
		}<br>
	}<br>
}<br>
</code></pre>

wait, wait, wait ...<br>
<br>
To really understand that you need more infos about namespaces.<br>
Each namespace you define is considered unique by the system,<br>
technically you can define the same variable name of a namespace in 2 different packages<br>
but the system will see those namespaces as different.<br>
<br>
<pre><code>package test<br>
{<br>
	public namespace debug;<br>
}<br>
</code></pre>

and<br>
<br>
<pre><code>package com.whatever<br>
{<br>
	public namespace debug;<br>
}<br>
</code></pre>

same name but different identities!!<br>
<br>
In the class above, we're passing the namespace as a reference.<br>
<br>
In the comment above when I say "you reuse your var", you could see that as "you reuse the identity of the namespace".<br>
<br>
in code you can do that with a property of your class<br>
<pre><code>     this["test"]( "hello world" );<br>
</code></pre>

if test is a public method, or a visible method, the slot will be resolved from the string "test"<br>
with a namespace value it work the same, but you can not resolve it from a string,<br>
you have to pass the reference of the namespace (it is a constant).<br>
<br>
so when we do that<br>
<pre><code>		public function test( msg:String ):void<br>
		{<br>
			_ns::test( msg ); //you reuse your var<br>
		}<br>
</code></pre>

<code>_ns</code> got resolved to the namespace we pass in the constructor, but there we can only pass<br>
the reference.<br>
<br>
We define 3 methods <i>test</i>, one in the public namespace, one in the debug namespace and one in the release namespace.<br>
<br>
The method in the public namespace is just a redirector who use the namespace notation.<br>
<br>
Let's use it<br>
<pre><code>import test.ClassA;<br>
import test.debug;<br>
<br>
var a:ClassA = new ClassA( debug ); //you pass your reference<br>
       a.test( "hello world" );<br>
       //will trace "debug: hello world"<br>
</code></pre>

So what happen really ?<br>
<br>
you save the namespace debug in the <code>_ns</code> variable<br>
first the public method test is called<br>
and redirect to <code>_ns::test</code><br>
<code>_ns::test</code> is resolved to <code>debug::test</code>


Let's use it more<br>
<pre><code>import test.ClassA;<br>
import test.debug;<br>
import test.release;<br>
<br>
var a:ClassA = new ClassA( debug );<br>
       a.test( "hello world" );<br>
       //will trace "debug: hello world"<br>
<br>
var b:ClassA = new ClassA( release );<br>
       b.test( "hello world" );<br>
       //will trace "release: hello world"<br>
</code></pre>

And you can do endless variations, for example, you could store the namespace in a public variable of the class<br>
and not even pass it to the constructor and so something like<br>
<pre><code>import test.ClassA;<br>
import test.debug;<br>
import test.release;<br>
<br>
var a:ClassA = new ClassA();<br>
       a.context = debug;<br>
       a.test( "hello world" );<br>
       //will trace "debug: hello world"<br>
       a.context = release;<br>
       a.test( "hello world" );<br>
       //will trace "release: hello world"<br>
</code></pre>


<h2>neat tricks with namespaces</h2>

<h3>Override the trace function</h3>

Oh yes you can. Let's see how :).<br>
<br>
<pre><code>package test<br>
{<br>
	public class ClassA<br>
	{<br>
                public function ClassA()<br>
		{<br>
		}<br>
		<br>
		public function test( msg:String ):void<br>
		{<br>
			trace( msg );<br>
		}<br>
                <br>
		protected function trace( msg:String ):void<br>
		{<br>
			public::trace( "[ " + msg + " ]" );<br>
		}<br>
	}<br>
}<br>
</code></pre>

The function trace is defined in the public namespace at the anonymous package level,<br>
it is publicly available everywhere in your code.<br>
<br>
But here in the context of your class, if you define a trace function either in the <b>protected</b> or <b>private</b>
namespace, your function will take the priority over the public trace.<br>
<br>
At the end you still want to use the trace function, so you explicitly use the full path<br>
including the public namespace.<br>
<br>
No hack here, you just use your language to the fullest.<br>
<br>
<h3>Code reflection</h3>

<pre><code>package test<br>
{<br>
	public class ClassA<br>
	{<br>
                public function ClassA()<br>
		{<br>
		<br>
		    var ns:NameSpace = new NameSpace( "flash.utils" );<br>
		    var c:Class = ns::["ByteArray"];<br>
		<br>
		    var ba:* = new c();<br>
		}<br>
	}<br>
}<br>
</code></pre>


TODO (more to come)<br>
<br>
<ul><li>customize MovieClip trick<br>
</li><li>hide parts of your public API<br>
</li><li>unit tests helper<br>
</li><li>advanced security class