## Introduction ##

Here we explain all the little differences between<br>
what we consider <b>slots</b>, <b>signals</b> and <b>events</b>.<br>
<br>
Basically it is all about transferring messages between objects,<br>
and yes you can do it in a lot of different ways.<br>
<br>
Are we asynchronous or synchronous ?<br>
Do we communicate with a user interface ?<br>
How fast can we go ?<br>
How many listeners can we reach ?<br>
etc.<br>
<br>
Just few questions you could ask yourself when<br>
it come to "message programming".<br>
<br>
<h2>Details</h2>

First, we are talking about AS3 and so we need to state<br>
that functions are first class objects: you can pass them as arguments.<br>
<br>
<h3>Function Callback</h3>

Nothing new, since AS1 you can do that.<br>
<br>
TODO<br>
<br>
<pre><code>//convention<br>
someInstance.onNotify = function( arg1, arg2 ) { .... }<br>
</code></pre>


<h3>Slots</h3>

Same, since AS1 we can use that, remember the <b>ASBroadcaster</b> class.<br>
Very similar to the function callback, ... TODO<br>
<br>
<pre><code>source --&gt; broadcast( message, ...args ) --&gt; target<br>
</code></pre>
<ul><li>you have a list of targets<br>
</li><li>the <code>message</code> is a function name<br>
</li><li>you loop trough the list<br>and call the function in the scope of each target<br>passing a serie of arguments</li></ul>

<pre><code>//convention<br>
otherInstance.notify = function( arg1, arg2 ):void<br>
{<br>
  //...<br>
}<br>
<br>
someInstance.addListener( otherInstance );<br>
<br>
someInstance.broadcast( "notify", arg1, arg2 );<br>
</code></pre>


<h3>Signals</h3>

Similar to the function callback and the slot, ... TODO<br>
<br>
<pre><code>signaler --&gt; emit( message, ...args ) --&gt; receiver<br>
</code></pre>

<pre><code>//convention<br>
//otherInstance implements Receiver<br>
<br>
otherInstance.receive( ...values:Array ):void<br>
{<br>
    onNotify( values[0], values[1] );<br>
}<br>
<br>
otherInstance.onNotify = function( arg1, arg2 ):void<br>
{<br>
  //...<br>
}<br>
<br>
otherFunction = function( arg1, arg2 )<br>
{<br>
  //...<br>
}<br>
<br>
someInstance.notified = new Signal();<br>
<br>
someInstance.notified.connect( otherInstance );<br>
someInstance.notified.connect( otherFunction );<br>
<br>
someInstance.notified.emit( arg1, arg2 );<br>
</code></pre>


<h3>Events</h3>

<pre><code>dispatcher --&gt; dispatch( event object ) --&gt; listener<br>
<br>
  (origin) --&gt; -- capture -----&gt; (target) ---.<br>
    ^                                        |<br>
    `--  (node) &lt;-- (node) &lt;--  bubbling &lt;---'<br>
</code></pre>

<pre><code>//convention<br>
<br>
someInstance.onNotify = function( event:EventType ):void<br>
{<br>
  //...<br>
}<br>
<br>
someInstance.addEventListener( EventString, onNotify );<br>
<br>
otherInstance.dispatchEvent( new EventType( EventString, arg1, arg2 ) );<br>
</code></pre>

<hr />
<h3>Ressources</h3>

<b>links:</b>
<ul><li><a href='http://en.wikipedia.org/wiki/Callback_(computer_programming)'>Callback</a> (Wikipedia)<br>
</li><li><a href='http://en.wikipedia.org/wiki/Signal_programming'>Signal programming</a> (Wikipedia)<br>
</li><li><a href='http://en.wikipedia.org/wiki/Event-driven_programming'>Event-driven programming</a> (Wikipedia)<br>
</li><li><a href='http://en.wikipedia.org/wiki/Signal_(computing)'>Unix Signal</a> (Wikipedia)<br>
</li><li><a href='http://en.wikipedia.org/wiki/Signals_and_slots'>Signals and Slots</a> (Wikipedia)<br>
</li><li><a href='http://qt-project.org/doc/qt-4.8/signalsandslots.html'>Signals &amp; Slots</a> (QT)<br>
</li><li><a href='http://python-gtk-3-tutorial.readthedocs.org/en/latest/basics.html'>Main loop and Signals</a> (Python GTK+ 3 Tutorial)<br>
</li><li><a href='http://www.javaworld.com/javaworld/javatips/jw-javatip10.html'>Implement callback routines in Java</a> (javaworld)