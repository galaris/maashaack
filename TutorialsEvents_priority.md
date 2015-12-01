# EventListener priority #

  * [HomePage](http://code.google.com/p/maashaack/)
    * [Returns events](events.md)

When you register an event listener with the **addEventListener** or the **registerEventListener** method of the **system.events.EventDispatcher** class you can apply a priority over your event listener.

The priority is designated by an uint value( an integer > 0 ).

The higher the number, the higher the priority. All listeners with priority **n** are processed before listeners of priority **n-1**.

If two or more listeners share the same priority, they are processed in the order in which they were added.

The default priority is **0**. This feature is native in the flash.events.**package of the FlashPlayer 9 et 10.**

```

import system.events.Event ;
import system.events.EventDispatcher ;
import system.events.EventListener ;
import system.events.Delegate ;

function debug( e:Event, msg:String ):void 
{
    trace ( "debug " + e.type + " message -> " + msg ) ;
}

var listener1:EventListener = new Delegate( this, debug , "listener1") ;
var listener2:EventListener = new Delegate( this, debug , "listener2") ;
var listener3:EventListener = new Delegate( this, debug , "listener3") ;
var listener4:EventListener = new Delegate( this, debug , "listener4") ;

var dispatcher:EventDispatcher = new EventDispatcher() ;

dispatcher.registerEventListener("test", listener1, false, 3) ;
dispatcher.registerEventListener("test", listener2, false, 1) ;
dispatcher.registerEventListener("test", listener3, false, 2) ;
dispatcher.registerEventListener("test", listener4, false, 1000) ; // high priority

dispatcher.dispatchEvent( new Event("test") ) ;

```

The result of the previous script in the output panel :

```
debug test message -> listener4
debug test message -> listener1
debug test message -> listener3
debug test message -> listener2
```