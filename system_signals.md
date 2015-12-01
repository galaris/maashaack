# About #

**system.signals** is a messaging library using function callbacks instead of events.

<a href='http://creativecommons.org/licenses/by-sa/3.0/'><img src='http://i.creativecommons.org/l/by-sa/2.0/uk/88x31.png' alt='Licence Creative Commons' /></a>



| **package** | **FPAPI** | **CC** | **dependencies** | **cross-platform** | **redtamarin** |
|:------------|:----------|:-------|:-----------------|:-------------------|:---------------|
| `system.signals.*` | FP\_10\_0 | n/a    | n/a              | yes                | yes            |

| **browse** | [/packages/signals/trunk](http://code.google.com/p/maashaack/source/browse/#svn%2Fpackages%2Fsystem_signals%2Ftrunk) |
|:-----------|:---------------------------------------------------------------------------------------------------------------------|
| **checkout** | `svn checkout http://maashaack.googlecode.com/svn/packages/system_signals/trunk system.signals-read-only`            |

<a href='http://maashaack.googlecode.com/svn/libs/trunk/swc/packages/system.signals.swc'><img src='http://maashaack.googlecode.com/svn/gfx/swc.png' align='left' /></a>
<a href='http://maashaack.googlecode.com/svn/libs/trunk/abc/packages/system.signals.abc'><img src='http://maashaack.googlecode.com/svn/gfx/abc.png' align='left' /></a>

<br />
<br />

# Introduction #

With AS3, the Flash Player and AIR uses by default events,
they are based on the W3C (couple of things missing) and are good
to hooks different interactions in your UI.

But sometimes you need to pass messages around objects
that are not part of your UI and there events can be slower
and/or use a bit too more ressources.

For those cases, we can replace events by signals.

To understand all the differences see [Slots vs Signals vs Events](SlotsVsSignalsVsEvents.md).

# Details #

Even if you could ignore this library and hook your messages directly using functions,
we felt all this needed a bit of structure, hence come this signals lib.

Note that his lib has nothing to do with that other lib [as3 signals](https://github.com/robertpenner/as3-signals/),
let's just say we don't see eye to eye and we preferred to go our own way.

We felt a signal library needed to do only one thing and one thing well: use functions to pass messages between objects.

And basically the signals lib is a lightweight implementation of the [Observer pattern](http://en.wikipedia.org/wiki/Observer_pattern).

So we kept things simple, with those few features:
  * a `Signaler` emits messages
  * a `Receiver` receives messages
  * a `Signaler` connect and disconnect with one or more `Receiver`
  * a `Signaler` can disconnect a specific or all `Receiver`
  * a `Receiver` can be automatically disconnected
  * a `Receiver` can be prioritized against other receivers<br>(eg. receiverX can receive a message before receiverY)<br>
<ul><li>a message is synchronous<br>(events are asynchronous)<br>
</li><li>a message is like a function<br>
</li><li>a message can be of any number of arguments<br>
</li><li>a message can have its number of arguments restricted<br>(eg. you can send only 2 args)<br>
</li><li>a message can be typed<br>(eg. 1st arg need to be a string, 2nd arg need to a int, etc.)</li></ul>

Also, signals compared to events<br>
<ul><li>a <code>Receiver</code> can be defined by a single function reference<br>or<br>implements the interface <code>Receiver</code>.<br>
</li><li>a <code>Receiver</code> subscribe to real objects,<br>not to string-based channels.<br>
</li><li>event string constants are no longer needed</li></ul>

Follow the documentation links bellow for more details.<br>
<br>
<hr />
<h1>Documentation</h1>

<ul><li><a href='SlotsVsSignalsVsEvents.md'>Slots vs Signals vs Events</a>
</li><li><a href='SignalersAndReceivers.md'>Signals &amp; Receivers</a></li></ul>

<hr />

<h1>Usages</h1>

Some examples and usages of this package.<br>
<ul><li><a href='http://code.google.com/p/maashaack/source/browse/#svn%2Fpackages%2Fsystem_signals%2Ftrunk%2Fexamples'>code examples</a>
</li><li><a href='http://maashaack.googlecode.com/svn/packages/system_signals/trunk/examples/system/signals/examples/Signal01Example.as'>example 1</a> (source code)<br>
</li><li><a href='http://maashaack.googlecode.com/svn/packages/system_signals/trunk/examples/system/signals/examples/Signal02Example.as'>example 2</a> (source code)<br>
</li><li><a href='http://maashaack.googlecode.com/svn/packages/system_signals/trunk/examples/system/signals/examples/MessengerExample.as'>messenger example</a> (source code)<br>
</li><li><a href='http://maashaack.googlecode.com/svn/packages/system_signals/trunk/examples/system/signals/examples/SignalButtonExample.as'>button example</a> (source code)