## Introduction ##

```
Interfaces provide a way for programs to express contracts between the producers and consumers of objects.
These contracts are type safe, easy to understand, and efficient to implement.
Programs should not have to pay a significant performance penalty for using interfaces.

An interface is a type whose methods must be defined by every class that claims to implement it.
Multiple interfaces can be inherited by another interface through the extends clause or by a class through the implements clause.
Instances of a class that implements an interface belong to the type represented by the interface.
Interface definitions must only contain function definitions, which may include get and set methods.

Interface methods are not public by default, but are added to the public namespace
by the implementing method definition.
```

see [Interfaces (AS3 spec)](http://livedocs.adobe.com/specs/actionscript/3/as3_specification95.html)


## Details ##

Most of the time you will want to see an interface as a type, and based on that you would want to ditch the **I** in front of the name.

See **Architectural Atrocities, Part 5: Interfaces in AS3** [|2|](#2.md), for a long discussion about that touchy subject.

My take on that is that I can accept a capital **I** in the name of an interface when we consider a template,
but for a type I will bust your balls till you capitulate and remove the **I**.

Yes, you don't need to put a capital **I** everywhere, and here some basic examples.

### Basics use ###

Let's say that in your code you want a **Serializable** type<br>
so when you see an object that implement the interface you could say<br>
<pre><code>my object is Serializable<br>
</code></pre>

what is the contract of a Serializable object ?<br>
<pre><code>package<br>
{<br>
<br>
    public interface Serializable<br>
    {<br>
    <br>
    }<br>
<br>
}<br>
</code></pre>

with just that for every class implementing the interface you could test<br>
<pre><code>trace( myobject is Serializable )<br>
</code></pre>

yes, you don't really need to define functions in this interface as your main concern is to be able to classify a type<br>
<br>
Now if you want to enforce a contract, as<br>
<pre><code>if you are of a type Serializable you have to respect a predefined behaviour<br>
</code></pre>

the definition of the contract will be the definition of the methods you add to an interface<br>
<pre><code>package<br>
{<br>
<br>
    public interface Serializable<br>
    {<br>
        function toSource( indent:int = 0 ):String;<br>
    }<br>
<br>
}<br>
</code></pre>

eg.<br>
<ul><li>you have to define a toSource method<br>
</li><li>this method have to return a string type<br>
</li><li>this method have one optional argument of type integer</li></ul>

that's the contract to respect to be considered of the <b>Serializable</b> type<br>
<br>
<h3>Some Thoughts</h3>

When you're programming in a framework context you will want to use interfaces to define common behaviours,<br>
here with maashaack we use <b>Serializable</b>, <b>Serializer</b>, etc.<br>
<br>
Don't do that if you plan to have only one serializer, but do use interfaces if you want to define<br>
a general serializer behaviour and have different implementation of it (a eden serializer, a WDDX serializer, a JSON serializer, etc.)<br>
<br>
If you're programming in a public API context using interfaces is THE way to go,<br>
you should even consider your interfaces being the API.<br>
Yes, even if you have only one implementation of the interface.<br>
You want the users of the public API to programm their code based on the interfaces, not the implementation.<br>
<br>
This is very well explained in <b>Program to an interface, not an implementation</b> <a href='#1.md'>|1|</a>.<br>
<br>
But you should be aware of certain traps.<br>
<br>
As soon as you put a public API out there, you can not change it.<br>
Well... you can not change the interfaces, but you can change the implementation.<br>
<br>
Ok I lied a bit, you can change the interfaces, but you can not break them.<br>
And here come the biggest trap: how to version an API.<br>
<br>
First, there are no rules and many many many ways of doing it.<br>
(I speak from my small experiences with Google Analytics and Miniclip, comments/critics welcome)<br>
<br>
Here what may happen to your public API<br>
<ul><li>on one side you gonna provide services to use publicly for your users<br>
</li><li>on the other side you'll have to update the implementation to correct bugs, add features, etc.</li></ul>

the best way imho to do that is to allow yourself to add but never remove anything.<br>
So your API can evolve, but not break older version or put another way: be backward compatible.<br>
<br>
so here the basic rules for a public API (wether you have 100 or 10000 users)<br>
<ul><li>always define interfaces for everything that your user can use (the public side)<br>
</li><li>never give access to the implementation (the private side)<br>
</li><li>never remove anything from your interfaces<br>
</li><li>use builtin types in your interfaces and/or other interfaces (don't use custom types)<br>
</li><li>be careful how you define your interfaces and how you add to it<br>
</li><li>if you want to give access to a single object (as an entry point), define an interface for it<br>and by extension use getter/setter to define properties for this object</li></ul>

for the versioning in itself I would favour versioning the implementations and keep the interfaces without versioning, but this can be done in a lot of different ways so this will highly depends on your needs (and your users needs).<br>
<br>
<h3>Defining a public API</h3>

So for example sake,<br>
let's say we have a brand name <b>Kiki's delivery</b> which is also a website with some services<br>
and we want to provide access to those services via a public API.<br>
<br>
Our use case is that <b>Kiki's delivery</b> is a gift delivery services and our main goal is to allow<br>
any developers using our public API to deliver gifts by providing a gift number.<br>
<br>
Here the plan:<br>
<ul><li>we want <b>Kiki</b> to be an entry point<br>
</li><li>we want to provide a <b>services</b> interface<br>
</li><li>so at the end your user can do <code>Kiki.services.doSomething()</code></li></ul>

let's define our interfaces<br>
<pre><code>package kiki<br>
{<br>
    public interface KikiAPI<br>
    {<br>
        function get version():String;<br>
        function get services():Services;<br>
    }<br>
}<br>
</code></pre>
<pre><code>package kiki<br>
{<br>
    public interface Services<br>
    {<br>
        function deliver( id:Number ):void;<br>
    }<br>
}<br>
</code></pre>

how your user will use it like that ?<br>
<pre><code>var kiki:KikiAPI = new KikiAPIImplementation();<br>
       kiki.services.deliver( 123 );<br>
</code></pre>

It's kind of bad as you have to give access to <b>KikiAPIImplementation</b> so the user can initialize your entry point.<br>
Also <b>KikiAPI</b> is not a very good name imho.<br>
<br>
Here come the use of the <a href='Singleton.md'>Singleton</a> to define your entry point and hide the implementation to your users.<br>
Let's rename <b>KikiAPI</b> to just <b>Kiki</b>
<pre><code>package kiki<br>
{<br>
    public interface Kiki<br>
    {<br>
        function get version():String;<br>
        function get services():Services;<br>
    }<br>
}<br>
</code></pre>
then let's do an internal implementation of it<br>
<pre><code>package kiki<br>
{<br>
    public class _Kiki implements Kiki<br>
    {<br>
        //...<br>
    }<br>
}<br>
</code></pre>
and finally provide an entry point for it<br>
<pre><code>package kiki<br>
{<br>
    public const KikiDelivery:Kiki = new _Kiki();<br>
}<br>
</code></pre>


now for your users, the use of the public API would be like that<br>
<pre><code>import kiki.KikiDelivery;<br>
<br>
KikiDelivery.services.deliver( 123 );<br>
</code></pre>

Very basic to implement and to use, and never your user need to know about your internal implementation.<br>
Tomorrow you can fix a dozen of bugs, you just keep the same interfaces and release a v1.1 update.<br>
<br>
But after tomorrow your users are demanding and they ask to be able to deliver a gift with a card so they can put a friendly message on it.<br>
<br>
Time to update your services interface<br>
<pre><code>package kiki<br>
{<br>
    public interface Services<br>
    {<br>
        function deliver( id:Number, message:String = "" ):void;<br>
    }<br>
}<br>
</code></pre>

and your users can now use it<br>
<pre><code>import kiki.KikiDelivery;<br>
<br>
KikiDelivery.services.deliver( 123, "from russia with love" );<br>
</code></pre>

Even if the example is over-simplified, I hope you can still see where numerous problems can occurs<br>
<ul><li>you could have a good half of your users not updating their app to the last API version<br>
</li><li>you have to deal in parallel with user using API v1.0 and user using API v2.0<br>
</li><li>if you don't give a default value for the message, you end up breaking old code that does not use the message property</li></ul>


so here <b>few tips</b> from various experiences:<br>
<br>
<b>1.</b> always define a version of your API, but don't use the version number in the interface name<br>
<br>
<pre><code>package kiki<br>
{<br>
    public class _Kiki implements Kiki<br>
    {<br>
        //...<br>
        public function get version():String<br>
        {<br>
            return "1.0"; //yeah as simple as that is enougth<br>
        }<br>
    }<br>
}<br>
</code></pre>

as a personal favorite I like to define an <b>API</b> class combined with an include file<br>
(you can reuse the include in an Ant build and use the rev number under SVN)<br>
<br>
<b>version.propertie</b>
<pre><code>version.major = 1<br>
version.minor = 0<br>
version.build  = 0<br>
</code></pre>

<b>API.as</b>
<pre><code>package kiki<br>
{<br>
    public class API<br>
    {<br>
        public static var version:Version = new Version()<br>
        include "version.properties"<br>
        version.revision = "$Rev: 1234 $ ".split( " " )[1];<br>
    }<br>
}<br>
</code></pre>
and in your implementation<br>
<pre><code>package kiki<br>
{<br>
    public class _Kiki implements Kiki<br>
    {<br>
        //...<br>
        public function get version():String<br>
        {<br>
            return API.version.toString();<br>
        }<br>
    }<br>
}<br>
</code></pre>

why ?<br>
<br>
for support, if you go into providing a public API you gonna have to support it<br>
and so if one of your user end up wit ha problem, you want to be able to ask<br>
please trace KikiDelivery.version and give me the number so you can check on your implementations<br>
to see if it's a bug or something is badly documented, etc.<br>
<br>
Depending on how much different version of the API, how many users you supports, etc.<br>
you will feel lucky if the user problems can be solved by just updating the API to the last version ;)<br>
<br>
<br>
<b>2.</b> if you really have to use an object as an entry point for your API<br>
<br>
Combine a Singleton and an Interface at the package level<br>
and use a Factory to initialize this main object<br>
<br>
small example<br>
<pre><code>package kiki<br>
{<br>
    public class _Kiki implements Kiki<br>
    {<br>
        public function _Kiki()<br>
        {<br>
            _factory();<br>
        }<br>
<br>
        private function _factory():void<br>
        {<br>
             _services = new KikiServices();<br>
        }<br>
<br>
        public function get version():String<br>
        {<br>
            return API.version.toString();<br>
        }<br>
<br>
        public function get services():Services<br>
        {<br>
            return _services;<br>
        }<br>
    }<br>
}<br>
</code></pre>

<pre><code>package kiki<br>
{<br>
    public const KikiDelivery:Kiki = new _Kiki();<br>
}<br>
</code></pre>

This will work pretty well if your API does not interact with display objects,<br>
also defining a constant at the package level will create your object pretty early in the stack.<br>
<br>
why ?<br>
<br>
In term of API, giving access to an entry point allow you to get away with a lot of things<br>
while keeping your code simple to use for your users.<br>
<br>
In the documentation, defining one line to import and use the properties is much much simpler to explain<br>
than initialize a factory, how to use events, wait for them, pass references, etc.<br>
<br>
<br>
<b>3.</b> if your main entry point object need a stage reference don't use a singleton at all<br>
<br>
Directly provide the Factory to build the instance anywhere, something that will look like that<br>
<pre><code>var myKiki:Kiki = new KikiDelivery( stage, any, other, options );<br>
</code></pre>

Notice the type, myKiki is the interface Kiki, not the class KikiDelivery.<br>
<br>
Sure it is less user friendly on the API side, but the way the display objects work if you really need<br>
that stage reference you're kind of stuck.<br>
<br>
why ?<br>
<br>
Let be clear, I'm not pro or against singletons, but if your main point is to give something simple to use to your users<br>
you gonna have to deal with a lot of complex things in the background to do just that: make things simple to use.<br>
<br>
But in the process you may end up fighting with Flash, and having access to the stage reference is one of those fights<br>
and it goes like that: on one side the only way to get this stage reference is to be an initialized display object on the display list<br>
there is no other way, period.<br>
and on the other side, you'll have to explain countless time to your user how to provide this stage reference,<br>
which after few thousands time, tons of documentation, wiki pages etc. can be painfull<br>
<br>
<br>
<b>4.</b> know your users (or at least try)<br>
<br>
There are various ways to distribute an API<br>
<ul><li>simple SWC (code only)<br>
</li><li>source code templates<br>
</li><li>Flash Component (visual SWC)<br>
</li><li>Flex Component (visual SWC)<br>
</li><li>MXP<br>
</li><li>external SWF to load<br>
</li><li>etc.</li></ul>

and <b>even more way your users will want to use this API</b>

why ?<br>
<br>
you can not plan in advance how the users will use your API<br>
you can try, but it is almost granted that you'll have to update your code and evolve the API<br>
one way or another<br>
<br>
this send back to <b>1.</b>, you'll have to deal with versioning, branching, etc.<br>
<br>
<br>
So for the little story,<br>
when we worked on the <a href='http://code.google.com/p/gaforflash/'>gaforflash</a> project we thought that the final users<br>
would want to either use the Flash or Flex component and not use the <b>code only</b> version at all<br>
we made the code only version for us, as we prefer to deal with code directly,<br>
and it happen that a lot of people prefer the code only version.<br>
<br>
For another little story on another project,<br>
we discovered that people wanted to drop a SWC in their Flash IDE library and have code completion in Flash<br>
and so to support that we had to create a small command line tool to parse the raw asdoc xml to generate Flash IDE xml documentation<br>
and by extension, the SWC was not enougth for Flash IDE, we had to package all that in an MXP,<br>
but ultimately the user didn't need any visual to use the API, they wanted to use code and have code completion.<br>
<br>
<b>conclusion</b>

For the specific case of a public API, or an API consumed by users in general, the interfaces are your friend.<br>
<br>
If you really follow the <b>hide the implementations, show the interfaces</b> basic principle you should be able to avoid the basic versioning problem traps.<br>
<br>
But imho, using interfaces does not solve completely the versioning problems, you will have to be more creative to deal with that.<br>
<br>
<br>
<br>
<h3>Versioning interfaces</h3>

TODO<br>
<br>
In some cases, you could version your interfaces by using inheritance.<br>
But don't think it as versioning by numbers, better see it as versioning per layer.<br>
<br>
Let's say you have a public API that you want to separate in two categories: free and professional.<br>
<br>
The professional version being a more advanced paying version of the API.<br>
<br>
You could organize your interfaces with inheritance<br>
<br>
first you define an empty interface for your base type<br>
<pre><code>package company<br>
{<br>
    public interface ChatServer<br>
    {<br>
    <br>
    }<br>
}<br>
</code></pre>

then your basic interface for the free version<br>
<pre><code>package company<br>
{<br>
    public interface ChatServerBasic extends ChatServer<br>
    {<br>
        <br>
    }<br>
}<br>
</code></pre>

and a pro interface for the more advanced version<br>
<pre><code>package company<br>
{<br>
    public interface ChatServerPro extends ChatServerBasic<br>
    {<br>
        <br>
    }<br>
}<br>
</code></pre>

TODO<br>
<br>
Another way to version interfaces is to not version the interfaces but version the package,<br>
as each package act as a context, you could switch from one context to another and keep the same<br>
type signatures for your interfaces.<br>
<br>
<pre><code>package company.v1<br>
{<br>
    public interface ChatServer<br>
    {<br>
    <br>
    }<br>
}<br>
</code></pre>

<pre><code>package company.v2<br>
{<br>
    public interface ChatServer<br>
    {<br>
    <br>
    }<br>
}<br>
</code></pre>

TODO<br>
<br>
Another example is gaforflash see <a href='http://code.google.com/p/gaforflash/source/browse/#svn/trunk/src/com/google/analytics/v4'>API v4</a>

in short, the <b>v4</b> package contains the configuration file, the API interface and 2 implementation of this interface<br>
<br>
if the API had to evolve in a <b>v5</b> version, we would duplicate the same structure in a v5 package<br>
<br>
the difference of versioned package is kind of hidden in the general interface <a href='http://code.google.com/p/gaforflash/source/browse/trunk/src/com/google/analytics/AnalyticsTracker.as'>AnalyticsTracker</a>

what is the logic behind that ?<br>
<br>
In short, the AS3 version of the Google Analytics API is a port of the JS implementation<br>
and as such, us the AS3 coders, we have no control over the API features, we just translate them<br>
so here the idea was (and is still valid imho) to have an interface <b>AnalyticsTracker</b> binding to a factory <b>GATracker</b><br>
and depending on the configuration the factory generate an instance of either <b>Bridge</b> or <b>Tracker</b> who both implements the interface <b>GoogleAnalyticsAPI</b>,<br>
so the versioned packages are here to bind our implementations and interfaces definition to particular version of the JavaScript source code<br>
<br>
<br>
<br>
TODO<br>
<br>
TODO<br>
<ul><li>illustrate double dispatch with interface</li></ul>


<h2>Annotation</h2>

<h4>1</h4>

<a href='http://www.artima.com/lejava/articles/designprinciples.html'>Program to an interface, not an implementation</a><br>
explained by Erich Gamma (you can not beat that :))<br>
<br>
But here some comments as AS3 is not Java:<br>
<br>
being able to switch implementation between a mock and the real implementation can be very usefull, and not only for testing<br>
<br>
for example, at Miniclip, we use that to provide 2 implementations of our API based on the same interfaces<br>
when a game developer works localy in Flash IDE, he adds a gamemanager.swc and produce a game.swf<br>
there he is using a mock implementation of the API, the goal is to add the types/interfaces signature to the swf bytecode.<br>
Later, when the game.swf is loaded online by a gamemanager.swf, because our game manager is loaded first<br>
its implementation of the interfaces take priority in memory<br>
and so when the game.swf is loaded, any interfaces signature use those definition (as an application domain can not define twice the same implementation, see <a href='ApplicationDomain.md'>ApplicationDomain</a> dirty secrets).<br>
<br>
<pre><code>In Java when you add a new method to an interface, you break all your clients.<br>
</code></pre>

It does not work the same in AS3, from what I experienced you can add arguments to existing methods and add new methods and it will not break your clients, most of the time it will work.<br>
But in some cases I could not isolate, sometimes it could break, almost as if the bytecode was checking itself for differences, and if the differences are too big then the runtime will throw an error.<br>
<br>
Also, don't try to emulate abstract in AS3, it will just fail, you don't have abstract classes in AS3<br>
it could change in a future AS4, but for now you have to do without it.<br>
<br>
<pre><code>Another lesson learned is that you should focus not only on developing version one,<br>
but to also think about the following versions.<br>
This doesn't mean designing in future extensibility, but just keeping in mind that<br>
you have to maintain what you produce and try to keep the API stable for a long time.<br>
You want to build to last.<br>
</code></pre>

this is so true on so many levels for AS3 too.<br>
<br>
<br>
<h4>2</h4>

<a href='http://blog.iconara.net/2006/07/29/architectural-atrocities-part-5-interfaces-in-as3/'>ARCHITECTURAL ATROCITIES, PART 5: INTERFACES IN AS3</a><br>
on <a href='http://blog.iconara.net'>Theo Hultberg Iconara blog</a>

<pre><code>If an interface is a type, and you want to program to interfaces,<br>
your ActionScript code will be littered with types that start with “I”.<br>
<br>
Types are types. It doesn’t matter if they are abstract or concrete, they are types,<br>
you shouldn’t distinguish between a type defined by an interface and one defined by an imlementation (a class).<br>
<br>
Prefixing with “I” takes interfaces aside and tells us that these are special cases, not abstract types.<br>
I read code like this as “This is an IFootballPlayer”, not “this is a football player”.<br>
This is wrong, a type represents a concept, not a type name and naming conventions<br>
should make it easier for the client programmer to think in this way, not harder.<br>
</code></pre>

nicely said and true.